-- Listar todos os produtos com as respectivas descrições, unidades e valores unitários, obtendo o seguinte resultado:
SELECT id, unidade, descricao, valor_unitario 
FROM produtos;
-- Listar todo o conteúdo de vendedor, obtendo o seguinte resultado, usando *:
SELECT *
FROM vendedores;
-- Listar da tabela CLIENTE o CNPJ, o nome do cliente e seu endereço, obtendo o seguinte resultado:
SELECT cnpj, nome, endereco
FROM clientes;
-- Listar todas as cidades em que há clientes
SELECT DISTINCT cidade
FROM clientes;
-- Listar todas as cidades e estados em que há clientes
SELECT DISTINCT cidade, uf
FROM clientes;
-- Quais são os clientes que moram em Niterói?
SELECT nome, cnpj
FROM clientes
WHERE cidade = 'Niteroi';
-- Listar os produtos que tenham unidade igual a ‘M’ e valor unitário igual a R$ 1,05 da tabela produto:
SELECT *
FROM produtos
WHERE unidade = 'M' OR valor_unitario >= 1.05;
SELECT *
FROM produtos
WHERE unidade = 'M' AND valor_unitario >= 1.05;
-- AND TODAS AS CONDIÇÕES DEVEM SER VERDADEIRAS
-- OR SE APENAS UMA DAS CONDIÇÕES FOR VERDADEIRA  O RESULTADO É VERDADEIRO
-- Listar o código, a descrição e o valor unitario dos produtos que tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
SELECT id, descricao, valor_unitario
FROM produtos
-- WHERE valor_unitario >= 0.32 AND valor_unitario >= 2.00;
WHERE valor_unitario BETWEEN 0.32 AND 2;
-- Listar oo código, a descrição e o valor unitario dos produtos que NÃO tenham o valor unitário na faixa de R$ 0,32 até R$ 2,00:
SELECT id, descricao, valor_unitario
FROM produtos
WHERE valor_unitario NOT BETWEEN 0.32 AND 2;
-- Listar os nomes entre Ana e Jorge
SELECT *
FROM clientes
WHERE nome NOT BETWEEN 'Ana' AND 'Jorge';
-- Listar os vendedores com faixas de comissão A ou B
SELECT nome, faixa_comissao
FROM vendedores
WHERE faixa_comissao = 'A' OR faixa_comissao = 'B';

SELECT nome, faixa_comissao
FROM vendedores
WHERE faixa_comissao IN ('A', 'B');

SELECT nome, faixa_comissao
FROM vendedores
WHERE faixa_comissao NOT IN ('A', 'B');

-- Listar todos os clientes SEM Inscrição Estadual (IE)
SELECT *
FROM clientes
WHERE ie IS NULL;

-- Listar todos os clientes COM Inscrição Estadual (IE)
SELECT *
FROM clientes
WHERE ie IS NOT NULL;

-- Listar apenas os dois primeiros vendedores
SELECT *
FROM vendedores
LIMIT 4;

-- Listar todos os produtos que tenham o seu nome começando por Q:
SELECT *
FROM produtos
WHERE descricao LIKE 'Q%';
-- Listar os vendedores que não começam por ‘Jo’:
SELECT *
FROM vendedores
WHERE nome NOT LIKE 'Jo%';
-- Listar todos os produtos cujo nome termina com 's';
SELECT *
FROM produtos
WHERE descricao LIKE '%o';

-- Listar os produtos que contenham as letras "inh"
SELECT *
FROM produtos
WHERE descricao LIKE '%inh%';
-- Listar os chocolates e valores 
SELECT descricao, valor_unitario
FROM produtos
WHERE descricao LIKE '%Chocolate%';
-- Listar os vendedores cuja segunda letra do nome seja 'a'
SELECT *
FROM vendedores
WHERE nome LIKE '__a%';

-- ORDER BY
-- Listar todos os vendedores ordenados por nome
SELECT *
FROM vendedores
ORDER BY nome;
-- Listar todos os vendedores ordenados por nome de forma descrescente
SELECT *
FROM vendedores
ORDER BY id;

-- Listar todos os vendedores ordenados por nome e salario 
SELECT *
FROM vendedores
ORDER BY nome ASC, salario DESC;

-- Listar todos os clientes com seus estados, sendo que o estado deverá ser ordenado em ordem crescente e o nome por ordem descrescente
SELECT uf, nome
FROM clientes
ORDER BY uf ASC, nome DESC;
-- Listar todos os vendedores que ganham MENOS de 3000 reais e apresentar em ordem crescente
SELECT nome AS nome_completo, salario
FROM vendedores
WHERE salario < 3000
ORDER BY salario DESC;
-- Listar os vendedores que não começam por ‘Jo’ e apresentar ordenado de forma descrescente
SELECT *
FROM vendedores
WHERE nome NOT LIKE 'Jo%'
ORDER BY faixa_comissao DESC;

-- FUNÇÕES COUNT(), AVG(), SUM(), MIN() e MAX()
-- Informe quantos clientes foram cadastrados
SELECT count(id) AS numero_clientes
FROM clientes;

SELECT count(id) 
FROM vendedores;

-- Informe quantos produtos tem valor unitário abaixo de 0.50 centavos
SELECT count(id)
FROM produtos
WHERE valor_unitario < 0.50;

-- Informe a média de salario dos vendedores
SELECT avg(salario)
FROM vendedores;

-- Informe a média de valores unitarios dos produtos vendidos a M
SELECT avg(valor_unitario) AS media_valor_unitario
FROM produtos
WHERE unidade = 'M';
-- Somar o valor de todos os salários
SELECT sum(salario)
FROM vendedores;
-- Somar o valor dos salarios da comissão A
SELECT sum(salario)
FROM vendedores
WHERE faixa_comissao = 'A';
-- Somar a quantidade de itens de pedidos

-- Informe o menor salario do vendedores
SELECT MIN(SALARIO) AS MINIMO_SALARIO
FROM VENDEDORES;
-- Informe o maior salario do vendedores
SELECT MAX(SALARIO) AS MAXIMO_SALARIO
FROM VENDEDORES;
-- Informe o maior salario do vendedores da faixa de comissão B
SELECT MAX(SALARIO) AS MAXIMO_SALARIO
FROM VENDEDORES
WHERE FAIXA_COMISSAO = 'B';

-- Listar os nomes entre Ana e Jorge, ordenado de forma descrescente

 -- MySQL Functions: https://www.w3schools.com/sql/sql_ref_mysql.asp  
 
 -- COLUNAS CALCULADAS
 -- Mostrar o novo salário fixo dos vendedores, de faixa de comissão ‘C’, 
 -- calculado com base no reajuste de 75% 
 -- acrescido de R$ 120,00 de bonificação. Ordenar pelo nome do vendedor
 
 SELECT nome, salario * 1.75 + 120 AS salario_calculado, faixa_comissao
 FROM vendedores
 WHERE faixa_comissao = 'C'
 ORDER BY nome DESC;
 

 -- GROUP BY
 -- Informe o número de clientes por Estado
SELECT uf, count(id) as numero_clientes_uf
FROM clientes
WHERE uf in ('GO', 'DF')
GROUP BY uf
ORDER BY uf DESC;

-- Informe a média salarial por faixa de comissão
SELECT faixa_comissao, AVG(salario) as media_salario
FROM vendedores
GROUP BY faixa_comissao;

-- Informe a média salarial por faixa de comissão ordenado de forma descrescente por valor

-- HAVING
-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000
SELECT faixa_comissao, avg(salario) as media
FROM vendedores
GROUP BY faixa_comissao
HAVING media > 2000;

-- Informe a média salarial por faixa de comissão apenas das faixas com ganho acima de 2000 ordenado de 
-- forma descrescente por valor
SELECT faixa_comissao, avg(salario) as media
FROM vendedores
WHERE salario > 1000
GROUP BY faixa_comissao
HAVING media > 3000
ORDER BY media desc;



-- INNER JOIN
SELECT pedidos.prazo_entrega as prazo_novos_pedidos, clientes.nome, clientes.cidade 
FROM pedidos as p
INNER JOIN clientes as c
ON p.id_cliente = c.id;

SELECT vendedores.nome, vendedores.faixa_comissao, pedidos.prazo_entrega
FROM vendedores
INNER JOIN pedidos
ON vendedores.id = pedidos.id_vendedor;

SELECT vendedores.nome as vendedor, clientes.nome as cliente, pedidos.prazo_entrega
FROM pedidos
INNER JOIN vendedores ON vendedores.id = pedidos.id_vendedor
INNER JOIN clientes ON clientes.id = pedidos.id_cliente;
