SELECT USER
FROM DUAL;
--==>> SCOTT

--�� EMP ���̺��� ������� 
-- �Ի��� ����� ���� ���� ������ ���� MAX(COUNT()) 
-- �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------- -------------
�Ի���  �ο��� 
--------- -------------
1981-02     2
1981-09     2
1987-07     2
--------- -------------
*/


--�ζ��� ����ϴ¹���� ���
-- ������ T
SELECT ENAME, HIREDATE
FROM EMP
ORDER BY 2;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
    , COUNT(*)"�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY');



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
    , COUNT(*)"�ο���"
FROM EMP
WHERE COUNT(*) = 2
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> �����߻�
-- (ORA-00934: group function is not allowed here)

SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
    , COUNT(*)"�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 2 ;



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
    , COUNT(*)"�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (�Ի��� ���� �ִ� �ο�);



SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
    , COUNT(*)"�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) =(SELECT MAX(COUNT(*))
                FROM EMP 
                GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));




SELECT T1.�Ի���, T1.�ο���
FROM 
(
    SELECT TO_CHAR(HIREDATE, 'YY-MM') "�Ի���"
         , COUNT(*) "�ο���"
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YY-MM')
) T1
WHERE T1.�ο��� = (SELECT MAX(T2.�ο���)
                FROM
                (
                SELECT TO_CHAR(HIREDATE, 'YY-MM') "�Ի���"
                     , COUNT(*) "�ο���"
                FROM EMP
                GROUP BY TO_CHAR(HIREDATE, 'YY-MM')
                ) T2
                 )
ORDER BY 1;

-------------------------------------------------------------------------------
-- ���� ROW_NUMBER ���� --

SELECT ENAME "�����" , SAL"�޿�" , HIREDATE"�Ի���" 
FROM EMP;

                        -- ���ȣ�� ���̴� �������� Ȱ��
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
        , ENAME "�����" , SAL"�޿�" , HIREDATE"�Ի���" 
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

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
        , ENAME "�����" , SAL"�޿�" , HIREDATE"�Ի���" 
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


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
        , ENAME "�����" , SAL"�޿�" , HIREDATE"�Ի���" 
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


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
        , ENAME "�����" , SAL"�޿�" , HIREDATE"�Ի���" 
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
                        -- ORACEL      --MYSQL
--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���.....������ �Խù��� �ڸ��� ������ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰԵȴ�.
--   �̴�...���ȼ� �����̳� �̰���...�ٶ������� ���� ���� �� �� �ֱ� ������
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������,
--   �ܼ��� �Խù��� ���ȭ �Ͽ� ����ڿ��� ����Ʈ�������� ������ ������
--   ������� �ʴ°��� �ٶ��� �� �� �ִ�.

--�� SEQUENCE(������: �ֹ���ȣ)  -- ���� ��ȣǥó�� (�Խù���ȣ �ڵ��߻�)
--   �� �������� �ǹ� : 1 . (�Ϸ���) �������� ��ǵ� 2.(���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD    -- �⺻���� ������ ���� ����
START WITH 1                -- ���۰�
INCREMENT BY 1              -- ������
NOMAXVALUE                  -- �ִ�
NOCACHE;                    -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� �ǽ����̺� ����
CREATE TABLE TBL_BOARD              -- TBL_BOARD ���̺� ���� ���� �� �Խ��� ���̺�
( NO           NUMBER               -- �Խù� ��ȣ       X
, TITLE        VARCHAR2(50)         -- �Խù� ����       ��
, CONTENTS     VARCHAR2(1000)       -- �Խù� ����       ��
, NAME         VARCHAR2(20)         -- �Խù� �ۼ���     ��    (ȸ��, ��ȸ��)
, PW           VARCHAR2(20)         -- �Խù� �н�����   ��
, CREATED      DATE DEFAULT SYSDATE -- �Խù� �ۼ���     X
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.



--�� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��� �׼�                        
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ �ڰ�ʹ�','10�и� �ڰ� �ò���','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ ����','������ ���� ����־��','���ҿ�','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����ʹ�','�����̰� �ʹ� ����;��','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����Ŀ�','��ħ�ε� ����Ŀ�','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ʹ��־��','������ ���������� �ʹ� �־��','���¹�','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ڶ��','���� ���� ���ڶ��','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ο�','���� ���� ���� ���ڶ��','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��´��','���ù���� ��´��','�ڿ���','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT *
FROM TBL_BOARD;

/*
1	��~ �ڰ�ʹ�	        10�и� �ڰ� �ò���	        ������	java002$	2022-08-22 10:29:51
2	��~ ����	            ������ ���� ����־��	    ���ҿ�	java002$	2022-08-22 10:29:57
3	����ʹ�	            �����̰� �ʹ� ����;��	    ������	java002$	2022-08-22 10:30:02
4	����Ŀ�	            ��ħ�ε� ����Ŀ�	        ������	java002$	2022-08-22 10:30:06
5	�ʹ��־��	        ������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22 10:30:09
6	���ڶ��	            ���� ���� ���ڶ��	        ������	java002$	2022-08-22 10:30:13
7	���ο�	            ���� ���� ���� ���ڶ��	    ������	java002$	2022-08-22 10:30:17
8	��´��            	���ù���� ��´��	        �ڿ���	java002$	2022-08-22 10:30:20
*/



--�� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.

DROP SEQUENCE SEQ_BOARD;
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����  �Ա⹰ ����, ���� �ۼ��ڴ� ��ĥ �� �ֱ� ������ �����ϰ� ���� �Ǵ� �Խù���ȣ
DELETE 
FROM TBL_BOARD
WHERE NO = 1;
-- 1 �� ��(��) �����Ǿ����ϴ�.


DELETE 
FROM TBL_BOARD
WHERE NO = 6;
-- 1 �� ��(��) �����Ǿ����ϴ�.

DELETE 
FROM TBL_BOARD
WHERE NO = 8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;

--�� �Խù� �ۼ�

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����սô�','�� ���� ������ �ʾƿ�','������','java002$',DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.



--�� �Խù� ����
DELETE 
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
2	��~ ����	������ ���� ����־��	���ҿ�	java002$	2022-08-22 10:29:57
3	����ʹ�	�����̰� �ʹ� ����;��	������	java002$	2022-08-22 10:30:02
4	����Ŀ�	��ħ�ε� ����Ŀ�	������	java002$	2022-08-22 10:30:06
5	�ʹ��־��	������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22 10:30:09
9	�����սô�	�� ���� ������ �ʾƿ�	������	java002$	2022-08-22 10:35:35
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �Խ����� �Խù� ����Ʈ ��ȸ
SELECT NO"�۹�ȣ", TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD;
/*
2	��~ ����	    ���ҿ�	2022-08-22 10:29:57
3	����ʹ�	    ������	2022-08-22 10:30:02
4	����Ŀ�	    ������	2022-08-22 10:30:06
5	�ʹ��־��	���¹�	2022-08-22 10:30:09
9	�����սô�	������	2022-08-22 10:35:35
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ" 
     , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD;
/*
1	��~ ����	���ҿ�	2022-08-22 10:29:57
2	����ʹ�	������	2022-08-22 10:30:02
3	����Ŀ�	������	2022-08-22 10:30:06
4	�ʹ��־��	���¹�	2022-08-22 10:30:09
5	�����սô�	������	2022-08-22 10:35:35
*/



-- ������
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ" 
     , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
/*
5	�����սô�	������	2022-08-22 10:35:35
4	�ʹ��־��	���¹�	2022-08-22 10:30:09
3	����Ŀ�	    ������	2022-08-22 10:30:06
2	����ʹ�	    ������	2022-08-22 10:30:02
1	��~ ����	    ���ҿ�	2022-08-22 10:29:57
*/


--------------------------------------------------------------------------------

--���� JOIN(����) ����--  ���������� �߿��� ������ �󸶳� �� Ȱ�� �ϴ����� ����

-- 1. SQL 1992 CODE 

-- CROSS JOIN   
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CATERSIAN PRODUCT) 14 * 4
--  �� ���̺��� ������ ��� ����� ��   

-- EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
-- ��� �� ����
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- ��Ī ����
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


-- NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ű�� ���� ���
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


-- EQUI JOIN  ��(+) �� Ȱ���� ���� ���
SELECT *        
FROM TBL_EMP;   -- 19��

SELECT *
FROM TBL_DEPT;  -- 4��



SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�Ȼ�Ȳ
-- ��, �μ���ȣ�� �������� �����(5) ��� ����
-- ����, �Ҽ� ����� ���� ���� �μ�(1) �� ����

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
-- ��� ���� ���� = �ű⿡ ��Ī�Ǵ°��� �߰��Ѵ�.

--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �Ҽ� ����� ���� ���� �μ�(1) ����   ----(+)
--  �μ���ȣ�� ���� ���� �����(5) ��� ��ȸ


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--               �곻 ���� ����
--> �� 15���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �μ���ȣ�� ���� ���� (5)�� ��� ����   ----(+)
--  �Ҽ� ����� ���� ���� �μ�(1) ��ȸ


--�� (+)�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��            -- ����
--   (+)�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·� -- �߰�(÷��)


-- �̿� ���� ������...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- �̷� ������ JOIN �� �������� �ʴ´�. ������ ����.
--==>> (ORA-01468: a predicate may reference only one outer-joined table)



SELECT *
FROM DEPT;

SELECT *
FROM EMP;

-- 2. SQL 1999 CODE         �� ��JOIN�� Ű���� ����  �� JOIN(����)�� ���� ���
--                         �� ��ON�� Ű���� ����    �� ���� ������ WHERE ��� ON

-- CROSS JOIN               �̶����� ����ϰ� �ٲ�

SELECT *
FROM EMP CROSS JOIN DEPT;    -- , ��� CROSS JOIN ���


-- INNER JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���

SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D              -- , �ڸ��� JOIN
ON E.DEPTNO = D.DEPTNO;             -- WHEWE �ڸ��� ON
-- INNER JOIN ���� INNER �� ���� ����


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
-- ��

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
8005	    ������	SALESMAN	    7698    	22/08/19	1000					
8004	    ������	SALESMAN	    7698    	22/08/19	2500					
8003	    �躸��	SALESMAN	    7698    	22/08/19	1700					
8002    	������	CHECK	    7566    	22/08/19	2000	10				
8001	    ���¹�	CHECK	    7566	    22/08/19	1500	10				
*/


SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- �� �߰�
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


-- OUTER JOIN ���� OUTER ���� ����


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
--> �̿� ���� ������� �������� �����ص�
-- ��ȸ ����� ��� ������ ������ ����.


SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK';
--> ������ �̿Ͱ��� �����Ͽ�
--  WHERE �� WHERE�� ��ȸ�ϴ� ���� �����Ѵ�.

--------------------------------------------------------------------------------
--�� EMP ���̺�� DEPT ���̺��� �������
--  ������ MANAGER  �� CLERK �� ����鸸
--  �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.DO

SELECT E.DEPTNO "�μ���ȣ", ENAME"�μ���", ENAME"�����", JOB"������", SAL"�޿�"
FROM EMP E JOIN DEPT D  --JOIN ��� ,
ON E.JOB = D.JOB        
WHERE E.JOB, D.JOB = IN('MANAGER', 'CLERK');

SELECT *
FROM DEPT;

SELECT *
FROM EMP;


SELECT DEPTNO "�μ���ȣ", ENAME"�μ���", ENAME"�����", JOB"������", SAL"�޿�"
FROM EMP E JOIN DEPT D  --JOIN ��� ,
ON E.JOB = D.JOB        
WHERE E.JOB, D.JOB = IN('MANAGER', 'CLERK');


SELECT *
FROM EMP E FULL JOIN DEPT D  --JOIN ��� ,
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = 'MANAGER' ; -- �̰ǰ���


SELECT *
FROM EMP E FULL JOIN DEPT D  --JOIN ��� ,
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = 'MANAGER' OR 'CLERK';  -- �̰� �Ұ���



DEPTNO "�μ���ȣ", ENAME"�μ���", ENAME"�����", JOB"������", SAL"�޿�"

SELECT *
FROM EMP E JOIN DEPT D 
ON E.DEPTNO = D.DEPTNO        
WHERE E.JOB = IN('MANAGER', 'CLERK');



--T
SELECT *
FROM EMP;

SELECT *
FROM DEPT;  -- DEPTNO ��(�����) �� �ϳ��ִ°� �̰��� �θ����̺��̴�

-- �μ���ȣ, �μ���, �����, ������ ,�޿�"
-- DEPTNO ,  DNAME,  ENAME, JOB, SAL
-- E, D      D       E     E     E 


SELECT DEPTNO, ENAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>(ORA-00918: column ambiguously defined)
--  �� ���̺� �� �ߺ��Ǵ� �÷��� ����
--  �Ҽ� ���̺��� �������(��������)�Ѵ�.


SELECT E.DEPTNO, ENAME, ENAME, JOB, SAL     -- �ڽĸ��XXXX
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;



SELECT D.DEPTNO, ENAME, ENAME, JOB, SAL     -- �θ���OOOOOO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--�� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�.
SELECT *
FROM EMP;  -- �ڽ� ���̺�

SELECT *
FROM DEPT; -- �θ� ���̺�


   -- �ʼ����� , ������� , ������� , ������� , �������
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �� ���̺� ��� ���ԵǾ��ִ� �ߺ��� �ø��� �ƴϴ���
-- �÷��� �Ҽ� ���̺��� ����� �� �� �ֵ��� �����Ѵ�.

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
 AND E.JOB = 'MANAGER' OR 'CLERK';  --??


SELECT D.DEPTNO, ENAME, ENAME, JOB, SAL    
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;




--------------------------------------------------------------------------------

--�� SELF JOIN(�ڱ� ����)
-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------------------------------------------------------
-- �����ȣ �����  ������  �����ڹ�ȣ  �����ڸ�  ������������
--------------------------------------------------------------------------------
-- 7369     SMITH   CLERK   7902       FORD      ANALYST
---------------------------------- E1
                           ------------------------------- E2

SELECT *
FROM EMP;




SELECT �����ȣ �����  ������  �����ڹ�ȣ  �����ڸ�  ������������
FROM EMP SELF JOIN;



SELECT  E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , E.EMPNO"�����ڹ�ȣ",E.ENAME"�����ڸ�", E.JOB"������������"
FROM EMP E SELF JOIN E
ON E.MGR = D.MGR;




SELECT  E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , E.EMPNO"�����ڹ�ȣ",E.ENAME"�����ڸ�", E.JOB"������������"
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;


-- ���� �� ��
SELECT  E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , D.EMPNO"�����ڹ�ȣ",D.ENAME"�����ڸ�", D.JOB"������������"
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;

SELECT COUNT(*)
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO;
--==>> 13

SELECT E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , D.EMPNO"�����ڹ�ȣ",D.ENAME"�����ڸ�", D.JOB"������������"
FROM EMP E RIGHT JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 21
-- ��,,,LEFT�� �ؾ��ϳ�??

SELECT E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , D.EMPNO"�����ڹ�ȣ",D.ENAME"�����ڸ�", D.JOB"������������"
FROM EMP E LEFT JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 14

SELECT E.EMPNO"�����ȣ", E.ENAME"�����", E.JOB"������"
     , D.EMPNO"�����ڹ�ȣ",D.ENAME"�����ڸ�", D.JOB"������������"
FROM EMP E FULL JOIN EMP D
ON E.MGR = D.EMPNO;
--==>> 22


-- T
SELECT EMPNO"�����ȣ", ENAME"�����" , JOB"������", MGR"�����ڹ�ȣ" ,ENAME"�����ڸ�", JOB"������ ������"
FROM EMP;



SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����" , E1.JOB"������"
     , E2.EMPNO"�����ڹ�ȣ" ,E2.ENAME"�����ڸ�", E2.JOB"������ ������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>> KING ���� �� ��Ȳ


SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����" , E1.JOB"������"
     , E2.EMPNO"�����ڹ�ȣ" ,E2.ENAME"�����ڸ�", E2.JOB"������ ������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

--  �� 1999 �Ʒ� 1922 ����

SELECT E1.EMPNO"�����ȣ", E1.ENAME"�����" , E1.JOB"������"
     , E2.EMPNO"�����ڹ�ȣ" ,E2.ENAME"�����ڸ�", E2.JOB"������������"
FROM EMP E1 , EMP E2
WHERE E1.MGR = E2.EMPNO(+);









