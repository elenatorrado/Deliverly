<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . "/config.php";
require_once __DIR__ . "/utils.php";

$dbConn = connect($db);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $input = json_decode(file_get_contents("php://input"), true);

    $idPedido = $input['idPedido'] ?? null;
    $codigo = $input['codigo'] ?? '';

    if (!$idPedido || $codigo === '') {
        echo json_encode(["success" => false]);
        exit();
    }

    // comprobar código
    $sql = $dbConn->prepare("
        SELECT codigoEntregaCliente FROM Pedido
        WHERE idPedido = :id
    ");

    $sql->execute([':id' => $idPedido]);
    $p = $sql->fetch(PDO::FETCH_ASSOC);

    if (!$p || $p['codigoEntregaCliente'] != $codigo) {
        echo json_encode(["success" => false, "message" => "Código incorrecto"]);
        exit();
    }

    // marcar entregado
    $dbConn->prepare("
        UPDATE Pedido
        SET estadoPedido = 'entregado'
        WHERE idPedido = :id
    ")->execute([':id' => $idPedido]);

    echo json_encode(["success" => true, "message" => "Entregado"]);
}