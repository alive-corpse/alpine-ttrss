<?php
include 'config.php';
$con = mysqli_connect(DB_HOST, DB_USER, DB_PASS);
while (!$con) {
    $con = mysqli_connect(DB_HOST, DB_USER, DB_PASS);
    sleep(1);
}
mysqli_select_db($con, DB_NAME) or die('Failed to connect to database '.DB_NAME);
?>
