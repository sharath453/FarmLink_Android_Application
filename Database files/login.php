<?php
// login.php
include 'connection.php';

header('Content-Type: application/json');

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';

$response = array('success' => false, 'message' => '');

if (empty($username) || empty($password)) {
    $response['message'] = 'Username and password are required.';
    echo json_encode($response);
    exit;
}

// Prepare and bind
$stmt = $conn->prepare("SELECT id, password FROM farmers WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    $stmt->bind_result($id, $storedPassword);
    $stmt->fetch();

    // Verify the password
    if ($password === $storedPassword) {
        $response['success'] = true;
        $response['message'] = 'Login successful.';
        // Optionally, you can return user details or create a session here
    } else {
        $response['message'] = 'Invalid username or password.';
    }
} else {
    $response['message'] = 'Invalid username or password.';
}

$stmt->close();
$conn->close();

echo json_encode($response);
?>