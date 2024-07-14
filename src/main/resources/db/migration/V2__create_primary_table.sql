DROP TABLE IF EXISTS `account`;
DROP TABLE IF EXISTS `card`;
DROP TABLE IF EXISTS `transactiontag`;
DROP TABLE IF EXISTS `tag`;
DROP TABLE IF EXISTS `transaction`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `ymember`;


CREATE TABLE `ymember`
(
    `email`         varchar(50) NOT NULL PRIMARY KEY,
    `password`      varchar(100) NULL,
    `name`          varchar(20) NULL,
    `phone`         varchar(15) NULL,
    `address`       text NULL,
    `profile_image` text NULL,
    `created_at`    date NULL
);


CREATE TABLE `account`
(
    `ano`      int AUTO_INCREMENT PRIMARY KEY,
    `email`    varchar(50)  NOT NULL,
    `name`     varchar(100) NOT NULL,
    `cname`    varchar(100) NULL,
    `type`     varchar(50)  NOT NULL DEFAULT 'MONEY' COMMENT 'TYPE: MONEY or ACCOUNT',
    `imgUrl`   text NULL,
    `memo`     text NULL,
    `amount`   bigint       NOT NULL,
    `isExcept` boolean      NOT NULL DEFAULT false,
    FOREIGN KEY (`email`) REFERENCES `ymember` (`email`)
);



CREATE TABLE `category`
(
    `cno`        int AUTO_INCREMENT PRIMARY KEY,
    `type`       varchar(50) NOT NULL COMMENT 'TYPE: INCOME or EXPAND',
    `name`       varchar(50) NOT NULL,
    `parent_cno` int NULL
);

DROP TABLE IF EXISTS `card`;

CREATE TABLE `card`
(
    `cno`      int AUTO_INCREMENT PRIMARY KEY,
    `email`    varchar(50)  NOT NULL,
    `name`     varchar(100) NOT NULL,
    `cname`    varchar(100) NULL,
    `type`     varchar(50)  NOT NULL COMMENT '타입: CREDIT or CHECK',
    `bday`     int          NOT NULL,
    `imgurl`   text NULL,
    `memo`     text NULL,
    `amount`   bigint       NOT NULL,
    `isExcept` boolean      NOT NULL DEFAULT false,
    FOREIGN KEY (`email`) REFERENCES `ymember` (`email`)
);

DROP TABLE IF EXISTS `transaction`;

CREATE TABLE `transaction`
(
    `tno`         int AUTO_INCREMENT PRIMARY KEY,
    `email`       varchar(50) NOT NULL,
    `cno`         int         NOT NULL COMMENT '카테고리 번호',
    `type`        varchar(50) NOT NULL COMMENT '거래 타입: INCOME or EXPAND',
    `stype`       varchar(50) NOT NULL COMMENT '소스 타입: ACCOUNT or CARD',
    `sno`         int         NOT NULL,
    `keyword`     varchar(250) NULL,
    `samount`     bigint      NOT NULL DEFAULT 0 COMMENT '수입: +, 지출: - ',
    `installment` int         DEFAULT 1 COMMENT '일시불:1, 할부 개월:2~10',
    `imageUrl`    text NULL,
    `tsmemo`      text NULL,
    `time`        TimeStamp NULL,
    `rtype`       varchar(50) NOT NULL DEFAULT 'NONE' COMMENT '반복 타입: NONE or WEEKLY or MONTHLY',
    FOREIGN KEY (`email`) REFERENCES `ymember` (`email`),
    FOREIGN KEY (`cno`) REFERENCES `category` (`cno`)
);



CREATE TABLE `tag`
(
    `tno`   int AUTO_INCREMENT PRIMARY KEY,
    `name`  varchar(100) NULL,
    `email` varchar(50) NOT NULL,
    FOREIGN KEY (`email`) REFERENCES `ymember` (`email`)
);

CREATE TABLE `transactiontag`
(
    `tgtsno` int AUTO_INCREMENT PRIMARY KEY,
    `tgno`   int NOT NULL,
    `tsno`   int NOT NULL,
    FOREIGN KEY (`tgno`) REFERENCES `tag` (`tno`),
    FOREIGN KEY (`tsno`) REFERENCES `transaction` (`tno`)
);
