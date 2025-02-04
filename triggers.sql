-- ========================
-- (j) Triggers
-- ========================

-- Trigger de atualizar a quantidade de estoque na venda
DELIMITER //

CREATE TRIGGER atualizar_estoque_venda
AFTER INSERT ON Possui
FOR EACH ROW
BEGIN
    DECLARE quantidade INT;
    SELECT quantidade_estoque INTO quantidade FROM Produto WHERE SKU = NEW.SKU;
    IF NEW.quantidade_venda > quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade de venda maior que a quantidade em estoque';
    END IF;
    UPDATE Produto
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade_venda
    WHERE SKU = NEW.SKU;
END;
//
DELIMITER ;

-- Trigger de atualizar a quantidade de estoque na compra
DELIMITER //

CREATE TRIGGER atualizar_estoque_compra
AFTER INSERT ON Compoe
FOR EACH ROW
BEGIN
  UPDATE Produto
  SET quantidade_estoque = quantidade_estoque + NEW.quantidade_compra
  WHERE SKU = NEW.SKU;
END;
//
DELIMITER ;

-- Trigger de atualização de valor da venda
DELIMITER //

CREATE TRIGGER atualiza_valor_possui
BEFORE INSERT ON Possui
FOR EACH ROW
BEGIN
    DECLARE preco_unitario DECIMAL(7,2);
    
    -- Obter o preço unitário do produto
    SELECT valor_produto_venda INTO preco_unitario
    FROM Produto
    WHERE SKU = NEW.SKU;

    -- Calcular e atualizar o preco_venda
    SET NEW.preco_venda = NEW.quantidade_venda * preco_unitario;
END;
//

DELIMITER ;

-- Trigger de atualização de valor total da venda
DELIMITER //

CREATE TRIGGER atualiza_valor_venda
AFTER INSERT ON Possui
FOR EACH ROW
BEGIN
    -- Atualiza o valor total da venda somando os preços de todos os itens
    UPDATE Venda
    SET valor_venda = (
        SELECT SUM(preco_venda)
        FROM Possui
        WHERE id_venda = NEW.id_venda
    )
    WHERE id_venda = NEW.id_venda;
END;
//

DELIMITER ;

-- Trigger de atualização de valor do compoe
DELIMITER //
CREATE TRIGGER atualiza_valor_compoe
BEFORE INSERT ON Compoe
FOR EACH ROW
BEGIN
    DECLARE preco_unitario DECIMAL(7,2);
    
    -- Obter o preço unitário do produto
    SELECT valor_produto_compra INTO preco_unitario
    FROM Produto
    WHERE SKU = NEW.SKU;

    -- Calcular e atualizar o preco_compoe
    SET NEW.preco_compra = NEW.quantidade_compra * preco_unitario;
END;
//

DELIMITER ;

-- Trigger de atualização de valor total da compra
DELIMITER //

CREATE TRIGGER atualiza_valor_compra
AFTER INSERT ON Compoe
FOR EACH ROW
BEGIN
    -- Atualiza o valor total da compra somando os preços de todos os itens
    UPDATE Compra
    SET valor_compra = (
        SELECT SUM(preco_compra)
        FROM Compoe
        WHERE id_compra = NEW.id_compra
    )
    WHERE id_compra = NEW.id_compra;
END;
//

DELIMITER ;

-- Trigger de delete no estoque
--   Confere se o produto a ser deletado possui estoque
--   Se sim, não permite a deleção
DELIMITER //
CREATE TRIGGER before_delete_produto
BEFORE DELETE ON Produto
FOR EACH ROW
BEGIN
    DECLARE quantidade INT;
    SELECT quantidade_estoque INTO quantidade FROM Produto WHERE SKU = OLD.SKU;
    IF quantidade > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Produto possui estoque';
    END IF;
END;
//

DELIMITER ;

-- Trigger de update em produtos
--   Confere se o nome do produto é nulo ou vazio
--   Se sim, não permite a atualização
DELIMITER //

CREATE TRIGGER before_update_nome_produto
BEFORE UPDATE ON Produto
FOR EACH ROW
BEGIN
    IF NEW.nome_produto IS NULL OR NEW.nome_produto = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: O nome do produto não pode ser vazio ou nulo!';
    END IF;
END ;
//

DELIMITER ;

SHOW TRIGGERS;

/* INSERT INTO Venda (data, cpf_cliente) VALUES ('2025-01-10', '11134567891');
SELECT * FROM Venda WHERE id_venda = 81;
INSERT INTO Possui (SKU, id_venda, quantidade_venda) VALUES (15001, 81, 7);
SELECT * FROM Venda WHERE id_venda = 81;
INSERT INTO Compra (data_compra, cnpj_fornecedor) VALUES ('2025-01-01', '12345678000190');
SELECT * FROM Compra WHERE id_compra = 51;
SELECT * FROM Produto WHERE SKU = 15001;
INSERT INTO Compoe (SKU, id_compra, quantidade_compra) VALUES (15001, 51, 57);
SELECT * FROM Compoe;
SELECT * FROM Compra WHERE id_compra = 51; */