
-- COUNT
-- conta a quantidade de valores não nulos

SELECT  COUNT (*),
        COUNT (1),
        COUNT (IdCliente)
FROM clientes;


-- COUNT DISTINCT 

SELECT COUNT (DISTINCT idCliente) 
FROM clientes;




SELECT 
    IdTransacao,
    DtCriacao
FROM transacoes
WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'
ORDER BY DtCriacao DESC;

-- QUANTAS TRANSAÇÕES EM JULHO DE 2025
SELECT COUNT(*)
FROM transacoes
WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'
ORDER BY DtCriacao DESC;

-- QUANTOS CLIENTES TRANSACIONARAM EM JULHO DE 2025

SELECT 
    COUNT(DISTINCT idCliente)
FROM transacoes
WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01';



-- SUM 

-- QUANTOS PONTOS FORAM GANHOS EM JULHO?


SELECT SUM(QtdePontos)

FROM transacoes

WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'
AND Qtdepontos > 0


-- EM COLUNAS DIFERENTES

SELECT 
    SUM(QtdePontos),
    SUM(
    CASE 
    WHEN QtdePontos > 0 THEN qtdePontos
    END
    ) AS sumPontosPositivos,

        SUM(
    CASE 
    WHEN QtdePontos  < 0 THEN qtdePontos
    END
    ) AS pontosNegativos

FROM transacoes
WHERE DtCriacao >= '2025-07-01' 
AND DtCriacao < '2025-08-01'


-- MEDIA

SELECT
    round (AVG(QtdePontos),2) AS MediaCarteira,
    1. * (sum(qtdePontos) /count(idCliente)) AS MEDIACARTEIRA,
    MIN(QtdePontos) as minCarteira,
    MAX(qtdePontos) as maxcarteira 
FROM clientes

