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

-- Criação de uma tabela de exemplo para ALTER e DROP TABLE (b)

CREATE TABLE Exemplo (
    id INT PRIMARY KEY,
    descricao VARCHAR(100)
);

ALTER TABLE Exemplo
ADD COLUMN quantidade INT;

ALTER TABLE Exemplo
MODIFY COLUMN descricao VARCHAR(50);

ALTER TABLE Exemplo
RENAME COLUMN id TO id_produto;

DROP TABLE IF EXISTS Exemplo;

-- Inserções no banco - c)

INSERT INTO Categoria (nome_categoria, descricao_categoria) VALUES
('Eletrônicos', 'Produtos eletrônicos como celulares, TVs e notebooks'),
('Eletrodomésticos', 'Itens para uso doméstico como geladeiras e fogões'),
('Roupas', 'Vestuário masculino, feminino e infantil'),
('Calçados', 'Calçados de todos os tipos e tamanhos'),
('Alimentos', 'Produtos alimentícios e bebidas'),
('Livros', 'Livros de diversos gêneros e temas'),
('Brinquedos', 'Brinquedos e jogos para crianças'),
('Ferramentas', 'Ferramentas manuais e elétricas'),
('Esportes', 'Artigos esportivos e fitness'),
('Móveis', 'Móveis para casa e escritório'),
('Perfumaria', 'Perfumes e fragrâncias para homens e mulheres'),
('Papelaria', 'Itens de papelaria e materiais escolares'),
('Automotivo', 'Produtos e acessórios para veículos'),
('Informática', 'Acessórios e periféricos de informática'),
('Saúde', 'Produtos para cuidados com a saúde'),
('Beleza', 'Cosméticos e produtos para cuidados pessoais'),
('Jardinagem', 'Ferramentas e insumos para jardins'),
('Pets', 'Produtos para animais de estimação'),
('Construção', 'Materiais e ferramentas para construção civil'),
('Games', 'Consoles, jogos e acessórios para gamers');

INSERT INTO Fornecedor (cnpj, nome_fornecedor, email, telefone) VALUES
('12345678000190', 'Indústria Alimentos S.A.', 'contato@industriaalimentos.com', '1112345678'),
('23456789000101', 'Construtora Rio Ltda.', 'vendas@construtorario.com', '2123456789'),
('34567890000112', 'Tech Solutions Ltda.', 'suporte@techsolutions.com', '3134567890'),
('45678901000123', 'Móveis Elegância', 'comercial@moveliselegancia.com', '4145678901'),
('56789012000134', 'Distribuidora São Paulo', 'contato@distribuidorasampa.com', '5156789012'),
('67890123000145', 'Ferragens e Ferramentas Brasil', 'vendas@ferragensbrasil.com', '6167890123'),
('78901234000156', 'Auto Peças Nova Era', 'autopecas@novaera.com', '7178901234'),
('89012345000167', 'Caldas & Cia', 'caldas@empresa.com', '8189012345'),
('90123456000178', 'Tecno Eletro', 'suporte@tecnoeletro.com', '9190123456'),
('01234567000189', 'Laticínios Pioneira', 'pioneira@laticiniospioneira.com', '1110234567'),
('12345678000101', 'Móveis São Jorge', 'moveis@moveissaorajorge.com', '2121345678'),
('23456789000112', 'Supermercados Casa Grande', 'atendimento@casagrande.com', '3132456789'),
('34567890000123', 'Transporte Júnior', 'transporte@junior.com', '4143567890'),
('45678901000134', 'Produtos do Campo', 'vendas@produtosdocampo.com', '5154678901'),
('56789012000145', 'Distribuidora Cosmos', 'cosmos@distribuidora.com', '6165789012');

INSERT INTO Produto (SKU, nome_produto, descricao_produto, valor_produto_venda, valor_produto_compra, quantidade_estoque, peso, id_categoria, cnpj_fornecedor) VALUES
(1001, 'Smartphone Galaxy S21', 'Smartphone de última geração com câmera de alta resolução', 4500.00, 3800.00, 50, 0.25, 1, '12345678000190'),
(1002, 'Notebook Dell Inspiron', 'Notebook com processador Intel i7 e 16GB de RAM', 5500.00, 4500.00, 30, 2.50, 1, '12345678000190'),
(1003, 'TV Samsung 55 Polegadas', 'Smart TV 4K UHD com suporte a HDR', 3200.00, 2700.00, 20, 15.00, 1, '12345678000190'),
(2001, 'Geladeira Frost Free', 'Geladeira 400L com freezer separado', 3200.00, 2500.00, 10, 60.00, 2, '23456789000101'),
(2002, 'Fogão 5 Bocas', 'Fogão com forno elétrico e acendimento automático', 1500.00, 1200.00, 15, 40.00, 2, '23456789000101'),
(3001, 'Camiseta Polo', 'Camiseta polo masculina tamanho G', 80.00, 50.00, 100, 0.20, 3, '34567890000112'),
(3002, 'Calça Jeans Feminina', 'Calça jeans feminina tamanho 38', 120.00, 80.00, 80, 0.50, 3, '34567890000112'),
(4001, 'Tênis Running', 'Tênis esportivo com amortecimento especial', 250.00, 180.00, 60, 1.20, 4, '45678901000123'),
(4002, 'Sapato Social Masculino', 'Sapato social em couro legítimo', 300.00, 200.00, 40, 1.00, 4, '45678901000123'),
(5001, 'Arroz 5kg', 'Pacote de arroz branco tipo 1', 25.00, 20.00, 200, 5.00, 5, '56789012000134'),
(5002, 'Feijão 1kg', 'Pacote de feijão preto tipo 1', 8.00, 6.50, 300, 1.00, 5, '56789012000134'),
(6001, 'Livro de Romance', 'Livro de romance best-seller', 40.00, 30.00, 50, 0.80, 6, '67890123000145'),
(6002, 'Livro de Ficção Científica', 'Livro de ficção científica premiado', 60.00, 45.00, 30, 1.00, 6, '67890123000145'),
(7001, 'Boneca Barbie', 'Boneca Barbie Fashionista', 120.00, 90.00, 40, 0.75, 7, '78901234000156'),
(7002, 'Lego Star Wars', 'Kit de Lego Star Wars com 1000 peças', 450.00, 380.00, 25, 2.00, 7, '78901234000156'),
(8001, 'Furadeira Bosch', 'Furadeira elétrica Bosch 500W', 300.00, 250.00, 30, 2.50, 8, '89012345000167'),
(8002, 'Chave de Fenda', 'Chave de fenda reforçada', 20.00, 15.00, 100, 0.30, 8, '89012345000167'),
(9001, 'Bola de Futebol', 'Bola oficial para campeonatos', 150.00, 120.00, 70, 0.50, 9, '90123456000178'),
(9002, 'Bicicleta Mountain Bike', 'Bicicleta para trilhas e esportes radicais', 2500.00, 2000.00, 15, 18.00, 9, '90123456000178'),
(10001, 'Sofá 3 Lugares', 'Sofá confortável para sala de estar', 1200.00, 1000.00, 10, 50.00, 10, '01234567000189'),
(10002, 'Cadeira de Escritório', 'Cadeira ergonômica com ajuste de altura', 700.00, 600.00, 20, 15.00, 10, '01234567000189'),
(11001, 'Perfume Chanel Nº5', 'Perfume clássico feminino', 750.00, 600.00, 20, 0.50, 11, '12345678000101'),
(11002, 'Colônia Masculina Paco Rabanne', 'Fragrância intensa e marcante', 450.00, 350.00, 30, 0.40, 11, '12345678000101'),
(12001, 'Caderno Universitário', 'Caderno com 200 folhas e capa dura', 20.00, 15.00, 100, 0.60, 12, '23456789000112'),
(12002, 'Caneta Esferográfica Azul', 'Pacote com 10 canetas esferográficas', 15.00, 10.00, 200, 0.30, 12, '23456789000112'),
(13001, 'Pneu Aro 16', 'Pneu para carros de passeio', 500.00, 400.00, 50, 10.00, 13, '34567890000123'),
(13002, 'Kit de Ferramentas Automotivas', 'Conjunto com 50 peças para reparos', 300.00, 250.00, 30, 8.00, 13, '34567890000123'),
(14001, 'Mouse Gamer Logitech', 'Mouse com 6 botões e iluminação RGB', 250.00, 200.00, 50, 0.50, 14, '45678901000134'),
(14002, 'Teclado Mecânico Razer', 'Teclado mecânico com switches táteis', 600.00, 500.00, 40, 1.50, 14, '45678901000134'),
(15001, 'Oxímetro de Dedo', 'Dispositivo para medir o nível de oxigênio no sangue', 120.00, 90.00, 100, 0.30, 15, '56789012000145'),
(15002, 'Termômetro Digital', 'Termômetro de alta precisão', 80.00, 60.00, 150, 0.20, 15, '56789012000145');

INSERT INTO Pessoa (cpf, nome, data_nascimento, email, telefone) VALUES
('12345678901', 'João Silva', '1985-01-15', 'joao.silva@gmail.com', '11987654321'),
('23456789012', 'Maria Oliveira', '1990-06-22', 'maria.oliveira@yahoo.com', '21976543210'),
('34567890123', 'Pedro Santos', '1987-04-10', 'pedro.santos@hotmail.com', '31965432109'),
('45678901234', 'Ana Costa', '1995-08-05', 'ana.costa@outlook.com', '41954321098'),
('56789012345', 'Lucas Almeida', '1992-03-18', 'lucas.almeida@gmail.com', '51943210987'),
('67890123456', 'Beatriz Ferreira', '1989-07-27', 'beatriz.ferreira@gmail.com', '61932109876'),
('78901234567', 'Fernando Rocha', '1991-12-30', 'fernando.rocha@yahoo.com', '71921098765'),
('89012345678', 'Juliana Lima', '1983-11-19', 'juliana.lima@hotmail.com', '81910987654'),
('90123456789', 'Carlos Gomes', '1993-09-02', 'carlos.gomes@outlook.com', '91909876543'),
('01234567890', 'Patrícia Sousa', '1996-05-23', 'patricia.sousa@gmail.com', '11123456789'),
('11234567891', 'Roberto Martins', '1984-02-14', 'roberto.martins@yahoo.com', '21987654320'),
('22345678902', 'Camila Nunes', '1997-10-08', 'camila.nunes@gmail.com', '31976543219'),
('33456789013', 'Rodrigo Carvalho', '1986-06-03', 'rodrigo.carvalho@outlook.com', '41965432108'),
('44567890124', 'Carolina Batista', '1994-04-22', 'carolina.batista@hotmail.com', '51954321097'),
('55678901235', 'Eduardo Souza', '1991-07-13', 'eduardo.souza@gmail.com', '61943210986'),
('66789012346', 'Marcela Ribeiro', '1990-12-01', 'marcela.ribeiro@yahoo.com', '71932109875'),
('77890123457', 'André Menezes', '1988-08-18', 'andre.menezes@gmail.com', '81921098764'),
('88901234568', 'Thaís Borges', '1992-05-11', 'thais.borges@hotmail.com', '91910987653'),
('99012345679', 'Rafael Barros', '1987-03-29', 'rafael.barros@gmail.com', '11909876542'),
('10123456780', 'Vanessa Vieira', '1993-11-25', 'vanessa.vieira@yahoo.com', '21987654319'),
('11134567891', 'Gustavo Ramos', '1995-06-09', 'gustavo.ramos@hotmail.com', '31976543218'),
('12245678902', 'Letícia Pires', '1989-10-16', 'leticia.pires@outlook.com', '41965432107'),
('13356789013', 'Bruno Miranda', '1996-01-21', 'bruno.miranda@gmail.com', '51954321096'),
('14467890124', 'Larissa Teixeira', '1990-04-27', 'larissa.teixeira@yahoo.com', '61943210985'),
('15578901235', 'Diego Lopes', '1988-09-15', 'diego.lopes@gmail.com', '71932109874'),
('16689012346', 'Fernanda Santana', '1994-12-20', 'fernanda.santana@hotmail.com', '81921098763'),
('17790123457', 'Ricardo Cruz', '1992-07-04', 'ricardo.cruz@outlook.com', '91910987652'),
('18801234568', 'Juliane Silva', '1987-02-12', 'juliane.silva@gmail.com', '11123456788'),
('19912345679', 'Thiago Oliveira', '1993-10-07', 'thiago.oliveira@yahoo.com', '21987654318'),
('20023456780', 'Gabriela Araújo', '1986-05-14', 'gabriela.araujo@hotmail.com', '31976543217'),
('21134567891', 'Adriana Rocha', '1990-08-19', 'adriana.rocha@gmail.com', '41965432106'),
('22245678902', 'Luiz Figueiredo', '1984-09-01', 'luiz.figueiredo@yahoo.com', '51954321095'),
('23356789013', 'Viviane Dias', '1991-03-03', 'viviane.dias@gmail.com', '61943210984'),
('24467890124', 'Paulo Fonseca', '1988-06-24', 'paulo.fonseca@outlook.com', '71932109873'),
('25578901235', 'Cíntia Souza', '1995-07-30', 'cintia.souza@hotmail.com', '81921098762'),
('26689012346', 'Vinícius Silva', '1992-11-10', 'vinicius.silva@gmail.com', '91910987651'),
('27790123457', 'Daniele Almeida', '1989-01-17', 'daniele.almeida@yahoo.com', '11123456787'),
('28801234568', 'Hugo Campos', '1994-09-22', 'hugo.campos@hotmail.com', '21987654317'),
('29912345679', 'Sandra Fernandes', '1987-08-11', 'sandra.fernandes@gmail.com', '31976543216'),
('30023456780', 'Murilo Nascimento', '1990-12-28', 'murilo.nascimento@yahoo.com', '41965432105'),
('31134567891', 'Monique Soares', '1993-02-26', 'monique.soares@hotmail.com', '51954321094'),
('32245678902', 'Henrique Santos', '1985-03-30', 'henrique.santos@gmail.com', '61943210983'),
('33356789013', 'Flávia Cardoso', '1996-06-05', 'flavia.cardoso@yahoo.com', '71932109872'),
('34467890124', 'Alexandre Lima', '1992-04-01', 'alexandre.lima@gmail.com', '81921098761'),
('35578901235', 'Helena Matos', '1988-10-23', 'helena.matos@hotmail.com', '91910987650'),
('36689012346', 'Cláudio Ribeiro', '1991-05-18', 'claudio.ribeiro@gmail.com', '11123456786'),
('37790123457', 'Bianca Martins', '1994-11-04', 'bianca.martins@yahoo.com', '21987654316'),
('38801234568', 'Joana Oliveira', '1990-07-08', 'joana.oliveira@hotmail.com', '31976543215'),
('39912345679', 'Mário Costa', '1986-10-12', 'mario.costa@gmail.com', '41965432104'),
('40023456780', 'Renata Alves', '1993-01-09', 'renata.alves@yahoo.com', '51954321093');

INSERT INTO Funcionario (cargo, salario, data_contratacao, carga_horaria, cpf, registro_funcionario) VALUES
('Gerente', 8500.00, '2020-01-15', 40, '12345678901', 1),
('Analista de Sistemas', 7500.00, '2021-03-10', 40, '23456789012', 2),
('Desenvolvedor', 6800.00, '2022-05-18', 40, '34567890123', 3),
('Analista de Suporte', 4500.00, '2019-06-22', 40, '45678901234', 4),
('Técnico de TI', 4000.00, '2020-09-01', 40, '56789012345', 5),
('Engenheiro de Software', 9500.00, '2023-01-02', 40, '67890123456', 6),
('Coordenador de Projetos', 8000.00, '2021-12-15', 40, '78901234567', 7),
('Gerente de TI', 9000.00, '2018-11-20', 40, '89012345678', 8),
('Auxiliar Administrativo', 3000.00, '2020-07-12', 30, '90123456789', 9),
('Desenvolvedor Frontend', 6500.00, '2022-08-10', 40, '01234567890', 10),
('Desenvolvedor Backend', 7000.00, '2019-03-05', 40, '11234567891', 11),
('Gerente de Projetos', 8800.00, '2023-06-21', 40, '22345678902', 12),
('Analista de Qualidade', 6000.00, '2021-05-08', 40, '33456789013', 13),
('Especialista em Redes', 7200.00, '2022-10-19', 40, '44567890124', 14),
('Suporte Técnico', 3500.00, '2018-04-01', 40, '55678901235', 15),
('Analista de Dados', 7000.00, '2020-09-17', 40, '66789012346', 16),
('Consultor de TI', 8500.00, '2023-02-27', 40, '77890123457', 17),
('Programador Mobile', 6900.00, '2022-03-22', 40, '88901234568', 18),
('Administrador de Banco de Dados', 8000.00, '2021-12-30', 40, '99012345679', 19),
('Analista de Segurança', 9200.00, '2023-01-25', 40, '10123456780', 20);

INSERT INTO Cliente (data_registro, cpf) VALUES
('2022-01-15', '11134567891'),
('2022-02-10', '12245678902'),
('2022-03-05', '13356789013'),
('2022-04-22', '14467890124'),
('2022-05-18', '15578901235'),
('2022-06-30', '16689012346'),
('2022-07-15', '17790123457'),
('2022-08-12', '18801234568'),
('2022-09-01', '19912345679'),
('2022-10-25', '20023456780'),
('2023-01-10', '21134567891'),
('2023-02-14', '22245678902'),
('2023-03-22', '23356789013'),
('2023-04-11', '24467890124'),
('2023-05-05', '25578901235'),
('2023-06-20', '26689012346'),
('2023-07-25', '27790123457'),
('2023-08-30', '28801234568'),
('2023-09-15', '29912345679'),
('2023-10-01', '30023456780'),
('2023-11-12', '31134567891'),
('2023-12-08', '32245678902'),
('2024-01-05', '33356789013'),
('2024-02-20', '34467890124'),
('2024-03-11', '35578901235'),
('2024-04-01', '36689012346'),
('2024-05-15', '37790123457'),
('2024-06-30', '38801234568'),
('2024-07-12', '39912345679'),
('2024-08-05', '40023456780');

-- Endereços dos Fornecedores
INSERT INTO Endereco (estado, cep, cidade, logradouro, bairro, numero_endereco, fornecedor_cnpj, pessoa_cpf) VALUES
('SP', 12345000, 'São Paulo', 'Rua dos Fornecedores', 'Centro', 100, '12345678000190', NULL),
('RJ', 23456000, 'Rio de Janeiro', 'Avenida Comercial', 'Copacabana', 200, '23456789000101', NULL),
('MG', 34567000, 'Belo Horizonte', 'Praça dos Negócios', 'Savassi', 300, '34567890000112', NULL),
('RS', 45678000, 'Porto Alegre', 'Rua das Indústrias', 'Moinhos', 400, '45678901000123', NULL),
('BA', 56789000, 'Salvador', 'Avenida Central', 'Pituba', 500, '56789012000134', NULL),
('PR', 67890000, 'Curitiba', 'Rua do Comércio', 'Água Verde', 600, '67890123000145', NULL),
('PE', 78900000, 'Recife', 'Rua Empresarial', 'Boa Viagem', 700, '78901234000156', NULL),
('CE', 89000000, 'Fortaleza', 'Avenida Mercantil', 'Aldeota', 800, '89012345000167', NULL),
('SC', 90000000, 'Florianópolis', 'Rua do Trabalho', 'Centro', 900, '90123456000178', NULL),
('ES', 91234000, 'Vitória', 'Rua de Serviços', 'Jardim Camburi', 1000, '01234567000189', NULL),
('SP', 12345004, 'São Paulo', 'Avenida Fornecedor 2', 'Vila Mariana', 150, '12345678000190', NULL),
('RJ', 23456004, 'Rio de Janeiro', 'Rua Comercial 2', 'Barra da Tijuca', 250, '23456789000101', NULL),
('MG', 34567004, 'Belo Horizonte', 'Rua Alternativa', 'Lourdes', 350, '34567890000112', NULL),
('RS', 45678004, 'Porto Alegre', 'Praça das Indústrias', 'Cidade Baixa', 450, '45678901000123', NULL),
('BA', 56789004, 'Salvador', 'Rua do Comércio 2', 'Itapuã', 550, '56789012000134', NULL);

-- Endereços das Pessoas
INSERT INTO Endereco (estado, cep, cidade, logradouro, bairro, numero_endereco, fornecedor_cnpj, pessoa_cpf) VALUES
('SP', 12345001, 'São Paulo', 'Rua dos Moradores', 'Centro', 101, NULL, '12345678901'),
('RJ', 23456001, 'Rio de Janeiro', 'Rua Residencial', 'Copacabana', 202, NULL, '23456789012'),
('MG', 34567001, 'Belo Horizonte', 'Rua das Flores', 'Savassi', 303, NULL, '34567890123'),
('RS', 45678001, 'Porto Alegre', 'Rua da Harmonia', 'Moinhos', 404, NULL, '45678901234'),
('BA', 56789001, 'Salvador', 'Rua Alegre', 'Pituba', 505, NULL, '56789012345'),
('PR', 67890001, 'Curitiba', 'Rua da Paz', 'Água Verde', 606, NULL, '67890123456'),
('PE', 78900001, 'Recife', 'Rua Tropical', 'Boa Viagem', 707, NULL, '78901234567'),
('CE', 89000001, 'Fortaleza', 'Rua da Amizade', 'Aldeota', 808, NULL, '89012345678'),
('SC', 90000001, 'Florianópolis', 'Rua Bela Vista', 'Centro', 909, NULL, '90123456789'),
('ES', 91234001, 'Vitória', 'Rua das Palmeiras', 'Jardim Camburi', 1011, NULL, '01234567890'),
('SP', 12345002, 'São Paulo', 'Rua das Árvores', 'Centro', 102, NULL, '11234567891'),
('RJ', 23456002, 'Rio de Janeiro', 'Rua do Sol', 'Copacabana', 203, NULL, '22345678902'),
('MG', 34567002, 'Belo Horizonte', 'Rua do Horizonte', 'Savassi', 304, NULL, '33456789013'),
('RS', 45678002, 'Porto Alegre', 'Rua do Lago', 'Moinhos', 405, NULL, '44567890124'),
('BA', 56789002, 'Salvador', 'Rua do Farol', 'Pituba', 506, NULL, '55678901235'),
('PR', 67890002, 'Curitiba', 'Rua das Pedras', 'Água Verde', 607, NULL, '66789012346'),
('PE', 78900002, 'Recife', 'Rua das Rosas', 'Boa Viagem', 708, NULL, '77890123457'),
('CE', 89000002, 'Fortaleza', 'Rua das Gaivotas', 'Aldeota', 809, NULL, '88901234568'),
('SC', 90000002, 'Florianópolis', 'Rua do Mar', 'Centro', 910, NULL, '99012345679'),
('ES', 91234002, 'Vitória', 'Rua da Lua', 'Jardim Camburi', 1012, NULL, '10123456780'),
('SP', 12345003, 'São Paulo', 'Rua do Céu', 'Centro', 103, NULL, '11134567891'),
('RJ', 23456003, 'Rio de Janeiro', 'Rua da Vitória', 'Copacabana', 204, NULL, '12245678902'),
('MG', 34567003, 'Belo Horizonte', 'Rua do Amor', 'Savassi', 305, NULL, '13356789013'),
('RS', 45678003, 'Porto Alegre', 'Rua do Campo', 'Moinhos', 406, NULL, '14467890124'),
('BA', 56789003, 'Salvador', 'Rua do Jardim', 'Pituba', 507, NULL, '15578901235'),
('PR', 67890003, 'Curitiba', 'Rua das Palmeiras', 'Água Verde', 608, NULL, '16689012346'),
('PE', 78900003, 'Recife', 'Rua do Coração', 'Boa Viagem', 709, NULL, '17790123457'),
('CE', 89000003, 'Fortaleza', 'Rua das Andorinhas', 'Aldeota', 810, NULL, '18801234568'),
('SC', 90000003, 'Florianópolis', 'Rua do Horizonte', 'Centro', 911, NULL, '19912345679'),
('ES', 91234003, 'Vitória', 'Rua do Porto', 'Jardim Camburi', 1013, NULL, '20023456780'),
('SP', 12345005, 'São Paulo', 'Rua do Parque', 'Morumbi', 102, NULL, '21134567891'),
('RJ', 23456005, 'Rio de Janeiro', 'Avenida Marítima', 'Ipanema', 205, NULL, '22245678902'),
('MG', 34567005, 'Belo Horizonte', 'Rua da Liberdade', 'Lourdes', 306, NULL, '23356789013'),
('RS', 45678005, 'Porto Alegre', 'Rua Verde', 'Mont Serrat', 407, NULL, '24467890124'),
('BA', 56789005, 'Salvador', 'Rua da Praia', 'Stella Maris', 508, NULL, '25578901235'),
('PR', 67890004, 'Curitiba', 'Rua do Jardim 2', 'Juvevê', 609, NULL, '26689012346'),
('PE', 78900004, 'Recife', 'Rua das Ondas', 'Casa Forte', 710, NULL, '27790123457'),
('CE', 89000004, 'Fortaleza', 'Rua do Céu Azul', 'Meireles', 811, NULL, '28801234568'),
('SC', 90000004, 'Florianópolis', 'Rua do Pôr do Sol', 'Lagoa da Conceição', 912, NULL, '29912345679'),
('ES', 91234004, 'Vitória', 'Rua das Orquídeas', 'Jardim da Penha', 1014, NULL, '30023456780');

INSERT INTO Venda (data, valor_venda, cpf_cliente) VALUES
('2025-01-10', 350.00, '11134567891'),
('2025-01-11', 1200.00, '12245678902'),
('2025-01-12', 850.00, '13356789013'),
('2025-01-13', 450.00, '14467890124'),
('2025-01-14', 500.00, '15578901235'),
('2025-01-15', 950.00, '16689012346'),
('2025-01-16', 700.00, '17790123457'),
('2025-01-17', 300.00, '18801234568'),
('2025-01-18', 420.00, '19912345679'),
('2025-01-19', 800.00, '20023456780'),
('2025-01-20', 220.00, '21134567891'),
('2025-01-21', 1050.00, '22245678902'),
('2025-01-22', 1800.00, '23356789013'),
('2025-01-23', 1100.00, '24467890124'),
('2025-01-24', 750.00, '25578901235'),
('2025-01-25', 950.00, '26689012346'),
('2025-01-26', 2000.00, '27790123457'),
('2025-01-27', 1400.00, '28801234568'),
('2025-01-28', 1300.00, '29912345679'),
('2025-01-29', 1500.00, '30023456780'),
('2025-01-30', 550.00, '11134567891'),
('2025-02-01', 1200.00, '12245678902'),
('2025-02-02', 400.00, '13356789013'),
('2025-02-03', 300.00, '14467890124'),
('2025-02-04', 950.00, '15578901235'),
('2025-02-05', 1100.00, '16689012346'),
('2025-02-06', 500.00, '17790123457'),
('2025-02-07', 1300.00, '18801234568'),
('2025-02-08', 800.00, '19912345679'),
('2025-02-09', 1200.00, '20023456780'),
('2025-02-10', 900.00, '21134567891'),
('2025-02-11', 250.00, '22245678902'),
('2025-02-12', 320.00, '23356789013'),
('2025-02-13', 180.00, '24467890124'),
('2025-02-14', 1100.00, '15578901235'),
('2025-02-15', 750.00, '16689012346'),
('2025-02-16', 1200.00, '17790123457'),
('2025-02-17', 500.00, '18801234568'),
('2025-02-18', 220.00, '19912345679'),
('2025-02-19', 600.00, '20023456780'),
('2025-02-20', 950.00, '21134567891'),
('2025-02-21', 1100.00, '22245678902'),
('2025-02-22', 450.00, '23356789013'),
('2025-02-23', 700.00, '24467890124'),
('2025-02-24', 1300.00, '25578901235'),
('2025-02-25', 800.00, '26689012346'),
('2025-02-26', 1500.00, '27790123457'),
('2025-02-27', 2000.00, '28801234568'),
('2025-02-28', 950.00, '29912345679'),
('2025-03-01', 1200.00, '30023456780'),
('2025-03-02', 220.00, '11134567891'),
('2025-03-03', 650.00, '12245678902'),
('2025-03-04', 750.00, '13356789013'),
('2025-03-05', 250.00, '14467890124'),
('2025-03-06', 1800.00, '15578901235'),
('2025-03-07', 1000.00, '16689012346'),
('2025-03-08', 900.00, '17790123457'),
('2025-03-09', 700.00, '18801234568'),
('2025-03-10', 850.00, '19912345679'),
('2025-03-11', 1200.00, '20023456780'),
('2025-03-12', 1500.00, '21134567891'),
('2025-03-13', 500.00, '22245678902'),
('2025-03-14', 320.00, '23356789013'),
('2025-03-15', 1100.00, '24467890124'),
('2025-03-16', 750.00, '25578901235'),
('2025-03-17', 800.00, '26689012346'),
('2025-03-18', 600.00, '27790123457'),
('2025-03-19', 500.00, '28801234568'),
('2025-03-20', 2000.00, '29912345679'),
('2025-03-21', 900.00, '30023456780'),
('2025-03-22', 1300.00, '11134567891'),
('2025-03-23', 1400.00, '12245678902'),
('2025-03-24', 700.00, '13356789013'),
('2025-03-25', 800.00, '14467890124'),
('2025-03-26', 500.00, '15578901235'),
('2025-03-27', 400.00, '16689012346'),
('2025-03-28', 350.00, '17790123457'),
('2025-03-29', 1200.00, '18801234568'),
('2025-03-30', 2000.00, '19912345679'),
('2025-03-31', 950.00, '20023456780');

INSERT INTO Compra (data_compra, valor_compra, cnpj_fornecedor) VALUES
('2025-01-01', 500.00, '12345678000190'),
('2025-01-02', 750.00, '23456789000101'),
('2025-01-03', 1200.00, '34567890000112'),
('2025-01-04', 900.00, '45678901000123'),
('2025-01-05', 1500.00, '56789012000134'),
('2025-01-06', 800.00, '67890123000145'),
('2025-01-07', 1100.00, '78901234000156'),
('2025-01-08', 1300.00, '89012345000167'),
('2025-01-09', 950.00, '90123456000178'),
('2025-01-10', 700.00, '01234567000189'),
('2025-01-11', 600.00, '12345678000190'),
('2025-01-12', 1400.00, '23456789000101'),
('2025-01-13', 1000.00, '34567890000112'),
('2025-01-14', 850.00, '45678901000123'),
('2025-01-15', 1200.00, '56789012000134'),
('2025-01-16', 900.00, '67890123000145'),
('2025-01-17', 1100.00, '78901234000156'),
('2025-01-18', 1300.00, '89012345000167'),
('2025-01-19', 950.00, '90123456000178'),
('2025-01-20', 700.00, '01234567000189'),
('2025-01-21', 600.00, '12345678000190'),
('2025-01-22', 1400.00, '23456789000101'),
('2025-01-23', 1000.00, '34567890000112'),
('2025-01-24', 850.00, '45678901000123'),
('2025-01-25', 1200.00, '56789012000134'),
('2025-01-26', 900.00, '67890123000145'),
('2025-01-27', 1100.00, '78901234000156'),
('2025-01-28', 1300.00, '89012345000167'),
('2025-01-29', 950.00, '90123456000178'),
('2025-01-30', 700.00, '01234567000189'),
('2025-01-31', 600.00, '12345678000190'),
('2025-02-01', 1400.00, '23456789000101'),
('2025-02-02', 1000.00, '34567890000112'),
('2025-02-03', 850.00, '45678901000123'),
('2025-02-04', 1200.00, '56789012000134'),
('2025-02-05', 900.00, '67890123000145'),
('2025-02-06', 1100.00, '78901234000156'),
('2025-02-07', 1300.00, '89012345000167'),
('2025-02-08', 950.00, '90123456000178'),
('2025-02-09', 700.00, '01234567000189'),
('2025-02-10', 600.00, '12345678000190'),
('2025-02-11', 1400.00, '23456789000101'),
('2025-02-12', 1000.00, '34567890000112'),
('2025-02-13', 850.00, '45678901000123'),
('2025-02-14', 1200.00, '56789012000134'),
('2025-02-15', 900.00, '67890123000145'),
('2025-02-16', 1100.00, '78901234000156'),
('2025-02-17', 1300.00, '89012345000167'),
('2025-02-18', 950.00, '90123456000178'),
('2025-02-19', 700.00, '01234567000189');

INSERT INTO Compoe (SKU, id_compra, quantidade_compra, preco_compra) VALUES
(1001, 1, 10, 3800.00),
(1002, 2, 20, 4500.00),
(1003, 3, 15, 2700.00),
(2001, 4, 25, 2500.00),
(2002, 5, 30, 1200.00),
(3001, 6, 12, 50.00),
(3002, 7, 18, 80.00),
(4001, 8, 22, 180.00),
(4002, 9, 14, 200.00),
(5001, 10, 16, 20.00),
(5002, 11, 19, 6.50),
(6001, 12, 21, 30.00),
(6002, 13, 17, 45.00),
(7001, 14, 23, 90.00),
(7002, 15, 24, 380.00),
(8001, 16, 20, 250.00),
(8002, 17, 25, 15.00),
(9001, 18, 30, 120.00),
(9002, 19, 28, 2000.00),
(10001, 20, 26, 1000.00),
(10002, 21, 22, 600.00),
(11001, 22, 24, 600.00),
(11002, 23, 18, 350.00),
(12001, 24, 20, 15.00),
(12002, 25, 16, 10.00),
(13001, 26, 14, 400.00),
(13002, 27, 12, 250.00),
(14001, 28, 10, 200.00),
(14002, 29, 8, 500.00),
(15001, 30, 6, 90.00),
(15002, 31, 4, 60.00),
(1001, 32, 2, 3800.00),
(1002, 33, 1, 4500.00),
(1003, 34, 3, 2700.00),
(2001, 35, 5, 2500.00),
(2002, 36, 7, 1200.00),
(3001, 37, 9, 50.00),
(3002, 38, 11, 80.00),
(4001, 39, 13, 180.00),
(4002, 40, 15, 200.00),
(5001, 41, 17, 20.00),
(5002, 42, 19, 6.50),
(6001, 43, 21, 30.00),
(6002, 44, 23, 45.00),
(7001, 45, 25, 90.00),
(7002, 46, 27, 380.00),
(8001, 47, 29, 250.00),
(8002, 48, 31, 15.00),
(9001, 49, 33, 120.00),
(9002, 50, 35, 2000.00),
(10001, 1, 37, 1000.00),
(10002, 2, 39, 600.00),
(11001, 3, 41, 600.00),
(11002, 4, 43, 350.00),
(12001, 5, 45, 15.00),
(12002, 6, 47, 10.00),
(13001, 7, 49, 400.00),
(13002, 8, 51, 250.00),
(14001, 9, 53, 200.00),
(14002, 10, 55, 500.00),
(15001, 11, 57, 90.00),
(15002, 12, 59, 60.00),
(1001, 13, 61, 3800.00),
(1002, 14, 63, 4500.00),
(1003, 15, 65, 2700.00),
(2001, 16, 67, 2500.00),
(2002, 17, 69, 1200.00),
(3001, 18, 71, 50.00),
(3002, 19, 73, 80.00),
(4001, 20, 75, 180.00),
(4002, 21, 77, 200.00),
(5001, 22, 79, 20.00),
(5002, 23, 81, 6.50),
(6001, 24, 83, 30.00),
(6002, 25, 85, 45.00),
(7001, 26, 87, 90.00),
(7002, 27, 89, 380.00),
(8001, 28, 91, 250.00),
(8002, 29, 93, 15.00),
(9001, 30, 95, 120.00),
(9002, 31, 97, 2000.00),
(10001, 32, 99, 1000.00),
(10002, 33, 100, 600.00),
(11001, 34, 98, 600.00),
(11002, 35, 96, 350.00),
(12001, 36, 94, 15.00),
(12002, 37, 92, 10.00),
(13001, 38, 90, 400.00),
(13002, 39, 88, 250.00),
(14001, 40, 86, 200.00),
(14002, 41, 84, 500.00),
(15001, 42, 82, 90.00),
(15002, 43, 80, 60.00),
(1001, 44, 78, 3800.00),
(1002, 45, 76, 4500.00),
(1003, 46, 74, 2700.00),
(2001, 47, 72, 2500.00),
(2002, 48, 70, 1200.00),
(3001, 49, 68, 50.00),
(3002, 50, 66, 80.00);

INSERT INTO Possui (SKU, id_venda, quantidade_venda, preco_venda) VALUES
(1001, 1, 10, 4500.00),
(1002, 2, 20, 5500.00),
(1003, 3, 15, 3200.00),
(2001, 4, 25, 3200.00),
(2002, 5, 30, 1500.00),
(3001, 6, 12, 80.00),
(3002, 7, 18, 120.00),
(4001, 8, 22, 250.00),
(4002, 9, 14, 300.00),
(5001, 10, 16, 25.00),
(5002, 11, 19, 8.00),
(6001, 12, 21, 40.00),
(6002, 13, 17, 60.00),
(7001, 14, 23, 120.00),
(7002, 15, 24, 450.00),
(8001, 16, 20, 300.00),
(8002, 17, 25, 20.00),
(9001, 18, 30, 150.00),
(9002, 19, 28, 2500.00),
(10001, 20, 26, 1200.00),
(10002, 21, 22, 700.00),
(11001, 22, 24, 750.00),
(11002, 23, 18, 450.00),
(12001, 24, 20, 20.00),
(12002, 25, 16, 15.00),
(13001, 26, 14, 500.00),
(13002, 27, 12, 300.00),
(14001, 28, 10, 250.00),
(14002, 29, 8, 600.00),
(15001, 30, 6, 120.00),
(15002, 31, 4, 80.00),
(1001, 32, 2, 4500.00),
(1002, 33, 1, 5500.00),
(1003, 34, 3, 3200.00),
(2001, 35, 5, 3200.00),
(2002, 36, 7, 1500.00),
(3001, 37, 9, 80.00),
(3002, 38, 11, 120.00),
(4001, 39, 13, 250.00),
(4002, 40, 15, 300.00),
(5001, 41, 17, 25.00),
(5002, 42, 19, 8.00),
(6001, 43, 21, 40.00),
(6002, 44, 23, 60.00),
(7001, 45, 25, 120.00),
(7002, 46, 27, 450.00),
(8001, 47, 29, 300.00),
(8002, 48, 31, 20.00),
(9001, 49, 33, 150.00),
(9002, 50, 35, 2500.00),
(10001, 1, 37, 1200.00),
(10002, 2, 39, 700.00),
(11001, 3, 41, 750.00),
(11002, 4, 43, 450.00),
(12001, 5, 45, 20.00),
(12002, 6, 47, 15.00),
(13001, 7, 49, 500.00),
(13002, 8, 51, 300.00),
(14001, 9, 53, 250.00),
(14002, 10, 55, 600.00),
(15001, 11, 57, 120.00),
(15002, 12, 59, 80.00),
(1001, 13, 61, 4500.00),
(1002, 14, 63, 5500.00),
(1003, 15, 65, 3200.00),
(2001, 16, 67, 3200.00),
(2002, 17, 69, 1500.00),
(3001, 18, 71, 80.00),
(3002, 19, 73, 120.00),
(4001, 20, 75, 250.00),
(4002, 21, 77, 300.00),
(5001, 22, 79, 25.00),
(5002, 23, 81, 8.00),
(6001, 24, 83, 40.00),
(6002, 25, 85, 60.00),
(7001, 26, 87, 120.00),
(7002, 27, 89, 450.00),
(8001, 28, 91, 300.00),
(8002, 29, 93, 20.00),
(9001, 30, 95, 150.00),
(9002, 31, 97, 2500.00),
(10001, 32, 99, 1200.00),
(10002, 33, 100, 700.00),
(11001, 34, 98, 750.00),
(11002, 35, 96, 450.00),
(12001, 36, 94, 20.00),
(12002, 37, 92, 15.00),
(13001, 38, 90, 500.00),
(13002, 39, 88, 300.00),
(14001, 40, 86, 250.00),
(14002, 41, 84, 600.00),
(15001, 42, 82, 120.00),
(15002, 43, 80, 80.00),
(1001, 44, 78, 4500.00),
(1002, 45, 76, 5500.00),
(1003, 46, 74, 3200.00),
(2001, 47, 72, 3200.00),
(2002, 48, 70, 1500.00),
(3001, 49, 68, 80.00),
(3002, 50, 66, 120.00);

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

-- Exemplos de delete em 5 tabelas (e)

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

-- 12 Consultas diferentes (f)

-- F1) Consulta com INNER JOIN
-- Recupera os nomes dos fornecedores e os nomes dos produtos que eles fornecem.
SELECT f.nome_fornecedor, p.nome_produto
FROM empresa.Fornecedor f
INNER JOIN empresa.Produto p ON f.cnpj = p.cnpj_fornecedor;

-- F2) Consulta com OUTER JOIN
-- Recupera os nomes de todos os fornecedores e os produtos que eles fornecem, incluindo fornecedores que não têm produtos associados.
SELECT f.nome_fornecedor, p.nome_produto
FROM empresa.Fornecedor f
LEFT OUTER JOIN empresa.Produto p ON f.cnpj = p.cnpj_fornecedor;

-- F3) Consulta com ORDER BY
-- Recupera os produtos com seus valores de venda, ordenados pelo valor de venda em ordem decrescente.
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto
ORDER BY valor_produto_venda DESC;

-- F4) Consulta com GROUP BY
-- Recupera a quantidade de produtos em estoque por categoria, somando a quantidade de estoque de cada categoria.
SELECT c.nome_categoria, SUM(p.quantidade_estoque) AS total_estoque
FROM empresa.Categoria c
JOIN empresa.Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome_categoria;

-- F5) Consulta com HAVING
-- Recupera o nome das categorias que possuem mais de 100 itens em estoque.
SELECT c.nome_categoria, SUM(p.quantidade_estoque) AS total_estoque
FROM empresa.Categoria c
JOIN empresa.Produto p ON c.id_categoria = p.id_categoria
GROUP BY c.nome_categoria
HAVING SUM(p.quantidade_estoque) > 100;

-- F6) Consulta com UNION
-- Recupera os nomes dos produtos e dos fornecedores, sem duplicação, combinando as duas consultas.
SELECT cnpj AS identificador, nome_fornecedor AS nome, 'Fornecedor' AS tipo
FROM empresa.Fornecedor
UNION
SELECT SKU AS identificador, nome_produto AS nome, 'Produto' AS tipo
FROM empresa.Produto;

-- F7) Consulta com IN
-- Recupera os produtos que pertencem às categorias "Eletrônicos" ou "Roupas".
SELECT nome_produto
FROM empresa.Produto
WHERE id_categoria IN (
    SELECT id_categoria
    FROM empresa.Categoria
    WHERE nome_categoria IN ('Eletrônicos', 'Roupas')
);

-- F8) Consulta com LIKE
-- Recupera os nomes dos fornecedores cujo nome começa com "A".
SELECT nome_fornecedor
FROM empresa.Fornecedor
WHERE nome_fornecedor LIKE 'A%';

-- F9) Consulta com IS NULL
-- Recupera os fornecedores que não têm nenhuma compra registrada:
SELECT f.nome_fornecedor
FROM empresa.Fornecedor f
LEFT JOIN empresa.Compra c ON f.cnpj = c.cnpj_fornecedor
WHERE c.id_compra IS NULL;

-- F10) Consulta com ANY ou SOME
-- Recupera os produtos cujo valor de venda é maior do que qualquer produto da categoria "Eletrônicos".
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto p
WHERE valor_produto_venda > ANY (
    SELECT valor_produto_venda
    FROM empresa.Produto
    JOIN empresa.Categoria c ON c.id_categoria = p.id_categoria
    WHERE c.nome_categoria = 'Eletrônicos'
);


-- F11) Consulta com ALL
-- Recupera os produtos cujo valor de venda é maior do que todos os produtos da categoria "Roupas".
SELECT nome_produto, valor_produto_venda
FROM empresa.Produto p
WHERE valor_produto_venda > ALL (
    SELECT valor_produto_venda
    FROM empresa.Produto
    JOIN empresa.Categoria c ON c.id_categoria = p.id_categoria
    WHERE c.nome_categoria = 'Roupas'
);

-- 12) Consulta com EXISTS
-- Recupera os nomes dos fornecedores que possuem ao menos um produto com estoque acima de 100 unidades.
SELECT nome_fornecedor
FROM empresa.Fornecedor f
WHERE EXISTS (
    SELECT 1
    FROM empresa.Produto p
    WHERE p.cnpj_fornecedor = f.cnpj
    AND p.quantidade_estoque > 100
);

