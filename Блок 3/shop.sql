SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shop` DEFAULT CHARACTER SET utf8 ;
USE `shop` ;

-- -----------------------------------------------------
-- Table `shop`.`Раздел`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Раздел` (
  `ID Раздела` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(80) NOT NULL,
  `Описание` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`ID Раздела`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Изображения`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Изображения` (
  `ID Изображения` INT NOT NULL AUTO_INCREMENT,
  `ALT` VARCHAR(150) NOT NULL,
  `Адрес изображения` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID Изображения`),
  UNIQUE INDEX `Адрес изображения_UNIQUE` (`Адрес изображения` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Товар`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Товар` (
  `ID товара` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(60) NOT NULL,
  `ID главного раздела` INT NOT NULL,
  `ID главного  изображения` INT NOT NULL,
  `Цена` DECIMAL(10,2) NOT NULL,
  `Цена без скидки` DECIMAL(10,2) NOT NULL,
  `Цена по промокоду` DECIMAL(10,2) NOT NULL,
  `Описание` VARCHAR(350) NOT NULL,
  `Активность товара` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID товара`),
  INDEX `Товар_Раздел` (`ID главного раздела` ASC) VISIBLE,
  INDEX `Товар_Главное_Изображение` (`ID главного  изображения` ASC) INVISIBLE,
  CONSTRAINT `Товар_раздел`
    FOREIGN KEY (`ID главного раздела`)
    REFERENCES `shop`.`Раздел` (`ID Раздела`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Товар_Главное_Изображение`
    FOREIGN KEY (`ID главного  изображения`)
    REFERENCES `shop`.`Изображения` (`ID Изображения`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Раздел_Товар`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Раздел_Товар` (
  `Товар_ID товара` INT NOT NULL,
  `Раздел_ID Раздела` INT NOT NULL,
  PRIMARY KEY (`Товар_ID товара`, `Раздел_ID Раздела`),
  INDEX `Раздел_Товар_ID_Товара` (`Товар_ID товара` ASC) VISIBLE,
  INDEX `Раздел_Товар_ID_раздела` (`Раздел_ID Раздела` ASC) VISIBLE,
  CONSTRAINT `Раздел_ID_раздела`
    FOREIGN KEY (`Раздел_ID Раздела`)
    REFERENCES `shop`.`Раздел` (`ID Раздела`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Товар_ID_товара`
    FOREIGN KEY (`Товар_ID товара`)
    REFERENCES `shop`.`Товар` (`ID товара`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Товар_изображение`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Товар_изображение` (
  `ID_товара` INT NOT NULL,
  `ID_Изображения товара` INT NOT NULL,
  PRIMARY KEY (`ID_товара`, `ID_Изображения товара`),
  INDEX `ID_Товара_для_Изображения` (`ID_товара` ASC) VISIBLE,
  INDEX `Изображение_товара` (`ID_Изображения товара` ASC) VISIBLE,
  CONSTRAINT `Изображение_ID`
    FOREIGN KEY (`ID_Изображения товара`)
    REFERENCES `shop`.`Изображения` (`ID Изображения`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Товар_ID`
    FOREIGN KEY (`ID_товара`)
    REFERENCES `shop`.`Товар` (`ID товара`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
