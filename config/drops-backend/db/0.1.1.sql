-- MySQL Script generated by MySQL Workbench
-- Di 25 Aug 2020 14:58:20 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema drops
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema drops
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `drops` ;
USE `drops` ;

-- -----------------------------------------------------
-- Table `drops`.`vca_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`vca_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `confirmed` TINYINT NOT NULL,
  `updated` BIGINT(20) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`password_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`password_info` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `hasher` VARCHAR(45) NULL,
  `vca_user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Credentials_User_idx` (`vca_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Credentials_User`
    FOREIGN KEY (`vca_user_id`)
    REFERENCES `drops`.`vca_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`service` (
  `id` BIGINT(20) NOT NULL,
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `updated` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`model` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `service_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE,
  INDEX `fk_model_service1_idx` (`service_id` ASC) VISIBLE,
  CONSTRAINT `fk_model_service1`
    FOREIGN KEY (`service_id`)
    REFERENCES `drops`.`service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`access_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`access_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `model_id` BIGINT(20) NOT NULL,
  `vca_user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`, `model_id`),
  INDEX `fk_access_user_model1_idx` (`model_id` ASC) VISIBLE,
  INDEX `fk_access_user_vca_user1_idx` (`vca_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_access_user_model1`
    FOREIGN KEY (`model_id`)
    REFERENCES `drops`.`model` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_access_user_vca_user1`
    FOREIGN KEY (`vca_user_id`)
    REFERENCES `drops`.`vca_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`access_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`access_token` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(45) NOT NULL,
  `t_case` VARCHAR(45) NOT NULL,
  `expired` BIGINT(20) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `vca_user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_access_token_pool_user1_idx` (`vca_user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_access_token_pool_user1`
    FOREIGN KEY (`vca_user_id`)
    REFERENCES `drops`.`vca_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`profile` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `mobile` VARCHAR(64) NULL,
  `birthdate` BIGINT(20) NULL,
  `gender` ENUM('divers', 'male', 'female', 'none') NULL,
  `updated` BIGINT(20) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `vca_user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_vca_user1_idx` (`vca_user_id` ASC) VISIBLE,
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE,
  CONSTRAINT `fk_profile_vca_user1`
    FOREIGN KEY (`vca_user_id`)
    REFERENCES `drops`.`vca_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`avatar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`avatar` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `updated` BIGINT(20) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `profile_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_avatar_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_avatar_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `drops`.`profile` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drops`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drops`.`address` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `street` VARCHAR(45) NULL,
  `additional` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `google_id` VARCHAR(255) NULL,
  `updated` BIGINT(20) NOT NULL,
  `created` BIGINT(20) NOT NULL,
  `profile_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`, `profile_id`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE,
  INDEX `fk_address_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `drops`.`profile` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
