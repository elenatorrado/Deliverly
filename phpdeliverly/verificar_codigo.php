<?php
require "config.php";
require "utils.php";

$dbConn = connect($db);

$data = json_decode(file_get_contents("php://input"), true);

$idPedido = $data["idPedido"];
$codigo = $data["codigo"];

// comprobar código
$sql = $dbConn->prepare("
    SELECT * FROM Pedido 
    WHERE idPedido = ? AND codigoEntregaCliente = ?
");
$sql->execute([$idPedido, $codigo]);

if ($sql->rowCount() > 0) {

    // actualizar estado a ENTREGADO
    $update = $dbConn->prepare("
        UPDATE Pedido 
        SET estadoPedido = 'entregado'
        WHERE idPedido = ?
    ");
    $update->execute([$idPedido]);

    echo json_encode(["success" => true]);

} else {
    echo json_encode(["success" => false]);
}