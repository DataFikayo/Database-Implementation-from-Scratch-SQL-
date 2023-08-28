-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FastPark
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FastPark
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FastPark` DEFAULT CHARACTER SET utf8 ;
USE `FastPark` ;

-- -----------------------------------------------------
-- Table `FastPark`.`customer_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`customer_service` (
  `customer_service_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_service_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 101;


-- -----------------------------------------------------
-- Table `FastPark`.`space_owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`space_owner` (
  `owner_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `no_of_space_owned` INT NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `managed_by` INT NOT NULL,
  PRIMARY KEY (`owner_id`),
  UNIQUE INDEX `Owner_ID_UNIQUE` (`owner_id` ASC) VISIBLE,
  INDEX `fk_Parking Space Owner_Customer_Service1_idx` (`managed_by` ASC) VISIBLE,
  CONSTRAINT `Managed_By`
    FOREIGN KEY (`managed_by`)
    REFERENCES `FastPark`.`customer_service` (`customer_service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`parking_space`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`parking_space` (
  `parking_space_id` INT NOT NULL,
  `parking_fee` INT NOT NULL,
  `access_code` VARCHAR(10) NULL,
  `owner_id` INT NOT NULL,
  `charging` ENUM("True", "False") NULL,
  PRIMARY KEY (`parking_space_id`),
  INDEX `owner_ID_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `owner_ID`
    FOREIGN KEY (`owner_id`)
    REFERENCES `FastPark`.`space_owner` (`owner_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`parking_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`parking_address` (
  `parking_space_id` INT NOT NULL,
  `house_number` VARCHAR(45) NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `post_code` VARCHAR(45) NOT NULL,
  INDEX `parking_space_idx` (`parking_space_id` ASC) VISIBLE,
  PRIMARY KEY (`parking_space_id`),
  CONSTRAINT `parking_space`
    FOREIGN KEY (`parking_space_id`)
    REFERENCES `FastPark`.`parking_space` (`parking_space_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`driver` (
  `driver_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `driver_license` VARCHAR(45) NOT NULL,
  `customer_service_id` INT NOT NULL,
  PRIMARY KEY (`driver_id`, `customer_service_id`),
  INDEX `fk_Driver_Customer_Service1_idx` (`customer_service_id` ASC) VISIBLE,
  CONSTRAINT `fk_Driver_Customer_Service1`
    FOREIGN KEY (`customer_service_id`)
    REFERENCES `FastPark`.`customer_service` (`customer_service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`vehicle_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`vehicle_type` (
  `vehicle_type_id` INT NOT NULL,
  `vehicle_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vehicle_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`reservation` (
  `reservation_id` INT NOT NULL,
  `parking_space_id` INT NOT NULL,
  `Vehicle_Type_id` INT NOT NULL,
  `driver_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `hours_used` DECIMAL(4,2) NOT NULL,
  `time_in` TIME NOT NULL,
  `time_out` TIME NOT NULL,
  PRIMARY KEY (`reservation_id`),
  INDEX `ParkingSpace_ID_idx` (`parking_space_id` ASC) VISIBLE,
  INDEX `driver_id_idx` (`driver_id` ASC) VISIBLE,
  INDEX `vehicle_id_idx` (`Vehicle_Type_id` ASC) VISIBLE,
  CONSTRAINT `ParkingSpace_ID`
    FOREIGN KEY (`parking_space_id`)
    REFERENCES `FastPark`.`parking_space` (`parking_space_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `driver_id`
    FOREIGN KEY (`driver_id`)
    REFERENCES `FastPark`.`driver` (`driver_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `vehicle_id`
    FOREIGN KEY (`Vehicle_Type_id`)
    REFERENCES `FastPark`.`vehicle_type` (`vehicle_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `reservation_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payment_Reservation_ID1_idx` (`reservation_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Reservation_ID1`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `FastPark`.`reservation` (`reservation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FastPark`.`refund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FastPark`.`refund` (
  `refund_id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  PRIMARY KEY (`refund_id`),
  INDEX `fk_Refund_Payment1_idx` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Refund_Payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `FastPark`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
