-- ========================
-- (e) Exemplo de deletes
-- ========================

-- Delete da tabela Funcionários
-- Delete de uma linha na tabela Funcionario, que possui o cpf 12345678901
DELETE FROM Funcionario
WHERE cpf = 12345678901;

-- Delete de todos os funcionários com salário menor que 5000
DELETE FROM Funcionario
WHERE salario < 5000;

-- Delete da tabela Produto
-- Delete de todos os produtos com quantidade em estoque zerado
DELETE FROM Produto
WHERE quantidade_estoque = 0;

-- Delete de todos os SKUs presentes na categoria Games
DELETE FROM Produto
WHERE id_categoria = (
    SELECT id_categoria
    FROM Categoria
    WHERE nome_categoria = 'Games'
);

-- Delete de todos os produtos de um fornecedor específico que não possuem vendas registradas
DELETE FROM Produto
WHERE cnpj_fornecedor = '12345678000190'
AND SKU NOT IN (
    SELECT SKU
    FROM Venda
);

-- Delete da tabela Cliente
-- Delete de um cliente com o CPF '12345678901'
DELETE FROM Cliente
WHERE cpf = '12345678901';

-- Delete de todos os clientes que não possuem vendas registradas
DELETE FROM Cliente
WHERE cpf NOT IN (
    SELECT cpf_cliente
    FROM Venda
);

-- Delete de uma linha na tabela endereço, que possui o CEP igual a 12345001
DELETE FROM Endereco
WHERE cep = 12345001;

-- Delete de uma linha na tabela Pessoa, que possui o cpf '12345678901'
DELETE FROM Pessoa
WHERE cpf = '12345678901';