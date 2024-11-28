<?php
header("Content-Type: application/json"); // Define o tipo de resposta como JSON

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtém o conteúdo JSON enviado no corpo da requisição
    $inputJSON = file_get_contents('php://input');
    $input = json_decode($inputJSON, true); // Decodifica o JSON para um array associativo

    // Verifica se o JSON foi decodificado corretamente
    if (json_last_error() !== JSON_ERROR_NONE) {
        echo json_encode(["success" => false, "message" => "JSON inválido"]);
        exit();
    }

    // Recupera os dados enviados
    $email = $input['usuario'] ?? null;
    $senha = $input['senha'] ?? null;

    // Verifica se os campos necessários foram fornecidos
    if (!$email || !$senha) {
        echo json_encode(["success" => false, "message" => "Usuário e senha são obrigatórios"]);
        exit();
    }

    // Conexão com o banco de dados
    include('conexao.php');

    // Prepara a consulta SQL para verificar o usuário
    $sql = "SELECT * FROM usuarios WHERE email = ? AND ativo = 1";
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        echo json_encode(["success" => false, "message" => "Erro na consulta ao banco de dados"]);
        exit();
    }

    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Comparar a senha (pode usar password_verify para hashes)
        if ($senha === $row['senha']) {
            echo json_encode(["success" => true, "message" => "Login efetuado com sucesso"]);
        } else {
            echo json_encode(["success" => false, "message" => "Senha incorreta"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Usuário não encontrado ou inativo"]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "Este endpoint espera uma requisição POST"]);
}
?>
