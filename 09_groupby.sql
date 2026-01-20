SELECT IdProduto,
        COUNT(*)
FROM transacao_produto
GROUP BY IdProduto;


--- Que cliente mais juntou pontos

SELECT 
    IdCliente,
    sum(qtdePontos) AS totalPontos
FROM transacoes
WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'
AND qtdePontos > 0
GROUP BY IdCliente
HAVING sum(QtdePontos) >= 4000
ORDER BY totalPontos DESC

