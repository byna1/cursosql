--- Criando nova coluna com pontos acrescidos

SELECT *,
    QtdePontos + 10
FROM clientes;

--- Como converter um datetime (fazendo isso, eu consigo trabalhar com calendario)

SELECT
    DtCriacao,
    datetime(SUBSTR(DtCriacao, 1, 19)) AS Data_Somente,

--- Como descobrir o dia da semana dessa data
    STRFTIME('%w', DtCriacao) AS Dia_Semana
FROM clientes


