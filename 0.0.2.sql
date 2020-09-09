-- MySQL Workbench Synchronization
-- Generated: 2020-07-13 15:37
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Unknown

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `auth`.`pool_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `confirmed` TINYINT(4) NULL DEFAULT NULL,
  `updated` INT(11) NULL DEFAULT NULL,
  `created` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uuid_UNIQUE` (`uuid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `auth`.`role` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `service_name` VARCHAR(45) NULL DEFAULT NULL,
  `created` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `auth`.`credentials` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `hasher` VARCHAR(45) NULL DEFAULT NULL,
  `pool_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Credentials_User_idx` (`pool_user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Credentials_User`
    FOREIGN KEY (`pool_user_id`)
    REFERENCES `auth`.`pool_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `auth`.`access_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `created` BIGINT(20) NULL DEFAULT NULL,
  `pool_user_id` INT(11) NOT NULL,
  `role_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_AccessUser_User1_idx` (`pool_user_id` ASC) VISIBLE,
  INDEX `fk_AccessUser_Role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_AccessUser_User1`
    FOREIGN KEY (`pool_user_id`)
    REFERENCES `auth`.`pool_user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AccessUser_Role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `auth`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `auth`.`model` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `access_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Model_AccessUser1_idx` (`access_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Model_AccessUser1`
    FOREIGN KEY (`access_user_id`)
    REFERENCES `auth`.`access_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `auth`.`access_token` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(45) NULL DEFAULT NULL,
  `expired` BIGINT(20) NULL DEFAULT NULL,
  `created` BIGINT(20) NULL DEFAULT NULL,
  `pool_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_access_token_pool_user1_idx` (`pool_user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_access_token_pool_user1`
    FOREIGN KEY (`pool_user_id`)
    REFERENCES `auth`.`pool_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
