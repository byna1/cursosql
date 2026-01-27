-- lista de transações com o produto "Resgatar ponei"

-- SELECT * 
-- FROM produtos

SELECT * 
FROM transacao_produto AS t1
WHERE t1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescCategoriaProduto = 'Resgatar Ponei'

)


-- # dos clientes que começaram SQL, quantos chegaram ao 5 dia

-- 1. quem são os clientes que começaram no primeiro dia


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

 