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


-- Função produtoMaisVendido:
--   Retorna uma tabela com o nome do produto mais vendido dentro de determinado tempo.
--   Inclui seu fornecedor, seu preço de compra, seu preço de venda, a quantidade vendida e a margem de lucro.
--   Usa a função MAX para encontrar o produto com maior quantidade vendida.
--   Usa a função SUM para somar a quantidade vendida de cada produto.
DELIMITER //
CREATE FUNCTION produtoMaisVendido(data_inicial DATE, data_final DATE)
RETURNS TABLE (
    nome_produto VARCHAR(100),
    fornecedor VARCHAR(100),
    preco_compra DECIMAL(7,2),
    preco_venda DECIMAL(7,2),
    quantidade_vendida INT,
    margem_lucro DECIMAL(10,2)
)
BEGIN
    RETURN (
        SELECT nome AS nome_produto, fornecedor, preco_compra, preco_venda, SUM(quantidade) AS quantidade_vendida, (preco_venda - preco_compra) AS margem_lucro
        FROM Produto
        JOIN ItemVenda ON Produto.id = ItemVenda.id_produto
        JOIN Venda ON ItemVenda.id_venda = Venda.id
        WHERE data_venda BETWEEN data_inicial AND data_final
        GROUP BY nome, fornecedor, preco_compra, preco_venda
        ORDER BY quantidade_vendida DESC
        LIMIT 1
    );
END //
DELIMITER ;

-- Teste da função
SELECT * FROM produtoMaisVendido('2021-01-01', '2021-12-31');



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