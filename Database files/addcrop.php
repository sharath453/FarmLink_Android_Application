<?php
// Include the database connection script
include 'connection.php';

// Get the POST data
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['username']) && isset($data['full_name']) && isset($data['email']) && isset($data['phone_number']) && isset($data['password'])) {
    $username = $conn->real_escape_string($data['username']);
    $full_name = $conn->real_escape_string($data['full_name']);
    $email = $conn->real_escape_string($data['email']);
    $phone_number = $conn->real_escape_string($data['phone_number']);
    $password = $conn->real_escape_string($data['password']);

    // Check if the username already exists
    $query = "SELECT * FROM farmers WHERE username = '$username'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        echo json_encode(['status' => 'error', 'message' => 'Username already exists']);
    } else {
        // Hash the password
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        // Insert the new farmer into the database
        $sql = "INSERT INTO farmers (username, password, full_name, email, phone_number) 
                VALUES ('$username', '$hashed_password', '$full_name', '$email', '$phone_number')";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(['status' => 'success', 'message' => 'Registration successful']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Error: ' . $conn->error]);
        }
    }

    $conn->close();
} else {
    echo json_encode(['status' => 'error', 'message' => 'All fields are required']);
}
?>
