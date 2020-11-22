<?php
require_once('db_config.php');

$sql = "SELECT * FROM vw_storepagebooks";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  $dbdata = array();
  while($row = mysqli_fetch_assoc($result)) {
    $dbdata[] = $row;
  }
} else {
  echo "0 results";
}

//Print array in JSON format
echo json_encode($dbdata);

mysqli_close($conn);
?> 