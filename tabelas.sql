-- Banco de dados: sistema_academico
CREATE DATABASE IF NOT EXISTS sistema_academico;
USE sistema_academico;

-- Tabela de Usuários
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('professor', 'aluno') NOT NULL,
    matricula VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Turmas
CREATE TABLE turmas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    periodo ENUM('Matutino', 'Vespertino', 'Noturno') NOT NULL,
    sala VARCHAR(20),
    capacidade INT,
    professor_id INT,
    status ENUM('Ativa', 'Inativa') DEFAULT 'Ativa',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (professor_id) REFERENCES usuarios(id)
);

-- Tabela de Disciplinas
CREATE TABLE disciplinas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    professor_id INT,
    turma_id INT,
    status ENUM('Ativa', 'Inativa') DEFAULT 'Ativa',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (professor_id) REFERENCES usuarios(id),
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

-- Tabela de Matrículas (Alunos na Turma)
CREATE TABLE matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    turma_id INT,
    data_matricula DATE NOT NULL,
    status ENUM('Ativo', 'Inativo', 'Transferido') DEFAULT 'Ativo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id),
    FOREIGN KEY (turma_id) REFERENCES turmas(id),
    UNIQUE KEY unique_matricula (aluno_id, turma_id)
);

-- Tabela de Atividades
CREATE TABLE atividades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    disciplina_id INT,
    tipo ENUM('Prova', 'Trabalho', 'Exercício', 'Projeto', 'Apresentação') NOT NULL,
    data_entrega DATE NOT NULL,
    valor DECIMAL(5,2) NOT NULL,
    status ENUM('Pendente', 'Entregue', 'Avaliada', 'Cancelada') DEFAULT 'Pendente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);

-- Tabela de Notas
CREATE TABLE notas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    atividade_id INT,
    nota DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 10),
    observacoes TEXT,
    data_lancamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id),
    FOREIGN KEY (atividade_id) REFERENCES atividades(id),
    UNIQUE KEY unique_avaliacao (aluno_id, atividade_id)
);

-- Tabela de Frequência
CREATE TABLE frequencia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    disciplina_id INT,
    data_aula DATE NOT NULL,
    presente BOOLEAN DEFAULT TRUE,
    justificativa TEXT,
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id),
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    UNIQUE KEY unique_presenca (aluno_id, disciplina_id, data_aula)
);

-- Tabela de Materiais
CREATE TABLE materiais (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    disciplina_id INT,
    tipo ENUM('Apostila', 'Slides', 'Exercícios', 'Projeto', 'Vídeo') NOT NULL,
    arquivo_path VARCHAR(500),
    tamanho VARCHAR(20),
    downloads INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id)
);