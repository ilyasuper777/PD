-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PD` DEFAULT CHARACTER SET utf8 ;
USE `PD` ;

-- -----------------------------------------------------
-- Table `PD`.`employment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`employment` (
  `id` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`employee` (
  `id` INT NOT NULL,
  `firstName` VARCHAR(30) NOT NULL,
  `lastName` VARCHAR(30) NOT NULL,
  `patronymic` VARCHAR(30) NOT NULL,
  `login` VARCHAR(30) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `id_employment` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_employment_idx` (`id_employment` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employment`
    FOREIGN KEY (`id_employment`)
    REFERENCES `PD`.`employment` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`news`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`news` (
  `id` INT NOT NULL,
  `content` TEXT NULL,
  `publish_date` DATE NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_news_employee1_idx` (`author_id` ASC) INVISIBLE,
  CONSTRAINT `fk_news_employee1`
    FOREIGN KEY (`author_id`)
    REFERENCES `PD`.`employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`service` (
  `id` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`status_of_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`status_of_request` (
  `id` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`form_education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`form_education` (
  `id` INT NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `years_of_education` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`type_of_dormitorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`type_of_dormitorie` (
  `id` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`dormitorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`dormitorie` (
  `id` INT NOT NULL,
  `number` INT(2) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `id_type_of_dormotories` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dormitorie_type_of_dormitorie1_idx` (`id_type_of_dormotories` ASC) VISIBLE,
  CONSTRAINT `fk_dormitorie_type_of_dormitorie1`
    FOREIGN KEY (`id_type_of_dormotories`)
    REFERENCES `PD`.`type_of_dormitorie` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`type_of_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`type_of_room` (
  `id` INT NOT NULL,
  `title` VARCHAR(30) NOT NULL,
  `description` TEXT NULL,
  `cost_per_month` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`room` (
  `id` INT NOT NULL,
  `room_number` VARCHAR(50) NOT NULL,
  `id_type_of_room` INT NOT NULL,
  `id_dormitorie` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_room_type_of_room1_idx` (`id_type_of_room` ASC) VISIBLE,
  INDEX `fk_room_dormitorie1_idx` (`id_dormitorie` ASC) VISIBLE,
  CONSTRAINT `fk_room_type_of_room1`
    FOREIGN KEY (`id_type_of_room`)
    REFERENCES `PD`.`type_of_room` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_dormitorie1`
    FOREIGN KEY (`id_dormitorie`)
    REFERENCES `PD`.`dormitorie` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`student` (
  `id` INT NOT NULL,
  `firstName` VARCHAR(50) NULL,
  `lastname` VARCHAR(50) NULL,
  `patronymic` VARCHAR(50) NULL,
  `phone_number` VARCHAR(12) NULL,
  `email` VARCHAR(50) NULL,
  `course_of_study` INT(2) NULL,
  `login` VARCHAR(30) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `check_in_date` DATE NULL,
  `check_out_date` DATE NULL,
  `id_room` INT NOT NULL,
  `id_forms_education` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_student_room1_idx` (`id_room` ASC) VISIBLE,
  INDEX `fk_student_ form_education1_idx` (`id_forms_education` ASC) VISIBLE,
  CONSTRAINT `fk_student_room1`
    FOREIGN KEY (`id_room`)
    REFERENCES `PD`.`room` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_ form_education1`
    FOREIGN KEY (`id_forms_education`)
    REFERENCES `PD`.`form_education` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PD`.`request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PD`.`request` (
  `id` INT NOT NULL,
  `date` DATE NULL,
  `id_student` INT NOT NULL,
  `id_status` INT NOT NULL,
  `id_service` INT NOT NULL,
  `id_employee` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_request_student1_idx` (`id_student` ASC) VISIBLE,
  INDEX `fk_request_status_of_request1_idx` (`id_status` ASC) VISIBLE,
  INDEX `fk_request_service1_idx` (`id_service` ASC) VISIBLE,
  INDEX `fk_request_employee1_idx` (`id_employee` ASC) VISIBLE,
  CONSTRAINT `fk_request_student1`
    FOREIGN KEY (`id_student`)
    REFERENCES `PD`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_request_status_of_request1`
    FOREIGN KEY (`id_status`)
    REFERENCES `PD`.`status_of_request` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_request_service1`
    FOREIGN KEY (`id_service`)
    REFERENCES `PD`.`service` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_request_employee1`
    FOREIGN KEY (`id_employee`)
    REFERENCES `PD`.`employee` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
