-- password, name, phone, address 컬럼에 NOT NULL 제약 조건 추가
ALTER TABLE `ymember` MODIFY COLUMN `password` varchar(100) NOT NULL;
ALTER TABLE `ymember` MODIFY COLUMN `name` varchar(20) NOT NULL;
ALTER TABLE `ymember` MODIFY COLUMN `phone` varchar(15) NOT NULL;
ALTER TABLE `ymember` MODIFY COLUMN `address` text NOT NULL;

-- created_at 컬럼의 기본값 변경
ALTER TABLE `ymember` MODIFY COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- role 컬럼 추가
ALTER TABLE `ymember` ADD COLUMN `role` varchar(10) NOT NULL DEFAULT 'USER';
