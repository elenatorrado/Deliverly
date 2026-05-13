<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . "/config.php";
require_once __DIR__ . "/utils.php";

try {

    $dbConn = connect($db);


    $action = $_POST['action'] ?? 'listar';

    
    if ($action === 'listar') {

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
            WHERE p.estadoPedido IN ('pendiente', 'en_camino')
            ORDER BY p.horarioInicio ASC
        ");

        $sql->execute();

        echo json_encode([
            "success" => true,
            "data" => $sql->fetchAll(PDO::FETCH_ASSOC)
        ]);

        exit;
    }

    
    if ($action === 'en_camino') {

        $idPedido = $_POST['idPedido'] ?? null;

        if (!$idPedido) {
            echo json_encode([
                "success" => false,
                "message" => "Falta idPedido"
            ]);
            exit;
        }

        $sql = $dbConn->prepare("
            UPDATE Pedido
            SET estadoPedido = 'en_camino'
            WHERE idPedido = :idPedido
        ");

        $sql->bindParam(':idPedido', $idPedido, PDO::PARAM_INT);
        $sql->execute();

        echo json_encode([
            "success" => true,
            "message" => "Pedido actualizado a en_camino"
        ]);

        exit;
    }

   
    echo json_encode([
        "success" => false,
        "message" => "Acción no válida"
    ]);

} catch (PDOException $e) {

    echo json_encode([
        "success" => false,
        "message" => $e->getMessage()
    ]);
}