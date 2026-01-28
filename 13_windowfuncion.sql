-- qual o dia com maior engajamento de cada aluno no curso no dia 1?

WITH alunos_dia01 AS

(
SELECT DISTINCT
IdCliente
FROM transacoes
WHERE substr(Dtcriacao,1,10) = '2025-08-25'

),

tb_diacliente

AS(

SELECT 
    t1.IdCliente,
    substr(t2.DtCriacao,1,10) as DtDia,
    count(IdTransacao) qtdinteracoes
FROM alunos_dia01 AS t1
LEFT JOIN transacoes as t2
ON t1.IdCliente = t2.IdCliente
AND t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30'
GROUP BY t1.IdCliente, DtDia
ORDER BY t1.IDCLiente, dtDia
),

tb_rn AS 
(
SELECT *,
    row_number() OVER (PARTITION BY idCliente ORDER BY qtdinteracoes DESC, DtDia) AS rn
FROM tb_diacliente
)

SELECT *
FROM tb_rn
WHERE rn = 1;


-- acumulado

With tb_sumario_dias AS 
(
SELECT 
    substr(DtCriacao,1,10) AS dtDia,
    Count(distinct IdTransacao) AS qtdeTransacao
FROM transacoes
WHERE dtDia >= '2025-08-25'
AND dtDia < '2025-08-30'
GROUP BY dtDia

)

SELECT *, 
    sum(qtdeTransacao) OVER (ORDER BY dtDia) AS qtTransacaoAcum 
FROM tb_sumario_dias;


-- acumulado de transacoes das pessoas

WITH tb_sumario_clientes AS 
(
SELECT 
    IdCliente,
    substr(DtCriacao,1,10) AS Dtdia,
    Count(distinct IdTransacao) AS qtdeTransacao
FROM transacoes
WHERE  substr(DtCriacao,1,10)>= '2025-08-25'
AND  substr(DtCriacao,1,10) < '2025-08-30'
GROUP BY IdCliente,dtDia

)

SELECT 
*,
sum(qtdeTransacao) OVER (PARTITION BY  IdCliente ORDER BY dtDia) AS acum,
lag(qtdeTransacao) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS lag
FROM tb_sumario_clientes;



-- DE QUANTO EM QUANTO TEMPO AS PESSOAS VOLTAM? 

WITH 
cliente_dia

AS

(
SELECT 
    IdCliente,
    substr(DtCriacao,1,10) AS dtDia
FROM transacoes
WHERE dtDia LIKE '%2025%'
GROUP BY IdCliente,dtDia
ORDER BY IdCliente, dtDia
),

tb_lag 
AS
(
SELECT *,
    lag (dtDia) OVER (PARTITION BY IdCliente ORDER BY dtDia) AS lag_dia
FROM cliente_dia
)

SELECT *,
JULIANDAY(dtDia) - JULIANDAY(lag_dia)
FROM tb_lag
--