
 -- Excluir database se existir 
drop database if exists lavajato;


-- Criação do banco de dados
create database if not exists lavajato;

-- Utilização do banco de dados
USE lavajato;

-- Criação das tabelas
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_cliente VARCHAR(100),
  telefone VARCHAR(20),
  endereco VARCHAR(200),
  cpf VARCHAR(11),
  veiculo VARCHAR(10)
);

CREATE TABLE servicos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao_servico VARCHAR(200),
  preco DECIMAL(10, 2),
  tipo_servico VARCHAR(50),
  data_servico DATE,
  lavagem_americana DECIMAL(10, 2),
  lavagem_simples DECIMAL(10, 2),
  lavagem_completa DECIMAL(10, 2),
  higienizacao_interna DECIMAL(10, 2)
);



CREATE TABLE funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_funcionario VARCHAR(100),
  cargo VARCHAR(50),
  salario DECIMAL(10, 2),
  data_contratacao DATE
);


CREATE TABLE estoque (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produto VARCHAR(100),
  quantidade INT,
  preco_unitario DECIMAL(10, 2),
  data_entrada DATE
);


CREATE TABLE despesas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao_despesa VARCHAR(200),
  valor DECIMAL(10, 2),
  data_despesa DATE
);


CREATE TABLE registros (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  servico_id INT,
  funcionario_id INT,
  estoque_id INT,
  despesa_id INT,
  data_servico DATE,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (servico_id) REFERENCES servicos(id),
  FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id),
  FOREIGN KEY (estoque_id) REFERENCES estoque(id),
  FOREIGN KEY (despesa_id) REFERENCES despesas(id)
);




-- Inserts nas tabelas
INSERT INTO clientes (nome_cliente, telefone, endereco, cpf, veiculo)
VALUES ('Filipe Silva', '999999999', 'Rua A, 123', '12345678900', 'Carro A');

INSERT INTO clientes (nome_cliente, telefone, endereco, cpf, veiculo)
VALUES ('Yasmin Santos', '888888888', 'Rua B, 456', '98765432100', 'Carro B');

INSERT INTO servicos (descricao_servico, preco, tipo_servico, data_servico, lavagem_americana, lavagem_simples, lavagem_completa, higienizacao_interna)
VALUES ('Lavagem Completa', 50.00, 'Lavagem', '2023-06-20', 0.00, 0.00, 50.00, 0.00);

INSERT INTO servicos (descricao_servico, preco, tipo_servico, data_servico, lavagem_americana, lavagem_simples, lavagem_completa, higienizacao_interna)
VALUES ('Higienização Interna', 80.00, 'Higienização', '2023-06-21', 0.00, 0.00, 0.00, 80.00);

INSERT INTO funcionarios (nome_funcionario, cargo, salario, data_contratacao)
VALUES ('Guilherme', 'Gerente', 5000, '2020-03-20');

INSERT INTO funcionarios (nome_funcionario, cargo, salario, data_contratacao)
VALUES ('Fabio', 'Patrão', 10000, '2018-03-30');

INSERT INTO estoque (produto, quantidade, preco_unitario, data_entrada)
VALUES ('limpa-tudo', '10', 19.99, '2023-01-11');

INSERT INTO estoque (produto, quantidade, preco_unitario, data_entrada)
VALUES ('pneu', '8', 150.00, '2023-02-20');

INSERT INTO despesas (descricao_despesa, valor, data_despesa)
VALUES ('Gastou o limpa-tudo', 19.99, '2023-03-20');

INSERT INTO despesas (descricao_despesa, valor, data_despesa)
VALUES ('Pneu furou', 150.00, '2023-03-21');


INSERT INTO registros (cliente_id, servico_id, funcionario_id, estoque_id, despesa_id, data_servico)
VALUES (1, 1,1,1,1, '2023-06-20');

INSERT INTO registros (cliente_id, servico_id, funcionario_id, estoque_id, despesa_id, data_servico)
VALUES(2,2,2,2,2, '2023-06-23');


-- Update em uma tabela
UPDATE clientes
SET telefone = '777777777'
WHERE id = 1;



-- Selects (exemplos)
SELECT * FROM clientes;
SELECT * FROM servicos;
SELECT * FROM registros;
SELECT c.nome_cliente, s.descricao_servico, f.nome_funcivw_registrosvw_registrosvw_registrosonario, e.produto, d.descricao_despesa FROM registros r
JOIN clientes c ON r.cliente_id = c.id
JOIN servicos s ON r.servico_id = s.id
JOIN funcionarios f ON r.funcionario_id = f.id
JOIN estoque e ON r.estoque_id = e.id
JOIN despesas d ON r.despesa_id = d.id;


-- Criação de uma view
CREATE VIEW vw_registros AS
SELECT c.nome_cliente, s.descricao_servico,f.nome_funcionario, e.produto, d.descricao_despesa, r.data_servico
FROM registros r
JOIN clientes c ON r.cliente_id = c.id
JOIN servicos s ON r.servico_id = s.id
JOIN funcionarios f ON r.funcionario_id = f.id
JOIN estoque e ON r.estoque_id = e.id
JOIN despesas d ON r.despesa_id = d.id;

-- Commit e rollback (exemplos)
START TRANSACTION;
INSERT INTO clientes (nome_cliente, telefone, endereco, cpf, veiculo)
VALUES ('Pedro Ferreira', '666666666', 'Rua C, 789', '55555555500', 'Carro C');
COMMIT;

START TRANSACTION;
INSERT INTO clientes (nome_cliente, telefone, endereco, cpf, veiculo)
VALUES ('Ana Souza', '555555555', 'Rua D, 012', '44444444400', 'Carro D');
ROLLBACK;

-- Grant e revoke (exemplos)
GRANT SELECT, INSERT, UPDATE, DELETE ON lavajato.clientes TO 'usuario1'@'localhost';

-- Exemplo de procedure
DELIMITER //
CREATE PROCEDURE sp_TotalServicos(IN dataInicial DATE, IN dataFinal DATE)
BEGIN
  SELECT COUNT(*) AS total_servicos
  FROM registros
  WHERE data_servico BETWEEN dataInicial AND dataFinal;
END //
DELIMITER ;
