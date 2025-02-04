-- Função vendasCliente:
--   Calcula o valor total de vendas de um cliente com base no CPF fornecido.
--   Usa a função SUM para somar o valor das vendas do cliente.
DELIMITER //
CREATE FUNCTION vendasCliente(cpf_cliente CHAR(11))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_vendas DECIMAL(10,2);
    SELECT SUM(valor_venda)
    INTO total_vendas FROM Venda
    WHERE cpf_cliente = venda.cpf_cliente;

    RETURN total_vendas;
END //
DELIMITER ;

-- Teste da função
SELECT vendasCliente('11134567891') AS TotalVendas;


-- Procedimento promocaoCategoria:
--   Reduz o preço de venda de todos os produtos de uma categoria de acordo com uma porcentagem.
--   Usa a função ROUND para arredondar o novo preço de venda.
DELIMITER //
CREATE PROCEDURE promocaoCategoria(id_categoria_param INT, porcentagem INT)
BEGIN
    UPDATE Produto
    SET valor_produto_venda = ROUND(valor_produto_venda * (1 - porcentagem / 100.0), 2)
    WHERE id_categoria = id_categoria_param;
END;

-- Teste do procedimento
CALL promocaoCategoria(1, 10);

SELECT * FROM Produto WHERE id_categoria = 1;