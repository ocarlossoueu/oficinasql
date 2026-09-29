-- ============================================================
-- BLOCO 4 — Cruzando Tabelas
-- INNER JOIN, LEFT JOIN, FULL OUTER JOIN
-- ============================================================

-- Consulta 1: INNER JOIN — alunos com nome da turma
SELECT a.nome AS aluno,
       t.nome AS turma,
       t.ano,
       t.semestre
FROM   alunos a
INNER JOIN turmas t ON a.turma_id = t.id
ORDER BY t.ano, t.semestre, a.nome;

-- Consulta 2: JOIN com quatro tabelas — notas com nomes
SELECT a.nome  AS aluno,
       m.nome  AS materia,
       tn.nome AS tipo_avaliacao,
       n.nota
FROM   notas n
INNER JOIN alunos      a  ON n.aluno_id   = a.id
INNER JOIN materias    m  ON n.materia_id = m.id
INNER JOIN tipos_notas tn ON n.tipo_id    = tn.id
ORDER BY a.nome, m.nome, tn.nome;

-- Consulta 3: LEFT JOIN — todos os professores, com ou sem turma
SELECT p.nome AS professor,
       e.nome AS especialidade,
       t.nome AS turma,
       t.ano,
       t.semestre
FROM   professores p
INNER JOIN especialidades e ON p.especialidade_id = e.id
LEFT  JOIN turmas         t ON t.professor_id     = p.id
ORDER BY p.nome;

-- Consulta 4: FULL OUTER JOIN — auditoria de matrículas
SELECT a.nome AS aluno,
       t.nome AS turma_existente
FROM   matriculas m
FULL OUTER JOIN alunos a ON m.aluno_id = a.id
FULL OUTER JOIN turmas t ON m.turma_id = t.id
ORDER BY a.nome;

-- EXERCICIO: Liste o nome do aluno, o nome da matéria
-- e a média das notas, arredondada para 2 casas decimais.

-- RESPOSTA:
SELECT a.nome                AS aluno,
       m.nome                AS materia,
       ROUND(AVG(n.nota), 2) AS media
FROM   notas n
INNER JOIN alunos   a ON n.aluno_id   = a.id
INNER JOIN materias m ON n.materia_id = m.id
GROUP BY a.nome, m.nome
ORDER BY a.nome, m.nome;
