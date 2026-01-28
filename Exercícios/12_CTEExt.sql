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
substr(Dtcriacao,1,10) >= '2025-08-25'
AND substr(Dtcriacao,1,10) <= '2025-08-30'
)

SELECT 
    COUNT (clientes_sql) AS clientes_janeiro_sql
FROM clientes_janeiro AS t1
LEFT JOIN clientes_sql AS t2
ON clientes_janeiro = clientes_sql


-- qual foi o dia com maior engajamento de cada aluno que entrou no dia 1

WITH tb_contagem
AS

(

SELECT
    IdCliente as id_c,
    substr(DtCriacao,1,10) AS data_transacao,
    COUNT(IdTransacao) AS total_transacoes
FROM transacoes
WHERE substr(DtCriacao,1,10) >= '2025-08-25'
AND substr (DtCriacao,1,10) <= '2025-08-28'
GROUP BY data_transacao,id_c
ORDER BY id_c
),

max_por_cliente

AS 
(
SELECT
        id_c,
        MAX(total_transacoes) AS max_trans
    FROM tb_contagem
    GROUP BY id_c

)

SELECT 
    t.id_c,
    t.data_transacao,
    t.total_transacoes
FROM tb_contagem AS t
INNER JOIN max_por_cliente AS  m 
ON t.id_c = m.id_c 
WHERE t.total_transacoes = m.max_trans
ORDER BY t.id_c;



-- QUAL FOI A CURVA DEHERN DO CURSO DE SQL

SELECT 
    substr(DtCriacao,1,10) AS dtDia,
    Count(DISTINCT IdCliente) as QtdCliente
FROM transacoes
WHERE substr(DtCriacao,1,10) >= '2025-08-25'
AND substr (DtCriacao,1,10) <= '2025-08-28'
GROUP BY Dtdia;

-- Obs: Essa nao eh a melhor forma de fazer porque
-- pode ser que pessoas novas estejam entrando

WITH

Tb_clientes_curso

AS 

(SELECT 
    DISTINCT IdCliente as clientesCurso,
    substr(DtCriacao,1,10) AS dtDia2  
FROM transacoes
WHERE substr(DtCriacao,1,10) >= '2025-08-25'
AND substr (DtCriacao,1,10) <= '2025-08-30'
),

tb_clientes_primeiro_dia

AS (

SELECT 
    DISTINCT idCliente AS clientesPrimeiroDia,
    substr(DtCriacao,1,10) AS dtDia1
FROM transacoes
WHERE substr(DtCriacao,1,10) = '2025-08-25'

)


SELECT 
    COUNT(DISTINCT clientesCurso),
    dtDia2
FROM tb_clientes_curso
INNER JOIN tb_clientes_primeiro_dia
ON clientesPrimeiroDia = clientesCurso
GROUP BY dtDia2;

-- outra forma de fazer



WITH

Tb_clientes_curso

AS 

(SELECT 
    DISTINCT IdCliente,
    substr(DtCriacao,1,10) AS dtDia2  
FROM transacoes
WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-26'
)

SELECT 
    substr(t2.DtCriacao,1,10) AS DtDia,
    COUNT(DISTINCT t1.idCliente) AS qtdCliente,
-- voce pode usar uma query dentro de um select
   1. * COUNT(DISTINCT t1.idCliente) / (SELECT COUNT (*) FROM Tb_clientes_curso)
FROM Tb_clientes_curso AS t1
LEFT JOIN transacoes AS t2 
ON t1.IdCliente = t2.IdCliente
WHERE substr(DtCriacao,1,10) >= '2025-08-25'
AND substr (DtCriacao,1,10) <= '2025-08-30'
GROUP BY DtDia;



--- DENTRE OS CLIENTES DE JANEIRO, QUANTOS ASSISTIRAM O CURSO DE SQL?

WITH

ClientesJaneiro

AS
(
SELECT 
    DISTINCT IdCliente,
    DtCriacao
FROM transacoes
WHERE substr(DtCriacao,1,10) >= '2025-01-01'
AND substr(DtCriacao,1,10) < '2025-02-01'
),

ClientesSQL
AS

( 
SELECT 
    DISTINCT IdCliente,
    DtCriacao
FROM transacoes
WHERE substr(DtCriacao,1,10) >= '2025-08-25'
AND substr(DtCriacao,1,10) < '2025-08-30'
)

SELECT 
    COUNT(DISTINCT t2.IdCliente) AS ClientesdeJaneiro,
    COUNT(DISTINCT t1.IdCliente) AS ClientesJaneiroNoCursoSQL
FROM ClientesJaneiro AS t1
LEFT JOIN ClientesSQL AS t2
ON t1.IdCliente = t2.IdCliente;


