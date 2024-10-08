CREATE DATABASE IF NOT EXISTS `GP2425`;

USE `GP2425`;

-- ----------------------- user_auth ----------------------------------- 

CREATE TABLE IF NOT EXISTS `user_auth` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `role` VARCHAR(50) NOT NULL
);


TRUNCATE TABLE `user_auth`;

INSERT INTO `user_auth` (`email`, `password`, `role`) VALUES
('lecturer-1@usth.edu.vn', '123456789', 'Lecturer'),
('lecturer-2@usth.edu.vn', '123456789', 'Lecturer'),
('student.xxBx1xxxx@usth.edu.vn', '123456789', 'Student')
ON DUPLICATE KEY UPDATE
 `password` = VALUES(`password`),
 `role` = VALUES(`role`);
 
ALTER TABLE `user_auth`
DROP COLUMN `nameoflecturer`; 
 
ALTER TABLE `user_auth`
ADD COLUMN `nameoflecturer` VARCHAR(50);

SET SQL_SAFE_UPDATES = 0;

UPDATE `user_auth`
SET `nameoflecturer` = SUBSTRING_INDEX(`email`, '@', 1)
WHERE role = 'Lecturer';

-- ---------------------------- classroom ------------------------------------ 

CREATE TABLE IF NOT EXISTS `classroom` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `nameofclass` VARCHAR(100) NOT NULL,
    `major` VARCHAR(10) NOT NULL,
    `begindate` DATE NOT NULL,
    `enddate` DATE NOT NULL,
    `nameoflecturer` VARCHAR(100) NOT NULL
);

-- --------------------------- student_information -----------------------------

CREATE TABLE IF NOT EXISTS `student_information` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `student_name` VARCHAR(100) NOT NULL,
    `student_id` VARCHAR(50) NOT NULL UNIQUE,
    `major` VARCHAR(10) NOT NULL,
    `face_id` VARCHAR(255) NOT NULL,
    `classroom_id` INT,
    FOREIGN KEY (`classroom_id`) REFERENCES `classroom`(`id`)
); 