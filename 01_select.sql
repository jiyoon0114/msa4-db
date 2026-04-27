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

-- -----------------------------------------------------

-- 출생년도가 1990년인 사원을 조회하기
SELECT *
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
	AND gender = 'M'
;

-- 이름이 '조은혜' 또는 '정유리'인 사원을 조회하기
SELECT
	*		
FROM employees
WHERE
	`name` = '조은혜'
	OR `name` = '정유리'
;

-- 1990년 출생이거나, 이름이 '정유리인 사원을 출력
SELECT
	*
FROM employees
WHERE
	(
	birth >= '1990-01-01'
	AND   birth <= '1990-12-31'
	)
	OR 	`name` = '정유리'
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회
	-- 1990년 출생이거나, 이름이 '정유리인 사원을 출력
SELECT
	*
FROM employees
WHERE
	birth BETWEEN '1990-01-01' AND '1990-12-31'
OR `name` = '정유리'
;

-- 사원번호가 10005, 10010인 사원을 조회하기
SELECT
 	*
FROM employees
WHERE
	emp_id = 10005
	OR emp_id = 10010
;

-- IN 연산자: 다수의 지정한 값과 일치하는 데이터 조회
SELECT
 	*
FROM employees
WHERE
	emp_id IN (10005, 10010)
;

-- LIKE절: 문자열의 내용을 조회
  -- 'ㄱ%', '%ㄱ', '%ㄴ%': 해당 문자열이 포함된 데이터 조회(글자수: 0 ~ n )
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우'   -- '우'로 끝나는 이름
;
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우%'  -- '우'가 이름 안에 들어가는 이름(글자수 상관X)
;

	-- _: 언더바의 개수만큼 "글자수를 허용"해서 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우_'  -- (숫자 상관없이 글자수)우(한 글자)
;
SELECT
	*
FROM employees
WHERE
	`name` LIKE '__우_'  -- (두 글자)우(한 글자)
;

-- ORDER BY 절: 데이터를 정렬
	-- `칼럼1`, `칼럼2`... 여러 개 연결하면, 1번 정렬 결과를 2번 정렬 결과를 3번 정렬...
	-- ASC: 오름차순 / DESC: 내림차순
SELECT
	*
FROM employees
ORDER BY `name`, birth   -- `name`으로 정렬한 그 결과를, `birth`로 정렬
;

SELECT
	*
FROM employees
ORDER BY `name`, birth DESC  -- `name`으로 정렬한 그 결과를, `birth`로 내림차순 정렬
;

-- LIMIT 키워드, OFFSET 키워드
	-- 출력 개수를 제한
	-- LIMIT: 총 출력 개수 / OFFSET: 오프센 다음번호부터 출력

	-- 사번 오름차순으로 정렬된 상위 10명 조회하기
SELECT
	*
FROM employees
ORDER BY emp_id DESC
LIMIT 100
-- WHERE gender = 'M'
;

-- 조회 결과에서 21번째부터 10개를 조회
-- limit 10 offset 20
SELECT
	*
FROM employees
ORDER BY emp_id 
LIMIT 10 OFFSET 20
;

SELECT *
FROM employees
LIMIT 20, 10
;

-- as: 칼럼명 변경 -> 생략 가능함
SELECT 
	sal_id salId
FROM salaries;

-- 집계함수
-- sum(칼럼) : 해당 컬럼의 합계를 출력
-- Max(칼럼) : 해당 커럼의 값중 최대값을 출력
-- min(칼럼): 해당 칼럼의 값중 최소값을 출력
-- avg(칼럼): 해당 컬럼의 평균을 출력
-- salary 데이터를 보면 사번은 동일한 레코드가 많음
-- end_at이 null인 경우만 현재 받는 연봉, 값이 있으면 예전 연봉값
SELECT 
	SUM(salary) AS sum_salary
	,MAX(salary)
	,MIN(salary)
	,AVG(salary)
FROM salaries
WHERE 
	end_at IS null
;

-- count(칼럼 || * ) : 검색 결과의 레코드 수를 출력
-- * : 총 레코드 수를 반환함
-- 칼럼명: 검색 결과 중 해당 컬럼의 값이 null이 아닌 레코드의 총 수
SELECT 
	COUNT(*)
FROM employees
;

SELECT 
	COUNT(fire_at)
FROM employees
;

-- 현재 받고 있는 급여 중 가장 많이 받는 급여와, 가장 적게 받는 급여를 출력
SELECT 
	MAX(salary)  maxSalary
	,MIN(salary) minSalary
FROM salaries
WHERE 
	end_at IS null
;

-- distinct 키워드: 검색결과에서 중복되는 레코드 없이 조회
-- 	속도가 느려서 현업에서 잘 쓰지 않음 
SELECT DISTINCT  
	emp_id
FROM salaries
;

-- group by절, having절
-- group by절: 그룹으로 묶어서 조회
-- having절: 그룹으로 묶을때 조건을 작성
-- 직책별 사원수 
-- 칼럼 여러개로 묶을수도 있음
SELECT 
	-- select절에 작성하는 컬럼은
	-- group by절에서 사용한 컬럼과 집계함수만 작성
	title_code
	,COUNT(*) AS count
FROM title_emps
WHERE 
	end_at IS NULL
GROUP BY title_code
;

-- 직책별 사원수중, 10000명 이상인 직책의 사원수를 출력
SELECT
	title_code
	,COUNT(*) cnt 
FROM title_emps
WHERE 
	end_at IS null
GROUP BY title_code
	HAVING cnt >= 10000
;

-- 퀄리 작성 순서 기본틀
-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]
-- WHERE [쿼리 조건]
-- GROUP BY [컬럼명] HAVING [집계함수 조건]
-- ORDER BY [컬럼명 ASC || 컬럼명 DESC]
-- LIMIT [n] OFFSET [n]
-- ;
