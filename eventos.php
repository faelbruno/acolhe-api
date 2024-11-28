<?php
include('conexao.php'); // Conexão ao banco

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Permitir acesso de qualquer origem
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Métodos aceitos
header('Access-Control-Allow-Headers: Content-Type'); // Cabeçalhos aceitos

// Verificar autenticação via token ou sessão
session_start();
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['success' => false, 'message' => 'Não autenticado']);
    exit();
}

// Consultar eventos do dia
$sql = "SELECT nome, data FROM eventos WHERE DATE(data) = CURDATE() AND id_unidade = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $_SESSION['id_unidade']);
$stmt->execute();
$result = $stmt->get_result();

$eventos = [];
while ($row = $result->fetch_assoc()) {
    $eventos[] = $row;
}

echo json_encode(['success' => true, 'eventos' => $eventos]);
$stmt->close();
$conn->close();
?>
