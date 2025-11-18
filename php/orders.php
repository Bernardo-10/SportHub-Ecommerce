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
        
        // Get user info for WhatsApp message
        $userInfo = getUserInfoForWhatsApp($_SESSION['user_id']);
        
        echo json_encode([
            'success' => true,
            'orderId' => $orderId,
            'totalAmount' => $totalAmount,
            'orderItems' => $orderItems,
            'userInfo' => $userInfo,
            'shippingInfo' => [
                'address' => $shippingAddress,
                'city' => $shippingCity,
                'postalCode' => $shippingPostalCode,
                'country' => $shippingCountry
            ]
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

function getUserInfoForWhatsApp($userId) {
    $conn = getDBConnection();
    
    // Get user info
    $stmt = $conn->prepare("SELECT email, first_name, last_name FROM users WHERE id_user = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch();
    
    if (!$user) {
        return [
            'firstName' => 'Client',
            'lastName' => '',
            'email' => ''
        ];
    }
    
    return [
        'firstName' => $user['first_name'] ?? 'Client',
        'lastName' => $user['last_name'] ?? '',
        'email' => $user['email'] ?? ''
    ];
}
?>
