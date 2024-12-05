<?php

include "headers.php";
include "connection.php";

class Transaction
{
    function generateRoomNumber()
    {
        $letter = chr(rand(65, 90));
        $number = rand(1, 9999);
        return sprintf("%s%04d", $letter, $number);
    }


    function adminLogin($json)
    {
        include "connection.php";
        $json = json_decode($json, true);
        $sql = "SELECT * FROM tbladmin WHERE admin_username = :admin_username AND BINARY admin_password = :admin_password";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":admin_username", $json['admin_username']);
        $stmt->bindParam(":admin_password", $json['admin_password']);
        $stmt->execute();
        return $stmt->rowCount() > 0 ? 1 : 0;
    }

    function createRoom()
    {
        include "connection.php";
        $rooms_number = $this->generateRoomNumber();

        $sql = "INSERT INTO tblrooms (rooms_number) VALUES (:rooms_number)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":rooms_number", $rooms_number);

        if ($stmt->execute()) {
            echo json_encode(["rooms_number" => $rooms_number]);
        } else {
            echo json_encode(["rooms_number" => 0]);
        }
    }



    function joinRoom($json)
    {
        include "connection.php";
        $json = json_decode($json, true);

        $sql = "SELECT rooms_number FROM tblrooms WHERE rooms_number = :rooms_number";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":rooms_number", $json['rooms_number']);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $room = $stmt->fetch(PDO::FETCH_ASSOC);
            $matching_room_number = $room['rooms_number'];
            $gender = $json['matching_gender'];

            $sql = "SELECT MAX(matching_temp_id) AS max_id FROM tblmatching WHERE matching_room_number = :matching_room_number AND matching_gender = :matching_gender";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(":matching_room_number", $matching_room_number);
            $stmt->bindParam(":matching_gender", $gender);
            $stmt->execute();

            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            $next_id = ($result['max_id'] !== null) ? $result['max_id'] + 1 : 1;

            try {
                $sql = "INSERT INTO tblmatching (matching_temp_id, matching_room_number, matching_gender, matching_id_number) 
                        VALUES (:matching_temp_id, :matching_room_number, :matching_gender, :matching_id_number)";
                $stmt = $conn->prepare($sql);
                $stmt->bindParam(":matching_temp_id", $next_id);
                $stmt->bindParam(":matching_room_number", $matching_room_number);
                $stmt->bindParam(":matching_gender", $gender);
                $stmt->bindParam(":matching_id_number", $json['matching_id_number']);

                if ($stmt->execute()) {
                    return $next_id;
                } else {
                    return 0;
                }
            } catch (PDOException $e) {
                if ($e->getCode() == 23000) {
                    return -1;
                } else {
                    return 0;
                }
            }
        } else {
            return 0;
        }
    }



    function getTempId($json)
    {
        include "connection.php";
        $json = json_decode($json, true);

        $sql = "SELECT matching_temp_id FROM tblmatching 
            WHERE matching_room_number = :matching_room_number 
            AND matching_gender = :matching_gender 
            AND matching_id_number = :matching_id_number";

        $stmt = $conn->prepare($sql);
        $stmt->bindParam(":matching_room_number", $json['matching_room_number']);
        $stmt->bindParam(":matching_gender", $json['matching_gender']);
        $stmt->bindParam(":matching_id_number", $json['matching_id_number']);
        $stmt->execute();

        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        return $result ? json_encode($result) : 0;
    }
}

$json = isset($_POST['json']) ? $_POST['json'] : "0";
$operation = isset($_POST['operation']) ? $_POST['operation'] : "0";
$transaction = new Transaction();

switch ($operation) {
    case 'adminLogin':
        echo $transaction->adminLogin($json);
        break;
    case 'createRoom':
        echo $transaction->createRoom();
        break;
    case 'joinRoom':
        echo $transaction->joinRoom($json);
        break;
    case 'getTempId':
        echo $transaction->getTempId($json);
        break;
    default:
        break;
}
