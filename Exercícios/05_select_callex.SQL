-- LISTA DE TRANSACOES COM APENAS 1  PONTO

SELECT *
FROM transacoes
WHERE QtdePontos = 1;

-- Lista de pedidos realizados no fim de semana

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

-- lISTA DE PRODUTOS COM NOME QUE COMEÇA  COM "Venda de"
SELECT 
IdProduto,
DescNomeProduto
FROM produtos
WHERE DescNomeProduto LIKE 'Venda de%';
