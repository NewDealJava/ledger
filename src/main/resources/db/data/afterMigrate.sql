SET foreign_key_checks = 0;
TRUNCATE TABLE ymember;
TRUNCATE TABLE account;
TRUNCATE TABLE card;
TRUNCATE TABLE tag;
TRUNCATE TABLE transaction;
SET foreign_key_checks = 1;

INSERT INTO ymember (email, password, name, phone, address, profile_image, created_at)
VALUES ('user1@example.com', 'password1', 'User One', '123-456-7890', '123 Main St', null, '2023-01-01'),
       ('user2@example.com', 'password2', 'User Two', '234-567-8901', '234 Oak St', null, '2023-02-01');


INSERT INTO account (email, name, cname, type, imgUrl, memo, amount, isExcept)
VALUES ('user1@example.com', 'Account 1', 'Checking', 'MONEY', null, 'Memo 1', 1000, false),
       ('user2@example.com', 'Account 2', 'Savings', 'ACCOUNT', null, 'Memo 2', 2000, false);


INSERT INTO card (email, name, cname, type, bday, imgurl, memo, amount, isExcept)
VALUES ('user1@example.com', 'Card 1', 'Visa', 'CREDIT', 15, null, 'Memo 1', 500, false),
       ('user2@example.com', 'Card 2', 'MasterCard', 'CHECK', 20, null, 'Memo 2', 1500, true);

INSERT INTO tag (name, email)
VALUES ('Groceries', 'user1@example.com'),
       ('Transport', 'user2@example.com'),
       ('Entertainment', 'user1@example.com'),
       ('Utilities', 'user2@example.com');



-- 필요한 카테고리의 cno를 가져옵니다.
-- 필요한 경우 수동으로 ID를 설정해야 합니다.
-- 예를 들어:
-- SELECT cno FROM category WHERE name = '식사';

SET @cno_food = (SELECT cno
                 FROM category
                 WHERE name = '일식');
SET @cno_cafe = (SELECT cno
                 FROM category
                 WHERE name = '베이커리');
SET @cno_income = (SELECT cno
                   FROM category
                   WHERE name = '기타' AND parent_cno = 24);

-- 기존 프로시저 삭제
DROP PROCEDURE IF EXISTS GenerateTransactions;

-- transaction 데이터 생성
DELIMITER $$

CREATE PROCEDURE GenerateTransactions()
BEGIN
    DECLARE v_email VARCHAR(50);
    DECLARE v_stype VARCHAR(50);
    DECLARE v_sno INT;
    DECLARE v_date DATE;
    DECLARE v_count INT DEFAULT 0;

    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT email FROM ymember;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN cur;

read_loop:
    LOOP
        FETCH cur INTO v_email;
        IF done THEN
            LEAVE read_loop;
END IF;

        SET v_date = '2024-04-01';
        WHILE v_date <= '2024-07-31'
            DO
                -- 하루에 30개의 트랜잭션 생성
                SET v_count = 0;
                WHILE v_count < 30
                    DO
                        IF v_count MOD 2 = 0 THEN
                            SET v_stype = 'ACCOUNT';
                            SET v_sno = (SELECT ano FROM account WHERE email = v_email LIMIT 1);
ELSE
                            SET v_stype = 'CARD';
                            SET v_sno = (SELECT cno FROM card WHERE email = v_email LIMIT 1);
END IF;

INSERT INTO transaction (email, cno, type, stype, sno, keyword, samount, installment, imageUrl,
                         tsmemo, time, rtype)
VALUES (v_email,
        CASE
            WHEN v_count MOD 3 = 0 THEN @cno_food
            WHEN v_count MOD 3 = 1 THEN @cno_cafe
            ELSE @cno_income
            END,
        CASE
            WHEN v_count MOD 3 = 2 THEN 'INCOME'
            ELSE 'EXPENSE'
            END,
        v_stype,
        v_sno,
        CONCAT('Keyword ', v_count),
        CASE
            WHEN v_count MOD 3 = 2 THEN 1000 + v_count * 10
            ELSE - (100 + v_count * 10)
            END,
        1,
        NULL,
        CONCAT('Memo ', v_count),
--         TIMESTAMP(v_date, '12:00:00'),
        TIMESTAMP(v_date, SEC_TO_TIME((v_count MOD 24) * 3600 + (v_count MOD 60) * 60)),
        'NONE');


SET v_count = v_count + 1;
END WHILE;
                SET v_date = DATE_ADD(v_date, INTERVAL 1 DAY);
END WHILE;
END LOOP;

CLOSE cur;
END$$

DELIMITER ;

-- 트랜잭션 생성 호출
CALL GenerateTransactions();
