-- TIPOS DE CONVERSÃO ##############################################################
-- Operador ::
-- CAST

-- EXEMPLOS ########################################################################

-- (Exemplo 1) Conversão de texto em data
-- Corrija a query abaixo utilizando o operador ::
select '2021-10-01'::date - '2021-02-01'::date



-- (Exemplo 2) Conversão de texto em número
-- Corrija a query abaixo utilizando o operador ::
select '100'::numeric - '10'::numeric


-- (Exemplo 3) Conversão de número em texto
-- Corrija a query abaixo utilizando o operador ::
select replace(112122::text,'1','A')


-- (Exemplo 4) Conversão de texto em data
-- Corrija a query abaixo utilizando a função CAST
select cast('2021-10-01' as date) - cast('2021-02-01' as date)


-- RESUMO ##########################################################################
-- (1) O operador :: e o CAST() são funções utilizadas para converter um dado para 
-- a unidade desejada. 
-- (2) O operador :: é mais "clean", porém, em algumas ocasiões não funciona, sendo
-- necessário utilizar a função CAST()
-- (3) Use o Guia de comandos para consultar a lista de unidades mais utilizadas

--------------------------------------------------------------------------

-- TIPOS ###########################################################################
-- CASE WHEN
-- COALESCE()


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Agrupamento de dados com CASE WHEN
-- Calcule o nº de clientes que ganham abaixo de 5k, entre 5k e 10k, entre 10k e 
-- 15k e acima de 15k

with faixa_de_renda as (
	select 
		income,
		case 
			when income < 5000 then '0 - 5000'
			when income >= 5000 and income < 10000 then '5000 - 10000'
			when income >= 10000 and income < 15000 then '10000 - 15000'
			else '15000+'
			end as faixa_renda
	from sales.customers
)
select faixa_renda, count(*)
from faixa_de_renda
group by faixa_Renda


-- (Exemplo 2) Tratamento de dados nulos com COALESCE
-- Crie uma coluna chamada populacao_ajustada na tabela temp_tables.regions e
-- preencha com os dados da coluna population, mas caso esse campo estiver nulo, 
-- preencha com a população média (geral) das cidades do Brasil
select * from temp_tables.regions limit 10
-- opção1
select *,
	case when population is not null then population
	else (select avg(population) from temp_tables.regions)
	end as populacao_ajustada
from temp_tables.regions
--opção 2
select *,
	coalesce(population, (select avg(population)from temp_tables.regions)) as populacao_ajustada
from temp_tables.regions
where population is null 
-- RESUMO ##########################################################################
-- (1) CASE WHEN é o comando utilizado para criar respostas específicas para 
-- diferentes condições e é muito utilizado para fazer agrupamento de dados
-- (2) COALESCE é o comando utilizado para preencher campos nulos com o primeiro
-- valor não nulo de uma sequência de valores.

--------------------------------------------------------------------------------------------
-- TIPOS ###########################################################################
-- LOWER()
-- UPPER()
-- TRIM()
-- REPLACE()

-- EXEMPLOS ########################################################################

-- (Exemplo 1) Corrija o primeiro elemento das queries abaixo utilizando os comandos 
-- de tratamento de texto para que o resultado seja sempre TRUE 

select lower('São Paulo') = lower('SÃO PAULO')


select upper('São Paulo') = upper('são paulo')


select trim('SÃO PAULO     ') = trim('SÃO PAULO')


select replace('SAO PAULO','SAO', 'SÃO') = 'SÃO PAULO'



-- RESUMO ##########################################################################
-- (1) LOWER() é utilizado para transformar todo texto em letras minúsculas
-- (2) UPPER() é utilizado para transformar todo texto em letras maiúsculas
-- (3) TRIM() é utilizado para remover os espaços das extremidades de um texto
-- (4) REPLACE() é utilizado para substituir uma string por outra string


--------------------------------------------------------------------------------------

-- TIPOS ###########################################################################
-- INTERVAL
-- DATE_TRUNC
-- EXTRACT
-- DATEDIFF


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Soma de datas utilizando INTERVAL
-- Calcule a data de hoje mais 10 unidades (dias, semanas, meses, horas)

select current_date + 10

SELECT (current_date + interval '10 weeks')::date

SELECT (current_date + interval '10 months')::date

SELECT (current_date + interval '10 hours')


-- (Exemplo 2) Truncagem de datas utilizando DATE_TRUNC
-- Calcule quantas visitas ocorreram por mês no site da empresa

select visit_page_date, count(*)
from sales.funnel
group by visit_page_date
order by visit_page_date desc

select
	(date_trunc('month', visit_page_date))::date as visit_page_month,
	count(*)
from sales.funnel
group by visit_page_month
order by visit_page_month desc



-- (Exemplo 3) Extração de unidades de uma data utilizando EXTRACT
-- Calcule qual é o dia da semana que mais recebe visitas ao site

select
	'2022-01-30'::date
select
	extract('dow' from visit_page_date) as dia_semana,
	count(*)
from sales.funnel
group by dia_semana
order by dia_semana desc



-- (Exemplo 4) Diferença entre datas com operador de subtração (-) 
-- Calcule a diferença entre hoje e '2018-06-01', em dias, semanas, meses e anos.
select (current_date - '2018-06-01')
select (current_date - '2018-06-01')/7
select (current_date - '2018-06-01')/30
select (current_date - '2018-06-01')/365

select datediff('weeks', '2018-06-01', current_date)

-- RESUMO --------------------------------------------------------------------------
-- (1) O comando INTERVAL é utilizado para somar datas na unidade desejada. Caso a 
-- unidade não seja informada, o SQL irá entender que a soma foi feita em dias.
-- (2) O comando DATE_TRUNC é utilizado para truncar uma data no início do período
-- (3) O comando EXTRACT é utilizado para extrair unidades de uma data/timestamp
-- (4) O cálculo da diferença entre datas com o operador de subtração (-) retorna  
-- valores em dias. Para calcular a diferença entre datas em outra unidade é necessário
-- fazer uma transformação de unidades (ou criar uma função para isso)
-- (5) Utilize o Guia de comandos para consultar as unidades de data e hora utilizadas 
-- no SQL

----------------------------------------------------------------------------------------------

-- PARA QUE SERVEM #################################################################
-- Servem para criar comandos personalizados de scripts usados recorrentemente.


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Crie uma função chamada DATEDIFF para calcular a diferença entre
-- duas datas em dias, semanas, meses, anos

select (current_date - '2018-06-01')
select (current_date - '2018-06-01')/7
select (current_date - '2018-06-01')/30
select (current_date - '2018-06-01')/365

select datediff('weeks', '2018-06-01', current_date)

create function datediff(unidade varchar, data_inicial date, data_final date)
returns integer
language sql

as 

$$
	select 
		case
			when unidade in ('day', 'd', 'days') then data_inicial - data_final
			when unidade in ('week', 'w', 'weeks') then (data_inicial-data_final)/7
			when unidade in ('m', 'month', 'months') then (data_inicial-data_final)/30
			when unidade in ('y', 'year', 'years') then (data_inicial-data_final)/365
		end as diferenca

$$



-- (Exemplo 2) Delete a função DATEDIFF criada no exercício anterior

drop function datediff


-- RESUMO ##########################################################################
-- (1) Para criar funções, utiliza-se o comando CREATE FUNCTION
-- (2) Para que o comando funcione é obrigatório informar (a) quais as unidades dos 
-- INPUTS (b) quais as unidades dos OUTPUTS e (c) em qual linguagem a função será escrita
-- (3) O script da função deve estar delimitado por $$
-- (4) Para deletar uma função utiliza-se o comando DROP FUNCTION



