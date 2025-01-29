-- Criação de uma tabela de exemplo para ALTER e DROP TABLE (b)

CREATE TABLE Exemplo (
    id INT PRIMARY KEY,
    descricao VARCHAR(100)
);

ALTER TABLE Exemplo
ADD COLUMN quantidade INT;

ALTER TABLE Exemplo
ALTER COLUMN descricao TYPE VARCHAR(50);

ALTER TABLE Exemplo
RENAME COLUMN id TO id_produto;

DROP TABLE IF EXISTS Exemplo;

-- Exemplos de UPDATE nas tabelas (d)

SET sql_safe_updates = 0; -- Seta o safe update para 0 para poder fazer updates usando campos não chave no WHERE

-- Update na tabela Pessoa, atualizando o email da pessoa de CPF '01234567890'
UPDATE Pessoa
SET email = 'patricia.sousa@hotmail.com'
WHERE cpf = '01234567890';

-- Update na tabela Produto, atualizando o valor de venda de produtos de valor menor ou igual a 100
UPDATE Produto
SET valor_produto_venda = valor_produto_venda + 5
WHERE valor_produto_venda <= 100;

-- Update na tabela Funcionario, atualizando o salário dos funcionários com o número de registro menor que 10
UPDATE Funcionario
SET salario = salario + 200
WHERE registro_funcionario < 10;

-- Update na tabela Endereco, atualizando o número do endereço da pessoa que tem o numero_endereco > 100 e que mora no bairro 'Centro'
UPDATE Endereco
SET numero_endereco = numero_endereco + 2
WHERE numero_endereco > 100 AND bairro = 'Centro';

-- Update aninhado na tabela Funcionario, atualizando o salário dos funcionários que nasceram antes de 1990, usando os dados da tabela Pessoa
UPDATE Funcionario f
SET f.salario = f.salario * 1.2
WHERE f.cpf IN (
    SELECT p.cpf
    FROM Pessoa p
    WHERE YEAR(p.data_nascimento) < 1990
);