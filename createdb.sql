-- Criação das tabelas - a)

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empresa` DEFAULT CHARACTER SET utf8;

-- -----------------------------------------------------
-- Schema empresa
-- -----------------------------------------------------

USE `empresa`;

-- -----------------------------------------------------
-- Table `empresa`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Fornecedor` (
  `cnpj` CHAR(14),
  `nome_fornecedor` VARCHAR(45) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `telefone` CHAR(11) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Categoria` (
  `id_categoria` INT AUTO_INCREMENT,
  `nome_categoria` VARCHAR(45) NOT NULL,
  `descricao_categoria` VARCHAR(200),
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Produto` (
  `SKU`INT,
  `nome_produto` VARCHAR(45) NOT NULL,
  `descricao_produto` VARCHAR(200),
  `valor_produto_venda` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `valor_produto_compra` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `quantidade_estoque` INT NOT NULL DEFAULT 0,
  `peso` DECIMAL(6,2) DEFAULT 0,
  `id_categoria` INT NOT NULL,
  `cnpj_fornecedor` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`SKU`),
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC) VISIBLE,
  INDEX `fk_Produto_Categoria_idx` (`id_categoria` ASC) VISIBLE,
  INDEX `fk_Produto_Fornecedor1_idx` (`cnpj_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `empresa`.`Categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`cnpj_fornecedor`)
    REFERENCES `empresa`.`Fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Pessoa` (
  `cpf` VARCHAR(11),
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NULL UNIQUE,
  `telefone` CHAR(11) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Cliente` (
  `data_registro` DATE NOT NULL,
  `cpf` VARCHAR(11),
  PRIMARY KEY (`cpf`),
  INDEX `fk_Cliente_Pessoa1_idx` (`cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`cpf`)
    REFERENCES `empresa`.`Pessoa` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Venda` (
  `id_venda` INT AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `valor_venda` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `cpf_cliente` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `fk_Venda_Cliente1_idx` (`cpf_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`cpf_cliente`)
    REFERENCES `empresa`.`Cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Funcionario` (
  `cargo` VARCHAR(45) NOT NULL,
  `salario` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `data_contratacao` DATE NOT NULL,
  `carga_horaria` INT NOT NULL DEFAULT 40,
  `cpf` VARCHAR(11),
  `registro_funcionario` INT NOT NULL,
  PRIMARY KEY (`cpf`),
  INDEX `fk_Funcionario_Pessoa1_idx` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `registro_funcionario_UNIQUE` (`registro_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Pessoa1`
    FOREIGN KEY (`cpf`)
    REFERENCES `empresa`.`Pessoa` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Compra` (
  `id_compra` INT AUTO_INCREMENT,
  `data_compra` DATE NOT NULL,
  `valor_compra` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `cnpj_fornecedor` CHAR(14) NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_Compra_Fornecedor1_idx` (`cnpj_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Fornecedor1`
    FOREIGN KEY (`cnpj_fornecedor`)
    REFERENCES `empresa`.`Fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Compoe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Compoe` (
  `SKU` INT NOT NULL,
  `id_compra` INT NOT NULL,
  `quantidade_compra` INT NOT NULL DEFAULT 1,
  `preco_compra` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `id_compoe` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_Produto_has_Compra_Compra1_idx` (`id_compra` ASC) VISIBLE,
  INDEX `fk_Produto_has_Compra_Produto1_idx` (`SKU` ASC) VISIBLE,
  PRIMARY KEY (`id_compoe`),
  CONSTRAINT `fk_Produto_has_Compra_Produto1`
    FOREIGN KEY (`SKU`)
    REFERENCES `empresa`.`Produto` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Compra_Compra1`
    FOREIGN KEY (`id_compra`)
    REFERENCES `empresa`.`Compra` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`Possui`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`Possui` (
  `SKU` INT NOT NULL,
  `id_venda` INT NOT NULL,
  `quantidade_venda` INT NOT NULL DEFAULT 1,
  `preco_venda` DECIMAL(7,2) NOT NULL DEFAULT 0.0,
  `id_possui` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_Produto_has_Venda_Venda1_idx` (`id_venda` ASC) VISIBLE,
  INDEX `fk_Produto_has_Venda_Produto1_idx` (`SKU` ASC) VISIBLE,
  PRIMARY KEY (`id_possui`),
  CONSTRAINT `fk_Produto_has_Venda_Produto1`
    FOREIGN KEY (`SKU`)
    REFERENCES `empresa`.`Produto` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Venda_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `empresa`.`Venda` (`id_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `empresa`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empresa`.`endereco` (
  `estado` VARCHAR(2) NOT NULL,
  `cep` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `numero_endereco` VARCHAR(45) NOT NULL,
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `Pessoa_cpf` VARCHAR(11),
  `Fornecedor_cnpj` CHAR(14),
  PRIMARY KEY (`id_endereco`),
  INDEX `fk_endereco_Pessoa1_idx` (`Pessoa_cpf` ASC) VISIBLE,
  INDEX `fk_endereco_Fornecedor1_idx` (`Fornecedor_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_Pessoa1`
    FOREIGN KEY (`Pessoa_cpf`)
    REFERENCES `empresa`.`Pessoa` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj`)
    REFERENCES `empresa`.`Fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;