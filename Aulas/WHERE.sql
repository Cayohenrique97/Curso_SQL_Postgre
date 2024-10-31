-- PARA QUE SERVE ##################################################################
-- Serve para filtrar linhas de acordo com uma condição


-- SINTAXE #########################################################################
select coluna_1, coluna_2, coluna_3
from schema_1.tabela_1
where condição_x=true


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Filtro com condição única
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina
SELECT email, state
from sales.customers
where state = 'SC'

-- (Exemplo 2) Filtro com mais de uma condição
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina
-- ou Mato Grosso do Sul
SELECT email, state
FROM sales.customers
where state = 'SC' OR state='MS'

-- (Exemplo 3) Filtro de condição com data
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina 
-- ou Mato Grosso do Sul e que tem mais de 30 anos

SELECT email, state, birth_Date
FROM sales.customers
WHERE (state = 'SC' or state = 'MS') and birth_date < '1991-12-28'

-- RESUMO ##########################################################################
-- (1) Comando utilizado para filtrar linhas de acordo com uma condição
-- (2) No PostgreSQL são utilizadas aspas simples para delimitar strings 
-- (3) string = sequência de caracteres = texto
-- (4) Pode-se combinar mais de uma condição utilizando os operadores lógicos
-- (5) No PostgreSQL as datas são escritas no formato 'YYYY-MM-DD' ou 'YYYYMMDD'
