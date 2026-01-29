
DROP TABLE IF EXISTS relatorio_Diario;

CREATE TABLE IF NOT EXISTS relatorio_Diario AS 

WITH tb_transac_cliente AS (

        SELECT
            IdCliente,
            SUBSTR(DtCriacao,1,10) AS DtDia,
            SUM(QtdePontos) as totalPontos,
            SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPositivos
        FROM transacoes
        GROUP BY IdCliente, DtDia
        ORDER BY IdCliente, DtDia
        )

    SELECT *,
        sum (totalPontos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontos,
        sum (pontosPositivos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontosPositivos

    FROM tb_transac_cliente;

SELECT *
FROM relatorio_Diario 