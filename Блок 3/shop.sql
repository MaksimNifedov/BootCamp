SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shop` DEFAULT CHARACTER SET utf8 ;
USE `shop` ;

-- -----------------------------------------------------
-- Table `shop`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`section` (
  `id_section` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_section`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`images` (
  `id_image` INT NOT NULL AUTO_INCREMENT,
  `alt` VARCHAR(150) NOT NULL,
  `link_image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_image`),
  UNIQUE INDEX `link_image` (`link_image` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `id_main_section` INT NOT NULL,
  `id_main_image` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `price_without_sale` DECIMAL(10,2) NOT NULL,
  `price_with_promocode` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(350) NOT NULL,
  `product_activity` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `prodict_main_section` (`id_main_section` ASC) VISIBLE,
  INDEX `product_main_image` (`id_main_image` ASC) INVISIBLE,
  CONSTRAINT `product_main_section`
    FOREIGN KEY (`id_main_section`)
    REFERENCES `shop`.`section` (`id_section`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_main_image`
    FOREIGN KEY (`id_main_image`)
    REFERENCES `shop`.`images` (`id_image`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`section_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`section_product` (
  `product_id_product` INT NOT NULL,
  `section_id_section` INT NOT NULL,
  PRIMARY KEY (`product_id_product`, `section_id_section`),
  INDEX `section_product_id_product` (`product_id_product` ASC) VISIBLE,
  INDEX `section_product_id_section` (`section_id_section` ASC) VISIBLE,
  CONSTRAINT `section_id_section`
    FOREIGN KEY (`section_id_section`)
    REFERENCES `shop`.`section` (`id_section`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id_product`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `shop`.`product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shop`.`product_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`product_image` (
  `id_prodict` INT NOT NULL,
  `id_image` INT NOT NULL,
  PRIMARY KEY (`id_prodict`, `id_image`),
  INDEX `id_product_for_image` (`id_prodict` ASC) VISIBLE,
  INDEX `image_product` (`id_image` ASC) INVISIBLE,
  CONSTRAINT `id_image`
    FOREIGN KEY (`id_image`)
    REFERENCES `shop`.`images` (`id_image`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_product`
    FOREIGN KEY (`id_prodict`)
    REFERENCES `shop`.`product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
