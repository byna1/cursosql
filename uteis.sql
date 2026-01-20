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