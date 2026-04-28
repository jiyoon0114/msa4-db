-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,tit.title_code
FROM employees emp
	JOIN title_emps tit
		ON emp.emp_id = tit.emp_id
WHERE 
	tit.end_at IS NULL
	AND emp.fire_at IS NULL
;
-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE 
	sal.end_at IS null
	AND emp.fire_at IS NULL
;
-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	employees.`name`
	,salaries.salary
FROM salaries
	JOIN employees
		ON salaries.emp_id = employees.emp_id
WHERE employees.emp_id = 10010
ORDER BY salaries.start_at 
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,dem.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL
			AND emp.fire_at IS NULL  
	JOIN departments dem
		ON dee.dept_code = dem.dept_code
			AND dem.end_at IS NULL 
ORDER BY emp.emp_id
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	emp.fire_at IS null
	AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;

EXPLAIN SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
-- 서브쿼리로 임시테이블을 만들어 메모리에 올림
-- 그로인해 공간복잡도는 올라가지만 조인하는 레코드 수가 줄어들어 시간 복잡도는 줄어듦
	JOIN (
		SELECT 
			sal.emp_id
			,sal.salary
		FROM salaries sal
		where
			sal.end_at IS NULL
		ORDER BY sal.salary DESC
		LIMIT 10
		) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_sal.salary DESC	
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_name
	,emp.`name`
	,emp.hire_at
FROM employees emp
	JOIN department_managers dem
		ON emp.emp_id = dem.emp_id
	JOIN departments dep
		ON dem.dept_code = dep.dept_code
WHERE
	emp.fire_at IS NULL 
	and dem.end_at IS NULL
	and dep.end_at IS NULL
ORDER BY dep.dept_code 
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.

SELECT
	AVG(sal.salary) avg_sal
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
	JOIN titles tit
		ON tite.title_code = tit.title_code
WHERE 
	tit.title = '부장'
	and sal.end_at IS NULL
	AND emp.fire_at IS NULL
	AND tite.end_at IS NULL 
GROUP BY tit.emp_id
;


SELECT
	tie.emp_id
	,AVG(sal.salary) avg_sal	
FROM title_emps tie
	JOIN titles tit
		ON tie.title_code = tit.title_code
			AND tit.title = '부장'
			AND tie.end_at IS NULL
	JOIN salaries sal
		ON tie.emp_id = sal.emp_id
GROUP BY tie.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,AVG(sal.salary) avg_sal
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
	JOIN titles tit
		ON tite.title_code = tit.title_code
WHERE 
	title = '부장'
	and sal.end_at IS NULL
	AND emp.fire_at IS NULL
	AND tite.end_at IS NULL 
GROUP BY emp.emp_id		
;


-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,dem.dept_code
FROM employees emp
	JOIN department_managers dem
		ON emp.emp_id = dem.emp_id
;

SELECT 
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code	
FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
ORDER BY depm.dept_code ASC, depm.start_at
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 
-- 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT
	tit.title
	,CEILING(avg(sal.salary))
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
	JOIN employees emp
		ON tite.emp_id = emp.emp_id
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	tite.end_at IS NULL
	AND sal.end_at IS NULL
	AND emp.fire_at IS NULL
GROUP BY tit.title
	HAVING AVG(salary) >= 60000000
ORDER BY AVG(salary) DESC
;

SELECT 
	tit.title
	,floor(AVG(sal.salary)) avg_sal
FROM title_emps tie
	JOIN salaries sal
		ON tie.emp_id = sal.emp_id
			AND tie.end_at IS NULL
			AND sal.end_at IS NULL
	JOIN titles tit
		ON tie.title_code = tit.title_code
-- group by로 묶지 않고 select 속성으로 쓰면 표준문법에 벗어남
GROUP BY tie.title_code, tit.title
	HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(salary) DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요. 
SELECT
	tite.title_code
	,emp.gender
	,COUNT(gender)
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
WHERE 
	tite.end_at IS null
	and gender = 'F'
GROUP BY tite.title_code
;

-- 10-1 남자 여자 직급별 사원수
SELECT
	tite.title_code
	,emp.gender
	,COUNT(gender)
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
GROUP BY 
	tite.title_code, emp.gender
ORDER BY 
	tite.title_code 
;



