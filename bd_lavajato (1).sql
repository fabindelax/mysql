drop database if exists lavajato; -- excluir database

create database if not exists lavajato;
default character set utf8 -- uft8 (8-bit Unicode Transformation Format - Pode representar qualquer caracter universal padrão do Unicode, sendo também compatível com o ASCII)
default collate utf8_general_ci;

use lavajato;-- selecionar banco de dados
/*
Outros comandos:
show database; -- lista os banco de dados criados
show tables;  -- lista as tabelas do database
describe ou desc "nome da tabela"; -- descreve os itens da tabela
*/

CREATE TABLE IF NOT EXISTS clientes ( -- criar tabela
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  telefone VARCHAR(20),
  endereco VARCHAR(200),
  cpf VARCHAR(11),
  veiculo VARCHAR(10)
);

CREATE TABLE servicos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(200),
  preco DECIMAL(10, 2),
  tipo_servico VARCHAR(50),
  data_servico DATE,
  lavagem_americana DECIMAL(10, 2),
  lavagem_simples DECIMAL(10, 2),
  lavagem_completa DECIMAL(10, 2),
  higienizacao_interna DECIMAL(10, 2)
);

CREATE TABLE registros (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  servico_id INT,
  data_servico DATE,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (servico_id) REFERENCES servicos(id)
);

CREATE TABLE funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
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
  descricao VARCHAR(200),
  valor DECIMAL(10, 2),
  data_despesa DATE
);

-- Inserts nas tabelas
INSERT INTO clientes (nome, telefone, endereco, cpf, veiculo)
VALUES ('Filipe Silva', '999999999', 'Rua A, 123', '12345678900', 'Carro A');

INSERT INTO clientes (nome, telefone, endereco, cpf, veiculo)
VALUES ('Yasmin Santos', '888888888', 'Rua B, 456', '98765432100', 'Carro B');

INSERT INTO servicos (descricao, preco, tipo_servico, data_servico, lavagem_americana, lavagem_simples, lavagem_completa, higienizacao_interna)
VALUES ('Lavagem Completa', 50.00, 'Lavagem', '2023-06-20', 0.00, 0.00, 50.00, 0.00);

INSERT INTO servicos (descricao, preco, tipo_servico, data_servico, lavagem_americana, lavagem_simples, lavagem_completa, higienizacao_interna)
VALUES ('Higienização Interna', 80.00, 'Higienização', '2023-06-21', 0.00, 0.00, 0.00, 80.00);

INSERT INTO registros (cliente_id, servico_id, data_servico)
VALUES (1, 1, '2023-06-20');

INSERT INTO registros (cliente_id, servico_id, data_servico)
VALUES (2, 2, '2023-06-21');

-- Update em uma tabela
UPDATE clientes
SET telefone = '777777777'
WHERE id = 1;

-- Delete em uma tabela
DELETE FROM registros
WHERE id = 2;

-- Selects (exemplos)
SELECT * FROM clientes;
SELECT * FROM servicos;
SELECT * FROM registros;
SELECT c.nome, s.descricao FROM registros r
JOIN clientes c ON r.cliente_id = c.id
JOIN servicos s ON r.servico_id = s.id;

-- Criação de uma view
CREATE VIEW vw_registros AS
SELECT c.nome, s.descricao, r.data_servico
FROM registros r
JOIN clientes c ON r.cliente_id = c.id
JOIN servicos s ON r.servico_id = s.id;

-- Commit e rollback (exemplos)
START TRANSACTION;
INSERT INTO clientes (nome, telefone, endereco, cpf, veiculo)
VALUES ('Pedro Ferreira', '666666666', 'Rua C, 789', '55555555500', 'Carro C');
COMMIT;

START TRANSACTION;
INSERT INTO clientes (nome, telefone, endereco, cpf, veiculo)
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