-- 내장 함수

-- 데이터 타입 변환 -> 캐스팅  함수
-- int 1234 데이터를 char로 바꿔줘
SELECT CAST(1234 AS CHAR(4));
SELECT CONVERT(1234, CHAR(4));

-- 제어 흐름 함수 -> mysql에서만 제공해줌
-- if(조건식 , true일때 리턴값 false일때 리턴값)
SELECT 
	`name`
	,gender
	,if(gender = 'M', '남자','여자') AS ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2)
-- 수식1이 null이면 수식2를 반환, 아니면 수식1을 반환
-- 퇴사한 사람이면 되사 날짜, null이면 재직중이라고 뜨게하기
SELECT
	IFNULL(fire_at, '재직중')
FROM employees
;

-- NULLIF(수식1, 수식2)
-- 	수식1과 수식2를 비교, 같으면 NULL을 반환, 
-- 	다르면 수식1을 반환
SELECT
	NULLIF(gender, 'M')
FROM employees
;

-- case문: case ~ when ~ else ~end
-- 	다중분기를 위해 사용
SELECT 
	case gender  
		when 'M' then '남자'
		when 'Z' then '선택안함'
		ELSE '여자'
	END AS ko_gender
FROM employees
;


-- -----------
-- 문자열 함수
-- -----------

-- 문자열 연결
SELECT CONCAT('안녕', ' ','하세요');
SELECT CONCAT(`NAME`, gender) FROM employees;

-- 구분자로 문자열 연결
SELECT CONCAT_WS(', ', '안녕', '하세요', '.');
-- 문자열만 되는데 mysql에서 자동 형변환을 사용해서 다르게 해줌
SELECT CONCAT_WS(', ', `name`, gender) AS '문자열합치기' FROM employees;


-- 숫자에 자릿수(,) 및 표시, 소수점 자리수도 표시 -> 문자열로 가져오기 때문에 DB에서 이런거 잘 안함
SELECT FORMAT(salary, 1) FROM salaries;

-- 문자열의 왼쪽과 오른쪽부터 길이만큼 잘라 반환
SELECT LEFT('123456', 2);
SELECT right('123456', 2);

-- 영어를 대/소문자로 변경
SELECT UPPER('asdDFs'), LOWER('asdDFs');

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD(emp_id, 10, '0') FROM employees;
SELECT RPAD(emp_id, 10, '0') FROM employees;


-- 좌/우 공백 제거
SELECT '        sdsd ', TRIM('        sdsd ');
select LTRIM('        sdsd '), RTRIM('        sdsd ');


-- 특정 문자열을 지우기 -> 중간에 있는 문자는 안 지워짐
-- 앞에 ab가 없어짐
SELECT TRIM(LEADING 'ab' FROM 'abcdab');
-- 뒤에 ab가 없어짐
SELECT TRIM(TRAILING 'ab' FROM 'abcdab');
-- 양쪽다 없애고 싶다
SELECT TRIM(BOTH 'ab' FROM 'abcdab');

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2); 

-- 왼쪽부터 구분자가 횟수번째만큼 나오면 그 이후 버림
-- 숫자가 음수면 뒤부터 시작, 양수는 앞부터 세기 시작
SELECT SUBSTRING_INDEX(
	'meerkat_HTML_CSS.html'
	,'.'
	,1
) AS txt;

-- -----------
-- 수학 함수
-- -----------
-- 올림, 반올림, 버림
SELECT CEILING(1.4), ROUND(1.5), FLOOR(1.6);

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버림
SELECT TRUNCATE(1.19, 0);

-- ---------------------------
-- 날짜 및 시간 관련 함수
-- ---------------------------

-- 현재 날짜/시간 반환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();

-- 데이트 타입의 값을 'YYYY-MM-DD'양식으로 변환
SELECT DATE(NOW());

-- 날짜1에 단위기간에 따라 더한 날짜/시간를 반환 -> 날짜에 더하기 빼기
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 MONTH);
SELECT ADDDATE(NOW(), INTERVAL -1 DAY);
SELECT ADDDATE(NOW(), INTERVAL -1 HOUR);
SELECT ADDDATE(NOW(), INTERVAL -1 MINUTE);
SELECT ADDDATE(NOW(), INTERVAL -1 SECOND); 
SELECT ADDDATE(NOW(), INTERVAL -1 MICROSECOND);

-- --------------------
-- 집계함수
-- --------------------
-- 목요일에 했음

-- --------------------
-- 순위함수
-- --------------------

-- rank() over(order by 칼럼 desc/asc)
-- 지정한 칼럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우는 동일한 순위를 부여함 -> 공동 우승자
SELECT 
	emp_id
	,salary
	,RANK() OVER(ORDER BY salary DESC) AS 'RANK'
FROM salaries
WHERE 
	end_at IS null
LIMIT 10
;

-- row_number -> 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여 -> 공동 수상 없음
SELECT 
	emp_id
	,salary
	,ROW_NUMBER() OVER(ORDER BY salary DESC) AS 'row_num'
FROM salaries
WHERE 
	end_at IS null
LIMIT 10
;











