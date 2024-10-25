CREATE TABLE `Cars`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `model` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `km` FLOAT(53) NOT NULL,
    `year` BIGINT NOT NULL,
    `price` FLOAT(53) NOT NULL,
    `combustible` VARCHAR(255) NOT NULL,
    `gearbox` VARCHAR(255) NOT NULL,
    `body_type` VARCHAR(255) NOT NULL,
    `cylinder_capacity` BIGINT NOT NULL,
    `power` BIGINT NOT NULL,
    `dateof_post` DATE NOT NULL,
    `id_post` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `img_url` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `Cars` ADD UNIQUE `cars_user_id_unique`(`user_id`);
CREATE TABLE `SoldCars`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `card_id` BIGINT NOT NULL,
    `sold_date` DATE NOT NULL,
    `sold_price` FLOAT(53) NOT NULL
);
ALTER TABLE
    `SoldCars` ADD UNIQUE `soldcars_card_id_unique`(`card_id`);
CREATE TABLE `OwnCars`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `car_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `purchase_date` DATE NOT NULL,
    `purchase_price` FLOAT(53) NOT NULL
);
ALTER TABLE
    `OwnCars` ADD UNIQUE `owncars_car_id_unique`(`car_id`);
ALTER TABLE
    `OwnCars` ADD UNIQUE `owncars_user_id_unique`(`user_id`);
CREATE TABLE `AppLogs`(
    `id` INT NOT NULL,
    `date` DATE NOT NULL,
    `user_id` BIGINT NOT NULL,
    PRIMARY KEY(`id`)
);
ALTER TABLE
    `AppLogs` ADD UNIQUE `applogs_user_id_unique`(`user_id`);
CREATE TABLE `Favourites`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `car_id` BIGINT NOT NULL,
    `user_id` BIGINT NULL
);
ALTER TABLE
    `Favourites` ADD INDEX `favourites_car_id_user_id_index`(`car_id`, `user_id`);
ALTER TABLE
    `Favourites` ADD UNIQUE `favourites_car_id_unique`(`car_id`);
ALTER TABLE
    `Favourites` ADD UNIQUE `favourites_user_id_unique`(`user_id`);
CREATE TABLE `AppDevices`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `registered` DATE NOT NULL,
    `used` BIGINT NOT NULL,
    `lastUsage` DATE NOT NULL
);
CREATE TABLE `User`(
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `id` BIGINT NOT NULL,
    `is_dealer` BOOLEAN NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` BIGINT NOT NULL,
    `profile_url` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);
ALTER TABLE
    `Favourites` ADD CONSTRAINT `favourites_car_id_foreign` FOREIGN KEY(`car_id`) REFERENCES `Cars`(`id`);
ALTER TABLE
    `Favourites` ADD CONSTRAINT `favourites_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`id`);
ALTER TABLE
    `OwnCars` ADD CONSTRAINT `owncars_car_id_foreign` FOREIGN KEY(`car_id`) REFERENCES `Cars`(`id`);
ALTER TABLE
    `OwnCars` ADD CONSTRAINT `owncars_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`id`);
ALTER TABLE
    `Cars` ADD CONSTRAINT `cars_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `User`(`id`);
ALTER TABLE
    `SoldCars` ADD CONSTRAINT `soldcars_card_id_foreign` FOREIGN KEY(`card_id`) REFERENCES `Cars`(`id`);
ALTER TABLE
    `AppDevices` ADD CONSTRAINT `appdevices_id_foreign` FOREIGN KEY(`id`) REFERENCES `User`(`id`);