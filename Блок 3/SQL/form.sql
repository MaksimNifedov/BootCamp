SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema feedback_form
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `feedback_form` DEFAULT CHARACTER SET utf8 ;
USE `feedback_form` ;

-- -----------------------------------------------------
-- Table `feedback_form`.`feedback_form`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `feedback_form`.`feedback_form` (
  `id_question` INT NOT NULL AUTO_INCREMENT,
  `name_user` VARCHAR(45) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `birthday` DATE NOT NULL,
  `topic` VARCHAR(45) NOT NULL,
  `question` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id_question`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
