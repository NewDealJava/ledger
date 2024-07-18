-- uuid 컬럼 추가
ALTER TABLE `ymember` ADD COLUMN `uuid` varchar(20) UNIQUE NOT NULL;