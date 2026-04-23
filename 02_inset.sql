-- insert 문
-- DML중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리

-- INSERT INTO 테이블 명[(칼럼1, 칼럼2...)]
-- VALUES (값1, 값2 ...);

-- auto increment는 중간에 데이터 삭제했다고 수가 줄어들고 그러지 않음
INSERT INTO employees (
-- emp_id는 auto increment이라서 자동으로 값이 증가함
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
)
VALUES (
	'한지윤'
	,'2004-01-14'
	,'F'
	,NOW()
	,NULL 
	,NULL 
	,NOW()
	,NOW()	
);

SELECT *
FROM employees
ORDER BY emp_id DESC
LIMIT 1
;