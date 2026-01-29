# LMS에 대한 테이블을 생성하고 있는 더미데이터 입력(CRUD)

SHOW databases; # LMS만 보인다.
USE LMS;

CREATE TABLE members( # mbmbers 테이블생성
	# 필드명    타입 옵션
	id        INT AUTO_INCREMENT PRIMARY KEY,
    #         정수 자동번호생성기   기본키(다른테이블과 연결용)
    uid       VARCHAR(50) NOT NULL UNIQUE,
    #         가변문자(50자) 공백비허용 유일한값
    password  VARCHAR(255) NOT NULL,
    name      VARCHAR(50) NOT NULL,
    role      ENUM('admin', 'manager', 'user') DEFAULT 'user',
    #		  열거타입(괄호안에 글자만 허용)		   기본값은 user
    active    BOOLEAN DEFAULT TRUE,
	#		  불린타입           기본값
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    # 생성일     날짜시간타입        기본값은 시스템시간
);

# 더미데이터 
INSERT INTO members(uid, password, name, role, active)
VALUES('kkw','1234','김기원','admin',true);
INSERT INTO members(uid, password, name, role, active)
VALUES('lhj','5678','임효정','manager',true);
INSERT INTO members(uid, password, name, role, active)
VALUES('kdg','1111','김도균','user',true);
INSERT INTO members(uid, password, name, role, active)
VALUES('ksb','2222','김수빈','user',true);
INSERT INTO members(uid, password, name, role, active)
VALUES('kjy','3333','김지영','user',true);
INSERT INTO members(uid, password, name, role, active)
VALUES('rhl','5555','노형래','admin',true);

# 더미데이터 출력
select * from members; # 전체 출력
SELECT * FROM members WHERE uid = 'kkw' and password = '1234' and active = true;
# 로그인 할 때

# 더미데이터 수정
UPDATE members set password = '1111' WHERE uid = 'kkw'

/* # 회원삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set active = false WHERE uid = 'kkw'; # 회원비활성화
*/

CREATE TABLE scores(
	id        INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    korean    INT NOT NULL,
    english   INT NOT NULL,
    math      INT NOT NULL,
    total     INT NOT NULL,
    average   FLOAT NOT NULL,
    grade     CHAR(1) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (member_id) REFERENCES members(id)
    # 외래키		내가 갖은 필드와 연결        테이블    필드
);

# 후보키 : 공백이 없고, 유일해야 되는 필드들(학번, 주민번호, id, email, 전화번호......)
# PRIMARY KEY : 기본키로 공백이 없고, 유일해야되며 인덱싱이 되어 있는 옵션.
# 인덱싱 : db에서 빠른 찾기를 위한 옵션.
# 외래키(FOREIGN KEY) : 다른 테이블과 연결이 되는 키!!!
# 외래키는 자식이고 기본키는 부모
# members가 부모임으로 kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을 수 있다.
# members 테이블에 id와 scores 테이블의 member_id는 타입 일치 필수!!!

SELECT DATABASE();

INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(6,99,99,99,297,99,'A');
INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(7,88,88,88,264,88,'B');
INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(8,77,77,77,231,77,'C');
INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(9,66,66,66,198,66,'F');
INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(14,80,80,80,240,80,'B');
INSERT INTO scores(member_id, korean, english, math, total, average, grade)
VALUES(16,100,100,100,300,100,'A');

SELECT * FROM scores;

# 기본 정보 조회(INNER JOIN)
# 성적 데이터가 존재하는 회원만 조회합니다. 이름, 과목 점수, 평균, 등급을 가져오는 쿼리.

SELECT
	m.name AS 이름,
    m.UID AS 아이디,
    s.korean AS 국어,
    s.english AS 영어,
    s.math AS 수학,
    s.total AS 총점,
    s.average AS 평균,
    s.grade AS 등급
FROM members m
# Aliasing(별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 주면 쿼리가 간결해짐
JOIN scores s ON m.id = s.member_id;
# ON 조건 : m.id = s.member_id와 같이 두 테이블을 연결하는 핵심 키(PK - FK)를 정확히 지정.

DELETE FROM scores WHERE member_id = 2;

# 성적이 없는 회원도 포함 조회(LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용합니다.
# 성적이 없으면 NULL로 표시됩니다.alter
SELECT
	m.name AS 이름,
    m.role AS 역할,
	s.average AS 평균,
    s.grade AS 등급,
    IFNULL(s.grade, '미산출') AS 상태 # 성적이 없으면 '미산출' 표시
FROM members m
LEFT JOIN scores s ON m.id = s.member_id;

CREATE TABLE boards(
	id        INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    title     VARCHAR(200) NOT NULL,
    content   TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (member_id) REFERENCES members(id)
);

INSERT INTO boards (member_id, title, content)
VALUES(6,'제목1','내용1');
INSERT INTO boards (member_id, title, content)
VALUES(7,'제목3','내용3');
INSERT INTO boards (member_id, title, content)
VALUES(8,'ㅋㅋㅋㅋㅋ','ㅎㅎㅎㅎㅎㅎ');
INSERT INTO boards (member_id, title, content)
VALUES(8,'크ㅡ크','흐ㅡ흐');
INSERT INTO boards (member_id, title, content)
VALUES(14,'배고프다','밥먹고싶다');

SELECT * FROM boards;

# 게시글 목록 조회(INNER KOIN)
SELECT
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자, -- members 테이블에서 가져옴
    b.created_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id = m.id
ORDER BY b.created_at DESC; -- 최신글 순으로 정렬

# 특정 사용자의 글만 조회(WHERE 절 조합)
SELECT
	b.title,
    b.content,
    m.name AS 작성자, -- members 테이블에서 가져옴
    b.created_at
FROM boards b
JOIN members m ON b.member_id = m.id
WHERE m.uid = 'lhj'; -- 특정 아이디를 가진 유저의 글만 필터링

# 관리자용 : 통계 조회(GROUP BY 조합)
SELECT
	m.name,
    m.uid,
    COUNT(b.id) AS 작성글수 #GROUP BY와 셋트
FROM members m
LEFT JOIN boards b ON m.id = b.member_id
GROUP BY m.id;
# WHERE m.name LIKE '%검색어%' OR b.title LIKE '%이름%'