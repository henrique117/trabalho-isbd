-- Delete da tabela Funcionários
-- Delete de uma linha na tabela Funcionario, que possui o id 1
DELETE FROM Funcionario
WHERE id = 1;

-- Delete de todos os funcionários com salário menor que 5000
DELETE FROM Funcionario
WHERE salario < 5000;

-- Delete de todos os funcionários que não possuem vendas registradas
DELETE FROM Funcionario
WHERE cpf NOT IN (
    SELECT cpf_funcionario
    FROM Venda
);


-- Delete da tabela Produto
-- Delete de uma linha na tabela Produto, que possui o SKU 1001
DELETE FROM Produto
WHERE SKU = 1001;

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

--Delete de todos os produtos de um fornecedor específico que não possuem vendas registradas
DELETE FROM Produto
WHERE cnpj_fornecedor = '12345678000190'
AND SKU NOT IN (
    SELECT SKU_produto
    FROM Venda
);


-- Delete da tabela Cliente
-- Delete de um cliente com o CPF '12345678901'
DELETE FROM Cliente
WHERE cpf = '12345678901';

-- Delete de todos os clientes registrados antes de 2023
DELETE FROM Cliente
WHERE data_registro < '2023-01-01';

-- Delete de todos os clientes que não possuem vendas registradas
DELETE FROM Cliente
WHERE cpf NOT IN (
    SELECT cpf_cliente
    FROM Venda
);


--Delete de uma linha na tabela Categoria, que possui o nome 'Eletrônicos'
DELETE FROM Categoria
WHERE nome_categoria = 'Eletrônicos';

--Delete de uma linha na tabela Fornecedor, que possui o cnpj '12345678000190'
DELETE FROM Fornecedor
WHERE cnpj = '12345678000190';