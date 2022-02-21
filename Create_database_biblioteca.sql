DROP DATABASE BIBLIOTECA;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BIBLIOTECA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BIBLIOTECA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BIBLIOTECA` DEFAULT CHARACTER SET utf8 ;

USE `BIBLIOTECA`;

-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Autor` (
  `ID_Autor` INT NOT NULL,
  `Nome_Autor` VARCHAR(40) NULL,
  PRIMARY KEY (`ID_Autor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Editora` (
  `ID_Editora` INT NOT NULL,
  `Nome_Editora` VARCHAR(40) NULL,
  `Logradouro` VARCHAR(40) NULL,
  `Cidade` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Editora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Obra` (
  `ID_Obra` INT NOT NULL,
  `ID_Editora` INT NOT NULL,
  `ID_Autor` INT NOT NULL,
  `Titulo_Obra` VARCHAR(40) NULL,
  `Numero_Publicacao` INT NULL,
  `Genero` VARCHAR(20) NULL,
  `Data_Publicacao` DATE NULL,
  PRIMARY KEY (`ID_Obra`),
  INDEX `fk_Obra_Autor_idx` (`ID_Autor` ASC),
  INDEX `fk_Obra_Editora1_idx` (`ID_Editora` ASC),
  CONSTRAINT `fk_Obra_Autor`
    FOREIGN KEY (`ID_Autor`)
    REFERENCES `BIBLIOTECA`.`Autor` (`ID_Autor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Obra_Editora1`
    FOREIGN KEY (`ID_Editora`)
    REFERENCES `BIBLIOTECA`.`Editora` (`ID_Editora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Estoque` (
  `ID_Estoque` INT NOT NULL,
  `ID_Obra` INT NOT NULL,
  `Quantidade_Livro` INT NULL,
  `Valor_Unitario` INT NULL,
  PRIMARY KEY (`ID_Estoque`, `ID_Obra`),
  INDEX `fk_Estoque_Obra1_idx` (`ID_Obra` ASC),
  CONSTRAINT `fk_Estoque_Obra1`
    FOREIGN KEY (`ID_Obra`)
    REFERENCES `BIBLIOTECA`.`Obra` (`ID_Obra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Usuario` (
  `ID_Usuario` INT NOT NULL,
  `Nome_Usuario` VARCHAR(40) NULL,
  `Logradouro` VARCHAR(40) NULL,
  `Bairro` VARCHAR(20) NULL,
  `Telefone` DECIMAL(9) NULL,
  `CEP` DECIMAL(8) NULL,
  `CPF` DECIMAL(14) NULL,
  PRIMARY KEY (`ID_Usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Cargo` (
  `ID_Cargo` INT NOT NULL,
  `Nome_Cargo` VARCHAR(20) NULL,
  `Salario` INT NULL,
  PRIMARY KEY (`ID_Cargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Departamento` (
  `ID_Departamento` INT NOT NULL,
  `ID_Cargo` INT NOT NULL,
  `Nome_Departamento` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Departamento`, `ID_Cargo`),
  INDEX `fk_Departamento_Cargo1_idx` (`ID_Cargo` ASC),
  CONSTRAINT `fk_Departamento_Cargo1`
    FOREIGN KEY (`ID_Cargo`)
    REFERENCES `BIBLIOTECA`.`Cargo` (`ID_Cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Funcionario` (
  `ID_Funcionario` INT NOT NULL,
  `ID_Cargo` INT NOT NULL,
  `ID_Departamento` INT NOT NULL,
  `Nome_Funcionario` VARCHAR(40) NULL,
  `Data_Admissao` DATE NULL,
  `Data_Demissao` DATE NULL,
  PRIMARY KEY (`ID_Funcionario`),
  INDEX `fk_Funcionario_Departamento1_idx` (`ID_Departamento` ASC, `ID_Cargo` ASC),
  CONSTRAINT `fk_Funcionario_Departamento1`
    FOREIGN KEY (`ID_Departamento` , `ID_Cargo`)
    REFERENCES `BIBLIOTECA`.`Departamento` (`ID_Departamento` , `ID_Cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Emprestimo` (
  `ID_Emprestimo` INT NOT NULL,
  `Data_Emprestimo` DATE NULL,
  `Hora_Emprestimo` TIME NULL,
  `Data_Entrega` DATE NULL,
  `ID_Obra` INT NOT NULL,
  `ID_Estoque` INT NOT NULL,
  `ID_Usuario` INT NOT NULL,
  `ID_Funcionario` INT NOT NULL,
  PRIMARY KEY (`ID_Emprestimo`, `ID_Obra`, `ID_Estoque`, `ID_Usuario`, `ID_Funcionario`),
  INDEX  (`ID_Obra`),
  INDEX (`ID_Estoque` ),
  INDEX (`ID_Usuario` ),
  INDEX (`ID_Funcionario`),
 
	FOREIGN KEY (`ID_Obra`)
    REFERENCES `BIBLIOTECA`.`Obra` (`ID_Obra`),
 
    FOREIGN KEY (`ID_Estoque`)
    REFERENCES `BIBLIOTECA`.`Estoque` (`ID_Estoque`),

    FOREIGN KEY (`ID_Usuario`)
    REFERENCES `BIBLIOTECA`.`Usuario` (`ID_Usuario`),

    FOREIGN KEY (`ID_Funcionario`)
    REFERENCES `BIBLIOTECA`.`Funcionario` (`ID_Funcionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIBLIOTECA`.`Devolucao`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Devolucao` (
  `ID_Devolucao` INT NOT NULL,
  `Data_Devolucao` DATE NULL,
  `Hora_Devolucao` TIME NULL,
  `Multa_Atraso` VARCHAR(2) NULL,
  `ID_Estoque` INT NOT NULL,
  `ID_Usuario` INT NOT NULL,
  `ID_Obra` INT NOT NULL,
  `ID_Emprestimo` INT NOT NULL,
  `ID_Funcionario` INT NOT NULL,
  PRIMARY KEY (`ID_Devolucao`, `ID_Estoque`, `ID_Obra`, `ID_Emprestimo`, `ID_Funcionario`, `ID_Usuario`),
  INDEX (`ID_Estoque`, `ID_Obra`),
  INDEX (`ID_Funcionario`),
  INDEX (`ID_Emprestimo`, `ID_Estoque`, `ID_Obra`, `ID_Funcionario`, `ID_Usuario`),
  
	
    FOREIGN KEY (`ID_Estoque` , `ID_Obra`)
    REFERENCES `BIBLIOTECA`.`Estoque` (`ID_Estoque` , `ID_Obra`),
    
    FOREIGN KEY (`ID_Emprestimo`)
    REFERENCES `BIBLIOTECA`.`Emprestimo` (`ID_Emprestimo`),
         
    FOREIGN KEY (`ID_Funcionario`)
    REFERENCES `BIBLIOTECA`.`Funcionario` (`ID_Funcionario`)
   
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `BIBLIOTECA`.`Reserva` (
  `ID_Reserva` INT NOT NULL,
  `Status_Livro` VARCHAR(20) NULL,
  `Data_Reserva` DATE NULL,
  `Hora_Reserva` TIME NULL,
  `ID_Emprestimo` INT NOT NULL,
  `ID_Obra` INT NOT NULL,
  `ID_Estoque` INT NOT NULL,
  `ID_Usuario` INT NOT NULL,
  `ID_Funcionario` INT NOT NULL,
  PRIMARY KEY (`ID_Reserva`, `ID_Emprestimo`, `ID_Obra`, `ID_Estoque`, `ID_Usuario`, `ID_Funcionario`),
  INDEX (`ID_Emprestimo`, `ID_Obra`, `ID_Estoque`, `ID_Usuario`, `ID_Funcionario`),
    FOREIGN KEY (`ID_Emprestimo` , `ID_Obra` , `ID_Estoque` , `ID_Usuario` , `ID_Funcionario`)
    REFERENCES `BIBLIOTECA`.`Emprestimo` (`ID_Emprestimo` , `ID_Obra` , `ID_Estoque` , `ID_Usuario` , `ID_Funcionario`)
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
