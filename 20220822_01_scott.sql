SELECT USER
FROM DUAL;
--==>> SCOTT

--○ EMP 테이블을 대상으로 
-- 입사한 사원의 수가 가장 많았을 때의 MAX(COUNT()) 
-- 입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.
/*
--------- -------------
입사년월  인원수 
--------- -------------
1981-02     2
1981-09     2
1987-07     2
--------- -------------
*/


--인라인 뷰로하는방법도 고민
-- 선생님 T
SELECT ENAME, HIREDATE
FROM EMP
ORDER BY 2;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
    , COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY');



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
    , COUNT(*)"인원수"
FROM EMP
WHERE COUNT(*) = 2
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 에러발생
-- (ORA-00934: group function is not allowed here)

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
    , COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 2 ;



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
    , COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (입사년월 기중 최대 인원);



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
    , COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) =(SELECT MAX(COUNT(*))
                FROM EMP 
                GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));




SELECT T1.입사년월, T1.인원수
FROM 
(
    SELECT TO_CHAR(HIREDATE, 'YY-MM') "입사년월"
         , COUNT(*) "인원수"
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YY-MM')
) T1
WHERE T1.인원수 = (SELECT MAX(T2.인원수)
                FROM
                (
                SELECT TO_CHAR(HIREDATE, 'YY-MM') "입사년월"
                     , COUNT(*) "인원수"
                FROM EMP
                GROUP BY TO_CHAR(HIREDATE, 'YY-MM')
                ) T2
                 )
ORDER BY 1;

-------------------------------------------------------------------------------
-- ■■■ ROW_NUMBER ■■■ --

SELECT ENAME "사원명" , SAL"급여" , HIREDATE"입사일" 
FROM EMP;

                        -- 행번호를 붙이는 기준으로 활용
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
        , ENAME "사원명" , SAL"급여" , HIREDATE"입사일" 
FROM EMP;
/*
1	KING	    5000	81/11/17
2	FORD	    3000	81/12/03
3	SCOTT	3000	87/07/13
4	JONES	2975	81/04/02
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
7	ALLEN	1600	81/02/20
8	TURNER	1500	81/09/08
9	MILLER	1300	82/01/23
10	WARD	    1250	81/02/22
11	MARTIN	1250	81/09/28
12	ADAMS	1100	87/07/13
13	JAMES	950	81/12/03
14	SMITH	800	80/12/17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
        , ENAME "사원명" , SAL"급여" , HIREDATE"입사일" 
FROM EMP
ORDER BY ENAME;

/*
12	ADAMS	1100	87/07/13
7	ALLEN	1600	81/02/20
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
2	FORD	    3000	81/12/03
13	JAMES	950	81/12/03
4	JONES	2975	81/04/02
1	KING	    5000	81/11/17
11	MARTIN	1250	81/09/28
9	MILLER	1300	82/01/23
3	SCOTT	3000	87/07/13
14	SMITH	800	80/12/17
8	TURNER	1500	81/09/08
10	WARD    	1250	81/02/22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
        , ENAME "사원명" , SAL"급여" , HIREDATE"입사일" 
FROM EMP
ORDER BY ENAME;

/*
1	ADAMS	1100	87/07/13
2	ALLEN	1600	81/02/20
3	BLAKE	2850	81/05/01
4	CLARK	2450	81/06/09
5	FORD	    3000	81/12/03
6	JAMES	950	81/12/03
7	JONES	2975	81/04/02
8	KING	    5000	81/11/17
9	MARTIN	1250	81/09/28
10	MILLER	1300	82/01/23
11	SCOTT	3000	87/07/13
12	SMITH	800	80/12/17
13	TURNER	1500	81/09/08
14	WARD	    1250	81/02/22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
        , ENAME "사원명" , SAL"급여" , HIREDATE"입사일" 
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
                        -- ORACEL      --MYSQL
--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우.....삭제한 게시물의 자리에 다음번호를 가진
--   게시물이 등록되는 상황이 발생하게된다.
--   이는...보안성 측면이나 미관상...바락직하지 않은 상태 일 수 있기 때문에
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY 를 사용하지만,
--   단순히 게시물을 목록화 하여 사용자에게 리스트형식으로 보여줄 때에는
--   사용하지 않는것이 바람직 할 수 있다.

--○ SEQUENCE(시퀀스: 주문번호)  -- 은행 번호표처럼 (게시물번호 자동발생)
--   → 사전적인 의미 : 1 . (일련의) 연속적인 사건들 2.(사건, 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD    -- 기본적인 시퀀스 생성 구문
START WITH 1                -- 시작값
INCREMENT BY 1              -- 증가값
NOMAXVALUE                  -- 최댓값
NOCACHE;                    -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 실습테이블 생성
CREATE TABLE TBL_BOARD              -- TBL_BOARD 테이블 생성 구문 → 게시판 테이블
( NO           NUMBER               -- 게시물 번호       X
, TITLE        VARCHAR2(50)         -- 게시물 제목       ○
, CONTENTS     VARCHAR2(1000)       -- 게시물 내용       ○
, NAME         VARCHAR2(20)         -- 게시물 작성자     △    (회원, 비회원)
, PW           VARCHAR2(20)         -- 게시물 패스워드   △
, CREATED      DATE DEFAULT SYSDATE -- 게시물 작성일     X
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.



--○ 데이터 입력 → 게시판에 게시물을 작성한 액셩                        
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~ 자고싶다','10분만 자고 올께요','장현성','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~ 웃겨','현성군 완전 재미있어요','엄소연','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '보고싶다','원석이가 너무 보고싶어요','조영관','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '배고파요','아침인데 배고파요','유동현','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '너무멀어요','집에서 교육원까지 너무 멀어요','김태민','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '모자라요','아직 잠이 모자라요','장현성','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저두요','저두 잠이 많이 모자라요','유동현','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '비온대요','오늘밤부터 비온대요','박원석','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.


SELECT *
FROM TBL_BOARD;

/*
1	아~ 자고싶다	        10분만 자고 올께요	        장현성	java002$	2022-08-22 10:29:51
2	아~ 웃겨	            현성군 완전 재미있어요	    엄소연	java002$	2022-08-22 10:29:57
3	보고싶다	            원석이가 너무 보고싶어요	    조영관	java002$	2022-08-22 10:30:02
4	배고파요	            아침인데 배고파요	        유동현	java002$	2022-08-22 10:30:06
5	너무멀어요	        집에서 교육원까지 너무 멀어요	김태민	java002$	2022-08-22 10:30:09
6	모자라요	            아직 잠이 모자라요	        장현성	java002$	2022-08-22 10:30:13
7	저두요	            저두 잠이 많이 모자라요	    유동현	java002$	2022-08-22 10:30:17
8	비온대요            	오늘밤부터 비온대요	        박원석	java002$	2022-08-22 10:30:20
*/



--○ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD이(가) 삭제되었습니다.

DROP SEQUENCE SEQ_BOARD;
--==>> Sequence SEQ_BOARD이(가) 삭제되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제  게기물 제목, 내용 작성자는 겹칠 수 있기 때문에 고유하게 관리 되는 게시물번호
DELETE 
FROM TBL_BOARD
WHERE NO = 1;
-- 1 행 이(가) 삭제되었습니다.


DELETE 
FROM TBL_BOARD
WHERE NO = 6;
-- 1 행 이(가) 삭제되었습니다.

DELETE 
FROM TBL_BOARD
WHERE NO = 8;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;

--○ 게시물 작성

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '집중합시다','전 전혀 졸리지 않아요','유동현','java002$',DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.



--○ 게시물 삭제
DELETE 
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
/*
2	아~ 웃겨	현성군 완전 재미있어요	엄소연	java002$	2022-08-22 10:29:57
3	보고싶다	원석이가 너무 보고싶어요	조영관	java002$	2022-08-22 10:30:02
4	배고파요	아침인데 배고파요	유동현	java002$	2022-08-22 10:30:06
5	너무멀어요	집에서 교육원까지 너무 멀어요	김태민	java002$	2022-08-22 10:30:09
9	집중합시다	전 전혀 졸리지 않아요	유동현	java002$	2022-08-22 10:35:35
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ 게시판의 게시물 리스트 조회
SELECT NO"글번호", TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD;
/*
2	아~ 웃겨	    엄소연	2022-08-22 10:29:57
3	보고싶다	    조영관	2022-08-22 10:30:02
4	배고파요	    유동현	2022-08-22 10:30:06
5	너무멀어요	김태민	2022-08-22 10:30:09
9	집중합시다	유동현	2022-08-22 10:35:35
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호" 
     , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD;
/*
1	아~ 웃겨	엄소연	2022-08-22 10:29:57
2	보고싶다	조영관	2022-08-22 10:30:02
3	배고파요	유동현	2022-08-22 10:30:06
4	너무멀어요	김태민	2022-08-22 10:30:09
5	집중합시다	유동현	2022-08-22 10:35:35
*/



-- 최종적
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호" 
     , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
/*
5	집중합시다	유동현	2022-08-22 10:35:35
4	너무멀어요	김태민	2022-08-22 10:30:09
3	배고파요	    유동현	2022-08-22 10:30:06
2	보고싶다	    조영관	2022-08-22 10:30:02
1	아~ 웃겨	    엄소연	2022-08-22 10:29:57
*/


--------------------------------------------------------------------------------

--■■■ JOIN(조인) ■■■--  개발자한테 중요한 문법★ 얼마나 잘 활용 하느냐의 차이

-- 1. SQL 1992 CODE 

-- CROSS JOIN   
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(CATERSIAN PRODUCT) 14 * 4
--  두 테이블을 결합한 모든 경우의 수   

-- EQUI JOIN : 서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법
-- 사용 빈도 높다
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 별칭 가능
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


-- NON EQUI JOIN : 범위 안에 적합한 것들끼리 연결시키는 결합 방법
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
/*
7369    	SMITH	CLERK	7902	80/12/17	800		20	1	700	1200
7900    	JAMES	CLERK	7698	81/12/03	950		30	1	700	1200
7876    	ADAMS	CLERK	7788	87/07/13	1100		20	1	700	1200
7521    	WARD	    SALESMAN	7698	81/02/22	1250	500	30	2	1201	1400
7654	    MARTIN	SALESMAN	7698	81/09/28	1250	1400	30	2	1201	1400
7934    	MILLER	CLERK	7782	82/01/23	1300		10	2	1201	1400
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	30	3	1401	2000
7499	    ALLEN	SALESMAN	7698	81/02/20	1600	300	30	3	1401	2000
7782	    CLARK	MANAGER	7839	81/06/09	2450		10	4	2001	3000
7698	    BLAKE	MANAGER	7839	81/05/01	2850		30	4	2001	3000
7566    	JONES	MANAGER	7839	81/04/02	2975		20	4	2001	3000
7788	SCOTT	ANALYST	7566	87/07/13	3000		20	4	2001	3000
7902	    FORD	    ANALYST	7566	81/12/03	3000		20	4	2001	3000
7839	    KING	    PRESIDENT		81/11/17	5000		10	5	3001	9999
*/


-- EQUI JOIN  시(+) 를 활용한 결합 방법
SELECT *        
FROM TBL_EMP;   -- 19건

SELECT *
FROM TBL_DEPT;  -- 4건



SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된상황
-- 즉, 부서번호를 갖지못한 사원들(5) 모두 누락
-- 또한, 소속 사원을 갖지 못한 부서(1) 도 누락

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
-- 얘네 먼저 나열 = 거기에 매칭되는것을 추가한다.

--> 총 19건의 데이터가 결합되어 조회된 상황
--  소속 사원을 갖지 못한 부서(1) 누락   ----(+)
--  부서번호를 갖지 못한 사원들(5) 모두 조회


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--               얘내 먼저 나열
--> 총 15건의 데이터가 결합되어 조회된 상황
--  부서번호를 갖지 못한 (5)명 모두 누락   ----(+)
--  소속 사원을 갖지 못한 부서(1) 조회


--※ (+)가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후            -- 기준
--   (+)가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로 -- 추가(첨가)


-- 이와 같은 이유로...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- 이런 형식의 JOIN 은 존재하지 않는다. 기준이 없다.
--==>> (ORA-01468: a predicate may reference only one outer-joined table)



SELECT *
FROM DEPT;

SELECT *
FROM EMP;

-- 2. SQL 1999 CODE         → 『JOIN』 키워드 등장  → JOIN(결합)의 유형 명시
--                         → 『ON』 키워드 등장    → 결합 조건은 WHERE 대신 ON

-- CROSS JOIN               이란것을 명시하게 바뀜

SELECT *
FROM EMP CROSS JOIN DEPT;    -- , 대신 CROSS JOIN 명시


-- INNER JOIN : 서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법

SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D              -- , 자리에 JOIN
ON E.DEPTNO = D.DEPTNO;             -- WHEWE 자리에 ON
-- INNER JOIN 에서 INNER 는 생략 가능


SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;





-- OUTER JOIN 
SELECT *
FROM TBL_DEPT;


SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--==>> 19
-- ↓

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
/*
7934	    MILLER	CLERK	    7782	    82/01/23	1300		10	10	ACCOUNTING	NEW YORK
7839    	KING    	PRESIDENT		    81/11/175000		10	10	ACCOUNTING	NEW YORK
7782	    CLARK	MANAGER	    7839	    81/06/09	2450		10	10	ACCOUNTING	NEW YORK
7902	    FORD    	ANALYST	    7566	    81/12/03	3000		20	20	RESEARCH    	DALLAS
7876	    ADAMS	CLERK	    7788	87/07/13	1100		20	20	RESEARCH    	DALLAS
7788	SCOTT	ANALYST	    7566	    87/07/13	3000		20	20	RESEARCH    	DALLAS
7566	    JONES	MANAGER	    7839	    81/04/02	2975		20	20	RESEARCH    	DALLAS
7369	    SMITH	CLERK	    7902	    80/12/17	800		20	20	RESEARCH    	DALLAS
7900	    JAMES	CLERK	    7698	    81/12/03	950		30	30	SALES	    CHICAGO
7844	TURNER	SALESMAN	    7698	    81/09/08	1500	0	30	30	SALES	    CHICAGO
7698	    BLAKE	MANAGER	    7839	    81/05/01	2850		30	30	SALES	    CHICAGO
7654    	MARTIN	SALESMAN	    7698	    81/09/28	1250	1400	30	30	SALES	    CHICAGO
7521    	WARD	    SALESMAN	    7698    	81/02/22	1250	500	30	30	SALES	    CHICAGO
7499    	ALLEN	SALESMAN	    7698    	81/02/20	1600	300	30	30	SALES	    CHICAGO
8005	    장현성	SALESMAN	    7698    	22/08/19	1000					
8004	    유동현	SALESMAN	    7698    	22/08/19	2500					
8003	    김보경	SALESMAN	    7698    	22/08/19	1700					
8002    	조현하	CHECK	    7566    	22/08/19	2000	10				
8001	    김태민	CHECK	    7566	    22/08/19	1500	10				
*/


SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- ★ 추가
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


-- OUTER JOIN 에서 OUTER 생략 가능


SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


--------------------------------------------------------------------------------
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> 이와 같은 방법으로 쿼리문을 구성해도
-- 조회 결과를 얻는 과정에 문제는 없다.


SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK';
--> 하지만 이와같이 구성하여
--  WHERE 는 WHERE에 조회하는 것을 권장한다.

--------------------------------------------------------------------------------
--○ EMP 테이블과 DEPT 테이블을 대상으로
--  직종이 MANAGER  와 CLERK 인 사원들만
--  부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.DO

SELECT E.DEPTNO "부서번호", ENAME"부서명", ENAME"사원명", JOB"직종명", SAL"급여"
FROM EMP E JOIN DEPT D  --JOIN 대신 ,
ON E.JOB = D.JOB        
WHERE E.JOB, D.JOB = IN('MANAGER', 'CLERK');

SELECT *
FROM DEPT;

SELECT *
FROM EMP;


SELECT DEPTNO "부서번호", ENAME"부서명", ENAME"사원명", JOB"직종명", SAL"급여"
FROM EMP E JOIN DEPT D  --JOIN 대신 ,
ON E.JOB = D.JOB        
WHERE E.JOB, D.JOB = IN('MANAGER', 'CLERK');


SELECT *
FROM EMP E FULL JOIN DEPT D  --JOIN 대신 ,
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = 'MANAGER' ; -- 이건가능


SELECT *
FROM EMP E FULL JOIN DEPT D  --JOIN 대신 ,
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = 'MANAGER' OR 'CLERK';  -- 이건 불가능



DEPTNO "부서번호", ENAME"부서명", ENAME"사원명", JOB"직종명", SAL"급여"

SELECT *
FROM EMP E JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = IN('MANAGER', 'CLERK');



--T
SELECT *
FROM EMP;

SELECT *
FROM DEPT;  -- DEPTNO 이(연결고리) 단 하나있는것 이것이 부모테이블이다

-- 부서번호, 부서명, 사원명, 직종명 ,급여"
-- DEPTNO ,  DNAME,  ENAME, JOB, SAL
-- E, D      D       E     E     E 


SELECT DEPTNO, ENAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>(ORA-00918: column ambiguously defined)
--  두 테이블 간 중복되는 컬럼에 대한
--  소속 테이블을 정해줘야(명시해줘야)한다.


SELECT E.DEPTNO, ENAME, ENAME, JOB, SAL     -- 자식명시XXXX
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;



SELECT D.DEPTNO, ENAME, ENAME, JOB, SAL     -- 부모명시OOOOOO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--※ 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 참조할 수 있도록 처리해야 한다.
SELECT *
FROM EMP;  -- 자식 테이블

SELECT *
FROM DEPT; -- 부모 테이블


   -- 필수사항 , 권장사항 , 권장사항 , 권장사항 , 권장사항
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 두 테이블에 모두 포함되어있는 중복된 컬림이 아니더라도
-- 컬럼의 소속 테이블을 명시해 줄 수 있도록 권장한다.

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
 AND E.JOB = 'MANAGER' OR 'CLERK';  --??


SELECT D.DEPTNO, ENAME, ENAME, JOB, SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;




--------------------------------------------------------------------------------

--○ SELF JOIN(자기 조인)
-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
--------------------------------------------------------------------------------
-- 사원번호 사원명  직종명  관리자번호  관리자명  관리자직종명
--------------------------------------------------------------------------------
-- 7369     SMITH   CLERK   7902       FORD      ANALYST
---------------------------------- E1
                           ------------------------------- E2

SELECT *
FROM EMP;




SELECT 사원번호 사원명  직종명  관리자번호  관리자명  관리자직종명
FROM EMP SELF JOIN;



SELECT  E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , E.EMPNO"관리자번호",E.ENAME"관리자명", E.JOB"관리자직종명"
FROM EMP E SELF JOIN E
ON E.MGR = D.MGR;




SELECT  E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , E.EMPNO"관리자번호",E.ENAME"관리자명", E.JOB"관리자직종명"
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;


-- 내가 한 것
SELECT  E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , D.EMPNO"관리자번호",D.ENAME"관리자명", D.JOB"관리자직종명"
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;

SELECT COUNT(*)
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;
--==>> 13

SELECT E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , D.EMPNO"관리자번호",D.ENAME"관리자명", D.JOB"관리자직종명"
FROM EMP E RIGHT JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 21
-- 왜,,,LEFT를 해야하냐??

SELECT E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , D.EMPNO"관리자번호",D.ENAME"관리자명", D.JOB"관리자직종명"
FROM EMP E LEFT JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 14

SELECT E.EMPNO"사원번호", E.ENAME"사원명", E.JOB"직종명"
     , D.EMPNO"관리자번호",D.ENAME"관리자명", D.JOB"관리자직종명"
FROM EMP E FULL JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 22


-- T
SELECT EMPNO"사원번호", ENAME"사원명" , JOB"직종명", MGR"관리자번호" ,ENAME"관리자명", JOB"관리자 직종명"
FROM EMP;



SELECT E1.EMPNO"사원번호", E1.ENAME"사원명" , E1.JOB"직종명"
     , E2.EMPNO"관리자번호" ,E2.ENAME"관리자명", E2.JOB"관리자 직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>> KING 제외 된 상황


SELECT E1.EMPNO"사원번호", E1.ENAME"사원명" , E1.JOB"직종명"
     , E2.EMPNO"관리자번호" ,E2.ENAME"관리자명", E2.JOB"관리자 직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

--  위 1999 아래 1922 같다

SELECT E1.EMPNO"사원번호", E1.ENAME"사원명" , E1.JOB"직종명"
     , E2.EMPNO"관리자번호" ,E2.ENAME"관리자명", E2.JOB"관리자직종명"
FROM EMP E1 , EMP E2
WHERE E1.MGR = E2.EMPNO(+);









