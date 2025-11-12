<?php
require_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

try {
    switch ($action) {
        case 'create':
            if ($method === 'POST') {
                createOrder();
            }
            break;
        
        case 'list':
            if ($method === 'GET') {
                getUserOrders();
            }
            break;
        
        case 'get':
            if ($method === 'GET') {
                $id = $_GET['id'] ?? null;
                if ($id) {
                    getOrder($id);
                } else {
                    http_response_code(400);
                    echo json_encode(['error' => 'Order ID is required']);
                }
            }
            break;
        
        default:
            http_response_code(404);
            echo json_encode(['error' => 'Invalid action']);
            break;
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

function createOrder() {
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Authentication required']);
        return;
    }
    
    $data = json_decode(file_get_contents('php://input'), true);
    
    $items = $data['items'] ?? [];
    $shippingAddress = $data['shippingAddress'] ?? '';
    $shippingCity = $data['shippingCity'] ?? '';
    $shippingPostalCode = $data['shippingPostalCode'] ?? '';
    $shippingCountry = $data['shippingCountry'] ?? '';
    
    if (empty($items)) {
        http_response_code(400);
        echo json_encode(['error' => 'No items in order']);
        return;
    }
    
    $conn = getDBConnection();
    
    try {
        $conn->beginTransaction();
        
        // Calculate total and validate stock
        $totalAmount = 0;
        $orderItems = [];
        
        foreach ($items as $item) {
            $articleId = $item['id'] ?? null;
            $quantity = $item['quantity'] ?? 0;
            
            if (!$articleId || $quantity <= 0) {
                throw new Exception('Invalid item data');
            }
            
            // Get article and check stock
            $stmt = $conn->prepare("SELECT id_article, name, price, stock FROM articles WHERE id_article = ? FOR UPDATE");
            $stmt->execute([$articleId]);
            $article = $stmt->fetch();
            
            if (!$article) {
                throw new Exception("Article not found: $articleId");
            }
            
            if ($article['stock'] < $quantity) {
                throw new Exception("Insufficient stock for: " . $article['name']);
            }
            
            $itemTotal = $article['price'] * $quantity;
            $totalAmount += $itemTotal;
            
            $orderItems[] = [
                'id_article' => $article['id_article'],
                'name' => $article['name'],
                'quantity' => $quantity,
                'price' => $article['price']
            ];
            
            // Update stock
            $newStock = $article['stock'] - $quantity;
            $stmt = $conn->prepare("UPDATE articles SET stock = ? WHERE id_article = ?");
            $stmt->execute([$newStock, $article['id_article']]);
        }
        
        // Create order
        $stmt = $conn->prepare("
            INSERT INTO orders (id_user, total_amount, shipping_address, shipping_city, shipping_postal_code, shipping_country) 
            VALUES (?, ?, ?, ?, ?, ?)
        ");
        $stmt->execute([
            $_SESSION['user_id'],
            $totalAmount,
            $shippingAddress,
            $shippingCity,
            $shippingPostalCode,
            $shippingCountry
        ]);
        
        $orderId = $conn->lastInsertId();
        
        // Create order items
        $stmt = $conn->prepare("
            INSERT INTO order_items (id_order, id_article, quantity, price) 
            VALUES (?, ?, ?, ?)
        ");
        
        foreach ($orderItems as $item) {
            $stmt->execute([
                $orderId,
                $item['id_article'],
                $item['quantity'],
                $item['price']
            ]);
        }
        
        $conn->commit();
        
        // Send email confirmation to user
        sendOrderConfirmationEmail($orderId, $orderItems, $totalAmount);
        
        echo json_encode([
            'success' => true,
            'orderId' => $orderId,
            'totalAmount' => $totalAmount
        ]);
        
    } catch (Exception $e) {
        $conn->rollBack();
        throw $e;
    }
}

function getUserOrders() {
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Authentication required']);
        return;
    }
    
    $conn = getDBConnection();
    
    $stmt = $conn->prepare("
        SELECT id_order, order_date, total_amount, status 
        FROM orders 
        WHERE id_user = ? 
        ORDER BY order_date DESC
    ");
    $stmt->execute([$_SESSION['user_id']]);
    $orders = $stmt->fetchAll();
    
    foreach ($orders as &$order) {
        $order['id_order'] = (int)$order['id_order'];
        $order['total_amount'] = (int)$order['total_amount'];
    }
    
    echo json_encode($orders);
}

function getOrder($orderId) {
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Authentication required']);
        return;
    }
    
    $conn = getDBConnection();
    
    // Get order
    $stmt = $conn->prepare("
        SELECT id_order, order_date, total_amount, status, 
               shipping_address, shipping_city, shipping_postal_code, shipping_country
        FROM orders 
        WHERE id_order = ? AND id_user = ?
    ");
    $stmt->execute([$orderId, $_SESSION['user_id']]);
    $order = $stmt->fetch();
    
    if (!$order) {
        http_response_code(404);
        echo json_encode(['error' => 'Order not found']);
        return;
    }
    
    // Get order items
    $stmt = $conn->prepare("
        SELECT oi.id_order_item, oi.quantity, oi.price, 
               a.id_article, a.name, a.image_url
        FROM order_items oi
        JOIN articles a ON oi.id_article = a.id_article
        WHERE oi.id_order = ?
    ");
    $stmt->execute([$orderId]);
    $items = $stmt->fetchAll();
    
    $order['id_order'] = (int)$order['id_order'];
    $order['total_amount'] = (int)$order['total_amount'];
    $order['items'] = $items;
    
    echo json_encode($order);
}

function sendOrderConfirmationEmail($orderId, $orderItems, $totalAmount) {
    if (!isset($_SESSION['user_id'])) {
        return;
    }
    
    $conn = getDBConnection();
    
    // Get user email
    $stmt = $conn->prepare("SELECT email, first_name FROM users WHERE id_user = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $user = $stmt->fetch();
    
    if (!$user || !$user['email']) {
        return;
    }
    
    $userEmail = $user['email'];
    $firstName = $user['first_name'] ?? 'Client';
    
    // Build email content
    $subject = "Confirmation de commande #$orderId - SportHub";
    
    $message = "<!DOCTYPE html>
<html>
<head>
    <meta charset='UTF-8'>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(to right, #2563eb, #ea580c); color: white; padding: 20px; text-align: center; }
        .content { background: #f9fafb; padding: 20px; }
        .order-item { background: white; padding: 15px; margin: 10px 0; border-radius: 5px; }
        .total { background: #2563eb; color: white; padding: 15px; margin-top: 20px; text-align: center; font-size: 1.2em; }
        .footer { text-align: center; padding: 20px; color: #6b7280; }
    </style>
</head>
<body>
    <div class='container'>
        <div class='header'>
            <h1>⚡ SportHub</h1>
            <p>Confirmation de Commande</p>
        </div>
        <div class='content'>
            <h2>Bonjour $firstName,</h2>
            <p>Merci pour votre commande ! Voici le récapitulatif de votre achat :</p>
            <p><strong>Numéro de commande :</strong> #$orderId</p>
            <h3>Articles commandés :</h3>";
    
    // Add each item
    foreach ($orderItems as $item) {
        $itemName = htmlspecialchars($item['name'] ?? 'Article');
        $itemPrice = number_format($item['price'], 0, ',', ' ');
        $quantity = $item['quantity'];
        $itemTotal = number_format($item['price'] * $quantity, 0, ',', ' ');
        
        $message .= "
            <div class='order-item'>
                <strong>$itemName</strong><br>
                Prix unitaire : $itemPrice FCFA<br>
                Quantité : $quantity<br>
                <strong>Total : $itemTotal FCFA</strong>
            </div>";
    }
    
    $totalFormatted = number_format($totalAmount, 0, ',', ' ');
    
    $message .= "
            <div class='total'>
                <strong>TOTAL : $totalFormatted FCFA</strong>
            </div>
            <p style='margin-top: 20px;'>Votre commande sera traitée dans les plus brefs délais. Vous recevrez un email de confirmation d'expédition dès que votre commande sera envoyée.</p>
        </div>
        <div class='footer'>
            <p>Merci de faire confiance à SportHub !</p>
            <p>Pour toute question, contactez-nous à SportHub@gmail.com</p>
            <p>&copy; 2025 SportHub. Tous droits réservés.</p>
        </div>
    </div>
</body>
</html>";
    
    // Set email headers
    $headers = "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=UTF-8\r\n";
    $headers .= "From: SportHub <noreply@sporthub.com>\r\n";
    $headers .= "Reply-To: SportHub@gmail.com\r\n";
    
    // Send email
    @mail($userEmail, $subject, $message, $headers);
}
?>
