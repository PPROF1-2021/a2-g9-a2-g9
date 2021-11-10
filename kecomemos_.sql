-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema KeComemos?
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema KeComemos?
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `KeComemos?` DEFAULT CHARACTER SET utf8 ;
USE `KeComemos?` ;

-- -----------------------------------------------------
-- Table `KeComemos?`.`planes_mensuales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `KeComemos?`.`planes_mensuales` (
  `IDusuario` INT NOT NULL,
  `IDreceta` INT NOT NULL AUTO_INCREMENT,
  `fecha_comienzo` DATETIME NOT NULL,
  `Fecha_fin` DATETIME NOT NULL,
  `peso_inicial` INT NOT NULL,
  `peso_fin` INT NOT NULL,
  PRIMARY KEY (`IDusuario`),
  INDEX `IDreceta_idx` (`IDreceta` ASC),
  CONSTRAINT `IDreceta`
    FOREIGN KEY (`IDreceta`)
    REFERENCES `KeComemos?`.`planes_diarios` (`IDreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KeComemos?`.`Recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `KeComemos?`.`Recetas` (
  `IDplanes_diarios` INT NOT NULL,
  `IDplanes_mensuales` INT NOT NULL,
  `IDusuario` INT NOT NULL,
  `Desayuno` VARCHAR(50) NOT NULL,
  `Merienda` VARCHAR(50) NOT NULL,
  `Almuerzo` VARCHAR(50) NOT NULL,
  `Cena` VARCHAR(50) NOT NULL,
  `IDreceta` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IDusuario`),
  CONSTRAINT `IDusuario`
    FOREIGN KEY (`IDusuario`)
    REFERENCES `KeComemos?`.`usuarios` (`IDusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KeComemos?`.`planes_diarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `KeComemos?`.`planes_diarios` (
  `IDusuario` INT NOT NULL,
  `IDreceta` INT NOT NULL AUTO_INCREMENT,
  `Fecha_comienzo` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `peso_inicial` INT NOT NULL,
  `peso_final` INT NOT NULL,
  PRIMARY KEY (`IDusuario`),
  CONSTRAINT `IDreceta`
    FOREIGN KEY (`IDreceta`)
    REFERENCES `KeComemos?`.`planes_mensuales` (`IDusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDusuario`
    FOREIGN KEY (`IDusuario`)
    REFERENCES `KeComemos?`.`Recetas` (`IDusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KeComemos?`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `KeComemos?`.`usuarios` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `DNI` INT NOT NULL,
  `Altura` INT NOT NULL,
  `Peso` INT NOT NULL,
  `Edad` INT NOT NULL,
  `Sexo` VARCHAR(25) NOT NULL,
  `IDusuario` INT NOT NULL AUTO_INCREMENT,
  `IDplanes_diarios` INT NOT NULL,
  `IDplanes_mensuales` INT NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDusuario`),
  UNIQUE INDEX `IDplanes_diarios_UNIQUE` (`IDplanes_diarios` ASC),
  UNIQUE INDEX `IDplanes_mensuales_UNIQUE` (`IDplanes_mensuales` ASC),
  INDEX `IDplanes_diarios_idx` (`IDplanes_diarios` ASC, `IDplanes_mensuales` ASC),
  CONSTRAINT `IDusuario`
    FOREIGN KEY (`IDusuario`)
    REFERENCES `KeComemos?`.`planes_diarios` (`IDusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDplanes_diarios`
    FOREIGN KEY (`IDplanes_diarios` , `IDplanes_mensuales`)
    REFERENCES `KeComemos?`.`planes_diarios` (`IDreceta` , `IDreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDplanes_mensuales`
    FOREIGN KEY (`IDplanes_diarios` , `IDplanes_mensuales`)
    REFERENCES `KeComemos?`.`planes_diarios` (`IDreceta` , `IDreceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
