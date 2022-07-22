SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shop` DEFAULT CHARACTER SET utf8 ;
USE `shop` ;

-- -----------------------------------------------------
-- Table `shop`.`Section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Section` (
  `ID_Section` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(80) NOT NULL,
  `Description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`ID_Section`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Images` (
  `ID_Image` INT NOT NULL AUTO_INCREMENT,
  `ALT` VARCHAR(150) NOT NULL,
  `Link_Image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID_Image`),
  UNIQUE INDEX `Link_Image` (`Link_Image` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Product` (
  `ID_Product` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(60) NOT NULL,
  `ID_Main_Section` INT NOT NULL,
  `ID_Main_Image` INT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  `Price_Without_Sale` DECIMAL(10,2) NOT NULL,
  `Price_With_Promocode` DECIMAL(10,2) NOT NULL,
  `Description` VARCHAR(350) NOT NULL,
  `Product_activity` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID_Product`),
  INDEX `Prodict_Main_Section` (`ID_Main_Section` ASC) VISIBLE,
  INDEX `Product_Main_Image` (`ID_Main_Image` ASC) INVISIBLE,
  CONSTRAINT `Product_Main_Section`
    FOREIGN KEY (`ID_Main_Section`)
    REFERENCES `shop`.`Section` (`ID_Section`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Product_Main_Image`
    FOREIGN KEY (`ID_Main_Image`)
    REFERENCES `shop`.`Images` (`ID_Image`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Section_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Section_Product` (
  `Product_ID_Product` INT NOT NULL,
  `Section_ID_Section` INT NOT NULL,
  PRIMARY KEY (`Product_ID_Product`, `Section_ID_Section`),
  INDEX `Section_Product_ID_Product` (`Product_ID_Product` ASC) VISIBLE,
  INDEX `Section_Product_ID_Section` (`Section_ID_Section` ASC) VISIBLE,
  CONSTRAINT `Section_ID_Section`
    FOREIGN KEY (`Section_ID_Section`)
    REFERENCES `shop`.`Section` (`ID_Section`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Product_ID_Product`
    FOREIGN KEY (`Product_ID_Product`)
    REFERENCES `shop`.`Product` (`ID_Product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`Product_Image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`Product_Image` (
  `ID_Prodict` INT NOT NULL,
  `ID_Image` INT NOT NULL,
  PRIMARY KEY (`ID_Prodict`, `ID_Image`),
  INDEX `ID_Product_for_Image` (`ID_Prodict` ASC) VISIBLE,
  INDEX `Image_Product` (`ID_Image` ASC) VISIBLE,
  CONSTRAINT `ID_Image`
    FOREIGN KEY (`ID_Image`)
    REFERENCES `shop`.`Images` (`ID_Image`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ID_Product`
    FOREIGN KEY (`ID_Prodict`)
    REFERENCES `shop`.`Product` (`ID_Product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
