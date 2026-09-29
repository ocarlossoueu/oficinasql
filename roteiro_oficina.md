# Roteiro da Oficina — SQL na Prática
## Consultas e Análise de Dados para Iniciantes
**Duração:** 2 horas | **Ferramenta:** Neon (PostgreSQL) | **Público:** Estudantes de SI e Eng. de Software (iniciantes)

---

## ESTRUTURA GERAL

| Bloco | Tema | Tempo |
|-------|------|-------|
| 0 | Abertura e configuração do ambiente | 10 min |
| 1 | O que é SQL e como pensar em dados | 15 min |
| 2 | Primeiras consultas — SELECT, WHERE, ORDER BY, LIMIT | 25 min |
| 3 | Agrupando e calculando — GROUP BY, COUNT, AVG, SUM | 20 min |
| 4 | Cruzando tabelas — INNER, LEFT e FULL OUTER JOIN | 25 min |
| 5 | Análise real — CTEs e Histórico Escolar | 20 min |
| 6 | Encerramento e próximos passos | 5 min |

---

## BLOCO 0 — Abertura e configuração (10 min)

### Objetivo
Todos com o banco de dados carregado e funcionando no Neon antes de começar.

### Roteiro de fala

"Bom dia, pessoal! Sejam bem-vindos à oficina de SQL. Antes de qualquer explicação, a gente vai fazer uma coisa prática: acessar a ferramenta que vamos usar hoje.

O Neon é uma plataforma gratuita de PostgreSQL — o banco de dados real que o mercado usa. Não precisa instalar nada, roda direto no navegador.

[Projetar o link de acesso ao banco compartilhado]

Eu já preparei um banco de dados completo para vocês. O que vamos fazer agora é simples: acessar o link, confirmar que o banco carregou, e rodar uma query de teste para garantir que está tudo funcionando."

### Instrução prática
1. Todos acessam o Neon com o link compartilhado
2. Abrir o SQL Editor
3. Rodar a query de teste:

```sql
SELECT * FROM alunos LIMIT 5;
```

"Se apareceram 5 linhas com nomes de alunos, você está pronto. Se der erro, me chama."

---

## BLOCO 1 — O que é SQL e como pensar em dados (15 min)

### Objetivo
Construir o modelo mental de banco relacional antes de qualquer comando.

### Roteiro de fala

"Agora que o ambiente está funcionando, vamos entender o que é esse negócio de SQL.

SQL é uma linguagem para fazer perguntas a um banco de dados. Simples assim. Você tem dados organizados em tabelas — parecido com uma planilha do Excel, mas muito mais poderoso — e o SQL é a forma de você extrair exatamente o que precisa.

No nosso banco de dados de hoje, temos um sistema escolar fictício. Tem alunos, turmas, professores, matérias, notas e presenças. Tudo conectado.

[Projetar o diagrama das tabelas com as relações]

Repara uma coisa importante aqui. A tabela de alunos não guarda o nome da turma — ela guarda um número, o turma_id. Esse número aponta para a tabela de turmas. Isso se chama chave estrangeira, ou Foreign Key. É a forma que o banco usa para conectar informações sem repetir dados.

Por que isso importa? Imagina que a coordenação muda o nome da turma de 'SI-2024-1' para 'SIN-2024-1'. Se o nome estivesse repetido em 100 linhas de alunos, teria que mudar 100 linhas. Assim, muda em um lugar só — na tabela de turmas.

Isso é o que chamamos de modelo relacional. E é exatamente o que vocês vão começar a entender hoje na prática."

### Diagrama a projetar (texto simples)

```
especialidades ─── professores ─── turmas ─── alunos ─── notas ─── tipos_notas
                                      │           │
                                  matriculas   presencas
                                              materias ──────────────┘
```

---

## BLOCO 2 — Primeiras consultas (25 min)

### Objetivo
Dominar SELECT, FROM, WHERE, ORDER BY, LIMIT. Aprender a ler o resultado como resposta a uma pergunta.

### Roteiro de fala

"Agora a gente vai começar a colocar a mão na massa. A estrutura básica de qualquer consulta SQL é essa aqui:"

```sql
SELECT <colunas>
FROM   <tabela>
WHERE  <condição>
ORDER BY <coluna>
LIMIT  <n>;
```

"Lê assim: 'Me mostre essas colunas, da tabela tal, onde isso for verdade, ordenado por isso, e traz só N linhas.'

Vamos começar do mais simples e ir subindo."

---

### Consulta 1 — Listar todos os alunos

"Primeira pergunta: quem são os alunos cadastrados no sistema?"

```sql
SELECT nome, email
FROM   alunos;
```

"Repara que eu não pus asterisco (*). Poderia colocar SELECT * e traria todas as colunas, mas na prática a gente sempre especifica o que quer. Menos dados na tela, mais fácil de ler."

---

### Consulta 2 — Filtrar por condição (WHERE)

"Agora uma pergunta mais específica: quais alunos são da turma de ID 2?"

```sql
SELECT nome, email
FROM   alunos
WHERE  turma_id = 2;
```

"O WHERE filtra linhas. Só aparecem as linhas em que a condição é verdadeira."

"E se eu quiser mais de uma condição? Uso AND ou OR:"

```sql
SELECT nome, email, data_nascimento
FROM   alunos
WHERE  turma_id = 1
  AND  data_nascimento > '2002-01-01';
```

---

### Consulta 3 — Ordenar resultados (ORDER BY)

"Quero ver os alunos em ordem alfabética:"

```sql
SELECT nome, email
FROM   alunos
ORDER BY nome ASC;
```

"ASC é crescente, DESC é decrescente. Se eu quiser os últimos cadastrados primeiro, poderia ordenar pelo id DESC."

---

### Consulta 4 — Limitar resultados (LIMIT)

"E se eu quiser só os 3 primeiros da lista?"

```sql
SELECT nome, email
FROM   alunos
ORDER BY nome ASC
LIMIT  3;
```

"LIMIT é muito usado quando o banco tem milhões de linhas. Você não quer trazer tudo — quer checar se está certo antes."

---

### Consulta 5 — Explorar outras tabelas

"Vamos ver as matérias disponíveis:"

```sql
SELECT nome, carga_horaria
FROM   materias
ORDER BY nome;
```

"E os tipos de nota:"

```sql
SELECT *
FROM tipos_notas;
```

"Aqui faz sentido usar SELECT * porque a tabela é pequena e queremos ver tudo."

---

### Pausa e exercício rápido (5 min)

"Agora é com vocês. Tentem responder essa pergunta usando SQL:

**Liste o nome e o e-mail de todos os professores, em ordem alfabética.**

Dica: a tabela se chama `professores`."

**Resposta esperada:**
```sql
SELECT nome, email
FROM   professores
ORDER BY nome ASC;
```

---

## BLOCO 3 — Agrupando e calculando (20 min)

### Objetivo
Entender GROUP BY, HAVING e funções de agregação: COUNT, AVG, SUM, MAX, MIN.

### Roteiro de fala

"Até agora a gente buscou linhas individuais. Mas muitas das perguntas que a gente precisa responder são do tipo: 'quantos', 'qual a média', 'qual o total'. Para isso usamos funções de agregação."

```sql
SELECT COUNT(*) FROM alunos;
```

"Quantos alunos temos no total? Vinte. Mas e por turma?"

---

### Consulta 6 — GROUP BY

```sql
SELECT turma_id,
       COUNT(*) AS total_alunos
FROM   alunos
GROUP BY turma_id
ORDER BY turma_id;
```

"O GROUP BY agrupa as linhas pelo valor da coluna indicada e aplica a função de agregação em cada grupo separadamente.

Repara no AS — é um alias, um apelido para a coluna calculada. Sem ele, o resultado apareceria como 'count', o que não é muito amigável."

---

### Consulta 7 — Média de notas por matéria

```sql
SELECT materia_id,
       ROUND(AVG(nota), 2) AS media,
       COUNT(*)            AS total_avaliacoes,
       MIN(nota)           AS menor_nota,
       MAX(nota)           AS maior_nota
FROM   notas
GROUP BY materia_id
ORDER BY media DESC;
```

"Aqui a gente usou ROUND para arredondar, AVG para média, COUNT para contar, MIN e MAX para extremos. Tudo numa consulta só."

---

### Consulta 8 — HAVING (filtro após agrupamento)

"WHERE filtra antes de agrupar. HAVING filtra depois. Exemplo: quero só as matérias com média acima de 7:"

```sql
SELECT materia_id,
       ROUND(AVG(nota), 2) AS media
FROM   notas
GROUP BY materia_id
HAVING AVG(nota) > 7
ORDER BY media DESC;
```

"WHERE não funciona aqui porque a média ainda não existe quando o WHERE roda — ela só é calculada depois do GROUP BY."

---

### Consulta 9 — Contagem de presenças e faltas

```sql
SELECT aluno_id,
       COUNT(*)                                      AS total_aulas,
       SUM(CASE WHEN presente = true  THEN 1 ELSE 0 END) AS presencas,
       SUM(CASE WHEN presente = false THEN 1 ELSE 0 END) AS faltas
FROM   presencas
GROUP BY aluno_id
ORDER BY faltas DESC;
```

"O CASE WHEN funciona como um SE do Excel: 'se presente for verdadeiro, conta 1, senão conta 0'. Somando isso, a gente conta presenças e faltas separadamente."

---

## BLOCO 4 — Cruzando tabelas com JOIN (25 min)

### Objetivo
Entender INNER JOIN, LEFT JOIN e FULL OUTER JOIN. Saber quando usar cada um.

### Roteiro de fala

"Até agora a gente trabalhou com uma tabela por vez. Mas o poder real do banco relacional está em cruzar tabelas. E é aqui que entra o JOIN.

Lembra que o aluno tem um turma_id e não o nome da turma? Com JOIN, a gente une as duas tabelas pelo id e traz os dados de ambas."

---

### Conceito visual — projetar diagrama

```
alunos              turmas
┌──────────────┐    ┌─────────────────┐
│ id           │    │ id              │
│ nome         │    │ nome            │
│ turma_id ────┼────┤ ano             │
└──────────────┘    │ semestre        │
                    └─────────────────┘

INNER JOIN → só linhas que têm correspondência nos dois lados
LEFT  JOIN → todas as linhas da esquerda + correspondência da direita (NULL se não tiver)
FULL OUTER JOIN → todas as linhas dos dois lados
```

---

### Consulta 10 — INNER JOIN básico

```sql
SELECT a.nome        AS aluno,
       t.nome        AS turma,
       t.ano,
       t.semestre
FROM   alunos a
INNER JOIN turmas t ON a.turma_id = t.id
ORDER BY t.ano, t.semestre, a.nome;
```

"Repara nos aliases: `alunos a` significa que posso chamar a tabela de 'a' daqui pra frente. Isso é muito útil quando a consulta tem várias tabelas."

---

### Consulta 11 — JOIN com três tabelas

```sql
SELECT a.nome        AS aluno,
       m.nome        AS materia,
       tn.nome       AS tipo_avaliacao,
       n.nota
FROM   notas n
INNER JOIN alunos   a  ON n.aluno_id   = a.id
INNER JOIN materias m  ON n.materia_id = m.id
INNER JOIN tipos_notas tn ON n.tipo_id = tn.id
ORDER BY a.nome, m.nome, tn.nome;
```

"Aqui a gente juntou quatro tabelas. O resultado traz nomes em vez de IDs — exatamente o que qualquer pessoa que olhar o relatório vai entender."

---

### Consulta 12 — LEFT JOIN

"E se a gente quiser listar todos os professores, mesmo os que não têm turma atribuída?"

```sql
SELECT p.nome        AS professor,
       e.nome        AS especialidade,
       t.nome        AS turma,
       t.ano,
       t.semestre
FROM   professores p
INNER JOIN especialidades e ON p.especialidade_id = e.id
LEFT  JOIN turmas t         ON t.professor_id     = p.id
ORDER BY p.nome;
```

"O LEFT JOIN garante que todos os professores aparecem. Professores sem turma aparecem com NULL nas colunas de turma. Se fosse INNER JOIN, eles sumiriam do resultado."

---

### Consulta 13 — FULL OUTER JOIN

"O FULL OUTER JOIN traz tudo dos dois lados — útil para auditorias, quando você quer identificar registros órfãos."

```sql
SELECT a.nome AS aluno,
       m.nome AS aluno_matricula,
       t.nome AS turma_existente
FROM   matriculas m
FULL OUTER JOIN alunos a ON m.aluno_id = a.id
FULL OUTER JOIN turmas t ON m.turma_id = t.id
ORDER BY a.nome;
```

"Na prática, FULL OUTER JOIN é menos comum que INNER e LEFT, mas importante conhecer."

---

### Pausa e exercício (5 min)

"Desafio: liste o nome do aluno, o nome da matéria e a média das notas dele nessa matéria. Arredonde para 2 casas decimais."

**Resposta esperada:**
```sql
SELECT a.nome                    AS aluno,
       m.nome                    AS materia,
       ROUND(AVG(n.nota), 2)     AS media
FROM   notas n
INNER JOIN alunos   a ON n.aluno_id   = a.id
INNER JOIN materias m ON n.materia_id = m.id
GROUP BY a.nome, m.nome
ORDER BY a.nome, m.nome;
```

---

## BLOCO 5 — CTEs e Histórico Escolar (20 min)

### Objetivo
Entender CTEs (WITH) e construir a análise de aprovação/reprovação combinando notas e frequência.

### Roteiro de fala

"Chegamos na análise mais completa da oficina. Vamos construir o histórico escolar — aquele documento que diz se o aluno foi aprovado ou reprovado em cada matéria.

A regra é:
- Média das notas >= 6.0 → aprovado por nota
- Frequência >= 75% da carga horária (mínimo 12 presenças de 16) → aprovado por frequência
- **Só é aprovado quem passa nos dois critérios**

Para organizar uma consulta complexa assim, usamos CTEs — Common Table Expressions. É uma forma de dar nome a um resultado intermediário e usar esse resultado como se fosse uma tabela."

---

### Passo 1 — CTE de médias

```sql
WITH medias AS (
    SELECT n.aluno_id,
           n.materia_id,
           ROUND(AVG(n.nota), 2) AS media
    FROM   notas n
    GROUP BY n.aluno_id, n.materia_id
)
SELECT * FROM medias LIMIT 10;
```

"A CTE `medias` calcula a média de cada aluno em cada matéria. A gente roda isso isolado primeiro para conferir se está certo."

---

### Passo 2 — CTE de frequência

```sql
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
```

"O ::numeric é um cast — converte o número para que a divisão não arredonde para inteiro."

---

### Passo 3 — Histórico Escolar Completo

```sql
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
    SELECT a.nome                          AS aluno,
           t.ano,
           t.semestre,
           m.nome                          AS materia,
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
           END                             AS situacao
    FROM   medias med
    INNER JOIN frequencias freq ON med.aluno_id   = freq.aluno_id
                                AND med.materia_id = freq.materia_id
    INNER JOIN alunos   a ON med.aluno_id   = a.id
    INNER JOIN materias m ON med.materia_id = m.id
    INNER JOIN turmas   t ON a.turma_id     = t.id
)
SELECT *
FROM   historico
ORDER BY ano, semestre, aluno, materia;
```

### Narrativa de fechamento

"Vejam o resultado. Temos o histórico completo de cada aluno, por matéria, com a média, a frequência e a situação final.

Esse é o tipo de consulta que alimenta um sistema de gestão escolar real. Com algumas linhas a mais, isso já estaria pronto para um relatório de secretaria ou um dashboard no Power BI.

O que vocês fizeram agora — combinar CTEs, JOINs, agregações e CASE WHEN — é exatamente o que engenheiros de dados e analistas fazem no dia a dia."

---

### Consulta bônus (se sobrar tempo)

**Ranking de alunos por média geral no semestre:**

```sql
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
```

---

## BLOCO 6 — Encerramento (5 min)

### Roteiro de fala

"Em duas horas vocês saíram do zero e chegaram em:

- SELECT, WHERE, ORDER BY, LIMIT
- Funções de agregação: COUNT, AVG, SUM, MIN, MAX
- GROUP BY e HAVING
- INNER JOIN, LEFT JOIN, FULL OUTER JOIN
- CTEs para organizar consultas complexas
- Uma análise de histórico escolar real

SQL é provavelmente a habilidade técnica mais transversal que existe em TI. Não importa se você vai trabalhar com desenvolvimento, dados, infraestrutura ou gestão — você vai esbarrar com banco de dados.

O banco que vocês usaram hoje fica disponível. Guardem o link do Neon, brinquem com as consultas, tentem modificar os filtros, criem suas próprias perguntas.

O próximo passo natural daqui é aprender sobre subconsultas, índices e modelagem de banco — que é justamente o que vocês estão vendo na disciplina.

Alguma dúvida antes de encerrarmos?"

---

## MATERIAL DE APOIO — Consultas de referência rápida

```sql
-- Estrutura básica
SELECT coluna1, coluna2 FROM tabela WHERE condição ORDER BY coluna LIMIT n;

-- Aggregações
SELECT coluna, COUNT(*), AVG(valor), SUM(valor), MIN(valor), MAX(valor)
FROM tabela GROUP BY coluna HAVING condição;

-- JOIN
SELECT a.col, b.col
FROM tabela_a a
INNER JOIN tabela_b b ON a.fk = b.id;

-- CTE
WITH nome_cte AS (
    SELECT ... FROM ... WHERE ...
)
SELECT * FROM nome_cte;

-- CASE WHEN
SELECT CASE WHEN condição THEN 'valor1' ELSE 'valor2' END AS coluna
FROM tabela;
```

