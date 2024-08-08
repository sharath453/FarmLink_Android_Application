<?php
// Include database connection
include('connection.php');

header('Content-Type: application/json');

// Get data from the request
$data = json_decode(file_get_contents("php://input"));

$username = $data->username;
$password = $data->password;

// Validate inputs
if (empty($username) || empty($password)) {
    echo json_encode(array("status" => "error", "message" => "Username and password required"));
    exit();
}

// Query to check if the user exists
$query = "SELECT * FROM managers WHERE username = ? AND password = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("ss", $username, $password);
$stmt->execute();
$result = $stmt->get_result();

// Check if user exists
if ($result->num_rows > 0) {
    echo json_encode(array("status" => "success", "message" => "Login successful"));
} else {
    echo json_encode(array("status" => "error", "message" => "Invalid username or password"));
}

$stmt->close();
$conn->close();
?>
