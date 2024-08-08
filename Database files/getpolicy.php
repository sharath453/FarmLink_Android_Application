<?php
// Database connection
include 'connection.php'; // Ensure this file contains your database connection settings

// SQL query to fetch policy details
$query = "SELECT crop_name AS name, policy_name, policy_description, policy_url FROM policies"; // Add policy_url
$result = mysqli_query($conn, $query);

// Check for query execution errors
if (!$result) {
    http_response_code(500); // Internal Server Error
    echo json_encode(['error' => 'Failed to execute query']);
    exit;
}

$policies = array();

// Fetch results and add them to the array
while ($row = mysqli_fetch_assoc($result)) {
    $policies[] = $row;
}

// Return the result as JSON
echo json_encode($policies);

// Close database connection
mysqli_close($conn);
?>
