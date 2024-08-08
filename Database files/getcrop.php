<?php
// Database connection
include 'connection.php';

// SQL query to fetch crop details
$query = "SELECT crop_name AS name, soil_type AS soilType, climate_condition AS climateCondition, season_start AS startSeason, season_end AS endSeason, government_policy AS policyName, description AS policyDescription, price AS pricePerKg FROM crops";
$result = mysqli_query($conn, $query);

$crops = array();

while ($row = mysqli_fetch_assoc($result)) {
    $crops[] = $row;
}

// Output the JSON encoded array
echo json_encode($crops);

// Close the database connection
mysqli_close($conn);
?>
