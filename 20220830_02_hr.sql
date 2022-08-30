SELECT USER
FROM DUAL;
--==>> HR

--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--   단 부서명이 'IT'인 직원들만 한정한다.
--  (변경에 대한 결과 확인 후 ROLLBACK 수행한다.)

SELECT *
FROM EMPLOYEES;

/*
103	Alexander	Hunold	    AHUNOLD	590.423.4567	2006/01/03	IT_PROG	9000		102	60
104	Bruce	    Ernst	    BERNST	590.423.4568	2007/05/21	IT_PROG	6000		103	60
105	David	    Austin	    DAUSTIN	590.423.4569	2005/06/25	IT_PROG	4800		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006/02/05	IT_PROG	4800		103	60
107	Diana	    Lorentz	    DLORENTZ	590.423.5567	2007/02/07	IT_PROG	4200		103	60
*/


UPDATE EMPLOYEES
SET = SALARY * 1.1 
WHERE JOB_ID가 IT로 시작;


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1 
WHERE SUBSTR(JOB_ID, 1, 2) = 'IT';
--==>> 5개 행 이(가) 업데이트되었습니다.

ROLLBACK;

-- 확인
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;


-- IT 부서 직원들의 FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID 조회
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE 부서명 = 'IT';

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 부서명이 'IT'인 부서의 부서번호;


SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 60;

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');

/*
Alexander	Hunold	9000	60
Bruce	Ernst	6000	60
David	Austin	4800	60
Valli	Pataballa	4800	60
Diana	Lorentz	4200	60
*/

SELECT FIRST_NAME, LAST_NAME, SALARY, salary *1.1 "10%인상급여",  DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.


-- 확인
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
/*
103	Alexander	Hunold	AHUNOLD	590.423.4567	2006/01/03	IT_PROG	9900		102	60
104	Bruce	Ernst	BERNST	590.423.4568	2007/05/21	IT_PROG	6600		103	60
105	David	Austin	DAUSTIN	590.423.4569	2005/06/25	IT_PROG	5280		103	60
106	Valli	Pataballa	VPATABAL	590.423.4560	2006/02/05	IT_PROG	5280		103	60
107	Diana	Lorentz	DLORENTZ	590.423.5567	2007/02/07	IT_PROG	4620		103	60
*/

ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 JOB_TITLE 이 Sales Manager 인 사원들의
-- SALARY 를 해당 직무(직종) 의 최고급여(MAX_SALARY)로 수정한다.
-- 단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한해 적용할 수 있도록 처리한다.
-- (변경에 대한 결과 확인 우 ROLLBACK 수행한다.)
SELECT *
FROM EMPLOYEES;

SELECT *
FROM JOBS;


SELECT *
FROM EMPLOYEES
WHERE JOB_TITLE = 'Sales Manager'
HAVING SALARY = MAX_SALARY;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID= 'SA_MAN';


UPDATE EMPLOYEES
SET SALARY  = MAX_SALARY
WHERE JOB_ID= 'SA_MAN';


UPDATE EMPLOYEES
SET SALARY  = 20080
WHERE JOB_ID= 'SA_MAN'
AND HIRE_DATE < TO_DATE('2006-01-01','YYYY-MM-DD');


ROLLBACK;

UPDATE EMPLOYEES
SET SALARY  = 20080
WHERE JOB_ID= 'SA_MAN';

-- 확인

SELECT *
FROM EMPLOYEES;

------------------------------------- T 선생님 풀이
UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'의 MAX_SALARY)
WHERE JOB_ID = ('Sales Manager'의 JOB_ID)
 AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY'))<2006;
 
 -- ('Sales Manager'의 MAX_SALARY)
SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> 20080


-- ('Sales Manager'의 JOB_ID)
SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> SA_MAN


UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
 AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY'))<2006;
--==>> 3개 행 이(가) 업데이트되었습니다.

ROLLBACK;
--==>> 롤백 완료.




SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;
--○ EMPLOYEES 테이블에서 SALARY 를
-- 각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--  Finance → 10% 인상    → SALARY *1.1
--  Executive → 15% 인상  → SALARY * 1.15
--  Accounting → 20% 인상  → SALARY * 1.2
-- 다른 나머지 부서들        → SALARY
--  (변경에 대한 결과 확인 후 BOLLBACK)

UPDATE EMPLOYEES
SET SALARY = SALART * 1.1
WHERE DEPARTMENT_NAME = 'Finance';


UPDATE EMPLOYEES
SET SALARY = SALART * 1.1
WHERE DEPARTMENT_NAME = 'Finance';

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';
--==>> 100	Finance	108	1700

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 100;
--==>> 100	Finance	108	1700

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT *
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_ID = 100);


UPDATE EMPLOYEES
SET SALARY 10% 인상
WHERE Finance 

UPDATE EMPLOYEES
SET SALARY 10% 인상
WHERE Finance 


SELECT *
FROM DEPARTMENTS;


SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';
--==>> 100


SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 100;
--==>> Finance


SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';
--==>> 90

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';
--==>> 110

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'Finance'); 
--==>> 6개 행 이(가) 업데이트되었습니다.

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.15
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID
                     FROM DEPARTMENTS
                     WHERE DEPARTMENT_NAME = 'Executive'); 
--==>> 3개 행 이(가) 업데이트되었습니다.

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.2
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID
                     FROM DEPARTMENTS
                     WHERE DEPARTMENT_NAME = 'Accounting'); 
--==>> 2개 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEES;


ROLLBACK;
--==>> 롤백 완료.



------------------------ T 선생님 
UPDATE EMPLOYEES
WHERE 



UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN('Finance'의 부서 아이디) 
                               THEN SALARY *1.1 
                               WHEN('Executive'의 부서 아이디) 
                               THEN SALARY *1.15  
                               WHEN('Accounting'의 부서 아이디) 
                               THEN SALARY *1.12
                               ELSE SALARY 
             END;

-- ('Finance'의 부서 아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance'
--==>> 100

-- ('Executive'의 부서 아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive'
--==>> 90

-- ('Accounting'의 부서 아이디) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting'
--==>> 110


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN 100
                               THEN SALARY *1.1 
                               WHEN 90
                               THEN SALARY *1.15  
                               WHEN 110
                               THEN SALARY *1.12
                               ELSE SALARY
             END;

--==>>풀스캔 모든메모리가 퍼올려진다.

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                     FROM DEPARTMENTS
                                     WHERE DEPARTMENT_NAME = 'Finance')
                               THEN SALARY *1.1 
                               WHEN (SELECT DEPARTMENT_ID
                                     FROM DEPARTMENTS
                                     WHERE DEPARTMENT_NAME = 'Executive')
                               THEN SALARY *1.15  
                               WHEN (SELECT DEPARTMENT_ID
                                     FROM DEPARTMENTS
                                     WHERE DEPARTMENT_NAME = 'Accounting')
                               THEN SALARY *1.12
                               ELSE SALARY
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance','Executive','Accounting') );
--==>> 11개 행 이(가) 업데이트되었습니다. 

ROLLBACK;
--==>> 롤백 완료.

--------------------------------------------------------------------------------

--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];


-- 테이블 복사(데이터 위주)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES이(가) 생성되었습니다.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==> 조회하고나서 삭제하자 (기본을 지키자) 

DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;


--○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.
-- 단, 부서명이 'IT'인 경우로 한정한다.
-- ※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
-- 다른 레코드에 의해 참조당하고 있는 경우(부모면)
-- 삭제되지 않을 수 있다는 사실을 염두해야 하며...
-- 그에 대한 이유도 알아야 한다.
SELECT *
FROM TBL_EMPLOYEES
WHERE 부서명이 'IT'


SELECT *
FROM TBL_EMPLOYEES
WHERE 부서명이 'IT'

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60


SELECT *
FROM TBL_EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');

DELETE
FROM TBL_EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 삭제되었습니다.
ROLLBACK;
--==>> 롤백 완료.

-------------------선생님 풀이

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT'부서의 부서아이디);

-- ('IT'부서의 부서아이디)
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';


SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
-- (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)



--------------------------------------------------------------------------------

--■■■ 뷰(VIEW)■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--  하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--  정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--  만들어놓은 가상의 테이블로 ★편의성 및 보안에 목적이 있다.

--  가상의 테이블이란... 뷰가 실제로 존재하는 테이블(객체)이 아니라
--  하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
--  그 정보를 추출해내는 SQL문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

--○ 뷰(VIEW) 생성

CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.
--> 뷰는 계속 재정의 하면서 사용 할 수 있다.


--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;
/*
Ellen	Abel	Sales	Oxford	United Kingdom	Europe
Sundar	Ande	Sales	Oxford	United Kingdom	Europe
Mozhe	Atkinson	Shipping	South San Francisco	United States of America	Americas
David	Austin	IT	Southlake	United States of America	Americas
Hermann	Baer	Public Relations	Munich	Germany	Europe
Shelli	Baida	Purchasing	Seattle	United States of America	Americas
Amit	Banda	Sales	Oxford	United Kingdom	Europe
Elizabeth	Bates	Sales	Oxford	United Kingdom	Europe
Sarah	Bell	Shipping	South San Francisco	United States of America	Americas
David	Bernstein	Sales	Oxford	United Kingdom	Europe
Laura	Bissot	Shipping	South San Francisco	United States of America	Americas
Harrison	Bloom	Sales	Oxford	United Kingdom	Europe
Alexis	Bull	Shipping	South San Francisco	United States of America	Americas
Anthony	Cabrio	Shipping	South San Francisco	United States of America	Americas
Gerald	Cambrault	Sales	Oxford	United Kingdom	Europe
Nanette	Cambrault	Sales	Oxford	United Kingdom	Europe
John	Chen	Finance	Seattle	United States of America	Americas
Kelly	Chung	Shipping	South San Francisco	United States of America	Americas
Karen	Colmenares	Purchasing	Seattle	United States of America	Americas
Curtis	Davies	Shipping	South San Francisco	United States of America	Americas
Lex	De Haan	Executive	Seattle	United States of America	Americas
Julia	Dellinger	Shipping	South San Francisco	United States of America	Americas
Jennifer	Dilly	Shipping	South San Francisco	United States of America	Americas
Louise	Doran	Sales	Oxford	United Kingdom	Europe
Bruce	Ernst	IT	Southlake	United States of America	Americas
Alberto	Errazuriz	Sales	Oxford	United Kingdom	Europe
Britney	Everett	Shipping	South San Francisco	United States of America	Americas
Daniel	Faviet	Finance	Seattle	United States of America	Americas
Pat	Fay	Marketing	Toronto	Canada	Americas
Kevin	Feeney	Shipping	South San Francisco	United States of America	Americas
Jean	Fleaur	Shipping	South San Francisco	United States of America	Americas
Tayler	Fox	Sales	Oxford	United Kingdom	Europe
Adam	Fripp	Shipping	South San Francisco	United States of America	Americas
Timothy	Gates	Shipping	South San Francisco	United States of America	Americas
Ki	Gee	Shipping	South San Francisco	United States of America	Americas
Girard	Geoni	Shipping	South San Francisco	United States of America	Americas
William	Gietz	Accounting	Seattle	United States of America	Americas
Douglas	Grant	Shipping	South San Francisco	United States of America	Americas
Nancy	Greenberg	Finance	Seattle	United States of America	Americas
Danielle	Greene	Sales	Oxford	United Kingdom	Europe
Peter	Hall	Sales	Oxford	United Kingdom	Europe
Michael	Hartstein	Marketing	Toronto	Canada	Americas
Shelley	Higgins	Accounting	Seattle	United States of America	Americas
Guy	Himuro	Purchasing	Seattle	United States of America	Americas
Alexander	Hunold	IT	Southlake	United States of America	Americas
Alyssa	Hutton	Sales	Oxford	United Kingdom	Europe
Charles	Johnson	Sales	Oxford	United Kingdom	Europe
Vance	Jones	Shipping	South San Francisco	United States of America	Americas
Payam	Kaufling	Shipping	South San Francisco	United States of America	Americas
Alexander	Khoo	Purchasing	Seattle	United States of America	Americas
Janette	King	Sales	Oxford	United Kingdom	Europe
Steven	King	Executive	Seattle	United States of America	Americas
Neena	Kochhar	Executive	Seattle	United States of America	Americas
Sundita	Kumar	Sales	Oxford	United Kingdom	Europe
Renske	Ladwig	Shipping	South San Francisco	United States of America	Americas
James	Landry	Shipping	South San Francisco	United States of America	Americas
David	Lee	Sales	Oxford	United Kingdom	Europe
Jack	Livingston	Sales	Oxford	United Kingdom	Europe
Diana	Lorentz	IT	Southlake	United States of America	Americas
Jason	Mallin	Shipping	South San Francisco	United States of America	Americas
Steven	Markle	Shipping	South San Francisco	United States of America	Americas
James	Marlow	Shipping	South San Francisco	United States of America	Americas
Mattea	Marvins	Sales	Oxford	United Kingdom	Europe
Randall	Matos	Shipping	South San Francisco	United States of America	Americas
Susan	Mavris	Human Resources	London	United Kingdom	Europe
Samuel	McCain	Shipping	South San Francisco	United States of America	Americas
Allan	McEwen	Sales	Oxford	United Kingdom	Europe
Irene	Mikkilineni	Shipping	South San Francisco	United States of America	Americas
Kevin	Mourgos	Shipping	South San Francisco	United States of America	Americas
Julia	Nayer	Shipping	South San Francisco	United States of America	Americas
Donald	OConnell	Shipping	South San Francisco	United States of America	Americas
Christopher	Olsen	Sales	Oxford	United Kingdom	Europe
TJ	Olson	Shipping	South San Francisco	United States of America	Americas
Lisa	Ozer	Sales	Oxford	United Kingdom	Europe
Karen	Partners	Sales	Oxford	United Kingdom	Europe
Valli	Pataballa	IT	Southlake	United States of America	Americas
Joshua	Patel	Shipping	South San Francisco	United States of America	Americas
Randall	Perkins	Shipping	South San Francisco	United States of America	Americas
Hazel	Philtanker	Shipping	South San Francisco	United States of America	Americas
Luis	Popp	Finance	Seattle	United States of America	Americas
Trenna	Rajs	Shipping	South San Francisco	United States of America	Americas
Den	Raphaely	Purchasing	Seattle	United States of America	Americas
Michael	Rogers	Shipping	South San Francisco	United States of America	Americas
John	Russell	Sales	Oxford	United Kingdom	Europe
Nandita	Sarchand	Shipping	South San Francisco	United States of America	Americas
Ismael	Sciarra	Finance	Seattle	United States of America	Americas
John	Seo	Shipping	South San Francisco	United States of America	Americas
Sarath	Sewall	Sales	Oxford	United Kingdom	Europe
Lindsey	Smith	Sales	Oxford	United Kingdom	Europe
William	Smith	Sales	Oxford	United Kingdom	Europe
Stephen	Stiles	Shipping	South San Francisco	United States of America	Americas
Martha	Sullivan	Shipping	South San Francisco	United States of America	Americas
Patrick	Sully	Sales	Oxford	United Kingdom	Europe
Jonathon	Taylor	Sales	Oxford	United Kingdom	Europe
Winston	Taylor	Shipping	South San Francisco	United States of America	Americas
Sigal	Tobias	Purchasing	Seattle	United States of America	Americas
Peter	Tucker	Sales	Oxford	United Kingdom	Europe
Oliver	Tuvault	Sales	Oxford	United Kingdom	Europe
Jose Manuel	Urman	Finance	Seattle	United States of America	Americas
Peter	Vargas	Shipping	South San Francisco	United States of America	Americas
Clara	Vishney	Sales	Oxford	United Kingdom	Europe
Shanta	Vollman	Shipping	South San Francisco	United States of America	Americas
Alana	Walsh	Shipping	South San Francisco	United States of America	Americas
Matthew	Weiss	Shipping	South San Francisco	United States of America	Americas
Jennifer	Whalen	Administration	Seattle	United States of America	Americas
Eleni	Zlotkey	Sales	Oxford	United Kingdom	Europe
*/

--○ 뷰(VIEW)의 구조 조회

DESC VIEW_EMPLOYEES;
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 

*/


-- ○ 뷰(VIEW) 소스 확인 --★ CHECK~!! ★

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
-- TEXT
/*
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID"



--==> 뷰 생성할때 소스를 확인 할 수 있다.
*/


-- PL SQL










