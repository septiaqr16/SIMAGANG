<?php
$conn = mysqli_connect("localhost", "root", "", "simagang");

if (!$conn) {
    die("Koneksi database gagal: " . mysqli_connect_error());
}
?>
