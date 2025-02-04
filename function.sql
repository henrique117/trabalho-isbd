-- Função vendasCliente:
--   Calcula o valor total de vendas de um cliente com base no CPF fornecido.
--   Usa a função SUM para somar o valor das vendas do cliente.
DELIMITER //
CREATE FUNCTION vendasCliente(cpf_cliente CHAR(11))
RETURNS DECIMAL(10,2) AS
BEGIN
    DECLARE total_vendas DECIMAL(10,2);
    SELECT SUM(valor)
    INTO total_vendas FROM Venda
    WHERE cpf_cliente = venda.cpf;

    RETURN total_vendas;
END //
DELIMITER ;

-- Teste da função
SELECT vendasCliente('11134567891') AS TotalVendas;


-- Função produtosZerados:
--  Retorna o nome dos produtos que estão sem estoque.
DELIMITER //
CREATE FUNCTION produtosZerados()
RETURNS VARCHAR(100)
BEGIN
    DECLARE nome_produto VARCHAR(100);
    SELECT nome
    INTO nome_produto
    FROM Produto
    WHERE estoque = 0;

    RETURN nome_produto;
END //
DELIMITER ;

-- Teste da função
SELECT produtosZerados() AS ProdutoSemEstoque;

-- Procedimento promocaoCategoria:
--   Reduz o preço de venda de todos os produtos de uma categoria de acordo com uma porcentagem.
--   Usa a função ROUND para arredondar o novo preço de venda.
DELIMITER //
CREATE PROCEDURE promocaoCategoria(id_categoria INT, porcentagem INT)
BEGIN
    DECLARE novo_preco DECIMAL(7,2);
CREATE PROCEDURE promocaoCategoria(id_categoria INT, porcentagem INT)
BEGIN
    DECLARE novo_preco DECIMAL(7,2);
    SET novo_preco = ROUND((100 - porcentagem) / 100 * preco_venda, 2);

    UPDATE Produto
    SET preco_venda = novo_preco
    WHERE id_categoria = id_categoria;
END;

-- Teste do procedimento
CALL promocaoCategoria(1, 10);