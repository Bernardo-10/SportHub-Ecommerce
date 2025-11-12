<?php
require_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? 'list';

try {
    switch ($action) {
        case 'list':
            getProducts();
            break;
        
        case 'get':
            $id = $_GET['id'] ?? null;
            if ($id) {
                getProduct($id);
            } else {
                http_response_code(400);
                echo json_encode(['error' => 'Product ID is required']);
            }
            break;
        
        case 'sports':
            getSports();
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

function getProducts() {
    $conn = getDBConnection();
    
    $sport = $_GET['sport'] ?? null;
    $category = $_GET['category'] ?? null;
    $search = $_GET['search'] ?? null;
    
    $sql = "SELECT id_article, name, description, price, sport, category, stock, image_url, featured FROM articles WHERE 1=1";
    $params = [];
    
    if ($sport && $sport !== 'all') {
        $sql .= " AND sport = ?";
        $params[] = $sport;
    }
    
    if ($category && $category !== 'all') {
        $sql .= " AND category = ?";
        $params[] = $category;
    }
    
    if ($search) {
        $sql .= " AND (name LIKE ? OR description LIKE ?)";
        $searchTerm = "%$search%";
        $params[] = $searchTerm;
        $params[] = $searchTerm;
    }
    
    $sql .= " ORDER BY featured DESC, id_article ASC";
    
    $stmt = $conn->prepare($sql);
    $stmt->execute($params);
    $products = $stmt->fetchAll();
    
    // Convert types
    foreach ($products as &$product) {
        $product['id_article'] = (int)$product['id_article'];
        $product['price'] = (int)$product['price'];
        $product['stock'] = (int)$product['stock'];
        $product['featured'] = (bool)$product['featured'];
    }
    
    echo json_encode($products);
}

function getProduct($id) {
    $conn = getDBConnection();
    
    $stmt = $conn->prepare("
        SELECT id_article, name, description, price, sport, category, stock, image_url, featured 
        FROM articles 
        WHERE id_article = ?
    ");
    $stmt->execute([$id]);
    $product = $stmt->fetch();
    
    if (!$product) {
        http_response_code(404);
        echo json_encode(['error' => 'Product not found']);
        return;
    }
    
    // Convert types
    $product['id_article'] = (int)$product['id_article'];
    $product['price'] = (int)$product['price'];
    $product['stock'] = (int)$product['stock'];
    $product['featured'] = (bool)$product['featured'];
    
    echo json_encode($product);
}

function getSports() {
    $conn = getDBConnection();
    
    $stmt = $conn->prepare("
        SELECT DISTINCT sport, COUNT(*) as count
        FROM articles 
        GROUP BY sport
        ORDER BY sport ASC
    ");
    $stmt->execute();
    $sports = $stmt->fetchAll();
    
    foreach ($sports as &$sport) {
        $sport['count'] = (int)$sport['count'];
    }
    
    echo json_encode($sports);
}
?>
