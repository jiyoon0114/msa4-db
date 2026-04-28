-- update 문
-- DML 중 하나로 저장되어있는 기존 데이터를 수정하기 위해 사용하는 쿼리

-- UPDATE 테이블명
-- SET 
-- 	컬럼1 = 값1
-- 	,칼럼2 = 값2
-- 	[....]
-- [WHERE 조건];

-- update하기 전에 select해서 한번 보고 내가 수정할 데이터가 맞는지 봐보기
SELECT * 
FROM employees
WHERE
	emp_id = 100005
; 

UPDATE employees
SET 
	`name` = '반장님'
WHERE 
	emp_id = 100005
;

-- 100005번 사원의 생일을 '2020-01-01', 이름을 마이콜로 변경

UPDATE employees
SET 
	`name` = '마이콜'
	,birth = '2020-01-01'
WHERE 
	emp_id = 100005
;

SELECT * 
FROM employees
WHERE
	emp_id = 100005
;