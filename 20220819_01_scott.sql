SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL)"급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	        8750
20	        10875
30	        9400
모든부서    	29025
*/


SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	        8750
20	        10875
30	        9400
모든부서    	8700
모든부서    	37725
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	        8750
20	        10875
30	        9400
모든부서    	8700
모든부서	    37725
*/


-- GROUPING()
SELECT GROUPING(DEPTNO) "GROUPING" , DEPTNO"부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
    0	        10	       8750
    0	        20	      10875
    0	        30	       9400     
    0		(null)         8700
    1		(null)        37725     -- roll up의 결과  
*/


SELECT DEPTNO"부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	 8750
20	10875
30	 9400
	 8700
	37725
*/
--○ 위에서 조회한 해당 내용을 
/*
10	        8750
20	        10875
30	        9400
인턴	        8700
모든부서    	37725
*/
--이와같이 조회되도록 쿼리문을 구성한다.
--※ 
SELECT GROUPING(DEPTNO) "GROUPING" , DEPTNO"부서번호", SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

/*
    0	        10	       8750
    0	        20	      10875
    0	        30	       9400     
    0		(null)         8700
    1		(null)        37725     -- roll up의 결과  
*/
--※  힌트
SELECT CASE GROUPING(DEPTNO) WHEN 0  THEN '단일부서' ELSE '모든부서' END "부서번호"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
단일부서    	8750
단일부서	    10875
단일부서	    9400
단일부서	    8700
모든부서    	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0  THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE NVL(TO_CHAR(DEPTNO), '모든부서') END "부서번호"
        , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

/*
10	        8750
20	        10875
30	        9400
인턴	    8700
모든부서    	37725
*/

--T
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
            ELSE'모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
-- 문자타입 숫자타입


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE'모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	        8750
20	        10875
30	        9400
(null)      8700
모든부서    	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE'모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

/*
10	    8750
20	    10875
30	    9400
인턴	8700
모든부서	37725
*/

-- TBL_SAWOM 테이블을 대상으로
-- 다음과 같이 조회 될 수 있도록 쿼리문을 구성한다.
/*
---------------  ------------------
    성별              급여합
---------------  ------------------
    남                  XXXX
    여                  XXXX
    모든사원          XXXXXX
---------------  ------------------
*/
SELECT *
FROM TBL_SAWON;

SELECT 성별이 남성인사람들 의 급여합
       성별이 여성인 사람들의 급여합
        모든사원의 급여합
FROM TBL_SAWON;



SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가' 
            END "성별"
        , SAL"급여"
FROM TBL_SAWON;


SELECT T.*
FROM 
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가' 
            END "성별"
        , SAL"급여"
    FROM TBL_SAWON;
)T
GROUP BY ROLLUP(T.성별, T.급여);
--==>> 오류 보고 -
--  알 수 없는 명령


SELECT T.*
FROM 
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별확인불가' 
            END "성별"
        , SAL"급여"
    FROM TBL_SAWON;
)T;
--==>> 오류 보고 -
--   알 수 없는 명령



SELECT CASE GROUPING(T.성별) WHEN '남성' THEN SUM(SAL) 
                             WHEN '여성' THEN SUM(SAL)
                             ELSE '모든사원' END "급여합"
FROM 
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가' 
                END "성별"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별);



SELECT *
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가' 
                END "성별"
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별);


SELECT *
FROM TBL_SAWON;


SELECT SANO"사원번호", SANAME"사원이름", JUBUN"주민번호", HIREDATE"입사일" , SAL"급여"
        ,CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN 1
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN 2
                ELSE 0
                END "성별"
FROM TBL_SAWON;



SELECT *
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
                ELSE '성별확인불가' 
                END "성별"
    FROM TBL_SAWON
)T
WHERE T.성별 
GROUP BY ROLLUP(T.성별);



--친구 꺼 참조해서 본 것
SELECT CASE T.성별 WHEN 1 THEN '남성'
                   WHEN 2 THEN '여성' ELSE '모든부서' END "성별"
      , SUM(T.급여) "급여합"
FROM
(
    SELECT SANO"사원번호", SANAME"사원이름", JUBUN"주민번호", HIREDATE"입사일" , SAL"급여"
        ,CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN 1
              WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN 2
                ELSE 0
                END "성별"
    FROM TBL_SAWON
)T 
GROUP BY ROLLUP(T.성별);



SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7,1) IN ('2', '4') THEN '여'
            ELSE '성별확인불가'
            END "성별"
     , SAL "급여"
FROM TBL_SAWON;
 

 
SELECT T.성별"성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7,1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL"급여"
    FROM TBL_SAWON
) T
GROUP BY T.성별;



-- ①
SELECT NVL(T.성별, '모든사원')"성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7,1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL"급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);



-- ②
SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
        ELSE '모든사원' 
        END "성별" 
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7,1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL"급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
/*
남	    11000
여	    31800
모든사원	42800
*/



--○ TBL_SAWON 테이블을 대상으로
-- 다음과 같이 조회 될 수 있도록 쿼리문을 구성한다.
/*
1. 현재나이를 가지고있는 서브쿼리
2. 현재나이로 연령대를 나눈다.
3. COUNT로 10대 COUNT 
   20,30 대 ROULLUP의 COUNT를 센다.
----------  --------------
연령대         인원수
----------  --------------
    10          X
    20          X
    30          X
    50          X
    전체        16
----------  --------------
*/
SELECT *
FROM VIEW_SAWON;


SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "현재나이"  
FROM TBL_SAWON;




SELECT CASE T.현재나이 WHEN 50 >= THEN 50
                       WHEN 30 >= THEN 30
                       WHEN 20 >= THEN 20
                       WHEN 10 >= THEN 10
                       ELSE 0 
                       END "연령대"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "현재나이"  
    FROM TBL_SAWON
)T;



CASE GROUPING(DEPTNO) WHEN 0  THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE NVL(TO_CHAR(DEPTNO), '모든부서') END "부서번호"


SELECT CASE GROUPING(T.현재나이) "GROUPING" WHEN 0 THEN COUNT(T.현재나이) 
                    ELSE END"인원수"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                       WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                        ELSE -1
                  END "현재나이"  
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.현재나이);



SELECT CASE T.현재나이 WHEN 50 >= AND THEN '50'
                       WHEN 30 >= THEN '30'
                       WHEN 20 >= THEN '20'
                       WHEN 10 >= THEN '10'
                       ELSE '확인불가' 
                       END "연령대"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "현재나이"  
              
    FROM TBL_SAWON
)T;



CASE GROUPING(DEPTNO) WHEN 0  THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE NVL(TO_CHAR(DEPTNO), '모든부서') END "부서번호"

SELECT NVL()
     , COUNT(*)
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899),-1) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999),-1) 
                    ELSE -1
              END "현재나이"  
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.현재나이) ;




--②
SELECT CASE GROUPING(T.현재나이) WHEN 0  THEN TO_CHAR(T.현재나이)
        ELSE NVL(TO_CHAR(T.현재나이), '전체연령') END "부서번호"
     , COUNT(*)"인원수"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899),-1) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999),-1) 
                    ELSE -1
              END "현재나이"  
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.현재나이) ;





--①
SELECT NVL(TO_CHAR(T.현재나이), '전체') "연령대"
     , COUNT(*)"인원수"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899),-1) 
                WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999),-1) 
            ELSE -1
            END "현재나이"  
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.현재나이) ;


--선생님 T
--방법 1. → INLINE VIEW 를 두 번 중첩

-- 연령대
SELECT CASE WHEN T1. 현재나이 >=50 THEN 50
            WHEN T1. 현재나이 >=40 THEN 40
            WHEN T1. 현재나이 >=30 THEN 30
            WHEN T1. 현재나이 >=20 THEN 20
            WHEN T1. 현재나이 >=10 THEN 10
            ELSE 0  END"연령대"
FROM
(
    -- 나이
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "현재나이"  
    FROM TBL_SAWON
) T1;

NVL(TO_CHAR(T.현재나이), '전체') "연령대"


SELECT NVL(TO_CHAR(T2.연령대), '전체') "연령대"
    ,COUNT (*) "인원"
FROM
(
    -- 연령대
    SELECT CASE WHEN T1. 현재나이 >=50 THEN 50
                WHEN T1. 현재나이 >=40 THEN 40
                WHEN T1. 현재나이 >=30 THEN 30
                WHEN T1. 현재나이 >=20 THEN 20
                WHEN T1. 현재나이 >=10 THEN 10
                ELSE 0  END"연령대"
    FROM
    (
        -- 나이
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                       WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                        ELSE -1
                  END "현재나이"  
        FROM TBL_SAWON
    ) T1
)T2
GROUP BY ROLLUP(T2.연령대);
/*
10	2
20	8
30	2
50	4
전체	16
*/
SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR((T2.연령대)) ELSE "WJS
    ,COUNT (*) "인원"
FROM
(
    -- 연령대
    SELECT CASE WHEN T1. 현재나이 >=50 THEN 50
                WHEN T1. 현재나이 >=40 THEN 40
                WHEN T1. 현재나이 >=30 THEN 30
                WHEN T1. 현재나이 >=20 THEN 20
                WHEN T1. 현재나이 >=10 THEN 10
                ELSE 0  END"연령대"
    FROM
    (
        -- 나이
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                       WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                        ELSE -1
                  END "현재나이"  
        FROM TBL_SAWON
    ) T1
)T2
GROUP BY ROLLUP(T2.연령대);

--방법 2. → INLINE VIEW 를 한 번 사용
--연령대
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                       WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                       ELSE -1
            END, -1) "연령대"  
FROM TBL_SAWON;



--연령대
SELECT CASE GROUPING(T.연령대) WHEN 0  THEN TO_CHAR(T.연령대) 
         ELSE END "연령대"
    , COUNT(*) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                           WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                           ELSE -1
                END, -1) "연령대"  
    FROM TBL_SAWON;
)T
GROUP BY T.연령대;




SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	    5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
/*
    10	CLERK	    1300        -- 10번 부서 CLACK 직종 급여합
    10	MANAGER	    2450        -- 10번 부서 MANAGER 직종 급여합
    10	PRESIDENT	5000        -- 10번 부서 PRESIDENT 직종 급여합
    10	(null)	    8750        -- 10번 부서 모든직종 급여합
    20	ANALYST	    6000
    20	CLERK	    1900
    20	MANAGER	      2975
    20	(null)	    10875       -- 20번 부서 모든직종 급여합
    30	CLERK	      950
    30	MANAGER	     2850
    30	SALESMAN	     5600
    30	(null)	     9400       -- 30번 부서 모든직종 급여합
(null)	(null)	    29025       -- 모든 부서 모든직종 급여합
*/


--○ CUBE() → ROLLUP()보다 더 자세한 결과를 반환받는다.

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20	    (null)	    10875
30	    CLERK	    950
30	    MANAGER	    2850
30	    SALESMAN	    5600
30	    (null)	    9400
(null)	ANALYST	    6000   -- 모든부서 ANALYST 직종의 급여합       --추가
(null)	CLERK	    4150   -- 모든부서 CLERK 직종의 급여합         --추가
(null)	MANAGER	    8275   -- 모든부서 MANAGER 직종의 급여합       --추가
(null)	PRESIDENT	5000    -- 모든부서 PRESIDENT 직종의 급여합    --추가
(null)	SALESMAN    	5600    -- 모든부서 SALESMAN 직종의 급여합     --추가
(null)	(null)	    29025  
*/
--※ ROLLUP() 과 CUBE()는 
-- 그룹을 묶어주는 방식이 다르다. (차이)

--ex).
-- ROLLUP(A,B,C)
-- (A,B,C)/ (A,B) / (A) / (전체)

-- CUBE(A,B,C)
-- (A,B,C)/ (A,B) / (A,C)/ (B,C) / (A) / (B) / (C) / (전체)
--==>> 위의 과정은(ROLLUP()) 묶음 방식이 다소 모자랄 때가 있고
--      아래 과정은(CUBE()) 묶음 방식이 다소 지나칠 때가 있기 때문에
--      다음과같은 방식의 쿼리를 더 많이 사용하게된다.
--      다음 작성하는 쿼리는 조회하고자하는 그룹만
-- GROUPING SETS 를 이용하여 묶어주는 방식이다.  
--  커스터마이징 하는 느낌
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE '전체부서'
        END"부서번호"
    , CASE GROUPING(JOB) WHEN 0 THEN JOB
        ELSE '전체직종'
        END "직종"
        
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;

/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750

20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875

30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN    	5600
30	        전체직종    	9400

인턴	    CHECK	    3500
인턴	    SALESMAN	    5200
인턴	    전체직종	    8700
전체부서	    전체직종	    37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE '전체부서'
        END"부서번호"
    , CASE GROUPING(JOB) WHEN 0 THEN JOB
        ELSE '전체직종'
        END "직종"
        
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        전체직종	    8750

20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        전체직종	    10875

30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	    5600
30	        전체직종	    9400

인턴	    CHECK	    3500
인턴	    SALESMAN	    5200
인턴	    전체직종	    8700

전체부서	    ANALYST	    6000
전체부서	    CHECK	    3500
전체부서	    CLERK	    4150
전체부서	    MANAGER	    8275
전체부서	    PRESIDENT	5000
전체부서    	SALESMAN	    10800

전체부서	    전체직종	    37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE '전체부서'
        END"부서번호"
    , CASE GROUPING(JOB) WHEN 0 THEN JOB
        ELSE '전체직종'
        END "직종"
        
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE()를 사용한 결과와 같은 조회 결과 반환


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE '전체부서'
        END"부서번호"
    , CASE GROUPING(JOB) WHEN 0 THEN JOB
        ELSE '전체직종'
        END "직종"
        
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO), ())
ORDER BY 1, 2;
--==>> ROLLUP()를 사용한 결과와 같은 조회 결과 반환


--------------------------------------------------------------------------------

-- 실무에서 많이 겪는 문제상황
SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


--○ TBL_EMP 테이블을 대상으로 입사년도별 인원수를 조회한다.
-- 1. HIREDATE 에서 YYYY를 추출한다. 
-- 2. 년도 별 인원수 COUNT() 한다,
-- 3. ROLLUP()으로 전체인원수도 추출한다.

/*
 1980   1
*/
SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"
FROM TBL_EMP
ORDER BY HIREDATE;
/*

*/

SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"
FROM TBL_EMP
GROUP BY ROLLUP (HIREDATE)
ORDER BY HIREDATE;
/*
1980
1981
1981
1981
1981
1981
1981
1981
1981
1981
1982
1987
2022
*/

SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"  --날짜 -> 문자
FROM TBL_EMP
GROUP BY ROLLUP (HIREDATE)
ORDER BY HIREDATE;



SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE))  --TO_NUMBER 도 안됨
ORDER BY HIREDATE;

SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'))  --TO_NUMBER 도 안됨
ORDER BY HIREDATE;


SELECT  TO_CHAR(HIREDATE, 'YYYY') "입사년도"
FROM TBL_EMP
GROUP BY GROUPING SETS(HIREDATE)
ORDER BY HIREDATE;



SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 THEN NVL(TO_CHAR(HIREDATE, 'YYYY'), '인턴')
        ELSE '전체부서'
        END"입사년도묶기"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE))
ORDER BY (HIREDATE);



SELECT ? "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY 입사년도



SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
/*
1980	    1
1981	10
1982	    1
1987	2
2022	    5
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;

SELECT TO_CHAR(HIREDATE , 'YYYY') "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>> (ORA-00979: not a GROUP BY expression)


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE , 'YYYY'))
ORDER BY 1;
--==>> (ORA-00979: not a GROUP BY expression)


-- 숫자기반으로 뽑았는데 문자기반으로 보여줄거야 ->  안된다.
SELECT TO_CHAR(HIREDATE , 'YYYY') "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE , 'YYYY'))
ORDER BY 1;
--==>> 
/*
1980	    1
1981	10
1982    	1
1987	2
2022	    5
        19
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도" 
     , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY ROLLUP EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;


SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
        THEN EXTRACT(YEAR FROM HIREDATE) 
        ELSE '전체'
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)



              ---   문자
SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
        THEN EXTRACT(YEAR FROM HIREDATE  -- 숫자 
        ELSE '전체'
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0   --이 그룹이 문자다
        THEN TO_CHAR(HIREDATE, 'YYYY') 
        ELSE '전체'
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))      --그룹 
ORDER BY 1;
--==>> (ORA-00979: not a GROUP BY expression)



SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0   --이 그룹이 문자다
        THEN TO_CHAR(HIREDATE, 'YYYY') 
        ELSE '전체'
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))      
ORDER BY 1;
--==>> ORA-00979: not a GROUP BY expression
-- SELECT 절에서 문자타입으로 조회해야하는 내용이면

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0   --이 그룹이 문자다
        THEN TO_CHAR(HIREDATE, 'YYYY') 
        ELSE '전체'
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))      
ORDER BY 1;





SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0  
        THEN EXTRACT(YEAR FROM HIREDATE)
        ELSE -1
        END"입사년도"
        , COUNT(*)"인원수"
FROM TBL_EMP
GROUP BY CUBE EXTRACT(YEAR FROM HIREDATE))     
ORDER BY 1;

------------------------------------------------------------------------------------
-- ■■■ HAVING ■■■■ -- 써야하는 상황이오면 WHERE로 쓸 수없나 생각해야한다

--○ EMP 테이블에서 부서번호가 20, 30 인 부서를 대상으로
--   부서의 총급여가 10000 보다 적을 경우만 부서별 총급여를 조회한다.


SELECT 부서의 총급여가 10000 보다 적을
FROM EMP
WHERE 부서번호가 20, 30


SELECT 부서의 총급여가 10000 보다 적을
FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT 부서의 총급여가 10000 보다 적을
FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT 부서의 총급여가 10000 보다 적을
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY CUBE(DEPTNO);

SELECT *
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY ROLLUP(DEPTNO);




SELECT CASE WHEN SUM(SAL)<10000 THEN '10000안넘는다' 
        ELSE '넘는다' END "총급여" 
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY CUBE(DEPTNO);




SELECT CASE WHEN SUM(SAL)<10000 THEN '10000안넘는다' 
            WHEN SUM(SAL)>10000 THEN '20000넘는다'
            ELSE '넘는다' END "총급여" 
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY CUBE(DEPTNO);


SELECT CASE WHEN SUM(SAL)<10000 THEN '10000안넘는다' 
            WHEN SUM(SAL)>10000 THEN '20000넘는다'
            ELSE '넘는다' END "총급여" 
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY CUBE(DEPTNO);


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
        ELSE '전체부서'
        END"부서번호"
    , CASE GROUPING(JOB) WHEN 0 THEN JOB
        ELSE '전체직종'
        END "직종"
        
     , SUM(SAL)"급여합"
FROM TBL_EMP
WHENE DEPTNO IN (20,30)
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--T
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE 부서번호가 20, 30
GROUP BY 부서번호;



SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)  --OR
GROUP BY DEPTNO;
/*
30	9400
20	10875
*/



SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
    AND SUM(SAL) <10000
GROUP BY DEPTNO;
--==>> 에러발생
-- (ORA-00934: group function is not allowed here) WHERE 그룹함수 못쓴다 




SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) <10000;   -- 그룹에대한 조건이니까 헤빙절에 써야한다.
--==>> 30	9400


-- 위아래 결과가 같지만 위가(WHERE)조건절로 추려주는게 더 바람직한 구문 
-- 메모리에 올라가는 양이 다르다


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) <10000
    AND DEPTNO IN (20, 30);
--==>> 30	9400

--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수는 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- MSSQL 은 이마저도 불가능하다.
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
/*
9400
10875
8750
*/
SELECT MAX(SUM(SAL))           -- 2충첩의 의미
FROM EMP
GROUP BY DEPTNO;
--==>> 10875

--RANK() / DENSE_RANK()
--> ORACLE 9i부터 적용 MSSQL 2005 부터 적용.....

--> 하위버전에서는 RANK() 나 DENSE_RANK() 를 사용할 수 없기 때문에
-- 예를 들어....급여 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인 후 (내 앞에 13명이있다면)
-- 확인한 숫자에 +1 추가 연산을 해주면    (나는 +1 한 , 14번째)
-- 그 값이 곧 해당 사원의 등수가 된다.
SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;            -- SMITH의 급여
--==>> 14                   -- SMITH의 급여 등수



SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;           -- 엘런의 급여
--==>> 7                    -- 엘런의 급여 등수


--※ 서브 상관 쿼리(상관 서브 쿼리)
-- 메인 쿼리가 있는 테이블의 컬럼이
-- 서브쿼리의 조건(WHERE절, HANING절)에 사용되는 경우
-- 우리는 이 쿼리문을 서브 상관 쿼리(상관 쿼리)라고 부른다. 반복문처럼 생각
SELECT ENAME"사원명", SAL"급여" ,1 "급여등수"
FROM EMP;


SELECT ENAME"사원명", SAL"급여" ,(SELECT COUNT(*) + 1
                                FROM EMP
                                WHERE SAL > 800) "급여등수"
FROM EMP;


SELECT E.ENAME"사원명", E.SAL"급여" ,(SELECT COUNT(*) + 1
                                     FROM EMP
                                     WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3;
/*
KING	    5000	1
FORD	    3000	2
SCOTT	3000	2
JONES	2975	4
BLAKE	2850	5
CLARK	2450	6
ALLEN	1600	7
TURNER	1500	8
MILLER	1300	9
WARD    	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950	13
SMITH	800	14
*/
-- EMP 테이블을 대상으로 사원명 급여, 부서번호, 부서내급여등수, 전체 급여등수
-- 항목을 조회한다. 
-- 단, RANK() 함수를 사용하지 않고 서브상관쿼리를 활용 할 수 있도록 한다.


SELECT ENAME"사원명", SAL"급여" , 부서번호, 부서내급여등수, 전체 급여등수
FROM EMP;



SELECT T.ENAME"사원명", T.SAL"급여" , T.DEPTNO"부서번호"
    , (SELECT COUNT(*) + 1 , SUM(SAL) 
        FROM EMP          -- 부서별 급여 
        GROUP BY DEPTNO;)"부서내급여등수", ()"전체 급여등수"
FROM EMP T;




SELECT T.ENAME"사원명", T.SAL"급여" , T.DEPTNO"부서번호"
    , (SELECT COUNT(*) + 1 , SUM(SAL) 
        FROM EMP          -- 부서별 급여 
        GROUP BY T.DEPTNO;)"부서내급여등수"
FROM EMP T
ORDER BY 4;



SELECT COUNT(*) + 1 , SUM(SAL) 
FROM EMP          -- 부서별 급여 
GROUP BY DEPTNO;  -- 부서별 급여


-- 내가 한 것
SELECT E.ENAME"사원명", E.SAL"급여" ,E.DEPTNO 부서번호 
            , (SELECT COUNT(*) + 1
               FROM EMP
               WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3, 4; 



-- 친구가한 것 
SELECT E.ENAME"사원명", E.SAL"급여" ,E.DEPTNO 부서번호 
    , (SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL AND DEPTNO = E.DEPTNO) "부서별급여등수"
    , (SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL) "전체급여등수"
FROM EMP E
ORDER BY 3, 4;


------ T 선생님---- 과정이 굉장히 중요
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;   


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800     -- SMITH의 급여
 AND DEPTNO = 20;   -- SMITH의 부서번호
--==> 5             -- SMITH의 부서내 급여 등수


SELECT ENAME"사원명", SAL"급여" ,DEPTNO "부서번호" 
    , (1) "부서내급여등수"
    , (1) "부서내급여등수"
FROM EMP



SELECT ENAME"사원명", SAL"급여" ,DEPTNO "부서번호" 
    , (SELECT COUNT(*) + 1
    FROM EMP
    WHERE SAL > 800   
    AND DEPTNO = 20) "부서내급여등수"
    , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > 800) "전체급여등수"
FROM EMP;




SELECT E.ENAME"사원명", E.SAL"급여" ,E.DEPTNO "부서번호" 
    , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL   
        AND DEPTNO = E.DEPTNO) "부서내급여등수"
    , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "전체급여등수"
FROM EMP E
ORDER BY 3,5;

--○ EMP 테이블 대상으로 다음과같이 조회될 수 있도록 쿼리문을 구성한다. DO
/*
                                - 각 부서 내에서 입사일자별로 누적된 급여의 합
------------------------------------------------------------
사원명  부서번호   입사일       급여     부서내입사별급여누적
------------------------------------------------------------
SMITH	 20	     1980-12-17	     800          800
JONES	 20	     1981-04-02	    2975         3775
FORD	     20	     1981-12-03	    3000         6775
SCOTT	 20	     1987-07-13	    3000          :
ADAMS	 20	     1987-07-13	    1100
*/
-- 친구가 한 것 참고
SELECT E.ENAME"사원명", E.HIREDATE"입사일" , E.DEPTNO "부서번호" , E.SAL"급여"
    , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO AND HIREDATE <= E.HIREDATE) "부서내입사별급여누적"
FROM EMP E
ORDER BY 3, 2;


--내가 시도한 것
SELECT E.ENAME"사원명", E.HIREDATE"입사일" , E.DEPTNO "부서번호" , E.SAL"급여"
    , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL   
        AND DEPTNO = E.DEPTNO) "부서내입사별급여누적"
FROM EMP E
ORDER BY 3, 4;


--내가 시도한 것
SELECT E.ENAME"사원명", E.DEPTNO "부서번호", E.HIREDATE"입사일" , E.SAL"급여"
    , (SELECT SUM(E.SAL)"급여합"
        FROM EMP
        WHERE DEPTNO = E.DEPTNO;) "부서내입사별급여누적"
FROM EMP E;



/*
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;             -- SMITH의 급여
--==>> 14                    -- SMITH의 급여 등수
*/

SELECT *
FROM EMP
ORDER BY DEPTNO, HIREDATE;



SELECT SUM(SAL)"급여합" ,TO_NUMBER(HIREDATE, 'YYYY-MM-DD')"입사일"
FROM EMP
WHERE DEPTNO = 20;   -- 20번 부서의 급여 누적


SELECT SUM(SAL)"급여합"
FROM EMP
WHERE DEPTNO = 20;   -- 20번 부서의 급여 누적


-- HIREDATE 'YYYY-MM-DD'입사별 
--TO_CHAR(HIREDATE, 'YYYY-MM-DD')X


SELECT HIREDATE
FROM EMP
WHERE SAL > 800
    AND DEPTNO = 30;


SELECT SUM(SAL)
FROM EMP
WHERE DEPTNO = E.DEPTNO AND HIREDATE <= E.HIREDATE; 

----T 선생님
SELECT EMP.ENAME"사원명", EMP.DEPTNO"부서번호", EMP.HIREDATE"입사일", EMP.SAL"급여"
        , (1) "부서내입사별급여누적"
FROM SCOTT.EMP
ORDER BY 2,3;



SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (1) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2,3;



SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (SELECT SUM(E2.SAL)
            FROM EMP E2
            WHERE E2.DEPTNO = E1.DEPTNO) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2,3;


SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
        , (SELECT SUM(E2.SAL)
            FROM EMP E2
            WHERE E2.DEPTNO = E1.DEPTNO
             AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2,3;

/*
CLARK	10	1981-06-09	2450    	 2450
KING	    10	1981-11-17	5000	     7450
MILLER	10	1982-01-23	1300	     8750
SMITH	20	1980-12-17	 800	      800
JONES	20	1981-04-02	2975	     3775
FORD	    20	1981-12-03	3000	     6775
SCOTT	20	1987-07-13	3000	    10875
ADAMS	20	1987-07-13	1100	    10875
ALLEN	30	1981-02-20	1600	     1600
WARD	    30	1981-02-22	1250	     2850
BLAKE	30	1981-05-01	2850    	 5700
TURNER	30	1981-09-08	1500    	 7200
MARTIN	30	1981-09-28	1250    	 8450
JAMES	30	1981-12-03	 950	     9400
*/
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
, TO_CHAR(SYSDATE, 'MM-DD') "COL8"         -- 08-17
*/
SELECT *
FROM EMP
ORDER BY HIREDATE;


SELECT COUNT(*) + 1
FROM EMP
GROUP BY HIREDATE; 

SELECT COUNT(*) + 1
FROM EMP
GROUP BY HIREDATE; 



SELECT E.ENAME"사원명", E.HIREDATE"입사일" , E.DEPTNO "부서번호" , E.SAL"급여"
    , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL   
        AND DEPTNO = E.DEPTNO) "부서내입사별급여누적"
FROM EMP E
ORDER BY 3, 4;



SELECT TRUNC(HIREDATE, 'MONTH')"입사년월"
    , (1) "인원수"
FROM EMP
GROUP BY HIREDATE;


SELECT TRUNC(E.HIREDATE, 'MONTH')"입사년월"
    , (SELECT COUNT(*) + 1
        FROM EMP 
        WHERE HIREDATE =E.HIREDATE) "인원수"
FROM EMP E;



SELECT TRUNC(HIREDATE, 'MONTH')"입사년월"
FROM EMP;




SELECT TRUNC(E.HIREDATE, 'MONTH')"입사년월"
    , (SELECT COUNT(*) + 1
        FROM EMP 
        WHERE HIREDATE = E.HIREDATE) "인원수"
FROM EMP E;




SELECT TO_CHAR(HIREDATE, 'YYYY') ||'-'|| TO_CHAR(HIREDATE, 'MM')"입사년월"
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월" ,COUNT(*)"인원수"
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY') ||'-'|| TO_CHAR(HIREDATE, 'MM')"입사년월"
    , ( SELECT COUNT(*) +1
        FROM EMP
        WHERE TO_CHAR(HIREDATE, 'YYYY') ||'-'|| TO_CHAR(HIREDATE, 'MM')) "인원수"
FROM EMP E
ORDER BY 1;




SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월" ,COUNT(*)"인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM EMP GROUP BY TO_
;


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

