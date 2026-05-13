<?php
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . "/config.php";
require_once "utils.php";

$dbConn = connect($db);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $input = json_decode(file_get_contents("php://input"), true);

    $usuario = trim($input['usuario'] ?? '');
    $password = trim($input['password'] ?? '');

    if ($usuario === '' || $password === '') {
        echo json_encode(["success" => false, "message" => "Faltan campos"]);
        exit();
    }

    
    $sql = $dbConn->prepare("
        SELECT * FROM Repartidor
        WHERE usuarioRepartidor = :usuario
        LIMIT 1
    ");

    $sql->execute([':usuario' => $usuario]);
    $user = $sql->fetch(PDO::FETCH_ASSOC);

    if (!$user || $password !== $user['passwordRepartidor']) {
        echo json_encode(["success" => false, "message" => "Login incorrecto"]);
        exit();
    }

    $idRepartidor = $user['idRepartidor'];

    
    $dbConn->prepare("
        UPDATE Repartidor
        SET disponibilidadRepartidor = 'disponible'
        WHERE idRepartidor = :id
    ")->execute([':id' => $idRepartidor]);

    // 🔥 ASIGNACIÓN AUTOMÁTICA (MAX 5 / 30 MIN)
    $pedidos = $dbConn->prepare("
        SELECT * FROM Pedido
        WHERE estadoPedido = 'pendiente'
        AND horarioInicio >= NOW() - INTERVAL 30 MINUTE
        LIMIT 5
    ");

    $pedidos->execute();
    $lista = $pedidos->fetchAll(PDO::FETCH_ASSOC);

    $asignados = [];

    foreach ($lista as $p) {

        // evitar duplicados
        $check = $dbConn->prepare("
            SELECT * FROM Asignacion WHERE idPedidoFK = :id
        ");
        $check->execute([':id' => $p['idPedido']]);

        if ($check->fetch()) continue;

        // insertar asignación
        $dbConn->prepare("
            INSERT INTO Asignacion (idPedidoFK, idRepartidorFK, fechaAsignacion)
            VALUES (:pedido, :repartidor, NOW())
        ")->execute([
            ':pedido' => $p['idPedido'],
            ':repartidor' => $idRepartidor
        ]);

        // actualizar pedido
        $dbConn->prepare("
            UPDATE Pedido
            SET estadoPedido = 'en_camino'
            WHERE idPedido = :id
        ")->execute([':id' => $p['idPedido']]);

        $asignados[] = $p['idPedido'];
    }

    echo json_encode([
        "success" => true,
        "idRepartidor" => $idRepartidor,
        "pedidosAsignados" => $asignados
    ]);

    exit();
}