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

# 조인의 종류
# 내부 조인(INNER JOIN) / 외부 조인(OUTER JOIN) / 교차 조인(CROSS JOIN) / 셀프 조인(SELE JOIN)
/* INNER JOIN(내부 조인의 기본 형식)
SELECT
	[열]
FROM [테이블 1]
	INNER JOIN [테이블 2] ON [테이블 1.열] = 테이블 2.열]
WHERE [검색 조건]
*/
SELECT
	a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id
AS a_address_id,
    b.address_id AS b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';

/* OUTER JOIN(아웃 조인의 기본 형식)
SELECT
	[열]
FROM [테이블 1]
	[LEFT | RIGHT | FULL] OUTER JOIN [테이블 2] ON [테이블 1.열] = [테이블 2.열]
WHERE [검색 조건]
*/
SELECT
	a.address, a.address_id AS a_address_id,
    b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id;

/* CROSS JOIN(크로스 조인의 기본 형식)
SELECT [열]
FROM [테이블 1]
	CROSS JOIN [테이블 2]
WHERE [검색 조건]
*/
# CROSS JOIN을 위해 샘플 생성
CREATE TABLE doit_cross1(num INT);
CREATE TABLE doit_cross2(name VARCHAR(10));
INSERT INTO doit_cross1 VALUES (1), (2), (3);
INSERT INTO doit_cross2 VALUES ('Do'), ('It'), ('SQL');
SELECT
	a.num, b.name
FROM doit_cross1 AS a
CROSS JOIN doit_cross2 AS b
ORDER BY a.num;

/*SELF JOIN(셀프 조인의 기본 형식)*/
SELECT a.customer_id AS a_customer_id, b.customer_id AS b_customer_id
FROM customer AS a
	INNER JOIN customer AS b ON a.customer_id = b.customer_id
    
# 쿼리 안에 또 다른 쿼리 서브 쿼리
/* WHERE 절에 서브 쿼리 사용하기*/
/* 단일 행 서브 쿼리의 기본 형식
SELECT [열]
FROM [테이블]
WHERE [열] = (SELECT [열] FROM [테이블])
*/
SELECT * FROM customer
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ROSA');

/*IN을 활용한 다중 행 서브 쿼리의 기본 형식
SELECT [열]
FROM [테이블]
WHERE [열] IN (SELECT [열] FROM [테이블])*/

/* FROM 절에 서브 쿼리 사용하기
FROM 절에 사용하는 서브 쿼리의 기본형식
SWLECT
	[열]
FROM [테이블] AS a
	INNER JOIN (SELECT [열] FROM [테이블] WHERE [열] = [값]) AS b ON [a.열] = [b.열]
    WHERE [열] = [값]
*/

# 공통 테이블 표현식
/*일반 CTE의 기본형식
WITH [테이블] (열 1, 열 2, ...)
AS
(
	<SELECT 문>
)
SELECT [열] FROM [테이블]
*/
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10
    AND customer_id < 100
)
SELECT * FROM cte_customer;

/* UNION으로 CTE 결합해보기
UNION ALL로 CTE 결합 */
WITH cte_customer ( customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10
	AND customer_id <= 15
	UNION ALL
    SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 25
    AND customer_id <= 30
)

SELECT * FROM cte_customer;

/*INTERSECT로 CTE 결합*/
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id >= 15
	INTERSECT
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id >= 20
)
SELECT * FROM cte_customer;

/*except문으로 CTE 결합 1*/
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15 
    EXCEPT
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id <= 20
)
SELECT * FROM cte_customer;

/*except문으로 CTE 결합 2*/
WITH cte_customer (customer_id, first_name, email)
AS
(
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 12 AND customer_id <= 20
	EXCEPT
	SELECT customer_id, first_name, email FROM customer WHERE customer_id >= 10 AND customer_id <= 15
)

SELECT * FROM cte_customer;

# 재귀 CTE
/*
재귀 CTE의 기본 형식
WITH RECURSIVE [CTE_테이블] (열 1, 열 2, ....)
AS(
	<SELECT * FROM 테이블 A>
    UNION ALL
    <SELECT * FROM 테이블 B JOIN CTE_테이블>
)
SELECT * FROM [CTE_테이블];
*/

/*재귀 CTE로 피보나치 수열 생성*/
WITH RECURSIVE fibonacci_number (n, fibonacci_n, next_fibonacci_n)
AS(
	SELECT 1, 0, 1
	UNION ALL
	SELECT 
		n + 1, next_fibonacci_n, fibonacci_n + next_fibonacci_n
	FROM fibonacci_number 
	WHERE n < 20
	)

SELECT * FROM fibonacci_number;

# 다양한 SQL 함수 사용하기
-- CONCAT 함수로 열 이름과 문자열 연결
SELECT CONCAT(first_name, ', ', last_name) AS customer_name FROM customer;

-- CONCAT_WS 함수로 구분자 지정
SELECT CONCAT_WS(', ', first_name, last_name, email) AS customer_name FROM customer;

-- CONCAT 함수로 NULL과 열 이름 연결
SELECT CONCAT(NULL, first_name, last_name) AS customer_name FROM customer;

-- CONCAT_WS 인자로 NULL이 있는 경우
SELECT CONCAT_WS(', ', first_name, NULL, last_name) as customer_name FROM customer;

# 데이터 형 변환 함수 : CAST, CONVERT
-- 문자열을 부호 없는 정수형으로 변경
SELECT
4 / '2',
4 / 2,
4 / CAST('2' AS UNSIGNED);

-- NOW 함수로 현재 날짜와 시간 출력
SELECT NOW();

-- CAST 함수로 날짜형을 숫자형으로 변환
SELECT CAST(NOW() AS SIGNED);

-- CAST 함수로 숫자형을 날짜형으로 변환
SELECT CAST(20230819 AS DATE);

-- CAST 함수로 숫자형을 문자열로 변환
SELECT CAST(20230819 AS CHAR);

-- CONVERT 함수로 날짜형을 정수형으로 변환
SELECT CONVERT(NOW(), SIGNED);

-- CONVERT 함수로 숫자형을 날짜형으로 변환
SELECT CONVERT(20230819, DATE);

-- CHAR로 데이터 길이 지정
SELECT CONVERT(20230819, CHAR(5));

-- 오버플로 발생 예
SELECT 9223372036854775807 + 1;

-- CAST 함수로 오버플로 방지
SELECT CAST(9223372036854775807 AS UNSIGNED) + 1;

-- CONVERT함수로 오버플로 방지
SELECT CONVERT(9223372036854775807, UNSIGNED) + 1;

# NULL을 대체하는 함수(IFNULL, COALESCE)
/*IFNULL 함수의 기본 형식
IFNULL(열, 대체할 값)*/
/*COALESCE 함수의 기본 형식
COALESCE(열 1, 열 2, ........)*/

-- 테이블 생성
CREATE TABLE doit_null (
col_1 INT,
col_2 VARCHAR(10),
col_3 VARCHAR(10),
col_4 VARCHAR(10),
col_5 VARCHAR(10)
);

INSERT INTO doit_null VALUES (1, NULL, 'col_3', 'col_4', 'col_5');
INSERT INTO doit_null VALUES (2, NULL, NULL, NULL, 'col_5');
INSERT INTO doit_null VALUES (3, NULL, NULL, NULL, NULL);

SELECT * FROM doit_null;

-- IFNULL 함수로 col_2열의 NULL 대체
SELECT col_1, IFNULL(col_2, '') AS col_2, col_3, col_4, col_5
FROM doit_null WHERE col_1 = 1;

-- IFNULL 함수로 col_3열의 NULL 대체
SELECT col_1, IFNULL(col_2, col_3) AS col_2, col_3, col_4, col_5
FROM doit_null WHERE col_1 = 1;

-- COALESCE 함수로 NULL을 다른 데이터로 대체: 마지막 인자에 데이터가 있는 경우
SELECT col_1, COALESCE(col_2, col_3, col_4, col_5)
FROM doit_null WHERE col_1 = 2;

-- COALESCE 함수로 NULL을 다른 데이터로 대체: 마지막 인자에도 NULL이 있는 경우
SELECT col_1, COALESCE(col_2, col_3, col_4, col_5)
FROM doit_null WHERE col_1 = 3;

/*소문자 혹은 대문자로 변경하는 함수(LOWER, UPPER)*/
-- LOWER 함수로 소문자를, UPPER 함수로 대문자로 변경
SELECT 'Do it! SQL', LOWER('Do it! SQL'), UPPER('Do it! SQL');

-- LOWER 함수로 소문자를, UPPER 함수로 대문자로 변경
SELECT email, LOWER(email), UPPER(email) FROM customer;

-- LTRIM 함수로 왼쪽 공백 제거
SELECT ' Do it! MySQL', LTRIM(' Do it! MySQL');

-- RTRIM 함수로 오른쪽 공백 제거
SELECT 'Do it! MySQL ', RTRIM('Do it! MySQL ');

-- TRIM 함수로 양쪽 공백 제거
SELECT ' Do it! MySQL ', TRIM(' Do it! MySQL ');

-- TRIM 함수로 양쪽 문자 제거
SELECT TRIM(BOTH '#' FROM '# Do it! MySQL #');

/*문자열 크기 또는 개수를 반환하는 함수(LENGTH, CHAR_LENNGTH)*/
-- LENGTH 함수로 문자열의 크기 반환
SELECT LENGTH('Do it! MySQL'), LENGTH('두잇 마이에스큐엘');

-- LENGTH 함수로 다양한 문자의 크기 반환
SELECT LENGTH('A'), LENGTH('강'), LENGTH('漢'), LENGTH('◁'), LENGTH(' ');

-- CHAR_LENGTH 함수로 문자열의 개수 반환
SELECT CHAR_LENGTH('Do it! MySQL'), CHAR_LENGTH('두잇 마이에스큐엘');

-- LENGTH와 CHAR_LENGTH 함수에 열 이름 전달
SELECT first_name, LENGTH(first_name), CHAR_LENGTH(first_name) FROM customer;

/*특정 문자까지의 문자열 길이를 반환하는 함수(POSITION)*/
-- POSITION 함수로 특정 문자까지의 크기 반환
SELECT 'Do it!! SQL', POSITION('!' IN 'Do it!! MySQL');

-- 탐색 문자가 없는 경우
SELECT 'Do it!! SQL', POSITION('#' IN 'Do it!! MySQL');

-- LEFT와 RIGHT 함수로 왼쪽과 오른쪽 2개의 문자열 반환
SELECT 'Do it! MySQL', LEFT('Do it! MySQL', 2), RIGHT('Do it! MySQL', 2);

/*지정한 범위의 문자열을 반환하는 함수(SUBSTRING)*/
-- SUBSTRING 함수로 지정한 범위의 문자열 반환
SELECT 'Do it! MySQL', SUBSTRING('Do it! MySQL', 4, 2);

-- SUBSTRING 함수에 열 이름 전달
SELECT first_name, SUBSTRING(first_name, 2, 3) FROM customer;

-- SUBSTRING과 POSITOIN 함수 조합
SELECT SUBSTRING('abc@email.com', 1, POSITION('@' IN 'abc@email.com') -1);

/*특정 문자를 다른 문자로 대체하는 함수(REPLACE)*/
-- REPLACE 함수로 문자 변경
SELECT first_name, REPLACE(first_name, 'A', 'C') FROM customer WHERE first_name LIKE 'A%';

-- REPEAT 함수로 문자 반복
SELECT REPEAT('0', 10);

-- REPEAT과 REPLACE 함수 조합
SELECT first_name, REPLACE(first_name, 'A', REPEAT('C', 10)) FROM customer WHERE first_name LIKE '%A%';

/*공백 문자를 생성하는 함수(SPACE)*/
-- SPACE 함수로 공백 문자 반복
SELECT CONCAT(first_name, SPACE(10), last_name) FROM customer;

/*문자열을 역순으로 출력하는 함수(REVERSE)*/
-- REVERSE 함수로 문자열을 역순으로 반환
SELECT 'Do it! MySQL', REVERSE('Do it! MySQL');

-- REVERSE 함수와 다른 여러 함수 조합
WITH ip_list (ip)
AS (
	SELECT '192.168.0.1' UNION ALL
	SELECT '10.6.100.99' UNION ALL
	SELECT '8.8.8.8' UNION ALL
	SELECT '192.200.212.113'
)
SELECT 
	ip, SUBSTRING(ip, 1, CHAR_LENGTH(ip) - POSITION('.' IN REVERSE(ip)))
FROM ip_list;

/*문자열을 비교하는 함수(STRCMP)*/
-- STRCMP 함수로 두 문자열을 비교: 동일한 경우
SELECT STRCMP('Do it! MySQL', 'Do it! MySQL');

-- STRCMP 함수로 두 문자열을 비교: 동일하지 않은 경우
SELECT STRCMP('Do it! MySQL', 'Do it! MySQL!');


# 날짜 함수
/*서버의 현재 날짜나 시간을 반환하는 다양한 함수*/
-- 날짜 함수로 현재 날짜나 시간 반환
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP(), NOW();

-- 정밀한 시각을 반환
SELECT CURRENT_DATE(), CURRENT_TIME(3), CURRENT_TIMESTAMP(3), NOW(3);

-- UTC_DATE, UTC_TIME, UTC_TIMESTAMP 함수로 세계 표준 날짜나 시간 반환
SELECT CURRENT_TIMESTAMP(3), UTC_DATE(), UTC_TIME(3), UTC_TIMESTAMP(3);

/*날짜를 더하거나 빼는 함수(DATE_ADD, DATE_SUB)*/
-- DATE_ADD 함수로 1년 증가한 날짜 반환
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR);

-- DATE_ADD 함수로 1년 감소한 날짜 반환
SELECT NOW(), DATE_ADD(NOW(), INTERVAL -1 YEAR);

-- DATE_SUB 함수로 1년 감소한 날짜 반환
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 1 YEAR), DATE_SUB(NOW(), INTERVAL -1 YEAR);

/*날짜 간 차이를 구하는 함수(DATEDIFF, TIMESTAMPDIFF)*/
-- DATEDIFF 함수로 날짜 간의 일수 차 반환
SELECT DATEDIFF('2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

-- TIMESTAMPDIFF 함수로 날짜 간의 개월 수 차 반환
SELECT TIMESTAMPDIFF(MONTH, '2023-12-31 23:59:59.9999999', '2023-01-01 00:00:00.0000000');

/*지정한 날짜의 요일을 반환하는 함수(DAYNAME)*/
-- DAYNAME 함수로 특정 날짜의 요일 반환
SELECT DAYNAME('2023-08-20');

/*날짜에서 연,월,주,일을 값으로 가져오는 함수(YEAR, MONTH, WEEK, DAY)*/
-- YEAR, MONTH, WEEK, DAY 함수로 연, 월, 주, 일을 별도의 값으로 반환
SELECT
	YEAR('2023-08-20'),
	MONTH('2023-08-20'),
	WEEK('2023-08-20'),
	DAY('2023-08-20');

/*날짜 형식을 변환하는 함수(DATE_FORMAT, GET_FORMAT)*/
-- DATE_FORMAT 함수로 날짜 형식 변경
SELECT DATE_FORMAT('2023-08-20 20:23:01', '%m/%d/%Y');

-- GET_FORMAT 함수로 국가나 지역별 날짜 형식 확인
SELECT 
	GET_FORMAT(DATE, 'USA') AS USA,
	GET_FORMAT(DATE, 'JIS') AS JIS,
	GET_FORMAT(DATE, 'EUR') AS Europe,
	GET_FORMAT(DATE, 'ISO') AS ISO,
	GET_FORMAT(DATE, 'INTERNAL') AS INTERNAL;

-- DATE_FORMAT과 GET_FORMAT 함수 조합
SELECT 
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'USA')) AS USA,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'JIS')) AS JIS,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'EUR'))AS Europe,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'ISO')) AS ISO,
	DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'INTERNAL')) AS INTERNAL;
    

# 집계 함수
/*조건에 맞는 데이터 개수를 세는 함수(COUNT)*/
-- COUNT 함수로 데이터 개수 집계
SELECT COUNT(*) FROM customer;

-- COUNT 함수와 GROUP BY 문 조합
SELECT store_id, COUNT(*) AS cnt FROM customer GROUP BY store_id;

-- COUNT 함수와 GROUP BY 문 조합: 열 2개 활용
SELECT store_id, active, COUNT(*) AS cnt FROM customer GROUP BY store_id, active;

-- NULL을 제외한 집계 확인
SELECT COUNT(*) AS all_cnt, COUNT(address2) AS ex_null FROM address;

-- COUNT 함수와 DISTINCT 문 조합
SELECT COUNT(*), COUNT(store_id), COUNT(DISTINCT store_id) FROM customer;

/*데이터의 합을 구하는 함수(SUM)*/
-- SUM 함수로 amount 열의 데이터 합산
SELECT SUM(amount) FROM payment;

-- SUM 함수와 GROUP BY 문 조합
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id;

-- 암시적 형 변환으로 오버플로 없이 합산 결과를 반환
CREATE TABLE doit_overflow (
col_1 int,
col_2 int,
col_3 int
);

INSERT INTO doit_overflow VALUES (1000000000,1000000000, 1000000000);
INSERT INTO doit_overflow VALUES (1000000000,1000000000, 1000000000);
INSERT INTO doit_overflow VALUES (1000000000,1000000000, 1000000000);

SELECT SUM(col_1) FROM doit_overflow;

/*데이터의 평균을 구하는 함수(AVG)*/
-- AVG 함수로 amount 열의 데이터 평균 계산
SELECT AVG(amount) FROM payment;

-- AVG 함수와 GROUP BY 문 조합
SELECT customer_id, AVG(amount) FROM payment GROUP BY customer_id;

/*최솟값 또는 최댓값을 구하는 함수(MIN,MAX)*/
-- MIN과 MAX 함수로 amount 열의 최솟값과 최댓값 조회
SELECT MIN(amount), MAX(amount) FROM payment;

-- MIN과 MAX 함수 그리고 GROUP BY 문 조합
SELECT customer_id, MIN(amount), MAX(amount) FROM payment GROUP BY customer_id;

/*부분합과 총합을 구하는 함수(ROLLUP)*/
-- ROLLUP 함수로 부분합 계산
SELECT 
	customer_id, staff_id, SUM(amount)
FROM payment
GROUP BY customer_id, staff_id WITH ROLLUP;

/*데이터의 표준편차를 구하는 함수(STDDEV, STDDEV_SAMP)*/
-- STDDEV와 STDDEV_SAMP 함수로 표준편차 계산
SELECT STDDEV(amount), STDDEV_SAMP(amount) FROM payment;

# 수학 함수
/*절댓값을 구하는 함수(ABS)*/
-- ABS 함수에 입력한 숫자를 절댓값으로 반환
SELECT ABS(-1.0), ABS(0.0), ABS(1.0);

-- ABS 함수에 입력한 수식의 결과를 절댓값으로 반환
SELECT 
	a.amount - b.amount AS amount, ABS(a.amount - b.amount) AS abs_amount
FROM payment AS a
	INNER JOIN payment AS b ON a.payment_id = b.payment_id-1;

-- 암시적 형 변환으로 오버플로 없이 절댓값을 반환
SELECT ABS(-2147483648);

/*양수 또는 음수 여부를 판단하는 함수(SIGN)*/
-- SIGN 함수로 입력한 숫자가 양수, 음수, 0인지를 판단
SELECT SIGN(-256), SIGN(0), SIGN(256);

-- SIGN 함수로 수식의 결과가 양수, 음수, 0인지를 판단
SELECT 
	a.amount - b.amount AS amount, SIGN(a.amount - b.amount) AS abs_amount
FROM payment AS a
	INNER JOIN payment AS b ON a.payment_id = b.payment_id-1;

/*천장값과 바닥값을 구하는 함수(CEILING, FLOOT)*/
-- CEILING 함수로 천장값 반환
SELECT CEILING(2.4), CEILING(-2.4), CEILING(0.0);

-- FLOOR 함수로 바닥값 반환
SELECT FLOOR(2.4), FLOOR(-2.4), FLOOR(0.0);

/*반올림을 반환하는 함수(ROUND)*/
-- ROUND 함수로 소수점 셋째 자리까지 반올림
SELECT ROUND(99.9994, 3), ROUND(99.9995, 3);

-- ROUND 함수로 소수와 정수를 따로 반올림
SELECT ROUND(234.4545, 2), ROUND(234.4545, -2);

-- 정수 부분의 길이보다 큰 자릿수를 입력한 경우
SELECT ROUND(748.58, -1);
SELECT ROUND(748.58, -2);
SELECT ROUND(748.58, -4);

/*로그를 구하는 함수(LOG)*/
-- LOG 함수로 로그 10을 계산
SELECT LOG(10);

-- LOG 함수로 로그 10의 5를 계산
SELECT LOG(10, 5);

/*e의 n 제곱값을 구하는 함수(EXP)*/
-- EXP 함수로 지수 1.0을 계산
SELECT EXP(1.0);

-- EXP 함수로 지수 10을 계산
SELECT EXP(10);

-- LOG 함수와 EXP 함수로 결과 확인
SELECT EXP(LOG(20)), LOG(EXP(20));

/*거듭제곱값을 구하는 함수(POWER)*/
-- POWER 함수로 거듭제곱 계산
SELECT POWER(2,3), POWER(2,10), POWER(2.0, 3);

/*제곱근을 구하는 함수(SQRT)*/
-- SQRT 함수로 제곱근 계산
SELECT SQRT(1.00), SQRT(10.00);

/*난수를 구하는 함수(RAND)*/
-- RAND 함수로 난수 계산
SELECT RAND(100), RAND(), RAND();

-- 인수가 없는 RAND 함수로 난수 계산
DELIMITER $$

CREATE PROCEDURE rnd()
BEGIN
	DECLARE counter INT;
	
	SET counter = 1;
	
	WHILE counter < 5 DO
		SELECT RAND() Random_Number;
	
		SET counter = counter + 1;
	END WHILE;

END $$

DELIMITER ;

call rnd();

/*삼각 함수(COS, SIN, TAN, ATAN)*/
-- COS 함수 계산
SELECT COS(14.78);

-- SIN 함수 계산
SELECT SIN(45.175643);

-- TAN 함수 계산
SELECT TAN(PI()/2), TAN(.45)

-- ATAN 함수 계산
SELECT 
	ATAN(45.87) AS atanCalc1,
	ATAN(-181.01) AS atanCalc2,
	ATAN(0) AS atanCalc3,
	ATAN(0.1472738) AS atanCalc4,
	ATAN(197.1099392) AS atanCalc5;
    
    
# 순위 함수
/*유일한 값으로 순위를 부여하는 함수(ROW_NUMBER)*/
-- ROW_NUMBER 함수로 순위 부여
SELECT 
	ROW_NUMBER() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- 내림차순 정렬한 결과에 ROW_NUMBER 함수로 순위 부여
SELECT 
	ROW_NUMBER() OVER(ORDER BY amount DESC, customer_id DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

-- PARTITION BY 문으로 사용해 그룹별 순위 부여
SELECT 
	staff_id,
	ROW_NUMBER() OVER(PARTITION BY staff_id ORDER BY amount DESC, customer_id ASC) AS num, 
	customer_id, 
	amount
FROM (
	SELECT 
		customer_id, staff_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id, staff_id
	) AS x;

/*우선순위를 고려하지 않고 순위를 부여하는 함수(RANK)*/
-- RANK 함수로 순위 부여
SELECT 
	RANK() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

/*건너뛰지 않고 순위를 부여하는 함수(DENSE_RANK)*/
-- DENSE_RANK 함수로 순위 부여
SELECT 
	DENSE_RANK() OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;

/*그룹 순위를 부여하는 함수(NTILE)*/
-- 내림차순으로 정렬한 결과에 NTILE 함수로 순위 부여
SELECT 
	NTILE(100) OVER(ORDER BY amount DESC) AS num, customer_id, amount
FROM (
	SELECT 
		customer_id, SUM(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS x;
    
    # 분석 함수
    /*앞 또는 뒤 행을 참조하는 함수(LAG, LEAD)*/
    -- LAG와 LEAD 함수로 앞뒤 행 참조
SELECT 
	x.payment_date,
	LAG(x.amount) OVER(ORDER BY x.payment_date ASC) AS lag_amount, amount,
	LEAD(x.amount) OVER(ORDER BY x.payment_date ASC) AS lead_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
	) AS x
ORDER BY x.payment_date;

-- LAG와 LEAD 함수로 2칸씩 앞뒤 행 참조
SELECT 
	x.payment_date,
	LAG(x.amount, 2) OVER(ORDER BY x.payment_date ASC) AS lag_amount, amount,
	LEAD(x.amount, 2) OVER(ORDER BY x.payment_date ASC) AS lead_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
) AS x
ORDER BY x.payment_date;

/*누적 분포를 계산하는 함수(CUME_DIST)*/
-- CUME_DIST 함수로 누적 분폿값 계산
SELECT 
	x.customer_id, x.amount, CUME_DIST() OVER(ORDER BY x.amount DESC)
FROM (
	SELECT 
		customer_id, sum(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS X
ORDER BY x.amount DESC;

/*상대 순위를 계산하는 함수(PERCENT_RANK)*/
-- PERCENT_RANK 함수로 상위 분포 순위를 계산
SELECT 
	x.customer_id, x.amount, PERCENT_RANK() OVER (ORDER BY x.amount DESC)
FROM (
	SELECT 
		customer_id, sum(amount) AS amount
	FROM payment GROUP BY customer_id
	) AS X
ORDER BY x.amount DESC;

/*첫 행 또는 마지막 행의 값을 구하는 함수(FIRST_VALUE, LAST_VALUE)*/
-- FIRST_VALUE 함수로 가장 높은 값 조회
SELECT 
	x.payment_date, x.amount,
	FIRST_VALUE(x.amount) OVER(ORDER BY x.payment_date) AS f_value,
	LAST_VALUE(x.amount) OVER(ORDER BY x.payment_date RANGE BETWEEN UNBOUNDED
	PRECEDING AND UNBOUNDED FOLLOWING) AS l_value,
	x.amount - FIRST_VALUE(x.amount) OVER(ORDER BY x.payment_date) AS increase_amount
FROM (
	SELECT 
		date_format(payment_date, '%y-%m-%d') AS payment_date,
		SUM(amount) AS amount
	FROM payment 
	GROUP BY date_format(payment_date, '%y-%m-%d')
	) AS x
ORDER BY x.payment_date;
