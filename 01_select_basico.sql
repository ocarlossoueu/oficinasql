-- ============================================================
-- BLOCO 2 — Primeiras Consultas
-- SELECT, WHERE, ORDER BY, LIMIT
-- ============================================================

-- Consulta 1: Listar todos os alunos
SELECT nome, email
FROM   alunos;

-- Consulta 2: Filtrar por turma
SELECT nome, email
FROM   alunos
WHERE  turma_id = 2;

-- Consulta 3: Múltiplas condições com AND
SELECT nome, email, data_nascimento
FROM   alunos
WHERE  turma_id = 1
  AND  data_nascimento > '2002-01-01';

-- Consulta 4: Ordenar resultados
SELECT nome, email
FROM   alunos
ORDER BY nome ASC;

-- Consulta 5: Limitar resultados
SELECT nome, email
FROM   alunos
ORDER BY nome ASC
LIMIT  3;

-- Consulta 6: Listar matérias
SELECT nome, carga_horaria
FROM   materias
ORDER BY nome;

-- Consulta 7: Tipos de nota disponíveis
SELECT *
FROM   tipos_notas;

-- EXERCICIO: Liste o nome e e-mail de todos os professores em ordem alfabética.
-- Dica: a tabela se chama "professores"

-- RESPOSTA:
SELECT nome, email
FROM   professores
ORDER BY nome ASC;
