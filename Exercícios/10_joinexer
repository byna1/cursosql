--  qual a categoria tem mais produitos vendidos


SELECT 
    t2.DescCategoriaProduto,
    COUNT(DISTINCT(t1.IdTransacao)) AS numeroTransacoes
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto
GROUP BY t2.DescCategoriaProduto
ORDER BY numeroTransacoes DESC

-- Em 2024 quantas transacoes de lovers tivemos


SELECT 
    t3.DescCategoriaProduto,
    count(distinct t1.IdTransacao)
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE substr(DtCriacao,1,4) LIKE '2024'
-- AND     t3.DescCategoriaProduto = 'lovers'
GROUP BY 1
ORDER BY count(distinct t1.IdTransacao)


-- Qual mês tivemos mais lista de presença assinada

SELECT 
    substr(t1.DtCriacao,1,7) AS mes,
    COUNT (DISTINCT t2.IdTransacao)
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.Idproduto = t2.IdProduto
WHERE DescNomeProduto = 'Lista de presença'
GROUP BY mes
ORDER BY COUNT (DISTINCT t2.IdTransacao) DESC



--- Quais clientes mais perderam pontos por Lover

SELECT 
    DISTINCT(t1.IdCliente) AS cliente,
    SUM(t1.QtdePontos) AS somaPontos,
    t3.DescCategoriaProduto
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE t1.QtdePontos < 0 
AND t3.DescCategoriaProduto = 'lovers'
GROUP BY cliente
ORDER BY somaPontos ASC
LIMIT 5

-- Quais clientes assinaram a lista de presenca no dia 2025-08-25?


SELECT 
    DISTINCT(t1.IdCliente),
    SUBSTR(t1.DtCriacao,1,10) AS t1_data,
    t3.DescCategoriaProduto
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.Idtransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE DescCategoriaProduto = 'present'
AND t1_data = '2025-08-25'

-- Quais clientes assinaram a lista de presenca do inicio ao fim 2025-08-25 a 2025-08-29?

SELECT 
    COUNT(DISTINCT(t1.IdCliente)),
    SUBSTR(t1.DtCriacao,1,10) AS t1_data,
    t3.DescCategoriaProduto
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.Idtransacao
LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto
WHERE DescCategoriaProduto = 'present'
AND t1_data >='2025-08-25' 
AND t1_data <= '2025-08-29'


-- Clientes mais antigos tem mais frequencia de transação? Nesse daqui voce tem que usar o sheets pra visualizar

SELECT t1.IdCliente,
        t1.DtCriacao,
        julianday ('now') - julianday(substr(t1.Dtcriacao,1,19))  AS idadeBase,
        COUNT(t2.idtransacao)
FROM clientes AS t1
LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
GROUP BY t1.IdCliente,idadeBase



-- Qual mês tivemos mais produtos vendidos?

SELECT
    substr(t1.DtCriacao,1,7) AS mes,
    SUM(t2.QtDeproduto)
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao
GROUP BY mes
ORDER BY SUM(t2.QtDeproduto) DESC

