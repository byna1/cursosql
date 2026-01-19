--- Selecione todos os clientes com email cadastrado

SELECT * 
FROM clientes
WHERE flEmail = 1;

--- WHRE flEmail <> 0
--- WHERE flEmail != 0
--- WHERE flEmail IS TRUE
--- WHERE flEmail = TRUE
--- WHERE flEmail = 'true'
--- WHERE flEmail IS NOT FALSE
--- WHERE flEmail != FALSE


--- Selecione todas as transa;oes de 50 pontos (exatos)

SELECT 
IdCliente,
qtdePontos
FROM transacoes
WHERE qtdePontos = 50;

--- Selecione todos os clientes com mais de 500 pontos


SELECT 
IdCliente,
qtdePontos
FROM transacoes
WHERE qtdePontos > 500;

--- Selecione produtos que contem churn no nome

SELECT *
FROM produtos
--- WHERE DescNomeProduto = 'Churn_10pp'
--- OR DescNomeProduto = 'Churn_2pp'
--- OR DescNomeProduto = 'Churn_5pp';
--- WHERE DescNomeProduto IN ('Churn_10pp', 'Churn_2pp', 'Churn_5pp');
--- WHERE DescNomeProduto LIKE '%Churn%'; 
--- A forma seguinte é a melhor forma de fazer essa query, no entanto, 
---  você precis entender o banco de dados pra poder saber qual a melhor forma de procurar. 
WHERE DescCategoriaProduto = 'churn_model'