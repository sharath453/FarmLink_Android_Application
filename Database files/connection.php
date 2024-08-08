<?php

$conn = new mysqli('localhost', 'root', '', 'farmer');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
