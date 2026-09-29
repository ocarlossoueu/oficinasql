-- ============================================================
-- BLOCO 3 — Agrupando e Calculando
-- GROUP BY, HAVING, COUNT, AVG, SUM, MIN, MAX
-- ============================================================

-- Consulta 1: Total de alunos
SELECT COUNT(*) AS total_alunos
FROM   alunos;

-- Consulta 2: Total de alunos por turma
SELECT turma_id,
       COUNT(*) AS total_alunos
FROM   alunos
GROUP BY turma_id
ORDER BY turma_id;

-- Consulta 3: Estatísticas de notas por matéria
SELECT materia_id,
       ROUND(AVG(nota), 2) AS media,
       COUNT(*)            AS total_avaliacoes,
       MIN(nota)           AS menor_nota,
       MAX(nota)           AS maior_nota
FROM   notas
GROUP BY materia_id
ORDER BY media DESC;

-- Consulta 4: HAVING — apenas matérias com média acima de 7
SELECT materia_id,
       ROUND(AVG(nota), 2) AS media
FROM   notas
GROUP BY materia_id
HAVING AVG(nota) > 7
ORDER BY media DESC;

-- Consulta 5: Contagem de presenças e faltas por aluno
SELECT aluno_id,
       COUNT(*)                                           AS total_aulas,
       SUM(CASE WHEN presente = true  THEN 1 ELSE 0 END) AS presencas,
       SUM(CASE WHEN presente = false THEN 1 ELSE 0 END) AS faltas
FROM   presencas
GROUP BY aluno_id
ORDER BY faltas DESC;
