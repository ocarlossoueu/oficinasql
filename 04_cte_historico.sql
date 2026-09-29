-- ============================================================
-- BLOCO 5 — CTEs e Histórico Escolar
-- WITH, CASE WHEN, análise de aprovação
-- Regras: média >= 6.0 E frequência >= 75%
-- ============================================================

-- Passo 1: CTE de médias (verificar isolado)
WITH medias AS (
    SELECT n.aluno_id,
           n.materia_id,
           ROUND(AVG(n.nota), 2) AS media
    FROM   notas n
    GROUP BY n.aluno_id, n.materia_id
)
SELECT * FROM medias LIMIT 10;

-- Passo 2: CTE de frequência (verificar isolado)
WITH frequencias AS (
    SELECT p.aluno_id,
           p.materia_id,
           COUNT(*)                                              AS total_aulas,
           SUM(CASE WHEN p.presente = true THEN 1 ELSE 0 END)  AS presencas,
           ROUND(
               SUM(CASE WHEN p.presente = true THEN 1 ELSE 0 END)::numeric
               / COUNT(*) * 100, 1
           )                                                    AS percentual_presenca
    FROM   presencas p
    GROUP BY p.aluno_id, p.materia_id
)
SELECT * FROM frequencias LIMIT 10;

-- Passo 3: Histórico Escolar Completo
WITH medias AS (
    SELECT n.aluno_id,
           n.materia_id,
           ROUND(AVG(n.nota), 2) AS media
    FROM   notas n
    GROUP BY n.aluno_id, n.materia_id
),
frequencias AS (
    SELECT p.aluno_id,
           p.materia_id,
           SUM(CASE WHEN p.presente = true THEN 1 ELSE 0 END) AS presencas,
           ROUND(
               SUM(CASE WHEN p.presente = true THEN 1 ELSE 0 END)::numeric
               / COUNT(*) * 100, 1
           ) AS percentual_presenca
    FROM   presencas p
    GROUP BY p.aluno_id, p.materia_id
),
historico AS (
    SELECT a.nome                 AS aluno,
           t.ano,
           t.semestre,
           m.nome                 AS materia,
           med.media,
           freq.presencas,
           freq.percentual_presenca,
           CASE
               WHEN med.media >= 6.0 AND freq.percentual_presenca >= 75
                   THEN 'Aprovado'
               WHEN med.media < 6.0 AND freq.percentual_presenca >= 75
                   THEN 'Reprovado por Nota'
               WHEN med.media >= 6.0 AND freq.percentual_presenca < 75
                   THEN 'Reprovado por Falta'
               ELSE 'Reprovado por Nota e Falta'
           END                    AS situacao
    FROM   medias med
    INNER JOIN frequencias freq ON med.aluno_id   = freq.aluno_id
                               AND med.materia_id  = freq.materia_id
    INNER JOIN alunos   a ON med.aluno_id   = a.id
    INNER JOIN materias m ON med.materia_id = m.id
    INNER JOIN turmas   t ON a.turma_id     = t.id
)
SELECT *
FROM   historico
ORDER BY ano, semestre, aluno, materia;

-- BONUS: Ranking de alunos por média geral no semestre
WITH medias AS (
    SELECT n.aluno_id,
           ROUND(AVG(n.nota), 2) AS media_geral
    FROM   notas n
    GROUP BY n.aluno_id
)
SELECT a.nome       AS aluno,
       t.ano,
       t.semestre,
       med.media_geral
FROM   medias med
INNER JOIN alunos a ON med.aluno_id = a.id
INNER JOIN turmas t ON a.turma_id   = t.id
ORDER BY t.ano, t.semestre, med.media_geral DESC;
