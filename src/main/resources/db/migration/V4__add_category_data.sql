
-- 1. 부모 카테고리 삽입
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '식사', NULL),
    ('EXPAND', '카페/간식', NULL),
    ('EXPAND', '술/유흥', NULL),
    ('EXPAND', '생활/마트', NULL),
    ('EXPAND', '온라인쇼핑', NULL),
    ('EXPAND', '백화점/패션', NULL),
    ('EXPAND', '금융/보험', NULL),
    ('EXPAND', '의료/건강', NULL),
    ('EXPAND', '뷰티/미용', NULL),
    ('EXPAND', '주거/통신', NULL),
    ('EXPAND', '학습/교육', NULL),
    ('EXPAND', '문화/예술', NULL),
    ('EXPAND', '교통/차량', NULL),
    ('EXPAND', '스포츠/레저', NULL),
    ('EXPAND', '여행/숙박', NULL),
    ('EXPAND', '경조사/회비', NULL),
    ('EXPAND', '출금', NULL),
    ('EXPAND', '자산이동', NULL),
    ('EXPAND', '기타지출', NULL),
    ('INCOME', '주수입', NULL),
    ('INCOME', '부수입', NULL),
    ('INCOME', '금융/대출', NULL),
    ('INCOME', '자산이동', NULL),
    ('INCOME', '기타수입', NULL);

-- 2. 서브카테고리 삽입
-- 식사
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '고기', 1),
    ('EXPAND', '기타', 1),
    ('EXPAND', '배달', 1),
    ('EXPAND', '분식', 1),
    ('EXPAND', '뷔페', 1),
    ('EXPAND', '아시아음식', 1),
    ('EXPAND', '양식', 1),
    ('EXPAND', '일반식당', 1),
    ('EXPAND', '일식', 1),
    ('EXPAND', '중식', 1),
    ('EXPAND', '치킨', 1),
    ('EXPAND', '패밀리레스토랑', 1),
    ('EXPAND', '패스트푸드', 1),
    ('EXPAND', '한식', 1),
    ('EXPAND', '식재료', 1);

-- 카페/간식
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 2),
    ('EXPAND', '도넛/아이스크림', 2),
    ('EXPAND', '디저트/떡', 2),
    ('EXPAND', '베이커리', 2),
    ('EXPAND', '샌드위치/핫도그', 2),
    ('EXPAND', '차/주스/빙수', 2),
    ('EXPAND', '커피', 2),
    ('EXPAND', '자판기', 2);

-- 술/유흥
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 3),
    ('EXPAND', '술집', 3),
    ('EXPAND', '유흥시설', 3);

-- 생활/마트
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '가전/가구', 4),
    ('EXPAND', '기타', 4),
    ('EXPAND', '마트', 4),
    ('EXPAND', '반려동물', 4),
    ('EXPAND', '육아', 4),
    ('EXPAND', '기프트샵/꽃', 4),
    ('EXPAND', '일상용품', 4),
    ('EXPAND', '생활서비스', 4),
    ('EXPAND', '편의점', 4);

-- 온라인쇼핑
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '결제/충전', 5),
    ('EXPAND', '기타', 5),
    ('EXPAND', '인터넷쇼핑', 5),
    ('EXPAND', '카드포인트', 5),
    ('EXPAND', '홈쇼핑', 5),
    ('EXPAND', '앱스토어', 5);

-- 백화점/패션
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 6),
    ('EXPAND', '백화점', 6),
    ('EXPAND', '스포츠의류', 6),
    ('EXPAND', '아울렛/몰', 6),
    ('EXPAND', '잡화', 6),
    ('EXPAND', '패션', 6);

-- 금융/보험
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 7),
    ('EXPAND', '보험', 7),
    ('EXPAND', '은행', 7),
    ('EXPAND', '세금/과태료', 7),
    ('EXPAND', '카드', 7),
    ('EXPAND', '증권/투자', 7),
    ('EXPAND', '이자/대출', 7);

-- 의료/건강
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 8),
    ('EXPAND', '병원', 8),
    ('EXPAND', '보조식품', 8),
    ('EXPAND', '약국', 8),
    ('EXPAND', '요양', 8),
    ('EXPAND', '의료기기', 8),
    ('EXPAND', '치과', 8),
    ('EXPAND', '한의원', 8);

-- 뷰티/미용
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 9),
    ('EXPAND', '네일', 9),
    ('EXPAND', '뷰티제품', 9),
    ('EXPAND', '피부/체형관리', 9),
    ('EXPAND', '헤어샵', 9);

-- 주거/통신
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '공과금', 10),
    ('EXPAND', '관리비', 10),
    ('EXPAND', '기타', 10),
    ('EXPAND', '부동산', 10),
    ('EXPAND', '월세', 10),
    ('EXPAND', '이사', 10),
    ('EXPAND', '통신', 10);

-- 학습/교육
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 11),
    ('EXPAND', '학교', 11),
    ('EXPAND', '학습교재', 11),
    ('EXPAND', '학습시설', 11),
    ('EXPAND', '학원', 11),
    ('EXPAND', '시험', 11);

-- 문화/예술
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '공연', 12),
    ('EXPAND', '기타', 12),
    ('EXPAND', '도서', 12),
    ('EXPAND', '영화', 12),
    ('EXPAND', '전시/관람', 12),
    ('EXPAND', '취미', 12),
    ('EXPAND', '여가시설', 12);

-- 교통/차량
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 13),
    ('EXPAND', '대리운전', 13),
    ('EXPAND', '대중교통', 13),
    ('EXPAND', '렌트카', 13),
    ('EXPAND', '정비/부품', 13),
    ('EXPAND', '주차/요금소', 13),
    ('EXPAND', '주유소', 13),
    ('EXPAND', '택시', 13),
    ('EXPAND', '휴게소', 13);

-- 스포츠/레저
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 14),
    ('EXPAND', '레저', 14),
    ('EXPAND', '무예', 14),
    ('EXPAND', '스파/마사지', 14),
    ('EXPAND', '스포츠', 14),
    ('EXPAND', '요가/헬스', 14),
    ('EXPAND', '테마파크', 14);

-- 여행/숙박
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '항공', 15),
    ('EXPAND', '관광', 15),
    ('EXPAND', '기타', 15),
    ('EXPAND', '숙박', 15),
    ('EXPAND', '여행', 15),
    ('EXPAND', '여행용품', 15),
    ('EXPAND', '해외결제', 15);

-- 경조사/회비
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기부', 16),
    ('EXPAND', '기타', 16),
    ('EXPAND', '용돈', 16),
    ('EXPAND', '헌금', 16),
    ('EXPAND', '회비', 16),
    ('EXPAND', '경조사', 16);

-- 출금
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 17);

-- 자산이동
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '기타', 18);

-- 기타지출
INSERT INTO category (type, name, parent_cno)
VALUES
    ('EXPAND', '공공기관', 19),
    ('EXPAND', '기업', 19),
    ('EXPAND', '기타', 19),
    ('EXPAND', '컨설팅', 19);

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
