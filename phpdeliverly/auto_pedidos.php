<?php

ini_set('display_errors', 1);
error_reporting(E_ALL);

require_once __DIR__ . '/PHPMailer/src/Exception.php';
require_once __DIR__ . '/PHPMailer/src/PHPMailer.php';
require_once __DIR__ . '/PHPMailer/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once "config.php";
require_once "utils.php";

$dbConn = connect($db);

$sql = $dbConn->prepare("
    SELECT p.idPedido, c.emailCliente
    FROM Pedido p
    JOIN Cliente c ON p.idClienteFK = c.idCliente
    WHERE p.codigoEntregaCliente IS NULL
");

$sql->execute();
$pedidos = $sql->fetchAll(PDO::FETCH_ASSOC);

foreach ($pedidos as $p) {

    $codigo = random_int(100000, 999999);

    $update = $dbConn->prepare("
        UPDATE Pedido 
        SET codigoEntregaCliente = ?
        WHERE idPedido = ?
    ");
    $update->execute([$codigo, $p["idPedido"]]);

    $mail = new PHPMailer(true);

    try {

        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;

        $mail->Username = 'deliverlyrapido@gmail.com';
        $mail->Password = 'qpyu klcc afrv lqju';

        // ✔ CORRECTO (Gmail recomendado)
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        
        $mail->SMTPOptions = [
            'ssl' => [
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            ]
        ];

        // DEBUG opcional
        // $mail->SMTPDebug = 2;

        $mail->setFrom('deliverlyrapido@gmail.com', 'Deliverly');
        $mail->addAddress($p["emailCliente"]);

        $mail->isHTML(false);
        $mail->Subject = "Codigo de tu pedido";
        $mail->Body = "Tu codigo es: $codigo";

        $mail->send();

    } catch (Exception $e) {
        error_log($mail->ErrorInfo);
    }
}

echo "OK";