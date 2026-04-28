-- --------------------------------------------
-- JOIN문
-- 두개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력
-- --------------------------------------------

-- --------------------------------------------
-- INNER JOIN (교집합)
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- -- --------------------------------------------
-- 전 사원의 사번, 이름 현재급여를 출력해주세요
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
-- 드라이빙 테이블
FROM employees emp
-- 앞에 inner는 생략 가능 그냥 join도 inner로 침
-- 드리브 테이블
	INNER JOIN salaries sal
-- 	조인할때의 조건 on에 적음
		ON emp.emp_id = sal.emp_id
WHERE
	sal.end_at IS null
;

-- 예전버전 inner join 요즘은 안씀
-- SELECT
-- 	emp.emp_id
-- 	,emp.`name`
-- 	,sal.salary
-- -- 드라이빙 테이블
-- FROM employees emp, salaries sal
-- WHERE
-- 		emp.emp_id = sal.emp_id
-- 	and sal.end_at IS null
-- ;


-- 재직중인 사원의 사번, 이름, 생일, 부서명
-- 테이블 3개 조인 bbmv
SELECT
	emp.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL
	JOIN departments dept
		ON dee.dept_code = dept.dept_code
;


-- --------------------------------------------
-- LEFT JOIN 
-- 왼쪽 테이블 내용은 다 출력하고 왼쪽에 포함되지 않은 
-- 오른쪽 테이블은 null로 나오게 만든다
-- -- -----------------------------------------

SELECT *
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
-- 		inner join을 할때는 where에 하나 on절에 조건을 적나 똑같음
-- 		but left or right join을 할때는 on절에 적는게 더 성능이 좋음
			AND sal.end_at IS NULL
;


-- --------------------------------------------
-- UNION
-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION 		(중복 레코드 제거)
-- UNION ALL   (중복 레코드 제거 안함)
-- --------------------------------------------

-- 중복되는 레코드 삭제함
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION 
SELECT * FROM employees WHERE emp_id IN (1, 5);

-- 중복되는 레코드 삭제 안함
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION ALL 
SELECT * FROM employees WHERE emp_id IN (1, 5);


-- --------------------------------------------
-- SELF JOIN
-- 같은 테이블 끼리 join
-- --------------------------------------------

-- 몇번 사원의 사수는 무슨 정보를 가지고 있는지 알고 싶다
SELECT
	emp.emp_id
	,emp.`name`
	,supe.*
FROM employees emp
	JOIN employees supe
		ON emp.sup_id = supe.emp_id
			AND emp.sup_id IS NOT NULL
;





