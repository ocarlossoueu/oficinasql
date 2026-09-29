# 🎓 Oficina SQL — SQL na Prática

> Consultas e Análise de Dados para Iniciantes  
> Ministrada por Carlos Amaral de Amarijo — UFR

---

## 📋 Sobre a oficina

Oficina prática de 2 horas voltada a estudantes de Sistemas de Informação e Engenharia de Software.  
Os participantes trabalham com um banco de dados escolar completo e aprendem SQL do zero até análises com CTEs e JOINs.

**Carga horária:** 2 horas  
**Ferramenta:** [Neon](https://neon.tech) — PostgreSQL serverless, gratuito, sem instalação  
**Público:** Iniciantes em SQL

---

## 🗂️ Estrutura do repositório

```
oficinasql/
├── banco/
│   └── banco_escolar.sql       # Script completo: CREATE TABLE + INSERT
├── queries/
│   ├── 01_select_basico.sql    # Bloco 2 — SELECT, WHERE, ORDER BY, LIMIT
│   ├── 02_agregacoes.sql       # Bloco 3 — GROUP BY, COUNT, AVG, SUM
│   ├── 03_joins.sql            # Bloco 4 — INNER, LEFT e FULL OUTER JOIN
│   └── 04_cte_historico.sql    # Bloco 5 — CTEs e Histórico Escolar
└── roteiro/
    └── roteiro_oficina.md      # Roteiro completo com narrativa expositiva
```

---

## 🚀 Como usar

### 1. Acesse o Neon
- Entre em [neon.tech](https://neon.tech) e crie uma conta gratuita (pode usar login com GitHub)
- Crie um novo projeto PostgreSQL

### 2. Importe o banco de dados
- No Neon, abra o **SQL Editor**
- Copie o conteúdo de [`banco/banco_escolar.sql`](banco/banco_escolar.sql)
- Cole no editor e execute

### 3. Execute as queries
- Os arquivos na pasta `queries/` estão organizados por bloco da oficina
- Execute na ordem para acompanhar a progressão do conteúdo

---

## 📊 Modelo de dados

```
especialidades ──── professores ──── turmas ──── alunos
                                        │            │
                                    matriculas     notas ──── tipos_notas
                                                   │
                                               presencas
                                               materias
```

### Tabelas

| Tabela | Tipo | Descrição |
|--------|------|-----------|
| `especialidades` | Dimensão | Áreas de especialidade dos professores |
| `professores` | Dimensão | Professores e suas especialidades |
| `turmas` | Dimensão | Turmas por ano e semestre |
| `materias` | Dimensão | Disciplinas com carga horária |
| `tipos_notas` | Dimensão | Tipos de avaliação (Prova 1, Prova 2, Trabalho) |
| `alunos` | Fato/Rel | Alunos vinculados a turmas |
| `matriculas` | Fato | Matrículas de alunos em turmas |
| `notas` | Fato | Notas por aluno, matéria e tipo de avaliação |
| `presencas` | Fato | Registro de presença/falta por aula |

### Regras de aprovação
- **Média ≥ 6.0** em cada matéria
- **Frequência ≥ 75%** da carga horária (mínimo 12 de 16 aulas)
- O aluno precisa atender **ambos** os critérios

---

## 📅 Semestres disponíveis

| Turma | Ano | Semestre |
|-------|-----|----------|
| SI-2024-1 | 2024 | 1º |
| SI-2024-2 | 2024 | 2º |
| SI-2025-1 | 2025 | 1º |
| SI-2025-2 | 2025 | 2º |

---

## 👨‍🏫 Autor

**Carlos Amaral de Amarijo**  
Discente — Bacharelado em Sistemas de Informação  
Universidade Federal de Rondonópolis (UFR)  
GitHub: [@ocarlossoueu](https://github.com/ocarlossoueu)
