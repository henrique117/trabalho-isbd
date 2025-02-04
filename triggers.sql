CREATE TABLE IF NOT EXISTS HistFuncionario(
	id INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(11),
    nome VARCHAR(45),
    salario DECIMAL(7,2),
    data_exclusao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER beforeDelFuncionario
BEFORE DELETE ON Funcionario
FOR EACH ROW
BEGIN
	INSERT INTO HistFuncionario(cpf, nome, salario)
    VALUES(OLD.cpf, OLD.nome, OLD.salario);
END;
//

DELIMITER;

DELIMITER //

CREATE TRIGGER atualizar_salario_funcionario
AFTER UPDATE ON empresa.Funcionario
FOR EACH ROW
BEGIN
    IF OLD.cargo != NEW.cargo THEN
        DECLARE novo_salario DECIMAL(7,2);

        -- Exemplo de ajustes baseados em cargos
        IF NEW.cargo = 'Gerente' THEN
            SET novo_salario = 5000.00;
        ELSEIF NEW.cargo = 'Assistente' THEN
            SET novo_salario = 2000.00;
        ELSE
            SET novo_salario = 3000.00;
        END IF;

        UPDATE empresa.Funcionario
        SET salario = novo_salario
        WHERE cpf = NEW.cpf;
    END IF;
END;

DELIMITER ;

DELIMITER //

CREATE TRIGGER verificar_quantidade_estoque
BEFORE INSERT ON empresa.Produto
FOR EACH ROW
BEGIN
    IF NEW.quantidade_estoque < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade de estoque não pode ser negativa!';
    END IF;
END;

DELIMITER ;

