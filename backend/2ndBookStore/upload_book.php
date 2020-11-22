<?php
    require_once('db_config.php');
    
    $sql = 'CALL sp_uploadBookAndItsImages('.$_POST["BookJSON"].')';
    
    if (mysqli_query($conn, $sql)) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }
?>