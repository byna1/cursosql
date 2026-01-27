-- common table expression

WITH tb_clientes_primeiro_dia AS 

(
SELECT distinct idCliente 
FROM transacoes 
WHERE substr(dtCriacao,1,10) = '2025-08-25'
)

SELECT * 
FROM tb_clientes_primeiro_dia



-- outra forma de fazer o exercicio - selecionar quais clientes estavam presentes no primeiro e no ultimo dia


WITH tbClientesPrimeiroDia AS

(
SELECT distinct idCliente AS clientesprimeiro
FROM transacoes 
WHERE substr(dtCriacao,1,10) = '2025-08-25'
),

tbClientesUltimoDia AS 
(

    SELECT distinct idCliente AS clientessegundo
FROM transacoes
WHERE substr(dtCriacao,1,10) = '2025-08-29'
)

SELECT 
    count (clientesprimeiro),
    count (clientessegundo) ,
    1.*count (clientessegundo)/count(clientesprimeiro) AS proporcaoDeConclusao


FROM tbClientesPrimeiroDia AS t1

LEFT JOIN tbClientesUltimoDia AS t2

ON clientesprimeiro = clientessegundo





