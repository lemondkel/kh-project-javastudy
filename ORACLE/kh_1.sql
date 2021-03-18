SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT EMP_NAME,DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
SELECT EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);


SELECT EMP_NAME, DEPT_CODE,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID);

SELECT DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
GROUP BY DEPT_TITLE;

SELECT * FROM EMPLOYEE;


--1 주민번호가 1970년대생이면서 성별이 여자이고, 성이 전씨인 직원들의
--사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급명 
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE 
(SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79) AND 
SUBSTR(EMP_NO,8,1)=2 AND 
SUBSTR(EMP_NAME,1,1)='전';

--2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID, EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
WHERE EMP_NAME LIKE '%형%';

--@@@@@@@@@@
--3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME 사원명, JOB_NAME 직급명, DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
WHERE DEPT_TITLE LIKE '해외영업%';

--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME 사원명,BONUS 보너스포인트,DEPT_TITLE 부서명,LOCAL_NAME 근무지역명 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
LEFT JOIN LOCATION ON (LOCAL_CODE=LOCATION_ID)
WHERE BONUS IS NOT NULL;

--5.부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME 사원명, JOB_NAME 직급명,DEPT_TITLE 부서명,LOCAL_NAME 근무지역명
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
JOIN LOCATION ON (LOCAL_CODE=LOCATION_ID)
WHERE DEPT_CODE = 'D2';

--6. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID=DEPT_CODE)
JOIN LOCATION ON (LOCAL_CODE=LOCATION_ID)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국','일본');

--7.같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (SELF JOIN 사용)
SELECT E1.EMP_NAME 사원명, D1.DEPT_TITLE 부서명,E2.EMP_NAME 동료이름 
FROM EMPLOYEE E1
JOIN DEPARTMENT D1 ON (DEPT_ID = DEPT_CODE)
JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE)
WHERE E1.EMP_NAME != E2.EMP_NAME
ORDER BY 1;

--8. 보너스포인트가 없는 직원등 중에서
--직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오
--단, JOIN 과 IN 사용할 것
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME IN ('차장','사원') AND BONUS IS NULL;

SELECT * FROM EMPLOYEE;
SELECT * FROM LOCATION;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM NATIONAL;

-- 부서코드가 D5인 직원 사번, 이름, 부서코드, 급여 출력
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE DEPT_CODE='D5';
--급여가 300만원 이상의 직원의 사번, 이름, 부서코드, 급여 출력
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE SALARY >=3000000;

-- 1. UNION(합집합) : 두 조회결과를 중복된 데이터를 제외하고 합침 + 첫번째 컬럼으로 정렬
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE DEPT_CODE='D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE SALARY >=3000000;

--  2. UNION ALL(합집합) : 중복데이터 포함, 정렬 X
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE DEPT_CODE='D5'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE SALARY >=3000000;

--  3. INTERSECT(교집합) : 여러개의 SELECT결과 중 공통부분만 출력
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE DEPT_CODE='D5'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE SALARY >=3000000;

--  4. MINUS(차집합) : 선행 SELECT에서 다음 SELECT와 겹치지 않는 부분만 출력
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE DEPT_CODE='D5'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE WHERE SALARY >=3000000;

----------------------------------------------------------------------
--면접에서 자주 질문하는 DB문제
-- 1. JOIN / 2.SUBQUERY
--전직원의 평균 급여
SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE;
--직원중에 전직원 평균급여보다 급여가 많은 사람의 이름 조회
SELECT EMP_NAME FROM EMPLOYEE
WHERE SALARY > (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

--  1. 단일행 서브쿼리
--  서브쿼리 조회결과가 (1행 1열) -> 1개의 단일값
-----------------------------------------------------------------
--전지연 직원의 관리자 이름을 출력
--1)전지연 직원의 관리자 이름 출력
SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME ='전지연';
--2)조회된 아이디를 활용해서 매니저 이름 조회
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID=214;
--SUBQUERY
SELECT EMP_NAME 
FROM EMPLOYEE 
WHERE 
EMP_ID=(SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME ='전지연');
--JOIN 
SELECT E2.EMP_NAME
FROM EMPLOYEE E1
JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID)
WHERE E1.EMP_NAME = '전지연';


--  1. 윤은해와 급여가 같은 사람들을 검색해서, 사원번호, 사원이름, 급여를 출력
--  단, 윤은해는 출력 X
SELECT EMP_ID,EMP_NAME,SALARY 
FROM EMPLOYEE 
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해') AND
EMP_NAME NOT IN ('윤은해');

--  2. EMPLOYEE테이블에서 기본급여가 가장 많은사람과 가장 적은사람의 정보를 출력
--  출력정보는 사번, 사원명, 급여
--  1) 메인쿼리가 수행될때 필요한 값
SELECT EMP_ID,EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE)
OR SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--  3. D1, D2 부서에 근무하는 사원들 중 기본급여가 D5부서의 평균급여보다 많은 사람들만
-- 부서번호, 사원번호, 사원명, 급여 출력
SELECT DEPT_CODE, EMP_ID,EMP_NAME,SALARY 
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5')
AND DEPT_CODE IN ('D1','D2');

SELECT * FROM EMPLOYEE;

--  2. 다중행 서브쿼리 : 서버쿼리 조회결과가 행이 여러개인 경우
--  송종기 또는 박나라가 속한 부서에 있는 사원들의 전체 정보
--  송종기가 속한 부서코드
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '송종기';
--  박나라가 속한 부서코드
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '박나라';

SELECT DEPT_CODE  FROM EMPLOYEE WHERE EMP_NAME IN ('송종기','박나라');
--IN
SELECT EMP_NAME, DEPT_CODE,SALARY FROM EMPLOYEE
WHERE 
DEPT_CODE IN (SELECT DEPT_CODE  FROM EMPLOYEE WHERE EMP_NAME IN ('송종기','박나라'));
--NOT IN
SELECT EMP_NAME, DEPT_CODE,SALARY FROM EMPLOYEE
WHERE 
DEPT_CODE NOT IN (SELECT DEPT_CODE  FROM EMPLOYEE WHERE EMP_NAME IN ('송종기','박나라'));

-- 차태연, 전지연 사원의 급여등급(SAL_LEVEL)과 같은 사원의 사원명, 급여 출력
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('차태연','전지연'))
AND EMP_NAME NOT IN ('차태연','전지연');

SELECT * FROM EMPLOYEE;

