<?php
// Include the database connection file
include 'connection.php';

// Retrieve and sanitize POST data
$username = $_POST['username'] ?? '';
$full_name = $_POST['full_name'] ?? '';
$email = $_POST['email'] ?? '';
$phone_number = $_POST['phone_number'] ?? '';
$password = $_POST['password'] ?? '';

// Validate the input data
if (empty($username) || empty($full_name) || empty($email) || empty($phone_number) || empty($password)) {
    echo json_encode([
        'status' => 'error',
        'message' => 'All fields are required'
    ]);
    $conn->close();
    exit();
}

// Prepare and execute the SQL statement
$sql = $conn->prepare('INSERT INTO farmers (username, full_name, email, phone_number, password) VALUES (?, ?, ?, ?, ?)');
$sql->bind_param('sssss', $username, $full_name, $email, $phone_number, $password);

if ($sql->execute()) {
    echo json_encode([
        'status' => 'success',
        'message' => 'Registration successful'
    ]);
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Registration failed: ' . $conn->error
    ]);
}

// Close the statement and connection
$sql->close();
$conn->close();
?>
