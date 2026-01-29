WITH tb_transac_cliente AS (

        SELECT
            IdCliente,
            SUBSTR(DtCriacao,1,10) AS DtDia,
            SUM(QtdePontos) as totalPontos,
            SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPositivos
        FROM transacoes
        GROUP BY IdCliente, DtDia
        ORDER BY IdCliente, DtDia
        ),
    total_pontos AS (

    SELECT *,
        sum (totalPontos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontos,
        sum (pontosPositivos) OVER (PARTITION BY idCliente ORDER BY DtDia) AS saldoPontosPositivos

    FROM tb_transac_cliente

    )

INSERT INTO relatorio_diario

SELECT *
FROM total_pontos

SELECT *
FROM relatorio_diario




