-- Qual o valor medio de pontos positivos por dia

SELECT SUM(QtdePontos) AS TotalPontos,
        COUNT(DISTINCT(SUBSTR(DtCriacao,1,10))) AS CountDias,
        SUM(QtdePontos) / COUNT(DISTINCT(SUBSTR(DtCriacao,1,10))) AS AvgDia
FROM transacoes
WHERE qtdePontos > 0 

--- dia da semana onde se tem mais numero de transacoes

SELECT
     strftime('%w',substr(DtCriacao,1,10)) AS diaSemana,
    Count(distinct(IdTransacao)) AS transacoesPorDia

FROM transacoes
WHERE substr(DtCriacao,1,10) LIKE '2025%'
GROUP BY diaSemana
ORDER BY 2 DESC



-- qual o produto mais transicionado

SELECT 
    IdProduto,
    SUM (QtdeProduto) AS totalProd,
    COUNT (distinct(IdTransacao)) AS nTransacao
FROM transacao_produto
GROUP BY IdProduto 
ORDER BY totalProd DESC


-- quantidade de transacoes por mês

SELECT 
    substr(t1.DtCriacao,1,7) AS mes,
    COUNT (DISTINCT t2.IdTransacao)
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.Idproduto = t2.IdProduto
WHERE DescCategoriaProduto= 'present'
GROUP BY mes
ORDER BY COUNT (DISTINCT t2.IdTransacao) DESC


-- Clientes mais antigos tem mais frequencia de transação? Nesse daqui voce tem que usar o sheets pra visualizar

SELECT t1.IdCliente,
        t1.DtCriacao,
        julianday ('now') - julianday(substr(t1.Dtcriacao,1,19))  AS idadeBase,
        COUNT(t2.idtransacao)
FROM clientes AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
GROUP BY t1.IdCliente,idadeBase


-- Quantidade de clientes que começou o curso e foi até o 5 dia

SELECT 
COUNT (DISTINCT(IdCliente))

FROM transacoes AS t1 

WHERE t1.IDCliente IN
(
SELECT DISTINCT IdCliente
FROM transacoes
WHERE substr(DtCriacao,1,10) = '2025-08-25'
)
AND substr(DtCriacao,1,10) = '2025-08-29'



-- QUAL FOI A CURVA DE CHERN DO CURSO DE SQL

SELECT 

    DtCriacao,
    substr(Dtcriacao,1,10) AS dtdia),
    COUNT (DISTINCT IdCliente) AS qtdd_cliente

FROM transacoes
WHERE 
substr(Dtcriacao,1,10) >= '2025-08-24'
AND substr(Dtcriacao,1,10) <= '2025-08-29'
GROUP BY dtDia


