SELECT USER
FROM DUAL;
--==>> SCOTT

--�� UNION �� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�.
--   �ݸ�, UNION ALL �� ���յ� ����(�������� ���̺��� ����� ����)���
--   ��ȸ�� ����� �ִ� �״�� ��ȯ�Ѵ�.(���� ����)
--   �̷� ���� UNION�� ���ϰ� ��ũ��.(���ҽ� �Ҹ� �� ũ��.)
--   ����, UNION �� ������� �ߺ���(���� �Ȱ���) ���ڵ�(��)�� �����Ұ��
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�.
-- ����� UNION �� ������ UNION ALL�� ������ �� ���Ƽ� ���󵵰� ����.
-- DISTINCT �ߺ�����

--�� ���ݱ��� �ֹ����� �����͸� ����
-- ��ǰ �� �� �ֹ����� ��ȸ�� �� �ִ� �������� �����Ѵ�. DO
-------------------JECODE �� ������ JUSU �� ��
--������ N�� ����Ĩ N ��

SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP;


SELECT JECODE"��ǰ��", SUM(JUSU) "���ֹ���"
FROM TBL_JUMUN J
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP U
WHERE J.JECODE = U.JECODE;





SELECT JECODE"��ǰ��", SUM(JUSU) "���ֹ���"
FROM TBL_JUMUN J
UNION ALL
SELECT JECODE"��ǰ��", SUM(JUSU) "���ֹ���"
FROM TBL_JUMUNBACKUP U
WHERE J.JECODE = U.JECODE
ORDER BY 2;

-------------------------T ������
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT JECODE, JUSU
FROM TBL_JUMUN;


SELECT T.JECODE"��ǰ�ڵ�", SUM(T.JUSU) "�ֹ�����"
FROM  
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T
GROUP BY T.JECODE;

/*
����Ĩ	30
������	20
ġ�佺	20
������	70
�����	10
���Ͻ�	20
���̽�	40
��īĨ	20
����Ĩ	20
������	30
��ǹ�	20
������	110
������	30
���ڱ�	40
Ȩ����	40
������	10
�Ҹ���	10
����ƽ	40
*/

--�� INTERSECT / MINUS (�����հ� ������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ������� ���� �Ȱ��� �ุ �����ϰ����Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���ڱ�	20
������	30
Ȩ����	10
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>> �����տ� �ش��ϴ� �κ��� �����ϰ� ������ ���
/*
������	20
����Ĩ	20
������	10
������	10
��ǹ�	20
�����	10
����Ĩ	20
������	20
������	10
�Ҹ���	10
ġ�佺	20
����ƽ	10
����ƽ	20
��īĨ	20
*/
-- �� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� �������
--   ��ǰ�ڵ�� �ֹ����� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ�Ѵ�.
SELECT T.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", T.JUDAY"�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T;




SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT JECODE, JUSU
FROM TBL_JUMUN
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT JECODE, JUSU
FROM TBL_JUMUN;



SELECT JECODE, JUSU, JUNO
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU, JUNO
FROM TBL_JUMUN;




SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T , (SELECT *
        FROM TBL_JUMUN;
        UNION ALL
        SELECT *
        FROM TBL_JUMUNBACKUP
        ) U;






SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T , (SELECT *
        FROM TBL_JUMUN
        UNION ALL
        SELECT *
        FROM TBL_JUMUNBACKUP
        ) U;






SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T , (SELECT *
        FROM TBL_JUMUN
        UNION ALL
        SELECT *
        FROM TBL_JUMUNBACKUP
        ) U;




    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN;
    
SELECT *    
FROM TBL_JUMUNBACKUP
MINUS
SELECT *
FROM TBL_JUMUN;
    
    



SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T ,(SELECT *
        FROM TBL_JUMUN
        UNION ALL
        SELECT *
        FROM TBL_JUMUNBACKUP
        ) U;







SELECT T.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", T.JUDAY"�ֹ�����"



    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN


SELECT JECODE, JUSU
FROM TBL_JUMUN



SELECT U.JUNO"�ֹ���ȣ", U.JECODE"��ǰ�ڵ�", U.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM TBL_JUMUNBACKUP U LEFT JOIN TBL_JUMUN J
ON U.JECODE = J.JECODE AND U.JUSU= J.JUSU;


SELECT U.JUNO"�ֹ���ȣ", U.JECODE"��ǰ�ڵ�", U.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM TBL_JUMUNBACKUP U RIGHT JOIN TBL_JUMUN J
ON U.JECODE = J.JECODE AND U.JUSU= J.JUSU;




SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", U.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T
JOIN 
(SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP
)U
ON T.JECODE= U.JECODE 
ORDER BY 2,4;







SELECT U.JUNO"�ֹ���ȣ", T.JECODE"��ǰ�ڵ�", U.JUSU"�ֹ���", U.JUDAY"�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T
JOIN 
    (SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
)U
ON T.JECODE = U.JECODE 
WHERE T.JUSU = U.JUSU
ORDER BY 2,4;





------------------------T ������ Ǯ��

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

/*
1	ġ�佺	20	2001-11-01
2	������	10	2001-11-01
3	������	30	2001-11-01
4	������	10	2001-11-02
5	��īĨ	20	2001-11-02
6	�Ҹ���	10	2001-11-03
7	���ڱ�	20	2001-11-04
8	��ǹ�	20	2001-11-04
9	�����	10	2001-11-05
10	����Ĩ	20	2001-11-05
11	Ȩ����	10	2001-11-05
12	Ȩ����	10	2001-11-05
13	����Ĩ	20	2001-11-06
14	������	10	2001-11-07
15	������	20	2001-11-08
16	����ƽ	10	2001-11-09
17	������	20	2001-11-10
18	Ȩ����	10	2001-11-11
19	����ƽ	10	2001-11-12
20	����ƽ	20	2001-11-13
98764	����Ĩ	10	2022-08-22
98765	������	30	2022-08-22
98766	������	20	2022-08-22
98767	���̽�	40	2022-08-22
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98770	������	10	2022-08-22
98771	���Ͻ�	20	2022-08-22
98772	������	30	2022-08-22
98773	������	20	2022-08-22
98774	������	50	2022-08-22
98775	������	10	2022-08-22
*/

SELECT JUNO, JECODE, JUSU, JUDAY
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JUNO, JECODE, JUSU, JUDAY
FROM TBL_JUMUN;
--==>> ��ȸ ��� ����
--> INTERSECT ���������� ���� ���� �� ����



-- ���1.

SELECT T2.JUNO"�ֹ���ȣ", T1.JECODE"��ǰ�ڵ�", T1.JUSU"�ֹ���", T2.JUDAY"�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T1
JOIN 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU
ORDER BY 2;
/*
98769	���ڱ�	20	2022-08-22
7	    ���ڱ�	20	2001-11-04
3	    ������	30	2001-11-01
98772	������	30	2022-08-22
98768	Ȩ����	10	2022-08-22
18	    Ȩ����	10	2001-11-11
11	    Ȩ����	10	2001-11-05
12	    Ȩ����	10	2001-11-05
*/




-- ���2.
SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('���ڱ�','������','Ȩ����')
  AND T.JUSU IN (20,30,10);
--==>> ���ڱ� 20,30,10 �� ã�ƶ� 
--> �߸� �� ������


SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE�� T.JUSU�� ���� ����� '���ڱ�20', '������30','Ȩ����10'



SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN('���ڱ�20', '������30','Ȩ����10');




SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN( SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUNBACKUP
                                    INTERSECT
                                    SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUN );




-------------------------------------------------------------------------------
-- �̷��͵� �ִ�......
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	    5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	    JONES	2975
20	RESEARCH	    FORD	    3000
20	RESEARCH	    ADAMS	1100
20	RESEARCH	    SMITH	800
20	RESEARCH	    SCOTT	3000
30	SALES	    WARD	    1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
--==>> ���� �߻�



SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	    JONES	2975
20	RESEARCH	    FORD	3000
20	RESEARCH	    ADAMS	1100
20	RESEARCH	    SMITH	800
20	RESEARCH	    SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
--==>> ����Ŭ�� ����, ���� �� �÷� ã���ְ�, ��õ� ���ص��ǰ� 
--> �����Ͱ� ���� �ʰų�, ����-���� ���谡 �ִ��� ������ Ȯ�� �뵵�θ� Ȯ��


SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D
USING(DEPTNO);
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING    	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	    JONES	2975
20	RESEARCH	    FORD	    3000
20	RESEARCH	    ADAMS	1100
20	RESEARCH	    SMITH	800
20	RESEARCH	    SCOTT	3000
30	SALES	    WARD	    1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/


-------------------------------------------------------------------------------

--�� TBL_EMP ���̺��� �޿��� ���� ���� �����
-- �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�. DO
SELECT �����ȣ, �����, ������, �޿�
FROM TBL_EMP
WHERE �޿��� ���� ���� ���;

SELECT *
FROM TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL IN(SELECT MAX(SAL)
            FROM TBL_EMP);

-- ���� ������ �� : �������� ����

SELECT MAX(SAL)
FROM TBL_EMP



---------------------------------- ������ T
--�޿��� ���� ���� ����� �޿�

SELECT MAX(SAL)
FROM TBL_EMP;


SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE �޿��� ���� ���� ����;


SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL = (�޿��� ���� ���� ����);


SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM TBL_EMP);

--��=ANY��
-- IN ó�� �ȿ����� � �� 


--��=ALL��
-- ��ü ���� ���Ͽ� ��� �����ؾ߸� true �̴�.
--
SELECT SAL
FROM TBL_EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
1500
2000
1700
2500
1000
*/


SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL = ANY(800,1600, 1250,2975,1250,2850,2450,3000
                ,5000,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);

-- ���Ʒ� ����� ����.
/*
7369	SMITH	CLERK	    800
7499	ALLEN	SALESMAN	    1600
7521    	WARD    	SALESMAN	    1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	    1250
7698	BLAKE	MANAGER	    2850
7782    	CLARK	MANAGER	    2450
7788	SCOTT	ANALYST	    3000
7839	KING    	PRESIDENT	5000
7844	TURNER	SALESMAN	    1500
7876	ADAMS	CLERK	    1100
7900    	JAMES	CLERK	    950
7902    	FORD    	ANALYST	    3000
7934	MILLER	CLERK	    1300
8001    	���¹�	CHECK	    1500
8002    	������	CHECK	    2000
8003    	�躸��	SALESMAN	    1700
8004    	������	SALESMAN	    2500
8005    	������	SALESMAN    	1000
*/

SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL >= ANY(800,1600, 1250,2975,1250,2850,2450,3000
                ,5000,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);


SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL >= ALL(800,1600, 1250,2975,1250,2850,2450,3000
                ,5000,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);
-- ������ �޿��� 800,...���� �ų� ���ƾ��Ѵ�.

--==>> 7839	KING	PRESIDENT	5000
-- MAX�� �����ʰ� �ִ��� ���ϴ� ��� >=ALL




SELECT EMPNO, ENAME, JOB,SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL
                FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000



--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ����� ��
-- �޿��� ���� ���� �����
-- �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�. DO

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE 20 �� �μ��� �ٹ��ϴ� ���, �޿��� ���帹�� ���



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL =(SELECT SAL(MAX)
                        FROM TBL_EMP);

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE DEPTNO = 20;



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL >=ANY(SELECT SAL
                                FROM TBL_EMP);



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL >=ANY(SELECT MAX(SAL)
                               FROM TBL_EMP);



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL
            FROM TBL_EMP
            WHERE DEPTNO = 20); 
             
                  
SELECT *                   
FROM TBL_EMP;

-- �� ������ 

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL
            FROM TBL_EMP
            WHERE DEPTNO = 20) 
AND DEPTNO = 20;


                               
------------------ T ������

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
            FROM TBL_EMP)
    AND DEPTNO =20;
-- �޿��� 5000�̸鼭 �μ��� 20�� �� ���?   
--==>> ��ȸ ��� ����



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL) -- �� ������ 20�� �μ����� �ִ�޿�
            FROM TBL_EMP
            WHERE DEPTNO =20)
    AND DEPTNO =20;
    -- ��ü���� 20�� �μ��� �ٹ��ϰ� �ִ»���� ã�ƶ�
    
    
SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL >=ALL (SELECT SAL 
                FROM TBL_EMP
                WHERE DEPTNO = 20)
AND DEPTNO = 20;
--2��ø�ۿ� ������ ����ؾ��Ѵ�.


--�� TBL_EMP ���̺��� ����(Ŀ�̼�, COMM) �� ���� ���� �����
-- �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼� �׸��� ��ȸ�Ѵ�.

SELECT �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼�
FROM TBL_EMP
WHERE ����(Ŀ�̼�, COMM) �� ���� ���� ���;

SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE ����(Ŀ�̼�, COMM) �� ���� ���� ���;




SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM  = (COMM�� ���� ū����);

SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM  = ( SELECT *
                FROM TBL_EMP
                NVL(COMM, 0));
                
                
                
SELECT NVL(COMM,0)"����"
FROM TBL_EMP;



-- ���� �� �� 
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM  >=ALL (SELECT NVL(COMM,0)
                   FROM TBL_EMP);
 
 
 
 ------------------ T ������
 SELECT �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼�
 FROM TBL_EMP
 WHERE ����(Ŀ�̼�, COMM) �� ���� ����;
 
 
 
 
 SELECT �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼�
 FROM TBL_EMP
 WHERE COMM = (��� ������ �� �ְ� Ŀ�̼�);
 
 
 
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
 FROM TBL_EMP
 WHERE COMM = ( SELECT MAX(COMM)
                FROM TBL_EMP);
 
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM >=ALL( SELECT COMM
                FROM TBL_EMP);
 
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM >=ALL( SELECT COMM
                FROM TBL_EMP);
 
 /*
  SELECT COMM
                FROM TBL_EMP
(null)              
(null)              
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
10
10
(null)
(null)
(null)
 */
 
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM >=ALL(NULL ,NULL ,300, 500, NULL , NULL ,NULL ,NULL , 0,NULL , 10,10);           
--==>> ��ȸ�������

                
                
                
SELECT EMPNO"�����ȣ", ENAME"�����", DEPTNO"�μ���ȣ", JOB"������", COMM"Ŀ�̼�"
FROM TBL_EMP
WHERE COMM  >=ALL (SELECT COMM
                   FROM TBL_EMP
                   WHERE COMM IS NOT NULL);
--==>> 7654	MARTIN	30	SALESMAN	1400
                
SELECT COMM
FROM TBL_EMP
WHERE COMM IS NOT NULL;
/*
300
500
1400
0
10
10
*/

--------------------------------------------------------------------------------

--�� DISTINCT() �ߺ� ��(���ڵ�)�� �����ϴ� �Լ�

-- TBL_EMP  ���̺��� �����ڷ� ��ϵ� �����
-- �����ȣ �����, �������� ��ȸ�Ѵ�.


SELECT *
FROM TBL_EMP;

SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"������"
FROM TBL_EMP E1 JOIN TBL_EMP E2 
ON E1.EMPNO = E2.MGR
ORDER BY 1;
/*
7566	JONES	MANAGER
7566	JONES	MANAGER
7566	JONES	MANAGER
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7698	BLAKE	MANAGER
7782	    CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	    PRESIDENT
7839	KING	    PRESIDENT
7839	KING	    PRESIDENT
7902	    FORD    	ANALYST
*/

SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"������"
FROM TBL_EMP E1 JOIN TBL_EMP E2 
ON E2.EMPNO = E1.MGR
ORDER BY 1;
/*
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521    	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	    CLARK	MANAGER
7788	SCOTT	ANALYST
7844	TURNER	SALESMAN
7876	ADAMS	CLERK
7900	    JAMES	CLERK
7902	    FORD	ANALYST
7934	MILLER	CLERK
8001    	���¹�	CHECK
8002	    ������	CHECK
8003	    �躸��	SALESMAN
8004	    ������	SALESMAN
8005	    ������	SALESMAN
*/


--------------------- T ������ Ǯ��
SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"������"
FROM TBL_EMP
WHERE �����ڷ� ��ϵ� ���;



SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����", E1.JOB"������"
FROM TBL_EMP
WHERE �����ȣ = (������(MGR)�� ��ϵ� ���);

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������"
FROM TBL_EMP
WHERE EMPNO = (������(MGR)�� ��ϵ� ���);



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������" ,MGR
FROM TBL_EMP
WHERE EMPNO = (������(MGR)�� ��ϵ� ���);




SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������"
FROM TBL_EMP
WHERE EMPNO IN (7902, 7698, 7698, 7839,7698,7839,7839,7566,NULL
                ,7698,7788,7698,7566,7782,7566,7566,7698,7698,7698);




SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������"
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);
                
                
SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������"
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);       
                
SELECT DISTINCT(MGR)
FROM TBL_EMP    
--==>> 
/*
7839
NULL
7782
7698
7902
7566
7788*/



SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������"
FROM TBL_EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR)
                FROM TBL_EMP);     
--==>> 
/*
7902    	FORD	    ANALYST
7698	BLAKE	MANAGER
7839	KING	    PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782    	CLARK	MANAGER
*/


SELECT JOB
FROM TBL_EMP;

SELECT DISTINCT(JOB)
FROM TBL_EMP;
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
CHECK
*/

SELECT DEPTNO
FROM TBL_EMP;


SELECT DISTINCT(DEPTNO)
FROM TBL_EMP;
/*
30

20
10
*/

-------------------------------------------------------------------------------
-- �ǹ����� ����� �ؾ��ϴµ�.......


SELECT *
FROM TBL_SAWON;


--�� TBL_SAWON ���̺� ���(������ ����)  �� �� ���̺� ���� ���質 �������� ���� ������ ����
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
-- TBL_SAWON ���̺��� �����͵鸸 �������
-- ��, �ٸ� �̸��� ���̺� ���·� ���� �� �� ��Ȳ


--��  ������ ����      ��������� 2���� �� �̷��� ����Ű��..?�� ��UPDATE �� ��WHERE ��SET�� 
UPDATE TBL_SAWON
SET SANAME = '�ʶ���'
WHERE SANO = 1005;


UPDATE TBL_SAWON
SET SANAME = '�ʶ���';


SELECT *
FROM TBL_SAWONBACKUP;
    
    
    
  -- �� ��      -- ���� ��
UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO =1001)
WHERE SANAME ='�ʶ���';



UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME ='�ʶ���';
--==>> 16�� �� ������Ʈ
SELECT *
FROM TBL_SAWON;

COMMIT;











