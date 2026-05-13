<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . "/config.php";
require_once __DIR__ . "/utils.php";

try {

    $dbConn = connect($db);

    $sql = $dbConn->prepare("
        SELECT 
            p.idPedido,
            p.descripcionPedido,
            p.direccionPedido,
            p.estadoPedido,

            CONCAT(
                IFNULL(DATE_FORMAT(p.horarioInicio, '%H:%i'), ''),
                IF(
                    p.horarioInicio IS NOT NULL AND p.horarioFin IS NOT NULL,
                    ' - ',
                    ''
                ),
                IFNULL(DATE_FORMAT(p.horarioFin, '%H:%i'), '')
            ) AS franjaHorario,

            c.nombreCliente,
            c.telefonoCliente

        FROM Pedido p
        INNER JOIN Cliente c ON p.idClienteFK = c.idCliente
        WHERE p.estadoPedido = 'entregado'
        ORDER BY p.idPedido DESC
    ");

    $sql->execute();

    $result = $sql->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $result
    ]);

} catch (PDOException $e) {

    echo json_encode([
        "success" => false,
        "message" => $e->getMessage()
    ]);
}