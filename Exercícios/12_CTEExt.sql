-- quem iniciou o curso assistiu em media quantas aulas

-- quem participou da primeira aula


With tb_prim_dia AS (

SELECT 

DISTINCT IdCliente

FROM transacoes

WHERE substr(DtCriacao, 1,10) = '2025-08-25'

),

-- quem participou do curso inteiro

tb_dias_curso AS (

SELECT DISTINCT 
    IdCliente, 
    substr(Dtcriacao,1,10) AS presenteDia
FROM transacoes

WHERE substr(DTcriacao,1,10) >= '2025-08-25' 
AND substr(DTcriacao,1,10) <= '2025-08-30'
ORDER BY IdCliente, presenteDia

),

-- contando quantas vezes quem participou do primeiro dia voltou

tb_clientes_dias AS (

SELECT
    t1.IdCliente,
    count(presentedia) AS qtdedias
FROM tb_prim_dia as t1
LEFT JOIN tb_dias_curso AS t2
ON t1.IdCliente = t2.IdCliente
GROUP BY t1.IdCliente
)

-- calculando a media

SELECT 

AVG(qtdedias)

FROM tb_clientes_dias


--- # dentre os clientes de janeiro, quantos assistiram o curso de SQL?



WITH clientes_janeiro AS
(
SELECT 
    Idcliente AS clientes_janeiro,
    DtCriacao
FROM clientes

WHERE

substr(Dtcriacao,1,7) = '2025-01'
),

clientes_sql AS 

(
SELECT DISTINCT
    Idcliente AS clientes_sql
FROM transacoes
WHERE 
substr(Dtcriacao,1,10) >= '2025-08-24'
AND substr(Dtcriacao,1,10) <= '2025-08-30'
)

SELECT 
    COUNT (clientes_sql) AS clientes_janeiro_sql
FROM clientes_janeiro AS t1
LEFT JOIN clientes_sql AS t2
ON clientes_janeiro = clientes_sql


-- qual foi o dia com maior engajamento de cada aluno que entrou no dia 1




-- QUAL FOI A CURVA DE CHERN DO CURSO DE SQL

-- SELECT 

--     DtCriacao,
--     substr(Dtcriacao,1,10) AS dtdia),
--     COUNT (DISTINCT IdCliente) AS qtdd_cliente

-- FROM transacoes
-- WHERE 
-- substr(Dtcriacao,1,10) >= '2025-08-24'
-- AND substr(Dtcriacao,1,10) <= '2025-08-29'
-- GROUP BY dtDia

WITH 
tb_clientes_d1 AS 
(
SELECT DISTINCT idcliente
FROM transacoes 
WHERE DtCriacao >= '2025-08-2025'
AND DtCriacao < '2025-08-26'
)

SELECT *
FROM tb_clientes_d1 AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
 WHERE 
 substr(Dtcriacao,1,10) >= '2025-08-24'
AND substr(Dtcriacao,1,10) <= '2025-08-29'

