-- 1. 현재 재직 중인 사원의 사번, 이름, 입사일을 조회해 주세요.
SELECT
	emp_id
	,`name`
	,hire_at
FROM employees
WHERE fire_at IS NULL
;

-- 2. 삭제되지 않은 부서 중 현재 운영 중인 부서의 부서코드와 부서명을 조회해 주세요.
SELECT 
	dept_code
	,dept_name
FROM departments
WHERE end_at IS NULL
;

-- 3. 급여 이력 중 2023년 이후 시작된 급여 기록만 조회해 주세요.
SELECT 
	salary
	,start_at
FROM salaries
WHERE 
	start_at >= '2023-01-01'
;
-- 4. 사원 이름에 '민', '지', '현' 중 하나라도 포함된 사원의 사번과 이름을 조회해 주세요.
SELECT
	emp_id
	,`name`
FROM employees
WHERE
	`name` LIKE '%민%'
	OR `name` LIKE '%지%'
	OR `name` LIKE '%현%'
;

-- 5. 현재 급여 기록만 조회해 주세요.
SELECT
	salary
FROM salaries
WHERE end_at IS NULL
;

-- 6. 사원별 평균 급여를 구하고, 평균 급여가 높은 순서대로 조회해 주세요.
SELECT 
	emp_id
	,AVG(salary)
FROM salaries
GROUP BY emp_id
ORDER BY AVG(salary) desc
;

-- 7. 사원별 급여 변경 횟수를 조회해 주세요.
SELECT
	,COUNT(end_at)
FROM salaries
GROUP BY emp_id
;
	

-- 8. 급여가 2번 이상 변경된 사원의 사번과 급여기록개수를 조회해 주세요.
SELECT
	emp_id 
	,COUNT(end_at)
FROM salaries
GROUP BY emp_id
	HAVING COUNT(end_at) >= 2
;

-- 9. 전체 평균 급여보다 높은 급여를 받은 기록을 조회해 주세요.
SELECT
	emp.`name`
	,emp.emp_id
	,sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
WHERE 
	salary > (
		SELECT AVG(salary)
		FROM salaries sal
		WHERE 
			sal.end_at IS NULL
	)
	AND sal.end_at IS NULL
;

-- 10. 현재 급여가 70,000,000 이상인 사원의 사번을 조회해 주세요.
SELECT
	emp_id
FROM employees
WHERE emp_id IN (
	SELECT emp_id
	FROM salaries
	WHERE
		salary >= 70000000
		AND end_at IS null
)
;

-- 11. 가장 높은 급여를 받은 이력이 있는 사원의 사번과 급여를 조회해 주세요.
SELECT
	emp_id
	,salary
FROM salaries
WHERE salary = (
	SELECT 
		MAX(salary)
	FROM salaries
)
;

-- 12. 입사일이 가장 빠른 사원의 사번, 이름, 입사일을 조회해 주세요.
SELECT
	emp_id
	,`name`
	,hire_at
FROM employees
WHERE hire_at = (
	SELECT 
		MIN(hire_at)
	FROM employees
);

-- 13. 현재 직급이 T003 또는 T004 또는 T005인 사원의 사번을 조회해 주세요.
SELECT
	emp_id
FROM title_emps
WHERE (
	title_code IN ('T003','T004','T005')
	AND end_at IS null
);

-- 14. 특정 부서 D001에 현재 소속된 사원의 사번을 조회해 주세요.
SELECT
	emp.emp_id
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
WHERE
	dee.end_at IS NULL 
	AND dee.dept_code = 'D001'
;


-- 15. 부서별 현재 소속 인원 수를 조회해 주세요.
SELECT
	COUNT(emp_id) numDepartment
FROM 
	department_emps
WHERE 
	end_at IS NULL
GROUP BY dept_code
;

-- 16. 현재 소속 인원이 3명 이상인 부서코드를 조회해 주세요.
SELECT
	dept_code
FROM 
	department_emps
WHERE
	COUNT(dept_code) >= 3
;

-- 17. 직급별 현재 인원 수를 조회해 주세요.


-- 18. 현재 부서장인 사원의 사번을 조회해 주세요.


-- 19. 부서장을 맡은 적이 있는 사원 중 중복 없이 사번만 조회해 주세요.


-- 20. 현재 급여가 전체 현재 급여 평균보다 높은 사원의 사번과 급여를 조회해 주세요.