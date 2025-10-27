USE sistema_academico;

-- Inserir Professor Helcio Soares Padilha
INSERT INTO usuarios (email, senha, nome, tipo, telefone) VALUES
('helcio.padilha@escola.com', '123456', 'Helcio Soares Padilha', 'professor', '(11) 99999-0000');

-- Inserir Alunos da 3° TDS
INSERT INTO usuarios (email, senha, nome, tipo, matricula, telefone) VALUES
('anna.lima@escola.com', '123456', 'Anna Julia de Lima', 'aluno', '20243001', '(11) 99999-0001'),
('adrian.rodrigo@escola.com', '123456', 'Adrian Rodrigo', 'aluno', '20243002', '(11) 99999-0002'),
('hygor.meireles@escola.com', '123456', 'Hygor Meireles', 'aluno', '20243003', '(11) 99999-0003'),
('pedro.camargo@escola.com', '123456', 'Pedro Henrique Camargo', 'aluno', '20243004', '(11) 99999-0004'),
('emilly.vieira@escola.com', '123456', 'Emilly Vieira', 'aluno', '20243005', '(11) 99999-0005'),
('thiago.tavares@escola.com', '123456', 'Thiago Tavares', 'aluno', '20243006', '(11) 99999-0006'),
('vinicius.fidelis@escola.com', '123456', 'Vinicius Fidelis', 'aluno', '20243007', '(11) 99999-0007');

-- Inserir Turma 3° TDS
INSERT INTO turmas (nome, ano, periodo, sala, capacidade, professor_id) VALUES
('3° TDS', 2024, 'Matutino', 'Laboratório 04', 30, 1);

-- Inserir Disciplinas
INSERT INTO disciplinas (codigo, nome, carga_horaria, professor_id, turma_id) VALUES
('DW-301', 'Desenvolvimento Web', 80, 1, 1),
('BD-302', 'Banco de Dados', 60, 1, 1),
('PM-303', 'Programação Mobile', 70, 1, 1),
('RC-304', 'Redes de Computadores', 50, 1, 1),
('ES-305', 'Engenharia de Software', 60, 1, 1);

-- Matricular alunos na turma
INSERT INTO matriculas (aluno_id, turma_id, data_matricula) VALUES
(2, 1, '2024-01-15'), (3, 1, '2024-01-15'), (4, 1, '2024-01-15'),
(5, 1, '2024-01-15'), (6, 1, '2024-01-15'), (7, 1, '2024-01-15'), (8, 1, '2024-01-15');

-- Inserir Atividades
INSERT INTO atividades (titulo, descricao, disciplina_id, tipo, data_entrega, valor) VALUES
('Projeto Site Institucional', 'Criar um site institucional responsivo usando HTML, CSS e JavaScript', 1, 'Projeto', '2024-04-10', 10.0),
('Modelagem Banco Escola', 'Modelar o banco de dados para sistema escolar com diagrama ER', 2, 'Trabalho', '2024-04-05', 8.0),
('App Lista de Tarefas', 'Desenvolver aplicativo mobile de lista de tarefas com React Native', 3, 'Projeto', '2024-03-28', 12.0),
('Prova Bimestral - Redes', 'Prova teórica sobre protocolos e configuração de redes', 4, 'Prova', '2024-04-15', 10.0);

-- Inserir Notas de Exemplo
INSERT INTO notas (aluno_id, atividade_id, nota, observacoes) VALUES
(2, 1, 8.5, 'Bom trabalho'), (3, 1, 7.8, 'Precisa melhorar responsividade'),
(4, 1, 9.2, 'Excelente!'), (5, 1, 6.0, 'Entregue incompleto'),
(2, 2, 7.5, NULL), (3, 2, 8.0, NULL), (4, 2, 8.8, NULL);

-- Inserir Frequência
INSERT INTO frequencia (aluno_id, disciplina_id, data_aula, presente, observacoes) VALUES
(2, 1, '2024-03-01', TRUE, NULL),
(3, 1, '2024-03-01', TRUE, NULL),
(4, 1, '2024-03-01', FALSE, 'Atestado médico'),
(2, 2, '2024-03-02', TRUE, NULL),
(3, 2, '2024-03-02', TRUE, NULL);

-- Inserir Materiais
INSERT INTO materiais (titulo, descricao, disciplina_id, tipo, arquivo_path, tamanho) VALUES
('Apostila HTML5 e CSS3', 'Guia completo de HTML5 e CSS3 com exemplos práticos', 1, 'Apostila', '/materiais/html-css.pdf', '4.2 MB'),
('Slides Modelagem de Dados', 'Apresentação sobre modelagem ER e normalização', 2, 'Slides', '/materiais/modelagem-dados.pptx', '2.8 MB'),
('Exercícios React Native', 'Lista de exercícios práticos de React Native', 3, 'Exercícios', '/materiais/react-native.pdf', '1.5 MB');