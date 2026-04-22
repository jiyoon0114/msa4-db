-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 칼럼만 출력
-- ``으로 감싸면 칼럼으로써 인식시킨다라는 의미
SELECT
  emp_id
 ,`name` 
 ,gender 
FROM employees;

-- 테이블 전체 칼럼 조회: *(asterisk)
SELECT *
FROM employees;

-- WHERE 절: 특정 컬럼의 값이 일치한 데이터만 조회
-- emp_id 칼럼이 1009번인 레코드 보여줘
SELECT *
FROM employees
WHERE emp_id = 10008;

SELECT *
FROM employees
WHERE `name` = '조은혜';

-- 스트링 방식으로 전달만 하면 데이터타입을 알아서 바꿔줌! (매우 편함)
SELECT * 
FROM employees
WHERE birth >= '1990-01-01';

SELECT *
FROM employees
WHERE fire_at IS NULL;

SELECT *
FROM employees
WHERE fire_at IS not NULL;

