

-- Quais foram os clientes que perderam mais pontos por Lover? 
-- escrito como Lover (DescCategoriaProduto - lovers)

WITH

tb_perda_pt

AS 
(
SELECT 
    t1.IdCliente AS id_cliente,
    SUM(t1.QtdePontos) AS sum_pontos,
    t3.DescCategoriaProduto
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.Idproduto = t3.Idproduto
WHERE t1.QtdePontos < 0
AND t3.DescCategoriaProduto = 'lovers'
GROUP BY id_cliente
)

SELECT *,
    ROW_NUMBER () OVER (ORDER BY sum_pontos) AS ranking_perda_pontos
FROM tb_perda_pt
LIMIT 5


-- Quais clientes assinaram lista de presenca no dia 2025-08-25

SELECT 
    DISTINCT t1.IdCliente,
    substr(t1.DtCriacao,1,10) AS dt_presenca,
    t3.DescNomeProduto 
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.Idproduto = t3.Idproduto
WHERE DescNomeProduto = 'Lista de presença'
AND DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-26'


-- Do inicio ao fim do nosso curso (2025-08-25 a 2025-08-29) quantos clientes assinaram a lista de presenca?

SELECT 
    COUNT (t1.IdCliente) AS qtdd_alunos_curso
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.Idproduto = t3.Idproduto
WHERE DescNomeProduto = 'Lista de presença'
AND DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'


-- Clientes mais antigos tem mais frequencia de transacao? 

WITH

tb_transacao

AS
(

SELECT
    t1.IdCliente,
    t1.IdTransacao,
    julianday(t1.DtCriacao) AS DtDia 
FROM transacoes AS t1
ORDER BY t1.IdCliente

),

lag_dia

AS

(
SELECT *,
    lag (DtDia) OVER (Partition BY IdCliente ORDER BY DtDia) AS lagDia
FROM tb_transacao

),

freq_trans
AS

(
SELECT 
    *,
    AVG(DtDia - lagDia) AS freq_trans
FROM lag_dia
GROUP BY IdCliente
ORDER BY freq_trans ASC
),

idade_cliente AS

(
    SELECT 
    IdCliente,
    julianday('now') - julianday(DtCriacao) AS idade_cliente
FROM clientes
ORDER BY idade_cliente DESC

)

SELECT 
    t1.IdCliente,
    freq_trans,
    idade_cliente
FROM freq_trans AS t1
LEFT JOIN idade_cliente AS t2
ON t1.idCliente = t2.idCliente


-- quantidade de transacoes acumuladas ao longo do tempo (diario)

WITH 

tb_diario 

AS

(
SELECT 
    substr(DtCriacao,1,10) AS DtDia,
    COUNT(DISTINCT IdTransacao) AS qtd_transacao
FROM transacoes
GROUP BY dtDia
ORDER BY dtDia
),

tb_acum
AS
(

-- quando chegamos a 100000 clientes? 

SELECT *,
    SUM(qtd_transacao) OVER (ORDER BY dtDia) AS qtTransacaoAcum
FROM tb_diario
)

SELECT *
FROM tb_acum
WHERE qtTransacaoAcum > 100000
ORDER BY qtTransacaoAcum

-- quantidade de usuarios cadastrados ao longo do tempo

WITH tb_dia_cliente 
AS
(
SELECT 
    substr(DtCriacao,1,10) AS DtDia,
    count(distinct IdCliente) AS qtddcliente
FROM clientes
GROUP BY DtDia
)

SELECT *,
    SUM(qtddCliente) OVER (ORDER BY dtDia) AS qtddclienteacum
from tb_dia_cliente;

-- qual o dia da semana mais ativo de cada usuario?


WITH 

tb_cont_transac

    AS

    (
    SELECT
        IdCliente, 
        strftime('%w',substr(DtCriacao,1,10)) AS dtDia,
        COUNT(IdTransacao) as count_trans
    FROM transacoes
    GROUP BY IdCliente, dtDia
    ),

rankingTrans

    AS
    (
    SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY count_trans DESC) AS rankingtrans
    FROM tb_cont_transac
    ) 

SELECT 
    IdCliente,
    count_trans,
    dtDia,
    CASE 
        WHEN dtDia = '0' THEN 'Domingo'
        WHEN dtDia = '1' THEN 'Segunda-Feira'
        WHEN dtDia = '2' THEN 'Terça-Feira'
        WHEN dtDia = '3' THEN 'Quarta-Feira'
        WHEN dtDia = '4' THEN 'Quinta-Feira'
        WHEN dtDia = '5' THEN 'Sexta-Feira'
        WHEN dtDia = '6' THEN 'Sábado'
    END AS DiaSemana
FROM rankingTrans
WHERE rankingtrans = 1

 

 -- saldo de pontos acumulado de cada usuario


WITH

tb_transac_cliente

AS

(
SELECT
    IdCliente,
    SUBSTR(DtCriacao,1,10) AS DtDia,
    SUM(QtdePontos) as totalPontos,
    SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPositivos
FROM transacoes
GROUP BY IdCliente, dtDia
ORDER BY IdCliente,dTdIa
)

SELECT *,
    sum (totalPontos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontos,
    sum (pontosPositivos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontos

FROM tb_transac_cliente



