-- LISTA DE TRANSACOES COM APENAS 1  PONTO

SELECT 
    IdTransacao,
    QtdePontos
FROM transacoes
WHERE QtdePontos = 1;

-- Lista de pedidos realizados no fim de semana
-- o 0 é domingo e o 6 é sábado

SELECT 
    DtCriacao,
    datetime(substr(DtCriacao,1,19)) AS Data_somente,
    Strftime('%w', DtCriacao) AS Dia_Semana
FROM transacoes
WHERE Dia_semana IN ('0','6')

-- Lista DE CLIENTES COM 0 (ZERO) PONTOS

SELECT 
    IdCliente,
    QtdePontos
FROM clientes
WHERE QtdePontos = 0;

-- Lista de clientes com 100 a 200 pontos 

SELECT
    IdCliente, 
    qtdePontos
FROM clientes
WHERE qtdePontos BETWEEN 100 AND 200; 

-- fazendo com maior e igual

SELECT
    IdCliente, 
    qtdePontos
FROM clientes
WHERE 100 >= qtdePontos AND qtdePontos <= 200; 

-- lISTA DE PRODUTOS COM NOME QUE COMEÇA  COM "Venda de"
SELECT 
    IdProduto,
    DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE 'Venda de%';

-- LISTA DE PRODUTOS QUE TERMINA COM "Lover"

SELECT 
    IdProduto,
    DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE '%Lover';

-- PRODUTOS QUE SAO CHAPEU

SELECT 
    idproduto,
    DescNomeProduto
FROM produtos
WHERE 
    DescNomeProduto LIKE '%chapéu%';

-- LISTA DE TRANSACOES COM O PRODUTO PONEI

SELECT 
    IdProduto,
    DescNomeProduto,
    DescCategoriaProduto
FROM 
    produtos
WHERE 
    DescCategoriaProduto = 'ponei';


-- Listar todas as transações adicionando uma ocluna nova sinalizando "alto", "médio", e "baixo" para o valor dos pontos <10; <500; >= 500

SELECT 
    idCliente,
    qtdePontos,
        CASE
            WHEN QtdePontos < 10 THEN 'BAIXO'
            WHEN QtdePontos < 500 THEN 'MÉDIO'
            WHEN qtdePontos >= 500 THEN 'ALTO'
        END
FROM clientes
ORDER BY qtdePontos DESC