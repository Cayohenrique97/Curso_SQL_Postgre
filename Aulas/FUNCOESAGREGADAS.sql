-- PARA QUE SERVE ##################################################################
-- Servem para executar operações aritmética nos registros de uma coluna 


-- TIPOS DE FUNÇÕES AGREGADAS ######################################################
-- COUNT()
-- SUM()
-- MIN()
-- MAX()
-- AVG()


-- EXEMPLOS ########################################################################

-- COUNT() -------------------------------------------------------------------------

-- (Exemplo 1) Contagem de todas as linhas de uma tabela
-- Conte todas as visitas realizadas ao site da empresa fictícia

SELECT COUNT(*)
FROM sales.funnel

-- (Exemplo 2) Contagem das linhas de uma coluna
-- Conte todos os pagamentos registrados na tabela sales.funnel 

SELECT COUNT(paid_date)
FROM sales.funnel

-- (Exemplo 3) Contagem distinta de uma coluna
-- Conte todos os produtos distintos visitados em jan/21

SELECT COUNT(DISTINCT product_id)
FROM sales.funnel
where visit_page_date between '2021-01-01' and '2021-01-31'

-- OUTRAS FUNÇÕES ------------------------------------------------------------------

-- (Exemplo 4) Calcule o preço mínimo, máximo e médio dos productos da tabela products
SELECT MIN(price),
MAX(price), 
AVG(price)
FROM sales.products

-- (Exemplo 5) Informe qual é o veículo mais caro da tabela products

select *
from sales.products
where price = (SELECT MAX(price) FROM sales.products)

-- RESUMO ##########################################################################
-- (1) Servem para executar operações aritmética nos registros de uma coluna 
-- (2) Funções agregadas não computam células vazias (NULL) como zero
-- (3) Na função COUNT() pode-se utilizar o asterisco (*) para contar os registros
-- (4) COUNT(DISTINCT ) irá contar apenas os valores exclusivos

--------------------------------------------------------------------------------------

-- PARA QUE SERVE ##################################################################
-- Serve para agrupar registros semelhantes de uma coluna
-- Normalmente utilizado em conjunto com as Funções de agregação


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Contagem agrupada de uma coluna
-- Calcule o nº de clientes da tabela customers por estado
select state,
count(*) as contagem
from sales.customers
group by state
order by contagem desc

-- (Exemplo 2) Contagem agrupada de várias colunas
-- Calcule o nº de clientes por estado e status profissional 
select state,
professional_status,
count(*) as contagem
from sales.customers
group by state, professional_status
order by state, contagem desc

-- (Exemplo 3) Seleção de valores distintos
-- Selecione os estados distintos na tabela customers utilizando o group by
select distinct state
from sales.customers

select state
from sales.customers
group by state


-- RESUMO ##########################################################################
-- (1) Serve para agrupar registros semelhantes de uma coluna, 
-- (2) Normalmente utilizado em conjunto com as Funções de agregação
-- (3) Pode-se referenciar a coluna a ser agrupada pela sua posição ordinal 
-- (ex: GROUP BY 1,2,3 irá agrupar pelas 3 primeiras colunas da tabela) 
-- (4) O GROUP BY sozinho funciona como um DISTINCT, eliminando linhas duplicadas


--------------------------------------------------------------------------------------------

-- PARA QUE SERVE ##################################################################
-- Serve para filtrar linhas da seleção por uma coluna agrupada


-- EXEMPLOS ########################################################################

-- (Exemplo 1) seleção com filtro no HAVING 
-- Calcule o nº de clientes por estado filtrando apenas estados acima de 100 clientes
select 
    state, 
    count(*) as contagem
from sales.customers
group by state
having count(*) > 100


-- RESUMO ##########################################################################
-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados 
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas

------------------------------------------------------------------------------------------

-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Conte quantos clientes da tabela sales.customers tem menos de 30 anos
SELECT COUNT(*)
FROM sales.customers
where ((current_date - birth_date)/365) < 30


-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers
SELECT 
min((current_date - birth_date)/365)as young,
max((current_date - birth_date)/365) as old
from sales.customers

-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)
Select *
from sales.customers
where income = (select max(income) from sales.customers)


-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca

select brand,
COUNT(*)
from sales.products
GROUP BY brand
ORDER BY brand

-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pela nome da marca e pelo ano do veículo
select brand,
model_year,
count(*)
from sales.products
group by brand, model_year
order by brand, model_year


-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados
select brand,
count(*) as contagem
from sales.products
group by brand
having count(*) > 10
order by contagem






