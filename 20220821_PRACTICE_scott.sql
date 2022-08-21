SELECT USER
FROM DUAL;
--==>> SCOTT



SELECT CASE T.성별 WHEN 1 THEN '남성' 
		   WHEN 2 THEN '여성' 
		ELSE '모든사원' 
		END"성별"
		SUM(T.급여) "급여합"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN 1
	   	 WHEN SUBSTR(JUBUN, 7,1) IN ('2' ,'4') THEN 2
	  	 ELSE 0
	   	END"성별"
	  	, SAL(급여)
	FROM TBL_SAWON 
)T
GROUP BY ROULLUP(T.성별);





SELECT NVL(T.성별 , '모든사원')"성별"
	, SUM(T.급여)"급여합"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3')THEN '남'
	   	    WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4')THEN '여'  
		ELSE '성별식별불가' 
		END "성별"
		, SAL"급여"
	FROM TBL_SAWON
) T
GROUP BY ROULLUP(T.성별);



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

SELECT CASE GROUPUNG(T.현재나이) WHEM  0 THEN TO_CHAR(T.현재나이)
	 ELSE NVL(TO_CHAR(T.현재나이),'전체')  END"연령대"
	COUNT(*)"인원수"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '2') 
			THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899)),-1)
	    	    WHEN SUBSTR(JUBUN, 7,1) IN ('3', '4') 
			THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999)), -1)
			ELSE -1 END"현재나이"
	FROM TBL_SAWON 
) T
GROUP BY ROLLUP(T.현재나이);




SELECT CASE WHEN T.현재나이 50 >= THEN 50
            WHEN T.현재나이 30 >= THEN 30
            WHEN T.현재나이 20 >= THEN 20
            WHEN T.현재나이 10 >= THEN 10
                       ELSE 0 
                       END "연령대"
            , COUNT(*) "인원수"
            
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
GROUP BY ROLLUP(T. 현재나이);





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




GROUPING SETS




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



SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY=MM'));


















