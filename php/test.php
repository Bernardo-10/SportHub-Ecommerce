<?php
/**
 * Test file to verify PHP and database setup
 * Access at: http://localhost/sporthub/php/test.php
 */

echo "<h1>SportHub - PHP & Database Test</h1>";
echo "<hr>";

// Test PHP version
echo "<h2>1. PHP Version</h2>";
echo "PHP Version: " . phpversion();
echo " ✓<br><br>";

// Test database connection
echo "<h2>2. Database Connection</h2>";
try {
    require_once 'config.php';
    $conn = getDBConnection();
    echo "Database connection: <strong style='color: green;'>SUCCESS ✓</strong><br><br>";
    
    // Test users table
    echo "<h2>3. Users Table</h2>";
    $stmt = $conn->query("SELECT COUNT(*) as count FROM users");
    $result = $stmt->fetch();
    echo "Users in database: " . $result['count'] . "<br><br>";
    
    // Test articles table
    echo "<h2>4. Articles Table</h2>";
    $stmt = $conn->query("SELECT COUNT(*) as count FROM articles");
    $result = $stmt->fetch();
    echo "Articles in database: " . $result['count'] . "<br>";
    
    if ($result['count'] > 0) {
        echo "<br>Sample products:<br>";
        $stmt = $conn->query("SELECT name, price, stock FROM articles LIMIT 5");
        echo "<ul>";
        while ($row = $stmt->fetch()) {
            echo "<li>{$row['name']} - \${$row['price']} (Stock: {$row['stock']})</li>";
        }
        echo "</ul>";
    }
    
    // Test orders table
    echo "<h2>5. Orders Table</h2>";
    $stmt = $conn->query("SELECT COUNT(*) as count FROM orders");
    $result = $stmt->fetch();
    echo "Orders in database: " . $result['count'] . "<br><br>";
    
    echo "<h2>✓ All Tests Passed!</h2>";
    echo "<p>Your database is set up correctly. You can now use the application.</p>";
    echo "<p><a href='../index.html'>Go to SportHub Website</a></p>";
    
} catch (Exception $e) {
    echo "<strong style='color: red;'>ERROR: " . $e->getMessage() . "</strong><br><br>";
    echo "<p>Please check:</p>";
    echo "<ul>";
    echo "<li>MySQL server is running</li>";
    echo "<li>Database credentials in config.php are correct</li>";
    echo "<li>Database 'sporthub_db' exists</li>";
    echo "<li>All tables are created (run database.sql)</li>";
    echo "</ul>";
}
?>

<style>
    body {
        font-family: Arial, sans-serif;
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
        background: #f5f5f5;
    }
    h1 { color: #2563eb; }
    h2 { color: #1e40af; margin-top: 20px; }
    ul { background: white; padding: 20px; border-radius: 5px; }
</style>
