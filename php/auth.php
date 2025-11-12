<?php
require_once 'config.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

try {
    switch ($action) {
        case 'register':
            if ($method === 'POST') {
                register();
            }
            break;
        
        case 'login':
            if ($method === 'POST') {
                login();
            }
            break;
        
        case 'logout':
            logout();
            break;
        
        case 'check':
            checkAuth();
            break;
        
        case 'profile':
            if ($method === 'GET') {
                getProfile();
            } elseif ($method === 'PUT') {
                updateProfile();
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

function register() {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $email = trim($data['email'] ?? '');
    $password = $data['password'] ?? '';
    $firstName = trim($data['firstName'] ?? '');
    $lastName = trim($data['lastName'] ?? '');
    
    // Validation
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        http_response_code(400);
        echo json_encode(['error' => 'Valid email is required']);
        return;
    }
    
    if (empty($password) || strlen($password) < 6) {
        http_response_code(400);
        echo json_encode(['error' => 'Password must be at least 6 characters']);
        return;
    }
    
    $conn = getDBConnection();
    
    // Check if email already exists
    $stmt = $conn->prepare("SELECT id_user FROM users WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        http_response_code(400);
        echo json_encode(['error' => 'Email already registered']);
        return;
    }
    
    // Hash password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
    // Insert user
    $stmt = $conn->prepare("
        INSERT INTO users (email, password, first_name, last_name) 
        VALUES (?, ?, ?, ?)
    ");
    $stmt->execute([$email, $hashedPassword, $firstName, $lastName]);
    
    $userId = $conn->lastInsertId();
    
    // Set session
    $_SESSION['user_id'] = $userId;
    $_SESSION['user_email'] = $email;
    
    echo json_encode([
        'success' => true,
        'user' => [
            'id' => $userId,
            'email' => $email,
            'firstName' => $firstName,
            'lastName' => $lastName
        ]
    ]);
}

function login() {
    $data = json_decode(file_get_contents('php://input'), true);
    
    $email = trim($data['email'] ?? '');
    $password = $data['password'] ?? '';
    
    if (empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(['error' => 'Email and password are required']);
        return;
    }
    
    $conn = getDBConnection();
    
    $stmt = $conn->prepare("
        SELECT id_user, email, password, first_name, last_name 
        FROM users 
        WHERE email = ?
    ");
    $stmt->execute([$email]);
    $user = $stmt->fetch();
    
    if (!$user || !password_verify($password, $user['password'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Invalid email or password']);
        return;
    }
    
    // Set session
    $_SESSION['user_id'] = $user['id_user'];
    $_SESSION['user_email'] = $user['email'];
    
    echo json_encode([
        'success' => true,
        'user' => [
            'id' => $user['id_user'],
            'email' => $user['email'],
            'firstName' => $user['first_name'],
            'lastName' => $user['last_name']
        ]
    ]);
}

function logout() {
    session_destroy();
    echo json_encode(['success' => true]);
}

function checkAuth() {
    if (isset($_SESSION['user_id'])) {
        $conn = getDBConnection();
        $stmt = $conn->prepare("
            SELECT id_user, email, first_name, last_name, phone, address, city, postal_code, country 
            FROM users 
            WHERE id_user = ?
        ");
        $stmt->execute([$_SESSION['user_id']]);
        $user = $stmt->fetch();
        
        if ($user) {
            echo json_encode([
                'authenticated' => true,
                'user' => [
                    'id' => $user['id_user'],
                    'email' => $user['email'],
                    'firstName' => $user['first_name'],
                    'lastName' => $user['last_name'],
                    'phone' => $user['phone'],
                    'address' => $user['address'],
                    'city' => $user['city'],
                    'postalCode' => $user['postal_code'],
                    'country' => $user['country']
                ]
            ]);
            return;
        }
    }
    
    echo json_encode(['authenticated' => false]);
}

function getProfile() {
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }
    
    $conn = getDBConnection();
    $stmt = $conn->prepare("
        SELECT id_user, email, first_name, last_name, phone, address, city, postal_code, country 
        FROM users 
        WHERE id_user = ?
    ");
    $stmt->execute([$_SESSION['user_id']]);
    $user = $stmt->fetch();
    
    if (!$user) {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
        return;
    }
    
    echo json_encode([
        'id' => $user['id_user'],
        'email' => $user['email'],
        'firstName' => $user['first_name'],
        'lastName' => $user['last_name'],
        'phone' => $user['phone'],
        'address' => $user['address'],
        'city' => $user['city'],
        'postalCode' => $user['postal_code'],
        'country' => $user['country']
    ]);
}

function updateProfile() {
    if (!isset($_SESSION['user_id'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Not authenticated']);
        return;
    }
    
    $data = json_decode(file_get_contents('php://input'), true);
    
    $conn = getDBConnection();
    $stmt = $conn->prepare("
        UPDATE users 
        SET first_name = ?, last_name = ?, phone = ?, address = ?, city = ?, postal_code = ?, country = ?
        WHERE id_user = ?
    ");
    
    $stmt->execute([
        $data['firstName'] ?? '',
        $data['lastName'] ?? '',
        $data['phone'] ?? '',
        $data['address'] ?? '',
        $data['city'] ?? '',
        $data['postalCode'] ?? '',
        $data['country'] ?? '',
        $_SESSION['user_id']
    ]);
    
    echo json_encode(['success' => true]);
}
?>
