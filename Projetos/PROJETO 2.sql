-- Objetivo:

-- Analise de perfil de leads.
-- Criar um dashboard que analise as principais características dos leads que visitam o nosso e-commerce

-- (Query 1) Gênero dos leads
-- Colunas: gênero, leads(#)

select 
		case 	
			when ibge.gender = 'male' then 'homens' 
			when ibge.gender = 'female' then 'mulheres'
		end as "gênero",
		count (*) as "leads (#)"
		from sales.customers as cus
		left join temp_tables.ibge_genders as ibge
			on lower(cus.first_name) = lower(ibge.first_name)
		group by ibge.gender

-- (Query 2) Status profissional dos leads
-- Colunas: status profissional, leads (%)
select 
	case 
		when professional_status = 'clt' then 'CLT'
		when professional_status = 'other' then 'outros'
		when professional_status = 'businessman' then 'Empresario'
		when professional_status = 'self_employed' then 'Autônomo'
		when professional_status = 'freelancer' then 'Freelancer'
		when professional_status = 'retired' then 'Aposentado'
		when professional_status = 'civil_servant' then 'Funcionário Público'
		when professional_status = 'student' then 'Estudante'
	end as "status profissional",
	(count (*)::float)/(select count(*) from sales.customers) as "leads (%)"
from sales.customers
group by "status profissional"
order by "leads (%)" desc


-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)
select
	case 
		when datediff('y', current_date, birth_date) < 20 then '0 - 20 anos'
		when datediff('y', current_date, birth_date) < 40 then '20 - 40 anos'
		when datediff('y', current_date, birth_date) < 60 then '40 - 60 anos'
		when datediff('y', current_date, birth_date) < 80 then '60 - 80 anos'
		else '80+'
	end as "faixa etária",
	(count (*)::float)/(select count(*) from sales.customers) as "leads (%)"
from sales.customers
group by "faixa etária"
order by "leads (%)"

-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem
select 
	case
		when income < 5000 then '0 - 5000'
		when income < 10000 then '5000 - 10000'
		when income < 15000 then '10000 - 15000'
		when income < 20000 then '15000 - 20000'
		else '20000+'
		end as "faixa salarial",
	(count (*)::float)/(select count(*) from sales.customers) as "leads (%)",
	case 
		when income < 5000 then 1
		when income < 10000 then 2
		when income < 15000 then 3
		when income < 20000 then 4
		else 5
	end as "ordem"
from sales.customers
group by "faixa salarial", "ordem"
order by "ordem"

-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos

with 
	classificacao_veiculos as (
		select 
			fun.visit_page_date,
			pro.model_year,
			extract ('year' from fun.visit_page_date) - pro.model_year::int as idade_veiculo,
			case 
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <= 2 then 'novo'
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) > 2 then 'semi-novo'
			end as "classificação do veículo",
		from sales.funnel as fun
		left join sales.products as pro
		using (product_id)
	)
select 
	"classificação do veículo",
	count (*) as "veículos visitados (#)"
from classificacao_veiculos
group by "classificação do veículo"


-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

with 
	faixa_idade_veiculos as (
		select 
			fun.visit_page_date,
			pro.model_year,
			extract ('year' from fun.visit_page_date) - pro.model_year::int as idade_veiculo,
			case 
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <= 2 then 'até 2 anos'
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=4 then '2 - 4 anos'
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=6 then '4 - 6 anos'
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=8 then '6 - 8 anos'
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=10 then '8 - 10 anos'
				else '10+'
			end as "idade do veículo",
			case 
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <= 2 then 1
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=4 then 2
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=6 then 3
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=8 then 4
				when (extract ('year' from fun.visit_page_date) - pro.model_year::int) <=10 then 5
				else 6
			end as "ordem"			
		from sales.funnel as fun
		left join sales.products as pro
		using (product_id)
	)
select 
	"idade do veículo",
	count (*)::float /(select count(*) from sales.funnel) as "veículos visitados (%)",
	ordem
from faixa_idade_veiculos
group by "idade do veículo", ordem
order by ordem


-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)

select 
	pro.brand,
	pro.model,
	count(*) as "visitas (#)"

from sales.funnel as fun
left join sales.products as pro
using (product_id)
group by pro.brand, pro.model
order by pro.brand, pro.model, "visitas (#)"









