
-- 1. 부모 카테고리 삽입
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '식사', NULL),
    ('EXPENSE', '카페/간식', NULL),
    ('EXPENSE', '술/유흥', NULL),
    ('EXPENSE', '생활/마트', NULL),
    ('EXPENSE', '온라인쇼핑', NULL),
    ('EXPENSE', '백화점/패션', NULL),
    ('EXPENSE', '금융/보험', NULL),
    ('EXPENSE', '의료/건강', NULL),
    ('EXPENSE', '뷰티/미용', NULL),
    ('EXPENSE', '주거/통신', NULL),
    ('EXPENSE', '학습/교육', NULL),
    ('EXPENSE', '문화/예술', NULL),
    ('EXPENSE', '교통/차량', NULL),
    ('EXPENSE', '스포츠/레저', NULL),
    ('EXPENSE', '여행/숙박', NULL),
    ('EXPENSE', '경조사/회비', NULL),
    ('EXPENSE', '출금', NULL),
    ('EXPENSE', '자산이동', NULL),
    ('EXPENSE', '기타지출', NULL),
    ('INCOME', '주수입', NULL),
    ('INCOME', '부수입', NULL),
    ('INCOME', '금융/대출', NULL),
    ('INCOME', '자산이동', NULL),
    ('INCOME', '기타수입', NULL);

-- 2. 서브카테고리 삽입
-- 식사
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '고기', 1),
    ('EXPENSE', '기타', 1),
    ('EXPENSE', '배달', 1),
    ('EXPENSE', '분식', 1),
    ('EXPENSE', '뷔페', 1),
    ('EXPENSE', '아시아음식', 1),
    ('EXPENSE', '양식', 1),
    ('EXPENSE', '일반식당', 1),
    ('EXPENSE', '일식', 1),
    ('EXPENSE', '중식', 1),
    ('EXPENSE', '치킨', 1),
    ('EXPENSE', '패밀리레스토랑', 1),
    ('EXPENSE', '패스트푸드', 1),
    ('EXPENSE', '한식', 1),
    ('EXPENSE', '식재료', 1);

-- 카페/간식
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 2),
    ('EXPENSE', '도넛/아이스크림', 2),
    ('EXPENSE', '디저트/떡', 2),
    ('EXPENSE', '베이커리', 2),
    ('EXPENSE', '샌드위치/핫도그', 2),
    ('EXPENSE', '차/주스/빙수', 2),
    ('EXPENSE', '커피', 2),
    ('EXPENSE', '자판기', 2);

-- 술/유흥
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 3),
    ('EXPENSE', '술집', 3),
    ('EXPENSE', '유흥시설', 3);

-- 생활/마트
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '가전/가구', 4),
    ('EXPENSE', '기타', 4),
    ('EXPENSE', '마트', 4),
    ('EXPENSE', '반려동물', 4),
    ('EXPENSE', '육아', 4),
    ('EXPENSE', '기프트샵/꽃', 4),
    ('EXPENSE', '일상용품', 4),
    ('EXPENSE', '생활서비스', 4),
    ('EXPENSE', '편의점', 4);

-- 온라인쇼핑
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '결제/충전', 5),
    ('EXPENSE', '기타', 5),
    ('EXPENSE', '인터넷쇼핑', 5),
    ('EXPENSE', '카드포인트', 5),
    ('EXPENSE', '홈쇼핑', 5),
    ('EXPENSE', '앱스토어', 5);

-- 백화점/패션
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 6),
    ('EXPENSE', '백화점', 6),
    ('EXPENSE', '스포츠의류', 6),
    ('EXPENSE', '아울렛/몰', 6),
    ('EXPENSE', '잡화', 6),
    ('EXPENSE', '패션', 6);

-- 금융/보험
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 7),
    ('EXPENSE', '보험', 7),
    ('EXPENSE', '은행', 7),
    ('EXPENSE', '세금/과태료', 7),
    ('EXPENSE', '카드', 7),
    ('EXPENSE', '증권/투자', 7),
    ('EXPENSE', '이자/대출', 7);

-- 의료/건강
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 8),
    ('EXPENSE', '병원', 8),
    ('EXPENSE', '보조식품', 8),
    ('EXPENSE', '약국', 8),
    ('EXPENSE', '요양', 8),
    ('EXPENSE', '의료기기', 8),
    ('EXPENSE', '치과', 8),
    ('EXPENSE', '한의원', 8);

-- 뷰티/미용
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 9),
    ('EXPENSE', '네일', 9),
    ('EXPENSE', '뷰티제품', 9),
    ('EXPENSE', '피부/체형관리', 9),
    ('EXPENSE', '헤어샵', 9);

-- 주거/통신
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '공과금', 10),
    ('EXPENSE', '관리비', 10),
    ('EXPENSE', '기타', 10),
    ('EXPENSE', '부동산', 10),
    ('EXPENSE', '월세', 10),
    ('EXPENSE', '이사', 10),
    ('EXPENSE', '통신', 10);

-- 학습/교육
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 11),
    ('EXPENSE', '학교', 11),
    ('EXPENSE', '학습교재', 11),
    ('EXPENSE', '학습시설', 11),
    ('EXPENSE', '학원', 11),
    ('EXPENSE', '시험', 11);

-- 문화/예술
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '공연', 12),
    ('EXPENSE', '기타', 12),
    ('EXPENSE', '도서', 12),
    ('EXPENSE', '영화', 12),
    ('EXPENSE', '전시/관람', 12),
    ('EXPENSE', '취미', 12),
    ('EXPENSE', '여가시설', 12);

-- 교통/차량
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 13),
    ('EXPENSE', '대리운전', 13),
    ('EXPENSE', '대중교통', 13),
    ('EXPENSE', '렌트카', 13),
    ('EXPENSE', '정비/부품', 13),
    ('EXPENSE', '주차/요금소', 13),
    ('EXPENSE', '주유소', 13),
    ('EXPENSE', '택시', 13),
    ('EXPENSE', '휴게소', 13);

-- 스포츠/레저
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 14),
    ('EXPENSE', '레저', 14),
    ('EXPENSE', '무예', 14),
    ('EXPENSE', '스파/마사지', 14),
    ('EXPENSE', '스포츠', 14),
    ('EXPENSE', '요가/헬스', 14),
    ('EXPENSE', '테마파크', 14);

-- 여행/숙박
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '항공', 15),
    ('EXPENSE', '관광', 15),
    ('EXPENSE', '기타', 15),
    ('EXPENSE', '숙박', 15),
    ('EXPENSE', '여행', 15),
    ('EXPENSE', '여행용품', 15),
    ('EXPENSE', '해외결제', 15);

-- 경조사/회비
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기부', 16),
    ('EXPENSE', '기타', 16),
    ('EXPENSE', '용돈', 16),
    ('EXPENSE', '헌금', 16),
    ('EXPENSE', '회비', 16),
    ('EXPENSE', '경조사', 16);

-- 출금
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 17);

-- 자산이동
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '기타', 18);

-- 기타지출
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPENSE', '공공기관', 19),
    ('EXPENSE', '기업', 19),
    ('EXPENSE', '기타', 19),
    ('EXPENSE', '컨설팅', 19);

-- 주수입 (수입 카테고리)
INSERT INTO category (type, name, parent_cno)
VALUES
    ('INCOME', '기타', 20);

-- 부수입
INSERT INTO category (type, name, parent_cno)
VALUES
    ('INCOME', '기타', 21);

-- 금융/대출 (수입 카테고리)
INSERT INTO category (type, name, parent_cno)
VALUES
    ('INCOME', '기타', 22);

-- 자산이동 (수입 카테고리)
INSERT INTO category (type, name, parent_cno)
VALUES
    ('INCOME', '입금', 23);

-- 기타수입 (수입 카테고리)
INSERT INTO category (type, name, parent_cno)
VALUES
    ('INCOME', '기타', 24);
