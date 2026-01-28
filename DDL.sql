select @@hostname;

/* 이 창은 메모장처럼 사용됨
스크립트를 1줄씩 실행하는것이 기본임 (ctrl + enter)
만약 더미데이터를 2개 입력한다!!!(블럭설정 ctrl + shift + enter)*/

use sakila; -- sakila 데이터베이스에 가서 사용
select * from actor; -- actor 테이블에 모든 값을 가져와

use world; -- world 데이터베이스에 가서 사용할게

/* create 문으로 데이터베이스 생성
CREATE DATABASE DoItSQL;*/

/* create 문으로 데이터베이스 삭제
DROP DATABASE doitsql;*/
/* 데이터베이스 생성 후 선택
CREATE DATABASE doitsql;
USE doitsql;*/
-- create 문으로 테이블 생성
CREATE TABLE doit_create_table (
col_1 INT,
col_2 VARCHAR(50),
col_3 DATETIME
);
/*drop 문으로 테이블 삭제*/
DROP TABLE doit_create_table;
CREATE TABLE doit_dml (
col_1 INT,
col_2 VARCHAR(50),
col_3 DATETIME
);
INSERT INTO doit_dml (col_1, col_2, col_3) VALUES (1, 'DoItSQL', '2023-01-01');

-- 테이블 조회하여 삽입한 데이터 확인
SELECT * FROM doit_dml;

-- 데이터 유형 불일치로 인한 오류 발생 예
INSERT INTO doit_dml(col_1) VALUES ('문자 입력');

-- 열 이름 생략하고 데이터 삽입
INSERT INTO doit_dml VALUES (2, '열 이름 생략', '2023-01-02');

-- 삽입된 데이터 확인
SELECT * FROM doit_dml;

-- 열 개수 불일치로 인한 오류 발생
INSERT INTO doit_dml VALUES (3, 'col_3 값 생략');

-- 특정 열에만 데이터 삽입
INSERT INTO doit_dml(col_1, col_2) VALUES (3, 'col_3 값 생략');

-- 삽입할 데이터의 순서 변경
INSERT INTO doit_dml(col_1, col_3, col_2) VALUES (4,'2023-01-03', '열순서 변경');

-- 여러 데이터 한 번에 삽입
INSERT INTO doit_dml(col_1, col_2, col_3) VALUES (5, '데이터 입력5', '2023-01-03'), (6, '데이터 입력6', '2023-01-03'), (7, '데이터 입력7', '2023-01-03');

-- NULL을 허용하지 않는 테이블 생성 후 NULL 삽입 시 오류가 발생한 예
CREATE TABLE doit_notnull (
col_1 INT,
col_2 VARCHAR(50) NOT NULL
);
INSERT INTO doit_notnull (col_1) VALUES (1);

-- update문으로 데이터 수정 1
update doit_dml set col_2 = '데이터 수정'
where col_1 = 4;

-- update문으로 데이터 수정 2
update doit_dml set col_2 = '데이터 수정'
where col_1 = 4;

-- update문으로 테이블 전체 데이터 수정
UPDATE doit_dml SET col_1 = col_1 + 10;

-- DELETE 문으로 데이터 수정
DELETE FROM doit_dml WHERE col_1 = 14;

-- DELETE 문으로 테이블 전체 데이터 삭제
DELETE FROM doit_dml;

SHOW DATABASES like 'sakila';
SELECT * FROM customer;
show columns from sakila.customer;
select * from customer where first_name = 'MARIA';

SELECT * FROM sakila.customer WHERE address_id = 200;
SELECT * FROM sakila.customer WHERE address_id < 200;
SELECT database();
use sakila;
SELECT * FROM customer WHERE first_name ='MARIA'; # customer 테이블에서 문자열형 비교로 first_name 열에서 데이터가 MARIA인 행을 조회
SELECT * FROM customer WHERE first_name < 'MARIA'; # customer 테이블에서 문자열형 비교로 FIRST_NAME열에서 데이터가 A, B, C 순으로 MARIA보다 앞에 위치한 행들을 조회.
SELECT * FROM payment
WHERE payment_date = '2005-07-09 13:24:07';

SELECT * FROM customer WHERE address_id BETWEEN 5 AND 10; # 정해진 범위에 해당하는 데이터 조회
SELECT * FROM payment WHERE payment_date BETWEEN '2005-06-17' AND '2005-07-19'; # 날짜가 포함한 날짜 조회
SELECT * FROM payment WHERE payment_date = '2005-07-08 07:33:56'; # payment_date에 있는 정확한 날짜 조회
SELECT * FROM customer
WHERE first_name NOT BETWEEN 'M' AND 'O';

SELECT * FROM city # 소괄호로 우선순위를 다시 정해 데이터를 조회
WHERE (country_id = 103 OR country_id = 86)
AND city IN ('Cheju','Sunnyvale','Dallas');

SELECT * FROM city # IN, AND를 결합하여 조회
WHERE country_id IN (103, 86)
	AND city IN ('Cheju','Sunnyvale','Dallas');

SELECT * FROM address; # Null이 있는 테이블 조회

SELECT * FROM address WHERE address2 = Null; # = 연산자를 사용해 NULL 데이터 조회

SELECT * FROM address  WHERE address2 IS NULL; # address2 열에 NULL인 데이터 조회

SELECT * FROM address WHERE address2 IS NOT NULL; # 현재 DB(sakila)에 있는 address 테이블의 참조해서 조건(WHERE)은 address2열에 있는 NULL이 아닌 값 조회.

SELECT * FROM address WHERE address2 = ''; # 현재 DB(sakila)에 있는 address 테이블의 참조해서 조건(WHERE)은 address2열에 있는 NULL이 아닌 값 조회.

# ORDER BY 절로 데이터 정렬하기
# ORDER BY 절의 기본 형식
# SELECT [열] FROM [테이블] WHERE [열] = [조건값] ORDER BY [열] [ASC 또는 DESC]
SELECT * FROM customer ORDER BY first_name; # first_name 값으로 정렬
SELECT * FROM customer ORDER BY last_name; # last_name 값으로 정렬
SELECT * FROM customer ORDER BY store_id, first_name; # By 다음 열부터 순차 정렬
SELECT * FROM customer ORDER BY first_name ASC; # ASC = 오름차순을 말함
SELECT * FROM customer ORDER BY first_name DESC; # DESC = 내림차순을 말함
SELECT * FROM customer ORDER BY store_id DESC, first_name ASC; # ASC(오름차순), DESC(내림차순) 조합하여 데이터 정렬.
SELECT * FROM customer ORDER BY store_id DESC, first_name ASC LIMIT 10; # LIMIT(리미트)를 사용하여 결과 수를 제한함 / 상위 10개의 데이터 조회
SELECT * FROM customer ORDER BY customer_id ASC LIMIT 100, 10; # LIMIT를 통해 101부터 10개 데이터 조회

# LIKE의 기본 형식
# SELECT [열] FROM [테이블] WHERE [열] LIKE [조건값]
#								[열] : 오건을 적용할 열 이름을 입력한다.
#									LIKE : 조건값에 일치하는 데이터를 조회하는 구문.
#										  [조건값] : 검색하고자 하는 데이터의 조건값을 입력한다.
SELECT * FROM customer WHERE first_name LIKE 'A%'; # 첫 번째 글자가 A로 시작하는 데이터 조회
SELECT * FROM customer WHERE first_name LIKE 'AA%'; # 첫 번째 글자가 AA로 시작하는 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '%A'; # 마지막 글자가 A로 끝나는 데이터 조회.
SELECT * FROM customer WHERE first_name LIKE '%A%'; # A를 포함하는 모든 데이터 조회
SELECT * FROM customer WHERE first_name NOT LIKE 'A%'; # 첫번쨰 글자가 A로 포함하지 않는 데이터 조회(LIKE 앞에 NOT가 있음)

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_bc' UNION ALL
SELECT 'ABC'
) # 특수 문자를 포함한 임의의 테이블 생성 
# SELECT * FROM CTE;    # CTE 테이블 조회.
SELECT * FROM CTE WHERE col_1 LIKE '%'; # 특수 문자를 포함한 데이터 조회.

# GROUP BY 절로 데이터 묶기
# GROUP BY 절과 HAVING 절의 기본 형식
# SELECT [열] FROM [테이블] WHERE [열] = [조건값] GROUP BY [열] HAVING [열] = [조건값]
SELECT special_features FROM film GROUP BY special_features; # special_features 열의 데이터를 그룹화
SELECT rating FROM film GROUP BY rating; # rating 열의 데이터를 그룹화
SELECT special_features, rating FROM film GROUP BY special_features, rating; # special_features, rating 열 순서로 데이터를 그룹화

# COUNT 함수로 그룹에 속한 데이터 개수 세기
SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features ;

# DISTINCT로 중복된 데이터 제거하기
# SELECT DISTINCT [열] FROM [테이블]
SELECT DISTINCT special_features, rating FROM film; # 두 열의 데이터 중복 제거
SELECT special_features, rating FROM film
GROUP BY special_features, rating; # GROUP BY 절로 두 열을 그룹화한 경우