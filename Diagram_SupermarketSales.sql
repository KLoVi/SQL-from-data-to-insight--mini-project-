-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sales_supermarket
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sales_supermarket
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sales_supermarket` DEFAULT CHARACTER SET utf8mb3 ;
USE `sales_supermarket` ;

-- -----------------------------------------------------
-- Table `sales_supermarket`.`supermarket_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sales_supermarket`.`supermarket_sales` (
  `invoice_id` INT NOT NULL,
  `branch` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `product_line` VARCHAR(45) NOT NULL,
  `unit_price` FLOAT NOT NULL,
  `quantity` INT NOT NULL,
  `total` FLOAT NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  `customer_type` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `rating` FLOAT NOT NULL,
  PRIMARY KEY (`invoice_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
