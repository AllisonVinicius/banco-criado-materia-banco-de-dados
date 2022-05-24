

#SHOW DATABASES;

/*DROP DATABASE LIVRARIA;*/



 CREATE SCHEMA IF NOT EXISTS `livraria` DEFAULT CHARACTER SET latin1 ;
  USE `livraria` ;

-- -----------------------------------------------------
-- Table `livraria`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`autor` (
  `ID_autor` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME_autor` VARCHAR(45) NOT NULL,
  `CIDADE` VARCHAR(25) NOT NULL,
  `NASCIMENTO` DATE NOT NULL,
  `PAÍS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_autor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`promocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`promocao` (
  `ID_promocao` INT(11) NOT NULL AUTO_INCREMENT,
  `OBS` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_promocao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `livraria`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`endereco` (
  `ID_ENDERECO` INT(11) NOT NULL AUTO_INCREMENT,
  `RUA` VARCHAR(45) NOT NULL,
  `CEP` INT(11) NOT NULL,
  `NUMERO` INT(11) NOT NULL,
  `COMPLEMENTO` VARCHAR(45) NOT NULL,
  `BAIRRO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_ENDERECO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`livraria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`livraria` (
  `ID_LIVRARIA` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(20) NOT NULL,
  `endereco_ID_ENDERECO` INT(11) NOT NULL,
  PRIMARY KEY (`ID_LIVRARIA`),
  INDEX `fk_livraria_endereco1_idx` (`endereco_ID_ENDERECO` ASC),
  CONSTRAINT `fk_livraria_endereco1`
    FOREIGN KEY (`endereco_ID_ENDERECO`)
    REFERENCES `livraria`.`endereco` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`cliente` (
  `ID_CLIENTE` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(50) NOT NULL,
  `CPF` VARCHAR(12) NOT NULL,
  `DATA_NASCIMENTO` DATE NOT NULL,
  `SEXO` VARCHAR(2) NOT NULL,
  `endereco_ID_ENDERECO` INT(11) NOT NULL,
  `livraria_ID_LIVRARIA` INT(11) NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  INDEX `fk_cliente_endereco1_idx` (`endereco_ID_ENDERECO` ASC),
  INDEX `fk_cliente_livraria1_idx` (`livraria_ID_LIVRARIA` ASC),
  CONSTRAINT `fk_cliente_endereco1`
    FOREIGN KEY (`endereco_ID_ENDERECO`)
    REFERENCES `livraria`.`endereco` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_livraria1`
    FOREIGN KEY (`livraria_ID_LIVRARIA`)
    REFERENCES `livraria`.`livraria` (`ID_LIVRARIA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`compra` (
  `ID_compra` INT(11) NOT NULL AUTO_INCREMENT,
  `VALOR_UNI` FLOAT NOT NULL,
  `DATA_compra` DATE NOT NULL,
  PRIMARY KEY (`ID_compra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`estoque` (
  `ID_estoque` INT(11) NOT NULL AUTO_INCREMENT,
  `QUANTIDADE` INT(11) NOT NULL,
  PRIMARY KEY (`ID_estoque`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`editora` (
  `ID_editora` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME_editora` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(25) NOT NULL,
  `TELEFONE` VARCHAR(25) NOT NULL,
  `endereco_ID_ENDERECO` INT(11) NOT NULL,
  PRIMARY KEY (`ID_editora`),
  INDEX `fk_editora_endereco1_idx` (`endereco_ID_ENDERECO` ASC),
  CONSTRAINT `fk_editora_endereco1`
    FOREIGN KEY (`endereco_ID_ENDERECO`)
    REFERENCES `livraria`.`endereco` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`lancamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`lancamento` (
  `ID_lancamento` INT NOT NULL,
  `lancamento_OU_NAO` BIT NOT NULL,
  `DAATA` DATE NOT NULL,
  PRIMARY KEY (`ID_lancamento`))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `livraria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`categoria` (
  `ID_categoria` INT(11) NOT NULL AUTO_INCREMENT,
  `GENERO` VARCHAR(25) NOT NULL,
  `promocao_ID_promocao` INT(11) NOT NULL,
  PRIMARY KEY (`ID_categoria`),
  INDEX `fk_categoria_promocao1_idx` (`promocao_ID_promocao` ASC),
  CONSTRAINT `fk_categoria_promocao1`
    FOREIGN KEY (`promocao_ID_promocao`)
    REFERENCES `livraria`.`promocao` (`ID_promocao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `livraria`.`livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`livro` (
  `ID_livro` INT(11) NOT NULL AUTO_INCREMENT,
  `NOME_livro` VARCHAR(45) NOT NULL,
  `autor_ID_autor` INT(11) NOT NULL,
  `estoque_ID_estoque` INT(11) NOT NULL,
  `editora_ID_editora` INT(11) NOT NULL,
  `categoria_ID_categoria` INT(11) NOT NULL,
  `lancamento_ID_lancamento` INT NOT NULL,
  PRIMARY KEY (`ID_livro`, `lancamento_ID_lancamento`),
  INDEX `FK_livro_autor_IDX` (`autor_ID_autor` ASC),
  INDEX `fk_livro_estoque1_idx` (`estoque_ID_estoque` ASC),
  INDEX `fk_livro_editora1_idx` (`editora_ID_editora` ASC),
  INDEX `fk_livro_categoria1_idx` (`categoria_ID_categoria` ASC),
  INDEX `fk_livro_lancamento1_idx` (`lancamento_ID_lancamento` ASC),
  CONSTRAINT `FK_livro_autor`
    FOREIGN KEY (`autor_ID_autor`)
    REFERENCES `livraria`.`autor` (`ID_autor`),
  CONSTRAINT `fk_livro_estoque1`
    FOREIGN KEY (`estoque_ID_estoque`)
    REFERENCES `livraria`.`estoque` (`ID_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livro_editora1`
    FOREIGN KEY (`editora_ID_editora`)
    REFERENCES `livraria`.`editora` (`ID_editora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livro_categoria1`
    FOREIGN KEY (`categoria_ID_categoria`)
    REFERENCES `livraria`.`categoria` (`ID_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livro_lancamento1`
    FOREIGN KEY (`lancamento_ID_lancamento`)
    REFERENCES `livraria`.`lancamento` (`ID_lancamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`cliente_has_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`cliente_has_compra` (
  `CLIENTE_ID_CLIENTE` INT(11) NOT NULL,
  `compra_ID_compra` INT(11) NOT NULL,
  `livro_ID_livro` INT(11) NOT NULL,
  PRIMARY KEY (`CLIENTE_ID_CLIENTE`, `compra_ID_compra`),
  INDEX `FK_cliente_has_compra_compra1_IDX` (`compra_ID_compra` ASC),
  INDEX `FK_cliente_has_compra_CLIENTE1_IDX` (`CLIENTE_ID_CLIENTE` ASC),
  INDEX `FK_cliente_has_compra_livro1_IDX` (`livro_ID_livro` ASC),
  CONSTRAINT `FK_cliente_has_compra_CLIENTE1`
    FOREIGN KEY (`CLIENTE_ID_CLIENTE`)
    REFERENCES `livraria`.`cliente` (`ID_CLIENTE`),
  CONSTRAINT `FK_cliente_has_compra_compra1`
    FOREIGN KEY (`compra_ID_compra`)
    REFERENCES `livraria`.`compra` (`ID_compra`),
  CONSTRAINT `FK_cliente_has_compra_livro1`
    FOREIGN KEY (`livro_ID_livro`)
    REFERENCES `livraria`.`livro` (`ID_livro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`reservaC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`reserva` (
  `ID_reserva` INT(11) NOT NULL AUTO_INCREMENT,
  `QUANTIDADE` INT(11) NOT NULL,
  `COM_OU_SEM_reserva` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID_reserva`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `livraria`.`cliente_has_reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`cliente_has_reserva` (
  `cliente_ID_CLIENTE` INT(11) NOT NULL,
  `reserva_ID_reserva` INT(11) NOT NULL,
  PRIMARY KEY (`cliente_ID_CLIENTE`, `reserva_ID_reserva`),
  INDEX `fk_cliente_has_reserva_reserva1_idx` (`reserva_ID_reserva` ASC),
  INDEX `fk_cliente_has_reserva_cliente1_idx` (`cliente_ID_CLIENTE` ASC),
  CONSTRAINT `fk_cliente_has_reserva_cliente1`
    FOREIGN KEY (`cliente_ID_CLIENTE`)
    REFERENCES `livraria`.`cliente` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_reserva_reserva1`
    FOREIGN KEY (`reserva_ID_reserva`)
    REFERENCES `livraria`.`reserva` (`ID_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `livraria`.`desconto_prox`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`desconto_prox` (
  `id_desconto` INT NOT NULL,
  `desconto_prox` BIT NOT NULL,
  PRIMARY KEY (`id_desconto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`total_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`total_compra` (
  `ID_TOTAL` INT NOT NULL,
  `total_compra` FLOAT NOT NULL,
  `desconto_prox_id_desconto` INT NOT NULL,
  PRIMARY KEY (`ID_TOTAL`),
  INDEX `fk_total_compra_desconto_prox1_idx` (`desconto_prox_id_desconto` ASC),
  CONSTRAINT `fk_total_compra_desconto_prox1`
    FOREIGN KEY (`desconto_prox_id_desconto`)
    REFERENCES `livraria`.`desconto_prox` (`id_desconto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`itens_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`itens_compra` (
  `ID_ITENcompra` INT NOT NULL,
  `QTD` INT NOT NULL,
  `compra_ID_compra` INT(11) NOT NULL,
  `total_compra_ID_TOTAL` INT NOT NULL,
  PRIMARY KEY (`ID_ITENcompra`),
  INDEX `fk_itens_compra_compra1_idx` (`compra_ID_compra` ASC),
  INDEX `fk_itens_compra_total_compra1_idx` (`total_compra_ID_TOTAL` ASC),
  CONSTRAINT `fk_itens_compra_compra1`
    FOREIGN KEY (`compra_ID_compra`)
    REFERENCES `livraria`.`compra` (`ID_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_compra_total_compra1`
    FOREIGN KEY (`total_compra_ID_TOTAL`)
    REFERENCES `livraria`.`total_compra` (`ID_TOTAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`itens_compra_has_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`itens_compra_has_compra` (
  `itens_compra_ID_ITENcompra` INT NOT NULL,
  `compra_ID_compra` INT(11) NOT NULL,
  PRIMARY KEY (`itens_compra_ID_ITENcompra`, `compra_ID_compra`),
  INDEX `fk_itens_compra_has_compra_compra1_idx` (`compra_ID_compra` ASC),
  INDEX `fk_itens_compra_has_compra_itens_compra1_idx` (`itens_compra_ID_ITENcompra` ASC),
  CONSTRAINT `fk_itens_compra_has_compra_itens_compra1`
    FOREIGN KEY (`itens_compra_ID_ITENcompra`)
    REFERENCES `livraria`.`itens_compra` (`ID_ITENcompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_compra_has_compra_compra1`
    FOREIGN KEY (`compra_ID_compra`)
    REFERENCES `livraria`.`compra` (`ID_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`total` (
  `ID_TOTAL` INT NOT NULL,
  `VALOT_TOTAL` FLOAT NOT NULL,
  PRIMARY KEY (`ID_TOTAL`))
ENGINE = InnoDB;

-- ----------------------------------------

-- ----------------------------[ENDERECO]----------------------------------

INSERT INTO endereco VALUES(1001, "ALAMEDA IVANIR", 15486, 10, "PERTO DA VENDA", "ALVORADA");
INSERT INTO endereco VALUES(1002, "ESMERALDA", 12345, 20, "PERTO PRAÇA", "CRISTO REDENTOR");
INSERT INTO endereco VALUES(1003, "RIO BRANCO", 67789, 50, "PERTO DA FARMACIA", "NOVA ALIANÇA");
INSERT INTO endereco VALUES(1004, "AVENIDA BRASIL", 22354, 70, "PERTO DO BANCO", "ALTA FLORESTA");
INSERT INTO endereco VALUES(1005, "ALBUQUERQUE", 23422, 100, "PERTO DA IGREJA", "CENTRO");
INSERT INTO endereco VALUES(1006, "PORTO CARRERO", 15975, 1000, "PERTO DA MERCEARIA", "NOVA CORUMBA");
INSERT INTO endereco VALUES(1007, "RICARDO FRANCO", 26485, 99, "PERTO DO BAR", "GUATÓS");
INSERT INTO endereco VALUES(1008, "14 DE MARCO", 36985, 45, "PERTO DA PIZZARIA", "GUANÃ");
INSERT INTO endereco VALUES(1009, "7 DE SETEMBRO", 45871, 30, "PERTO DO HOSPITAL", "PREVISUL");
INSERT INTO endereco VALUES(1010, "15 DE NOVEMBRO", 98663, 04, "PERTO DO MUSEU", "MARIA LEITE");
INSERT INTO endereco VALUES(1011, "FREI MARIANO", 16497, 08, "PERTO DA BANCA DE JORNAL", "UNIVERSITÁRIO");
INSERT INTO endereco VALUES(1012, "ANTONIO MARIA COELHO", 33116, 19, "PERTO DO CAMPO", "POPULAR NOVA");
INSERT INTO endereco VALUES(1013, "ANTONIO JOAO", 90506, 22, "PERTO DO PONTO DE ONIBUS", "POPULAR VELHA");
INSERT INTO endereco VALUES(1014, "JOSÉ FRAGELIS", 40998, 33, "PERTO DA CHURRASCARIA", "CENTRO AMÉRICA");
INSERT INTO endereco VALUES(1015, "RUBI", 31978, 66, "PERTO DO PRESIDIO", "ARTHUR MARINHO");

INSERT INTO endereco VALUES(1016, "FERNANDO DE BARROS", 122128, 121, "PERTO ESCOLA", "CENTRO AMERICA");
INSERT INTO endereco VALUES(1017, "ATIBAIA", 31978, 76, "PERTO DO VENDA", "PALHOÇA");
INSERT INTO endereco VALUES(1018, "AMANBAIA", 31978, 290, "AO LADO DA PRACA", "CENTRO");
INSERT INTO endereco VALUES(1019, "NATALL", 31978, 3782, "EM FRENTE UFMS", "MANGUEIRAL");
INSERT INTO endereco VALUES(1020, "JOSE FRAGELLI", 31978, 54, "ESQUINA ALAMEDA", "IGREJINHA");
INSERT INTO endereco VALUES(1021, "CABRALL", 31978, 111, "AO LADO DO CORGO", "UNIVERSITARIO");
INSERT INTO endereco VALUES(1022, "21 DE ABRIL", 31978, 1152, "PERTO D PONTO", "BORROVISK");
INSERT INTO endereco VALUES(1023, "AV DA PEIXERADA", 31978, 1054, "ESQUNA BAR", "AV BRASIL");
INSERT INTO endereco VALUES(1024, "7 DE AGOSTO", 31978, 6021, "RUA DA ESCOLA", "CENTRO AMERICA");
INSERT INTO endereco VALUES(1025, "ESMERALDA", 31978, 541, "PERTO SOBRADO", "CRISTO REDENTOR");
INSERT INTO endereco VALUES(1026, "VITORIA REGIA", 31978, 987, "BEM DE ESQUINA", "CARLINDAA");
INSERT INTO endereco VALUES(1027, "AFONSO PENA", 31978, 093, "ATRAS IGREJA", "MONTE CASTELO");
INSERT INTO endereco VALUES(1028, "21 DE SETEMBRO", 31978, 325, "ATRAS DO BANCO", "FUNDAO ");
INSERT INTO endereco VALUES(1029, "31 DE AGOSTO", 31978, 35, "EM FRENTE A LOJA", "PEIXERADA");
INSERT INTO endereco VALUES(1030, "28 DE FEVEREIRIO", 902189, 1, "AO LADO DO LAVA JATO", "PORTO");
INSERT INTO endereco VALUES(1031, "AV BRASIL", 091278, 87, "ATRAS CAMPO", "POPULAR VELHA");
INSERT INTO endereco VALUES(1032, "DOM BOSCO", 794293, 236, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1033, "FREI MARIANO", 92728,122, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1034, "DOM PEDRO II", 45755, 90, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1035, "PEDRO PAULO DE MEDEIRO", 8080, 73, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1036, "RIO BRANCO", 14144, 23, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1037, "PARANAA", 4341, 188, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1038, "TENENTE MELQUIADES", 90939,999, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1039, "PARAIBA", 9843, 888, "PERTO DO PRESIDIO", "PORTO");
INSERT INTO endereco VALUES(1040, "MINAS GERAIS", 32109,1010, "PERTO DO PRESIDIO", "PORTO");





UPDATE endereco SET RUA  =  "ESPERANÇA" WHERE ID_ENDERECO = 1001;
UPDATE endereco SET RUA  = "RUA DO CARMO" WHERE ID_ENDERECO = 1002;
UPDATE endereco SET RUA  =  "ORIENTAL" WHERE ID_ENDERECO = 1003;
UPDATE endereco SET RUA  = "CABRAL" WHERE ID_ENDERECO = 1006;
UPDATE endereco SET RUA  =  "MAJOR GAMA" WHERE ID_ENDERECO = 110;



INSERT INTO livraria VALUES(1, "PAGA MAS NAO LE", "03336669",1001);

-- -----------------------------------------------------------------------------------------------------------

-- ---------------------------[CLIENTE] -------------------------------------

INSERT INTO cliente VALUES(211,"FRANCISCO DA SILVA","06734112",'1878-04-23',"H",1002,1);
INSERT INTO cliente VALUES(212,"SANSAO DE GAZA","11223431",'1993-03-23',"M",1003,1);
INSERT INTO cliente VALUES(213,"SEBASTIÃO DE ASSIS","89387383",'1999-04-01',"H",1004,1);
INSERT INTO cliente VALUES(214,"CATATAU VIEIRA","15640026",'1997-04-18',"H",1005,1);
INSERT INTO cliente VALUES(215,"VARAO ISRAELITA","06734121",'1996-09-01',"H",1006,1);
INSERT INTO cliente VALUES(216,"LUCAS SANTOS DE OLIVEIRA","60379423",'2000-08-06',"H",1007,1);
INSERT INTO cliente VALUES(217,"MATEUS DE ARRUDA OLIVEIRA","55984632",'1996-05-10',"H",1008,1);
INSERT INTO cliente VALUES(218,"RODRIGO SANTIAGO SAMOZA","33987462",'1995-08-22',"H",1009,1);
INSERT INTO cliente VALUES(219,"PAMELA GONÇALVES DE PAULA","15927864",'1998-04-16',"M",1010,1);
INSERT INTO cliente VALUES(220,"LUIZ DE ASSIS FRANÇA","68429513",'1989-01-1',"H",1011,1);
INSERT INTO cliente VALUES(221,"BARBARA ESTER CUNHA FRETES","74196355",'2002-04-11',"M",1012,1);
INSERT INTO cliente VALUES(222,"JADSON VIEIRA DE MIRANDA","64319782",'1974-05-21',"H",1013,1);
INSERT INTO cliente VALUES(223,"CARLOS ALBERTO DA SILVA","44997766",'1965-04-30',"H",1014,1);
INSERT INTO cliente VALUES(224,"MAYARA FRETES MARTINES DA SILVA","03429228",'1992-07-16',"M",1015,1);
INSERT INTO cliente VALUES(225,"PEDRO LUAN SAMPAIO DA COSTA","16794364",'1993-11-2',"H",1001,1);
INSERT INTO cliente VALUES(226,"VALERIA JUSTINIANO DA SILVA","81392746",'1987-11-18',"M",1015,1);
INSERT INTO cliente VALUES(227,"JOSÉ DE ARIMATEIA","14632597",'1977-10-10',"H",1011,1);
INSERT INTO cliente VALUES(228,"LEONARDO LUCAS LOZADA DA SILVA","88844469",'1997-12-25',"H",1002,1);

------------------------------------------------------------------------------------

-- -----------[ autor ] ---------------------------------
INSERT INTO autor VALUES(100,"TRANQUEDO NEVES","CORUMBA",'1990-04-8',"BRASIL");
INSERT INTO autor VALUES(101,"POGBA","GANTE",'1991-03-24',"BELGICA");
INSERT INTO autor VALUES(102,"EVO MORALES","MATHUPTHU",'1617-03-25',"BOLIVIA");
INSERT INTO autor VALUES(103,"FRANCIS THAN","",'1789-12-23',"ESTADOS UNIDOS");
INSERT INTO autor VALUES(104,"AMADO BATISTA","NOVA YOURK",'1690-04-10',"PERU");
INSERT INTO autor VALUES(105,"BRUNO YOK","BUENOS AIRES",'1978-7-22',"ARGENTINA");
INSERT INTO autor VALUES(106,"ZINEDNE ZIDANE","CAMPO GRANDE",'1991-09-21',"ALEMANHA");
INSERT INTO autor VALUES(107,"RONALDINHO GAUCHO","APARECIDA DO TABOADO",'1989-06-02',"ITALIA");
INSERT INTO autor VALUES(108,"JOAO DORIA","AQUIDAUANA",'1980-11-11',"PAQUISTAO");
INSERT INTO autor VALUES(109,"MICHEL TEMER","BRASILIA",'2001-05-30',"BOLIVIA");
INSERT INTO autor VALUES(110,"THERY HENRI","ANGELICA",'1997-12-28',"TURQUIA");
INSERT INTO autor VALUES(111,"HENRY FORD","CUIABA",'1996-10-14',"ISRAEL");
INSERT INTO autor VALUES(112,"SIGMON FREUD","BONITO",'1945-11-07',"COREIA DO NORTE");
INSERT INTO autor VALUES(113,"MARCAL CABRAL","MIRASOL DO OESTE",'1978-12-10',"AFRICA DO SUL");
INSERT INTO autor VALUES(114,"MARIA MADALENA","ANASTACIO",'1940-01-4',"CROACIA");
INSERT INTO autor VALUES(115,"JOAO ALMEIDA","SIDROLANDIA",'1940-05-2',"ESPANHA");
INSERT INTO autor VALUES(116,"CRISTIANO RONALDO","LISBOA",'1940-01-4',"PORTUGAL");
INSERT INTO autor VALUES(117,"ISAN BOLT","KINGSTON",'1940-01-4',"JAMAICA");
INSERT INTO autor VALUES(118,"DAVI SOARES","POLINIA",'1940-01-4',"REPUBLICA THECA");
INSERT INTO autor VALUES(119,"JOSEPH SMITH","HENRY FREUD",'1940-01-4',"PAIS DE GALA");
INSERT INTO autor VALUES(120,"GABRIEL MARTINS","CORK",'1940-01-4',"IRLANDIA");
INSERT INTO autor VALUES(121,"MOHAMED IZA","ASTANA",'1940-01-4',"CASAQUISTÃO");
INSERT INTO autor VALUES(122,"CARLINHOS BROW","NICE",'1940-01-4',"FRANÇAA");
INSERT INTO autor VALUES(123,"ROBBEN OLIVEIRA","MONTE VIDAL",'1940-01-4',"HOLANDA");
INSERT INTO autor VALUES(124,"LIONE MESSI","UKOCHIMA",'1940-01-4',"CHINAA");
INSERT INTO autor VALUES(125,"OZAMA BINLAD","CEZAREIA",'1940-01-4',"IRAQUE");



UPDATE autor SET NOME_autor  =  "LULA DA SILVA" WHERE ID_autor = 100;
UPDATE autor SET NOME_autor  =  "MICHAEL PHELPS" WHERE ID_autor = 101;
UPDATE autor SET NOME_autor  =  "LILIANE CUNHA" WHERE ID_autor = 109;
UPDATE autor SET NOME_autor  =  "FRANCISCA ROBERTA" WHERE ID_autor = 113;
UPDATE autor SET NOME_autor  =  "EVELAINE MORAES" WHERE ID_autor = 114;


-- -------------[estoque] --------------------------------------

INSERT INTO estoque VALUES (301, 3);
INSERT INTO estoque VALUES (302, 4);
INSERT INTO estoque VALUES (303, 6);
INSERT INTO estoque VALUES (304, 1);
INSERT INTO estoque VALUES (305, 8);
INSERT INTO estoque VALUES (306, 10);
INSERT INTO estoque VALUES (307, 22);
INSERT INTO estoque VALUES (308, 21);
INSERT INTO estoque VALUES (309, 65);
INSERT INTO estoque VALUES (310, 76);
INSERT INTO estoque VALUES (311, 12);
INSERT INTO estoque VALUES (312, 75);
INSERT INTO estoque VALUES (313, 97);
INSERT INTO estoque VALUES (314, 99);
INSERT INTO estoque VALUES (315, 1);
INSERT INTO estoque VALUES (316, 10);
INSERT INTO estoque VALUES (317, 42);
INSERT INTO estoque VALUES (318, 8);
INSERT INTO estoque VALUES (319, 33);
INSERT INTO estoque VALUES (320, 56);
INSERT INTO estoque VALUES (321, 45);
INSERT INTO estoque VALUES (322, 32);
INSERT INTO estoque VALUES (323, 21);
INSERT INTO estoque VALUES (324, 31);
INSERT INTO estoque VALUES (325, 41);

-- --------------------------------[editoraS]----------------------------------------------

INSERT INTO editora VALUES(500, "CONVICCAO", "conviccao@hotmail.com", "01196569",1016);
INSERT INTO editora VALUES(502, "CENTAURO", "sextante.br@gmail.com", "30322155",1017);
INSERT INTO editora VALUES(503, "CASA VERDE", "casaverdebr@hotmail.com"," 88663212",1018);
INSERT INTO editora VALUES(504, "DERIVA", "derivaaa@gmail.com", "27913365",1019);
INSERT INTO editora VALUES(505, "LIBERATO", "liberatolivros@gmail.com","123658",1020);
INSERT INTO editora VALUES(506, "QUADRANTE", "quadrante.livro@gmail.com", "16765923",1021);
INSERT INTO editora VALUES(507, "VEJA", "veja.livro@gmail.com", "8392839",1022);
INSERT INTO editora VALUES(508, "ISTOE", "istoe.livro@gmail.com", "3029320",1023);
INSERT INTO editora VALUES(509, "FORTHAN", "fotrthan.livro@gmail.com", "39029302",1024);
INSERT INTO editora VALUES(510, "JAVA", "java.livro@gmail.com", "0932933",1025);
INSERT INTO editora VALUES(511, "PHP", "php.livro@gmail.com"," 1293823",1026);
INSERT INTO editora VALUES(512, "QUADRI", "quadri.livro@gmail.com", "392839283",1027);
INSERT INTO editora VALUES(513, "ABSTRACT", "abstract.livro@gmail.com", "4421234",1028);
INSERT INTO editora VALUES(514, "DECIMAL", "decimal.livro@gmail.com", "9928271",1029);
INSERT INTO editora VALUES(515, "BANCO", "banco.livro@gmail.com", "232112",1030);
INSERT INTO editora VALUES(516, "AVIVA", "avivah.livro@gmail.com", "232112",1031);
INSERT INTO editora VALUES(517, "SENTINELA", "sentinela.livro@gmail.com", "232112",1032);
INSERT INTO editora VALUES(518, "MAJOR GAMA", "major.livro@gmail.com", "232112",1033);
INSERT INTO editora VALUES(519, "PRIMERO DE ABRIL", "primeiro.livro@gmail.com", "232112",1034);
INSERT INTO editora VALUES(520, "SHARMANDAIA","sharam.livro@gmail.com", "232112",1035);
INSERT INTO editora VALUES(521, "JUVENAL", "juvenal.livro@gmail.com", "232112",1036);
INSERT INTO editora VALUES(522, "VEM QUE TEM", "vemquetem.livro@gmail.com", "232112",1037);
INSERT INTO editora VALUES(523, "O MUNDO DA LEITURA", "mundo.livro@gmail.com", "232112",1037);
INSERT INTO editora VALUES(524, "NUVEM AZUL", "nuvelazul.livro@gmail.com", "232112",1039);
INSERT INTO editora VALUES(525, "DEBOX", "debox.livro@gmail.com", "232112",1040);


UPDATE editora SET TELEFONE  = "067389238" WHERE ID_editora = 500;
UPDATE editora SET TELEFONE  = "067366344" WHERE ID_editora = 501;
UPDATE editora SET TELEFONE  = "067666555" WHERE ID_editora = 502;
UPDATE editora SET TELEFONE  = "0673332323" WHERE ID_editora = 510;
UPDATE editora SET TELEFONE  = "067112212" WHERE ID_editora = 511;

-- -----------------------------------------------------------------------------------------
INSERT INTO promocao VALUES(1,"PROXIMA SEMANA");
INSERT INTO promocao VALUES(2,"ENQUANTO DURAR estoque");
INSERT INTO promocao VALUES(3,"ATE ACABAR lancamento");
INSERT INTO promocao VALUES(4,"PROXIMA SEMANA");
INSERT INTO promocao VALUES(5,"DQUI TRES DIAS");
INSERT INTO promocao VALUES(6,"PAGUE 2 LEVE 3");
INSERT INTO promocao VALUES(7,"SEM PREVISAO");
INSERT INTO promocao VALUES(8,"SEM promocao");
INSERT INTO promocao VALUES(9,"ATE ACABA OS lancamento");
INSERT INTO promocao VALUES(10,"ENQUANTO DURAR ESTOQE");
INSERT INTO promocao VALUES(11,"ATE MEIA NOITE");
INSERT INTO promocao VALUES(12,"DQUI A POUCAS HORAS");
INSERT INTO promocao VALUES(13,"UMA  SEMANA");
INSERT INTO promocao VALUES(14,"ESTA EM PROMCAO CINQUENTA POR CENTO");
INSERT INTO promocao VALUES(15,"DQUI DOIS DIAS");


UPDATE promocao SET OBS = "POUCO PARA promocao" WHERE ID_promocao = 3;
UPDATE promocao SET OBS = "ACABOU A 1 DIA A PRIMOCAO" WHERE ID_promocao = 1;
UPDATE promocao SET OBS = "ESTA EM promocao" WHERE ID_promocao = 12;
UPDATE promocao SET OBS = "SEM estoque PARA promocao" WHERE ID_promocao = 10;
UPDATE promocao SET OBS = "EM promocao ATE 11 HORAS" WHERE ID_promocao = 15;



 -- --------------------------------------------------
-- --------------------------------[lancamento]---------------------------------------------

INSERT INTO lancamento VALUES(600, 1, '2017-08-03');
INSERT INTO lancamento VALUES(601, 0, '2015-07-13');
INSERT INTO lancamento VALUES(602, 1, '2017-08-03');
INSERT INTO lancamento VALUES(603, 1, '2017-08-03');
INSERT INTO lancamento VALUES(604, 0, '2016-05-15');
INSERT INTO lancamento VALUES(605, 1, '2017-08-03');
INSERT INTO lancamento VALUES(606, 0, '2013-06-20');
INSERT INTO lancamento VALUES(607, 1, '2017-08-03');
INSERT INTO lancamento VALUES(608, 1, '2017-08-03');
INSERT INTO lancamento VALUES(609, 1,' 2017-08-03');
INSERT INTO lancamento VALUES(610, 0, '2012-11-13');
INSERT INTO lancamento VALUES(611, 1, '2017-08-03');
INSERT INTO lancamento VALUES(612, 0, '2011-12-25');
INSERT INTO lancamento VALUES(613, 1, '2017-08-03');
INSERT INTO lancamento VALUES(614, 1, '2012-05-26');
INSERT INTO lancamento VALUES(615, 0, '2013-05-26');
INSERT INTO lancamento VALUES(616, 0, '2011-08-25');
INSERT INTO lancamento VALUES(617, 0, '2015-12-21');
INSERT INTO lancamento VALUES(618, 0, '2017-10-20');
INSERT INTO lancamento VALUES(619, 0, '2010-11-21');
INSERT INTO lancamento VALUES(620, 1, '2011-05-10');
INSERT INTO lancamento VALUES(621, 1, '2009-05-11');
INSERT INTO lancamento VALUES(622, 1, '2008-05-12');
INSERT INTO lancamento VALUES(623, 1, '2009-05-31');
INSERT INTO lancamento VALUES(624, 0, '2010-05-30');
INSERT INTO lancamento VALUES(625, 1, '2007-05-29');


UPDATE lancamento SET DAATA  = '2017-06-10' WHERE ID_lancamento = 600;
UPDATE lancamento SET DAATA  = '2017-05-07' WHERE ID_lancamento = 605;
UPDATE lancamento SET DAATA  = '2017-08-01' WHERE ID_lancamento = 608;
UPDATE lancamento SET DAATA  = '2017-08-02' WHERE ID_lancamento = 612;
UPDATE lancamento SET DAATA  = '2011-07-10' WHERE ID_lancamento = 614;

-- ----------------------------------------------------------------------------------------------




-- --------- [INSERCAO categoria]---------------------
-- ---------------------------------------------------

 INSERT INTO categoria VALUES(121,"COMEDIA",1);
 INSERT INTO categoria VALUES(122,"SUSPENSE",2);
 INSERT INTO categoria VALUES(123,"AVENTURA",3);
 INSERT INTO categoria VALUES(124,"ROMANCE",4);
 INSERT INTO categoria VALUES(125,"ACAO",5);





-- -------------------------------------[reserva]-------------------------------------------------

INSERT INTO reserva VALUES(1, 0, "SEM reserva");
INSERT INTO reserva VALUES(2, 5, "COM reserva");
INSERT INTO reserva VALUES(3, 4, "COM reserva");
INSERT INTO reserva VALUES(4, 2, "SEM reserva");
INSERT INTO reserva VALUES(5, 8, "COM reserva");
INSERT INTO reserva VALUES(6, 0, "COM reserva");
INSERT INTO reserva VALUES(7, 6, "COM reserva");
INSERT INTO reserva VALUES(8, 0, "COM reserva");
INSERT INTO reserva VALUES(9, 2, "COM reserva");
INSERT INTO reserva VALUES(10, 0, "COM reserva");
INSERT INTO reserva VALUES(11, 9, "COM reserva");
INSERT INTO reserva VALUES(12, 0, "COM reserva");
INSERT INTO reserva VALUES(13, 5, "COM reserva");
INSERT INTO reserva VALUES(14, 4, "COM reserva");
INSERT INTO reserva VALUES(15, 6, "COM reserva");
INSERT INTO reserva VALUES(16, 8, "COM reserva");
INSERT INTO reserva VALUES(17, 0, "SEM reserva");
INSERT INTO reserva VALUES(18, 13, "COM reserva");
INSERT INTO reserva VALUES(19, 14, "COM reserva");
INSERT INTO reserva VALUES(20, 15, "COM reserva");

UPDATE reserva SET QUANTIDADE  = 1 WHERE ID_reserva = 2;
UPDATE reserva SET QUANTIDADE  = 0 WHERE ID_reserva = 4;
UPDATE reserva SET QUANTIDADE  = 11 WHERE ID_reserva = 8;
UPDATE reserva SET QUANTIDADE  = 3 WHERE ID_reserva = 12;
UPDATE reserva SET QUANTIDADE  = 5 WHERE ID_reserva = 15;

-- ------------------------------------------------------------------------------------------------



-- -------[ PROCESSAR reserva "ID CLIENTE , ID reserva] ---------------------------------------


INSERT INTO cliente_has_reserva VALUES(211,1);
INSERT INTO cliente_has_reserva VALUES(212,2);
INSERT INTO cliente_has_reserva VALUES(213,3);
INSERT INTO cliente_has_reserva VALUES(214,4);
INSERT INTO cliente_has_reserva VALUES(215,5);
INSERT INTO cliente_has_reserva VALUES(216,6);
INSERT INTO cliente_has_reserva VALUES(217,7);
INSERT INTO cliente_has_reserva VALUES(218,8);
INSERT INTO cliente_has_reserva VALUES(219,9);
INSERT INTO cliente_has_reserva VALUES(220,10);





-- -------------[PROCESSAR VENDA]----------------------------------

INSERT INTO compra VALUES (400,100, '2017-01-1');
INSERT INTO compra VALUES (401,112, '2017-01-10');
INSERT INTO compra VALUES (402,43, '2017-01-2');
INSERT INTO compra VALUES (403,102,' 2017-01-12');
INSERT INTO compra VALUES (404,900, '2017-01-7');
INSERT INTO compra VALUES (405,422, '2017-02-3');
INSERT INTO compra VALUES (406,521, '2017-02-13');
INSERT INTO compra VALUES (407,12, '2017-02-1');
INSERT INTO compra VALUES (408,43.6, '2017-02-23');
INSERT INTO compra VALUES (409,22.3, '2017-02-22');
INSERT INTO compra VALUES (410,14.2,' 2017-02-10');
INSERT INTO compra VALUES (411,89.5, '2017-03-25');
INSERT INTO compra VALUES (412,25, '2017-03-29');
INSERT INTO compra VALUES (413,20, '2017-03-28');
INSERT INTO compra VALUES (414,23.4,' 2017-03-20');
INSERT INTO compra VALUES (415,65, '2017-03-11');
INSERT INTO compra VALUES (416,31.2, '2017-06-3');
INSERT INTO compra VALUES (417,40, '2017-07-31');
INSERT INTO compra VALUES (418,45.6, '2017-08-29');


UPDATE compra SET DATA_compra  = '2016-09-1' WHERE ID_compra = 400;
UPDATE compra SET DATA_compra  = '2012-11-14' WHERE ID_compra = 403;
UPDATE compra SET DATA_compra  = '2014-08-30' WHERE ID_compra = 405;
UPDATE compra SET DATA_compra  = '2017-12-25' WHERE ID_compra = 410;
UPDATE compra SET DATA_compra  = '2013-10-11' WHERE ID_compra = 415; 
-- -----------------------------------------------------------------

-- ----------------------------------------------------

INSERT INTO desconto_prox VALUES (701,0);
INSERT INTO desconto_prox VALUES (702,0);
INSERT INTO desconto_prox VALUES (703,1);
INSERT INTO desconto_prox VALUES (704,0);
INSERT INTO desconto_prox VALUES (705,0);
INSERT INTO desconto_prox VALUES (706,0);
INSERT INTO desconto_prox VALUES (707,0);
INSERT INTO desconto_prox VALUES (708,0);
INSERT INTO desconto_prox VALUES (709,0);
INSERT INTO desconto_prox VALUES (710,1);
INSERT INTO desconto_prox VALUES (711,1);
INSERT INTO desconto_prox VALUES (712,0);
INSERT INTO desconto_prox VALUES (713,1);
INSERT INTO desconto_prox VALUES (714,0);
INSERT INTO desconto_prox VALUES (715,0);
INSERT INTO desconto_prox VALUES (716,0);



UPDATE desconto_prox SET desconto_prox  = 0 WHERE ID_DESCONTO = 701;
UPDATE desconto_prox SET desconto_prox  = 1 WHERE ID_DESCONTO = 707;
UPDATE desconto_prox SET desconto_prox  = 0 WHERE ID_DESCONTO = 710;
UPDATE desconto_prox SET desconto_prox  = 0 WHERE ID_DESCONTO = 713;
UPDATE desconto_prox SET desconto_prox  = 0 WHERE ID_DESCONTO = 711;
-- ---------------------------------------------------

-- --------------[ TOTAL compra ] ---------------------


INSERT INTO total_compra VALUES(900,300,701);
INSERT INTO total_compra VALUES(901,219,702);
INSERT INTO total_compra VALUES(902,903,703);
INSERT INTO total_compra VALUES(903,100,704);
INSERT INTO total_compra VALUES(904,90,705);
INSERT INTO total_compra VALUES(905,30,706);
INSERT INTO total_compra VALUES(906,501.34,707);
INSERT INTO total_compra VALUES(907,200,708);
INSERT INTO total_compra VALUES(908,43,709);
INSERT INTO total_compra VALUES(909,50,710);
INSERT INTO total_compra VALUES(910,122,711);
INSERT INTO total_compra VALUES(911,43,712);
INSERT INTO total_compra VALUES(912,34.2,713);
INSERT INTO total_compra VALUES(913,90.2,714);
INSERT INTO total_compra VALUES(914,32.2,715);
INSERT INTO total_compra VALUES(915,32.2,716);



UPDATE total_compra SET total_compra  = 600 WHERE ID_TOTAL = 900;
UPDATE total_compra SET total_compra  = 600 WHERE ID_TOTAL = 902;
UPDATE total_compra SET total_compra  = 160 WHERE ID_TOTAL = 906;
UPDATE total_compra SET total_compra  = 499 WHERE ID_TOTAL = 910;
UPDATE total_compra SET total_compra  = 456 WHERE ID_TOTAL = 914;




-- -----------------[ ITENS compra ] ------------------

INSERT INTO itens_compra VALUES (500,10,400,900);
INSERT INTO itens_compra VALUES (501,12,401,902);
INSERT INTO itens_compra VALUES (502,1,402,903);
INSERT INTO itens_compra VALUES (503,21,403,904);
INSERT INTO itens_compra VALUES (504,16,404,905);
INSERT INTO itens_compra VALUES (505,17,405,906);
INSERT INTO itens_compra VALUES (506,18,406,907);
INSERT INTO itens_compra VALUES (507,20,407,908);
INSERT INTO itens_compra VALUES (508,3,408,909);
INSERT INTO itens_compra VALUES (509,5,409,910);
INSERT INTO itens_compra VALUES (510,6,410,911);
INSERT INTO itens_compra VALUES (511,11,411,912);
INSERT INTO itens_compra VALUES (512,9,412,913);
INSERT INTO itens_compra VALUES (513,10,413,914);
INSERT INTO itens_compra VALUES (514,14,414,915);



-- -------------------------------------------------------


-- ------------------ ----------------- [COMEDIA] ----------------------------
INSERT INTO livro VALUES(1,"ASTRONAUTA ",101,301,500,121,600);
INSERT INTO livro VALUES(2,"PATATI PATATA EM MARROCOS",103,303,502,121,602);
INSERT INTO livro VALUES(3,"MR.BEEM EM NOVA YOURK",104,304,503,123,603);
INSERT INTO livro VALUES(4,"TIC TAC TOI",105,305,504,124,604);

-- -------------------------------------------------------
--  --------------- [SUSPENSE] ------------------------------
INSERT INTO livro VALUES(5,"A VOLTA DOS QUE NAO FORAM",105,306,505,124,605);
INSERT INTO livro VALUES(6,"O MASSACRE DA SERRA ELETRICa",106,307,506,125,606);
INSERT INTO livro VALUES(7,"FLORESTA NEGRA",107,308,507,122,607);
INSERT INTO livro VALUES(8,"A CABANHA",108,309,508,123,608);
INSERT INTO livro VALUES(9," O ALTO DA COMPADECIDA",109,310,510,124,609);

-- ----------------------------------------------------------
-- -------------------------------------------------


 -- ------------- [AVENTURA] -------------------------------------

INSERT INTO livro VALUES(10,"TARZAN 1",110,311,511,121,610);
INSERT INTO livro VALUES(11," ZORRO NEGRO",111,312,512,122,611);
INSERT INTO livro VALUES(12,"O CAPOERISTA NO DESERTO",112,313,513,121,612);
INSERT INTO livro VALUES(13,"PROGRAMANDO EM JAVA",113,314,514,123,613);
INSERT INTO livro VALUES(14,"INSPETOR BUGIGANGA",114,315,515,124,614);
-- --------------------------------------------------------------

-- -----------[ROMANCE] ----------------------------------------
INSERT INTO livro VALUES(15,"HISTORIA DE IZAQUE E REBECA",115,316,516,123,615);
INSERT INTO livro VALUES(16,"TITANIC",116,317,517,123,616);
INSERT INTO livro VALUES(17,"AS BATIDAS DO AMOR",117,318,518,122,617);
INSERT INTO livro VALUES(18, "SORTE NO AMOR",118,319,519,121,618);
INSERT INTO livro VALUES(19,"COMO SE FOSSE A PRIMEIRA VEZ",119,320,520,124,619);
-- --------------------------------------------------------------

-- -----------------------------[ACAO] -----------------------------------
INSERT INTO livro VALUES(20,"EXTERMINADOR DO FUTURO",120,321,521,121,620);
INSERT INTO livro VALUES(21,"APOCALIPSE ZUMBI",121,322,522,122,621);
INSERT INTO livro VALUES(22,"X-MEN EVOLUCTION",122,323,523,123,622);
INSERT INTO livro VALUES(23, "HARRY POTTER",123,324,524,123,623);
INSERT INTO livro VALUES(24,"DRAGON BALL Z",124,325,525,124,624);



INSERT INTO cliente_has_compra VALUES(211,400,1);
INSERT INTO cliente_has_compra VALUES(212,401,2);
INSERT INTO cliente_has_compra VALUES(213,402,3);
INSERT INTO cliente_has_compra VALUES(214,403,4);
INSERT INTO cliente_has_compra VALUES(215,404,5);
INSERT INTO cliente_has_compra VALUES(216,405,6);
INSERT INTO cliente_has_compra VALUES(217,406,7);
INSERT INTO cliente_has_compra VALUES(218,407,8);
INSERT INTO cliente_has_compra VALUES(219,408,9);
INSERT INTO cliente_has_compra VALUES(220,409,10);
INSERT INTO cliente_has_compra VALUES(221,410,11);
INSERT INTO cliente_has_compra VALUES(222,411,12);
INSERT INTO cliente_has_compra VALUES(223,412,13);
INSERT INTO cliente_has_compra VALUES(224,413,14);
INSERT INTO cliente_has_compra VALUES(225,414,15);

