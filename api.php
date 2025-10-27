<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers,Content-Type,Access-Control-Allow-Methods, Authorization, X-Requested-With');

include 'conexao.php';

$method = $_SERVER['REQUEST_METHOD'];
$db = new Database();
$conn = $db->getConnection();

// Roteamento básico
$request = $_GET['action'] ?? '';

switch($method) {
    case 'GET':
        handleGet($conn, $request);
        break;
    case 'POST':
        handlePost($conn, $request);
        break;
    case 'PUT':
        handlePut($conn, $request);
        break;
    case 'DELETE':
        handleDelete($conn, $request);
        break;
}

function handleGet($conn, $action) {
    switch($action) {
        case 'login':
            $email = $_GET['email'] ?? '';
            $senha = $_GET['senha'] ?? '';
            loginUsuario($conn, $email, $senha);
            break;
            
        case 'alunos':
            getAlunos($conn);
            break;
            
        case 'disciplinas':
            getDisciplinas($conn);
            break;
            
        case 'notas':
            $aluno_id = $_GET['aluno_id'] ?? '';
            getNotasAluno($conn, $aluno_id);
            break;
            
        case 'atividades':
            getAtividades($conn);
            break;
            
        case 'frequencia':
            $aluno_id = $_GET['aluno_id'] ?? '';
            getFrequenciaAluno($conn, $aluno_id);
            break;
            
        default:
            jsonResponse(false, 'Ação não encontrada');
    }
}

// FUNÇÃO DE LOGIN
function loginUsuario($conn, $email, $senha) {
    try {
        $query = "SELECT id, email, nome, tipo, matricula FROM usuarios 
                 WHERE email = :email AND senha = :senha";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':senha', $senha);
        $stmt->execute();
        
        if($stmt->rowCount() > 0) {
            $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
            jsonResponse(true, 'Login realizado com sucesso', $usuario);
        } else {
            jsonResponse(false, 'Email ou senha incorretos');
        }
    } catch(PDOException $e) {
        jsonResponse(false, 'Erro: ' . $e->getMessage());
    }
}

// FUNÇÃO PARA OBTER ALUNOS
function getAlunos($conn) {
    try {
        $query = "SELECT u.id, u.nome, u.email, u.matricula, u.telefone, 
                         t.nome as turma 
                  FROM usuarios u 
                  LEFT JOIN matriculas m ON u.id = m.aluno_id 
                  LEFT JOIN turmas t ON m.turma_id = t.id 
                  WHERE u.tipo = 'aluno' AND m.status = 'Ativo'";
        $stmt = $conn->prepare($query);
        $stmt->execute();
        
        $alunos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse(true, 'Alunos carregados', $alunos);
    } catch(PDOException $e) {
        jsonResponse(false, 'Erro: ' . $e->getMessage());
    }
}

// FUNÇÃO PARA OBTER NOTAS DO ALUNO
function getNotasAluno($conn, $aluno_id) {
    try {
        $query = "SELECT n.nota, n.observacoes, a.titulo as atividade, 
                         d.nome as disciplina, a.tipo, a.data_entrega
                  FROM notas n
                  JOIN atividades a ON n.atividade_id = a.id
                  JOIN disciplinas d ON a.disciplina_id = d.id
                  WHERE n.aluno_id = :aluno_id
                  ORDER BY a.data_entrega DESC";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':aluno_id', $aluno_id);
        $stmt->execute();
        
        $notas = $stmt->fetchAll(PDO::FETCH_ASSOC);
        jsonResponse(true, 'Notas carregadas', $notas);
    } catch(PDOException $e) {
        jsonResponse(false, 'Erro: ' . $e->getMessage());
    }
}

// Adicione outras funções conforme necessário...
?>