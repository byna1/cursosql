-- quantos clientes tem email cadastrado

SELECT 
count(*)
FROM clientes
WHERE flEmail =1;


SELECT 

sum(flEmail)

FROM clientes


select * 
from clientes


-- qual cliente juntou mais pontos positivos no mes 05 de 2025

SELECT 
    IdCliente,
    sum(qtdePontos) as somaPontos
FROM clientes
WHERE 
    qtdePontos > 0 
    AND DtCriacao >= '2025-05-01'
    AND DtCriacao < '2025-06-01'
GROUP BY IdCliente
ORDER BY somaPontos DESC
LIMIT 1


-- Qual cliente fez mais transacoes no ano de 2024



SELECT
    Idcliente,
    Count (IdTransacao)
FROM transacoes
WHERE 
    DtCriacao >= '2024-01-01' 
    AND DtCriacao < '2025-01-01'
GROUP BY IdCliente
ORDER BY count (IdTransacao) DESC
LIMIT 1


-- quantos produtos sao de rpg

SELECT 
    DescCategoriaProduto,
    Count (*)
FROM produtos
GROUP BY DescCategoriaProduto


-- Qual o valor medio de pontos positivos por dia

SELECT SUM(QtdePontos) AS TotalPontos,
        COUNT(DISTINCT(SUBSTR(DtCriacao,1,10))) AS CountDias,
        SUM(QtdePontos) / COUNT(DISTINCT(SUBSTR(DtCriacao,1,10))) AS AvgDia
FROM transacoes
WHERE qtdePontos > 0 

-- Qual o dia da semana que tem mais pedidos em 2025


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

-- Qual o produto com mais pontos transacionados

SELECT 
    IdProduto,
    SUM (vlProduto*QtdeProduto) AS totalPontos
FROM transacao_produto
GROUP BY IdProduto 
ORDER BY totalPontos DESC
