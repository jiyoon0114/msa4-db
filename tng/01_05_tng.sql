-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles;

-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.

SELECT 
	emp_id
FROM salaries
WHERE 
	salary <= 60000000
	AND end_at IS NULL
;

-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT 
	emp_id
FROM salaries
WHERE
	salary BETWEEN 60000000 AND 70000000
	AND end_at IS null
;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT *
FROM employees
WHERE emp_id IN (10001, 10005);

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT 
	title_code
	,title
FROM titles
WHERE title LIKE '%사%';
	
-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT 
	`name`
FROM employees
ORDER BY `name`;
	
-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT
	AVG(salary)
FROM salaries
GROUP BY emp_id;

-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT
	emp_id
	,AVG(salary)
FROM salaries
GROUP BY emp_id
	HAVING 
		AVG(salary) BETWEEN 30000000 AND 50000000
;

-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.

SELECT 
	emp_id
	,`name`
	,gender
FROM employees
WHERE emp_id IN (
	SELECT emp_id
	FROM salaries
	GROUP BY salaries.emp_id
		HAVING AVG(salary) >= 70000000
)
;
-- 10. 현재 직급이 'T005'인,
--   사원의 사원번호와 이름을 조회해 주세요.

SELECT 
	emp_id
	,`name`
FROM employees
WHERE emp_id IN (
	SELECT emp_id
	FROM title_emps
	WHERE 
		title_emps.title_code = 'T005'
		AND title_emps.end_at IS NULL
);
