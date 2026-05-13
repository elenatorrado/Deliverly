<?php

function connect($db)
{
    try {
        $conn = new PDO(
            "mysql:host={$db['host']};dbname={$db['db']};charset=utf8mb4",
            $db['username'],
            $db['password']
        );

     
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

     
        $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

        return $conn;

    } catch (PDOException $e) {

       
        echo json_encode([
            "success" => false,
            "message" => "Error de conexión a la base de datos"
        ]);

        exit();
    }
}