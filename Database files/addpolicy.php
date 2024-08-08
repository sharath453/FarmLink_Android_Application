<?php
// addpolicy.php

header('Content-Type: application/json');

// Include database connection
include 'connection.php';

// Get the POST data
$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    $crop_name = $conn->real_escape_string($data['crop_name']);
    $policy_name = $conn->real_escape_string($data['policy_name']);
    $policy_description = $conn->real_escape_string($data['policy_description']);

    $sql = "INSERT INTO policies (crop_name, policy_name, policy_description) 
            VALUES ('$crop_name', '$policy_name', '$policy_description')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(['status' => 'success', 'message' => 'Policy added successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Error: ' . $conn->error]);
    }

    $conn->close();
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input']);
}
?>
