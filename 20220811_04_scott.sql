--○ 접속된 사용자 계정 조회

SELECT USER
FROM DUAL;
--==>> SCOTT


CREATE TABLE DEPT
( DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY
, DNAME VARCHAR2(14)
, LOC VARCHAR2(13) 
) ;
--==>> Table DEPT이(가) 생성되었습니다.


CREATE TABLE EMP
( EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
--==>> Table EMP이(가) 생성되었습니다.


INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');
--==>> 1 행 이(가) 삽입되었습니다. * 4



INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--==>> 1 행 이(가) 삽입되었습니다. * 14



CREATE TABLE BONUS
( ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, SAL NUMBER
, COMM NUMBER
);
--==>> Table BONUS이(가) 생성되었습니다.


CREATE TABLE SALGRADE
( GRADE NUMBER
, LOSAL NUMBER
, HISAL NUMBER 
);
--==>> Table SALGRADE이(가) 생성되었습니다.



INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
--==>> 1 행 이(가) 삽입되었습니다. * 5


COMMIT;
--==>> 커밋 완료.

--○ SCOTT 계정이 갖고있는 테이블 조회
SELECT *
FROM TAB;
--==>>
/*
BONUS	    TABLE	
DEPT	        TABLE	
EMP	        TABLE	
SALGRADE	    TABLE	
*/

SELECT *
FROM USER_TABLES;
--==>> 
/*
DEPT	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO
EMP	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO
BONUS	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO
SALGRADE	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO
*/


--○ 위에서 조회한 각각의 테이블들이
--  어떤 테이블 스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	    USERS
EMP	    USERS
BONUS	USERS
SALGRADE	USERS
*/


--○ 테이블 생성(테이블명 : TBL_EXAMPLE1)
CREATE TABLE TBL_EXAMPLE1
( NO    NUMBER
, NAME  VARCHAR2(10)
, ADDR  VARCHAR2(20)
);
--==>> Table TBL_EXAMPLE1이(가) 생성되었습니다.



--○ 테이블 생성(테이블 명 : TBL_EXAMPLE2)
CREATE TABLE TBL_EXAMPLE2
( NO NUMBER(4)
, NAME VARCHAR2(20)
, ADDR VARCHAR2(20)
) TABLESPACE TBS_EDUA;
--==> Table TBL_EXAMPLE2이(가) 생성되었습니다.




--TBL_EXAMPLE1 과 Table TBL_EXAMPLE2
-- 각각 어떤테이블 스페이스에 저장 되어있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	            USERS
EMP	            USERS
BONUS	        USERS
SALGRADE	        USERS
TBL_EXAMPLE1	    USERS
TBL_EXAMPLE2	    TBS_EDUA
*/



-------------------------------------------------------------------------

-- ■■■ 관계형 데이터베이스(RDBMS) ■■■ --

-- 각각의 데이터를 테이블의 형태로 연결시켜 저장해 놓은 구조
-- 그리고 이들 각각의 테이블들 간의 관계를 설정하여 연결시켜 놓은 구조

/*=======================================
    ※ SELECT 문의 처리(PARSING) 순서 외우기 ※

    SELECT 컬럼명         -- ⑤┒
    FROM 테이블명         -- ①┚
    WHERE 조건절          -- ② +
    GROUP BY 조건절       -- ③ + 
    HAVING 조건절         -- ④ + 묶여져있을때의 조건 
    ORDER BY 절           -- ⑥ +  정.렬

=======================================*/

--○ SCOTT 소유의 테이블
SELECT *
FROM TAB;
--==>>
/*
BONUS	    TABLE	-- 보너스(BONUS) 데이터 테이블
DEPT	        TABLE	-- 부서(DEPARTMENTS) 데이터 테이블
EMP	        TABLE	-- 사원(EMPLOYEES)데이터 테이블
SALGRADE	    TABLE	-- 급여(SAL) 등급 데이터 테이블

TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
*/

--○ 각 테이블 데이터 조회
SELECT *
FROM BONUS;
--==>> 조회 결과 없음(조회된 데이터가 존재하지 않음)

SELECT *
FROM DEPT;
--==>> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
SELECT *
FROM EMP;
--==>> 
/*
7369	    SMITH	CLERK	    7902    	80/12/17	    800	(null)	 20
7499    	ALLEN	SALESMAN	    7698	    81/02/20	    1600  300     30
7521    	WARD	    SALESMAN	    7698	    81/02/22	    1250	 500	     30
7566	    JONES	MANAGER	    7839	    81/04/02	    2975	(null)	 20
7654    	MARTIN	SALESMAN	    7698	    81/09/28	    1250	1400     30
7698    	BLAKE	MANAGER	    7839	    81/05/01	    2850	(null)	 30
7782	    CLARK	MANAGER	    7839	    81/06/09	    2450	(null)	 10
7788	SCOTT	ANALYST	    7566    	81/11/17	5000	(null)	 10
7839	    KING	    PRESIDENT  (null)	81/11/17	5000	(null)	 10
7844	TURNER	SALESMAN	    7698	    81/09/08	    1500	    0	 30
7876    	ADAMS	CLERK	    7788	87/07/13	    1100	(null)	 20
7900	    JAMES	CLERK	    7698    	81/12/03	    950	(null)	 30
7902    	FORD    	ANALYST	    7566	    81/12/03	    3000	(null)	 20
7934    	MILLER	CLERK	    7782	    82/01/23	    1300	(null)	 10
*/

SELECT *
FROM SALGRADE;
--==>>
/*
1	700	    1200
2	1201    	1400
3	1401    	2000
4	2001    	3000
5	3001	    9999
*/
--○ DEPT 테이블에 존재하는 컬럼의 구조 조회

DESCRIBE DEPT;
--==>> 
/*
이름     널?       유형           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
        
컬럼명  
*/

-- DEPTNO       DNAME      LOC
-- 부서번호     부서명     부서위치
----------------------------------
--10            인사부     서울      → 데이터 입력 가능
--20                       대전      → 데이터 입력 가능
--              개발부     대구      → 데이터 입력 불가~!!!

--------------------------------------------------------------
--■■■오라클의 주요 자료형(DATA TYPE) ■■■--
/*

cf) MSSQL 서버의 정수 표현 타입

    tinyint     0 ~ 255              1Byte
    smallint    -32,768 ~ 32,767    2Byte
    int         -21억 ~ 21억      4Byte
    bigint      엄청 큼             8Byte

    MSSQL 서버의 실수 표현 타입
    float, real 
    
    MSSQL 서버의 숫자 표현 타입
    decimal, numeric
    
    MSSQL 서버의 문자 표현 타입
    char, varchar, Nvarchar


※ ORACLE 은 숫자 표현 타입이 한가지로 통일되어 있다. 기쁜소식><

1. 숫자형  NUMBER          →  -10승 38승-1 ~10의 38승
          NUMBER(3)        →  -999 ~ 999
          NUMBER(4)        →  -9999 ~ 9999
          NUMBER(4, 1)     →  -999.1 ~ 999.1
          
            전체자리가 4자리고 , 소수점 이하 1까지다

※ ORACLE 의 문자 표현 타입

2. 문자형 CHAR             → 고정형 크기
                            (무조건 지정된 크기 소모)
         CHAR(10)      ←← '강의실' 6Byte 이지만 10Byte 를 소모
         CHAR(10)      ←← '실습조영관' 10Byte 소모
         CHAR(10)      ←← '영관이뭐하지'10Byte 를 초과하므로 입력불가
          
        
         VARCHAR2         → 가변형 크기
                            (상황에 따라 크기가 변경)
         VARCHAR2(10)  ←← '박원석' 6Byte 소모
         VARCHAR2(10)  ←← '실습조영관' 10Byte 소모
         VARCHAR2(10)  ←← '영관이뭐하지'10Byte 를 초과하므로 입력불가


         NCHAR        → 유니코드 기반 고정형 크기(글자 수)
         NCHAR(10)       ←← 10글자            
        
         NVARCHAR2    → 유니코드 기반 가변형 크기(글자 수)
         NVARCHAR2(10)   ←← 10글자 
        
3. 날짜형 DATE



*/

SELECT HIREDATE
FROM EMP;


DESCRIBE EMP;
DESC EMP;
--※ 날짜형식에 대한 세션 변경 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT HIREDATE
FROM EMP;
/*
1980-12-17
1981-02-20
1981-02-22
1981-04-02
1981-09-28
1981-05-01
1981-06-09
1987-07-13
1981-11-17
1981-09-08
1987-07-13
1981-12-03
1981-12-03
1982-01-23
*/
SELECT ENAME, HIREDATE 
FROM EMP;
--==>>
/*
SMITH	1980-12-17
ALLEN	1981-02-20
WARD	1981-02-22
JONES	1981-04-02
MARTIN	1981-09-28
BLAKE	1981-05-01
CLARK	1981-06-09
SCOTT	1987-07-13
KING	1981-11-17
TURNER	1981-09-08
ADAMS	1987-07-13
JAMES	1981-12-03
FORD	1981-12-03
MILLER	1982-01-23
*/

-- SYSDATE 함수 년, 월,일 시분초
SELECT SYSDATE
FROM DUAL;
--==>> 2022-08-11

-- 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2022-08-11 05:11:21

-- 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2022-08-11 17:12:34

--○ EMP 테이블에서 사원번호, 사원명, 급여, 커미션 데이터만 조화한다.

SELECT *
FROM EMP;

SELECT 사원번호, 사원명, 급여, 커미션
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;

--○ EMP 테이블에서 부서번호가 20번인 직원들의 데이터들 중
-- 사원번호, 사원명 , 직종명, 급여, 부서번호 조회

--내가 한것
/*
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP;
WHERE EMPNO = 20;
*/
SELECT 사원번호, 사원명 , 직종명, 급여, 부서번호 
FROM EMP
WHERE 부서번호가 20번;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
--==>>
/*
7369	    SMITH	CLERK	 800	 20
7566	    JONES	MANAGER	2975	 20
7788	SCOTT	ANALYST	3000	 20
7876	    ADAMS	CLERK	1100 20
7902	    FORD	    ANALYST	3000	 20
*/

-- ○ 별칭 으로 바꾸기 AS "" 생략가능 ★ 가급적이면 ""는 생략하지 말자
SELECT EMPNO AS "사원번호", ENAME "사원명", JOB 직종명, SAL "급      여"
FROM EMP;


--※ 테이블을 조회하는 과정에서
-- 각 컬럼의 이름에는 별칭(ALIAS)을 부여할 수 있다.
-- 기본 구분 형식은 『컬럼명 AS "별칭이름"』 의 형태로 작성되며
-- 이 때, 『AS』는 생략이 가능하다.
-- 또한, 별칭 이름을 감싸는 ""도 생략이 가능하지만
-- 『""』 를 생략할 경우 별칭 내에서 공백은 사용할 수 없다.
-- 공백의 등장은 해당 컬럼의 표현에 대한 종결을 의미하므로
-- 별칭(ALIAS)의 이름 내부에 공백을 사용해야 할 경우
-- 『""』를 사용하여 별칭을 부여할 수 있도록 한다.



-- EMP 테이블에서 부서번호가 20번과 30번 직원들의 데이터들 중
-- 사원번호, 사원명, 직종명, 급여, 부서번S호 항목을 조회한다.
-- 단, 별칭(ALIAS)을 사용한다.
SELECT *
FROM EMP;

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20 ||  DEPTNO =30;
--WHERE DEPTNO = 30 ; 아님
--==>> 에러발생

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20 OR  DEPTNO =30;
--==>>
/*
7369	SMITH	CLERK	800	20
7499	ALLEN	SALESMAN	1600	30
7521	WARD    	SALESMAN	1250	30
7566	JONES	MANAGER	2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	2850	30
7788	    SCOTT	ANALYST	3000	20
7844	    TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	1100	20
7900	JAMES	CLERK	950	30
7902	FORD    	ANALYST	3000	20
*/
