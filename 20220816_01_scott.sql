SELECT USER
FROM DUAL;
--==>> SCOTT


-- �� TBL_EMP ���̺��� �Ի����� 1981�� 4�� 2�� ����
-- 1981�� 9�� 28�� ���̿� �Ի��� ��������
-- �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�. (�ش��� ����)


--SELECT �����, ������, �Ի���
--FROM TBL_EMP
--WHERE �Ի����� 1981�� 4�� 2�� ���� 1981�� 9�� 28�� ����

-- ���ǿ����� ������ ǥ�� �ΰ��̻��� ����....�� ��������
SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE 1981�� 4�� 2�� <= �Ի��� <= 1981�� 9�� 28��;

SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE 1981�� 4�� 2�� <= �Ի���
   AND �Ի��� <= 1981�� 9�� 28��;
   



--���� �Ѱ� ,,,,,
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') > TO_DATE('1981-09-28', 'YYYY-MM-DD');



SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-05-01
CLARK	MANAGER	1981-06-09
TURNER	SALESMAN	1981-09-08
*/
--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

-- ��
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	    1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	    1981-09-08
*/

--�� ��BETWEEN �� AND �Ρ��� ����� ���� ���ϰ� �������̰� ���������δ� �ε�ȣ�� ó���ȴ�. (�������)
--�� BETWEEN �� AND �� 
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02', 'YYYY-MM-DD')
                   AND TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	    1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	    1981-09-08
*/

--�� TBL_EMP ���̺��� �޿�(SAL)�� 2450���� 3000 ������ �������� ��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
WHERE SAL BETWEEN 2450 AND 3000;
--==>>
/*
7566	    JONES	MANAGER	7839	1981-04-02	2975		20
7698	    BLAKE	MANAGER	7839	1981-05-01	2850		30
7782    	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		20
7902    	FORD	    ANALYST	7566	1981-12-03	3000		20
*/


--�� TBL_EMP ���̺��� �������� �̸��� 
-- 'C'�� �����ϴ� �̸����� 'S'�� �����ϴ� �̸��� ���
-- ��� �׸��� ��ȸ�Ѵ�. CHACK~!~!  
SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S';        -- ������ �迭 ���� S����!!!�̴�.
--==>>
/*
        C 
7566	    JONES	MANAGER	7839	    1981-04-02	    2975		20
7654    	MARTIN	SALESMAN	7698	    1981-09-28	    1250	1400	30
7782    	CLARK	MANAGER	7839	    1981-06-09	    2450		10
7839    	KING	    PRESIDENT		1981-11-17	    5000		10
7900	    JAMES	CLERK	7698	    1981-12-03	    950		30
7902    	FORD	    ANALYST	7566	    1981-12-03	    3000		20
7934    	MILLER	CLERK	7782	    1982-01-23	    1300		10
        S
*/

--��  ��BETWEEN �� AND �Ρ� �� ��¥��, ������, ������ ������ ��ο� ������ �ȴ�.
-- ��, �������� ��� �ƽ�Ű�ڵ� ������ �����⶧���� (������ �迭)
-- �빮�ڰ� ���ʿ� ��ġ�ϰ� �ҹ��ڰ� ���ʿ� ��ġ�Ѵ�.
-- ����, ��BETWEEN �� AND �Ρ��� �ش� ������ ����Ǵ� ��������
-- ����Ŭ ���������δ� �ε�ȣ �������� ���·� �ٲ�� ���� ó���ȴ�.

SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 's';        -- ������ �迭 ���� S����!!!�̴�.


--�� ASCII()
-- �Ű������� 

SELECT ASCII('A'), ASCII('B'),ASCII('a'),ASCII('b')
FROM DUAL;
--==>> 65	66	97	98

-- ����Ŭ���� 1�� ����
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
   OR JOB = 'CLERK';

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN ('SALESMAN','CLERK');

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB =ANY ('SALESMAN', 'CLERK');


--�� ���� 3���� ������ �������� ��� ���� ����� ��ȯ�Ѵ�.
--  ������ �� ���� ������(OR)�� ���� ������ ó���ȴ�.(���� �� �ȵ�����...)
--  ���� �޸𸮿� ���� ������ �ƴ϶� CPU ó���� ���� �����̹Ƿ�
--  �� �κб��� �����Ͽ� �������� �����ϰԵǴ� ���� ���� �ʴ�.
--  ��IN�� �� ��=ANY�� �� ���� ������ ȿ���� ������.
--  �̵� ��� ���������δ� ��OR�� ������ ����Ǿ� ���� ó���ȴ�.

DROP TABLE TBL_SAWON;
--==>> Table TBL_SAWON��(��) �����Ǿ����ϴ�. �����뿡 ���� ����!


PURGE RECYCLEBIN;
--==>> RECYCLEBIN��(��) ��������ϴ�.


--�� �߰� �ǽ� ���̺� ����(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO       NUMBER(4)
, SANAME     VARCHAR2(30)
, JUBUN      CHAR(13)
, HIREDATE   DATE        DEFAULT SYSDATE
, SAL        NUMBER(10)
);
--==>> Table TBL_SAWON��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_SAWON;


DESC TBL_SAWON;
--==>>
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/

--�� ������ ���̺� ������ �Է�(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '����', '9409252234567', TO_DATE('2005-01-03', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '�躸��', '9809022234567', TO_DATE('1999-11-23', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '���̰�', '9810092234567', TO_DATE('2006-08-10', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '���α�', '9307131234567', TO_DATE('1998-05-13', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '������', '7008161234567', TO_DATE('1998-05-13', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '������', '9309302234567', TO_DATE('1999-10-10', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '������', '0302064234567', TO_DATE('2010-10-23', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '�μ���', '6807102234567', TO_DATE('1998-03-20', 'YYYY-MM-DD'), 1500);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '������', '6710261234567', TO_DATE('1998-03-20', 'YYYY-MM-DD'), 1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '������', '6511022234567', TO_DATE('1998-12-20', 'YYYY-MM-DD'), 2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '���켱', '0506174234567', TO_DATE('2011-10-10', 'YYYY-MM-DD'), 1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '���ù�', '0102033234567', TO_DATE('2010-10-10', 'YYYY-MM-DD'), 2400);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '����', '0210303234567', TO_DATE('2011-10-10', 'YYYY-MM-DD'), 2800);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '�ݺ���', '9903142234567', TO_DATE('2012-11-11', 'YYYY-MM-DD'), 5200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '������', '9907292234567', TO_DATE('2012-11-11', 'YYYY-MM-DD'), 5200);

--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 15


COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_SAWON;
--==>> 
/*
1001	    ����	    9409252234567	2005-01-03	3000
1002	    �躸��	    9809022234567	    1999-11-23	2000
1003	    ���̰�	    9810092234567	2006-08-10	4000
1004	    ���α�	    9307131234567	1998-05-13	2000
1005	    ������	    7008161234567	1998-05-13	1000
1006	    ������	    9309302234567	    1999-10-10	3000
1007	    ������	    0302064234567	    2010-10-23	4000
1008	    �μ���	    6807102234567	1998-03-20	1500
1009	    ������	    6710261234567	1998-03-20	1300
1010	    ������    	6511022234567	1998-12-20	2600
1011	    ���켱	    0506174234567	2011-10-10	1300
1012	    ���ù�	    0102033234567	    2010-10-10	2400
1013    	����	        0210303234567	    2011-10-10	2800
1014    	�ݺ���	    9903142234567	2012-11-11	5200
1015    	������	    9907292234567	2012-11-11	5200
*/

--�� TBL_SAWON ���̺��� '����' ����� �����͸� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '����';
--==>> 1001	����	9409252234567	2005-01-03	3000


SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '����';
--==>> 1001	����	9409252234567	2005-01-03	3000

--�� LIKE : ���� �� �����ϴ�
--          �λ� �� ~�� ����,  ~ó��

--�� WILD CARD(CHARACTER) %��
-- ��LIKE�� �� �Բ� ���Ǵ� ��%���� ��� ���ڸ� �ǹ��ϰ�(��~�� ���� , ���ڰ����)
-- ��LIKE�� �� �Բ� ���Ǵ� ��_���� �ƹ� ���� �� �� �� �ǹ��Ѵ�.


--��TBL_SAWON ���� ������ ���� ���� �����
-- ����� , �ֹκ�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT ����� , �ֹκ�ȣ, �޿�
FROM TBL_SAWON
WHERE ������ '��';


SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '��';
--==>> ��ȸ ��� ����

SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '��__';
--==>> ��ȸ ��� ����
--��__�� �����Ϳ�


SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��__';
--==>> ����	9409252234567	3000

SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��%';
--==>> ����	9409252234567	3000

--�� TBL_SAWON ���̺��� ������ ���̡����� ����� 
--�����, �ֹκ�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME , JUBUN, SAL
FROM  TBL_SAWOM
WHERE ������ '��';

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��%';
--==>>
/*

������	7008161234567	1200
������	0302064234567   	4000
���̰�	0605063234567   	1500
*/


--�� TBL_SAWON ���̺��� ����� �̸��� ���������� ������ �����
-- �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME , JUBUN, SAL
FROM  TBL_SAWOM
WHERE ��� �̸��� '��'���� ������;

SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '__��';
--==>>
/*
�ݺ���	9903142234567	5200
������	9907292234567	5200
*/


SELECT SANAME , JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%��';
--==>>
/*
�ݺ���	9903142234567	5200
������	9907292234567	5200
*/


--�� �߰� ������ �Է� (TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '���̰�', '0605063234567', TO_DATE('2015-01-20'), 1500);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	����	9409252234567	2005-01-03	3000
1002	�躸��	9809022234567	    1999-11-23	2000
1003	���̰�	9810092234567	2006-08-10	4000
1004	���α�	9307131234567	1998-05-13	2000
1005	������	7008161234567	1998-05-13	1000
1006	������	9309302234567	    1999-10-10	3000
1007	������	0302064234567   	2010-10-23	4000
1008	�μ���	6807102234567	1998-03-20	1500
1009	������	6710261234567	1998-03-20	1300
1010	������	6511022234567	1998-12-20	2600
1011	���켱	0506174234567	2011-10-10	1300
1012	���ù�	0102033234567   	2010-10-10	2400
1013	����  	0210303234567	    2011-10-10	2800
1014	�ݺ���	9903142234567	2012-11-11	5200
1015	������	9907292234567	2012-11-11	5200
1016	���̰�	0605063234567   	2015-01-20	1500
*/

--�� Ŀ�� 
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_SAWON ���̺��� ����� �̸��� ���̡� ��� ���ڰ� 
--  �ϳ��� ���ԵǾ��ִٸ� �� �����
--  �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT �����ȣ, �����, �޿�
FROM TBL_SAWON
WHERE ����� �̸��� '��' ��� ���ڰ� �ϳ��� ����'

-- DO ����
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%��%';
--==>>
/*
1005	    ������	1000
1006    	������	3000
1007	    ������	4000
1008	    �μ���	1500
1016	    ���̰�	1500
*/


--�� TBL_SAWON ���̺��� ����� �̸��� ���̡� ��� ���ڰ� �� �� ����ִ� �����
-- �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT �����ȣ, �����, �޿�
FROM TBL_SAWON
WHERE �̸��� �� ��� ���ڰ� �� �� ����;

--DO �����Ѱ� ���� ���ڶ�
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%����%';
--=>> 1016	���̰�	1500


SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%��%��%';
--==>>
/*
1007	������	4000
1016	���̰�	1500
*/

--�� TBL_SAWON ���̺��� ����� �̸��� ���̡� ��� ���ڰ�
-- �������� �� �� ����ִ� �����
-- �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%����%';
--==>> 1016	���̰�	1500



--�� TBL_SAWON ���̺��� ����� �̸��� �� ���� ���ڰ� ������ �� �����
-- �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM  TBL_SAWON
WHERE SANAME LIKE '_��%';
--==>>
/*
1002	�躸��	2000
1014	�ݺ���	5200
*/

--T
SELECT SANO, SANAME, SAL
FROM  TBL_SAWON
WHERE SANAME LIKE '_��';
--==>> ��ȸ ��� ����
--==>> �� ����(�� ��)


SELECT SANO, SANAME, SAL
FROM  TBL_SAWON
WHERE SANAME LIKE '_��_';
--==>> �̸��� 3���ڸ�
/*
1002	�躸��	2000
1014	�ݺ���	5200
*/

--�� TBL_SAWON ���̺��� ������ ���������� �����
--  �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
-- ���� ������ �ȵȴ�.
SELECT SANO, SANAME, SAL
FROM  TBL_SAWON
WHERE SANAME LIKE '��%';
--==>>
/*
1009	������	1300
1010	������	2600
1011	���켱	1300
*/

--�� �����ͺ��̽� ���� ��������
-- ���� �̸��� �и��Ͽ� ó���� ���� ��ȹ�� �ִٸ�
--(���� ������ �ƴϴ���,,,)
-- ���̺��� �� Į���� �̸��� �и��Ͽ� �����ؾ� �Ѵ�.


--�� TBL_SAWON ���̺��� ���������� 
-- �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE JUBUN ������;

--DO �����Ѱ� ����! 
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN LIKE '______2%'
   OR JUBUN LIKE '______4%';
--=>>
/*
����	9409252234567	3000
�躸��	9809022234567	    2000
���̰�	9810092234567	4000
������	9309302234567	    3000
������	0302064234567	    4000
�μ���	6807102234567	1500
������	6511022234567	2600
���켱	0506174234567	1300
�ݺ���	9903142234567	5200
������	9907292234567	5200
*/

DESC TBL_SAWON;
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/


SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE ������ ����;

SELECT SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE ������ ����;

SELECT SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE �ֹι�ȣ 7��° �ڸ� 1���� 2
     �ֹι�ȣ 7��° �ڸ� 1���� 4;

-- �� �ٶ����� ��������
SELECT SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______'
  OR  JUBUN LIKE '______4______';
--==>>
/*
����	9409252234567	3000
�躸��	9809022234567   	2000
���̰�	9810092234567	4000
������	9309302234567	    3000
������	0302064234567	    4000
�μ���	6807102234567	1500
������	6511022234567	2600
���켱	0506174234567	1300
�ݺ���	9903142234567	5200
������	9907292234567	5200
*/


-- �� �ǽ� ���̺� ����(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME VARCHAR2(20)
, BIGO       VARCHAR2(100)
);
--==>>Table TBL_WATCH��(��) �����Ǿ����ϴ�.

-- �� ������ �Է�
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('�ݽð�', '����99.99% ������ �ְ�� �ð�');

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('���ð�', '�� ������ 99.99���� ȹ���� �ְ��� �ð�');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

-- �� Ȯ��
SELECT *
FROM TBL_WATCH;
--==>>�ݽð�	����99.99% ������ �ְ�� �ð�
--    ���ð�	�� ������ 99.99���� ȹ���� �ְ��� �ð�

-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- ��TBL_WATCH ���̺��� BOGO(���) �÷���
-- ��99.99%�� ��� ���ڰ� ���Ե�(����ִ�) ��(���ڵ�)��
-- �����͸� ��ȸ�Ѵ�. (�ݽð踸)
 
SELECT *
FROM TBL_WATCH;
WHERE ��� �÷��� '99.99%'��� ���ڰ� ����;

-- DO
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';

-- T
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>> ��ȸ ��� ����
-- BIGO �÷��� ���ڿ��� 99.99�� �����ϴ�...

-- DO
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>> 
/*
�ݽð�	����99.99% ������ �ְ�� �ð�
���ð�	�� ������ 99.99���� ȹ���� �ְ��� �ð�
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%';
--==>> 
/*
�ݽð�	����99.99% ������ �ְ�� �ð�
���ð�	�� ������ 99.99���� ȹ���� �ְ��� �ð�
*/

-- �� ESCAPE 

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE'\';
--==>> �ݽð�	����99.99% ������ �ְ�� �ð�

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE'$';
--==>> �ݽð�	����99.99% ������ �ְ�� �ð�

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99@%%' ESCAPE'@';
--==>> �ݽð�	����99.99% ������ �ְ�� �ð�

-- �� ESCAPE �� ���� ������ ���� �� ���ڸ� ���ϵ� ī�忡�� Ż�� ���Ѷ�...
-- �Ϲ������� ��� �󵵰� ���� Ư������(Ư����ȣ)�� ����Ѵ�.

--------------------------------------------------------------------------------

--����COMMIT/ ROLLBACK ����--

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

-- �� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50,'���ߺ�', '����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


DESC TBL_DEPT;


SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

-- 50�� ���ߺ� ����...
-- �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ� �ִ�
-- �ϵ��ũ�� ���������� ����Ǿ� ����� ���� �ƴϴ�.
-- �޸�(RAM)�� �Էµ� ���̴�.

--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
-->> 50 �� ���ߺ� ����...�� ���� �����Ͱ� �ҽǵǾ����� Ȯ��(�������� ����)

--�� �ٽ� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50,'���ߺ�', '����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	����
*/

-- 50�� ���ߺ� ����...
-- �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ��ִ� �ϵ��ũ �� ����� ���� �ƴ϶�
-- �޸�(RAM) �� �Էµ� ���̴�.
-- �̸�.. ���� �ϵ��ũ �� ���������� ����� ��Ȳ�� Ȯ���ϱ� ���ؼ���
-- COMMIT �� �����ؾ��Ѵ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� Ŀ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

--�� �ѹ����� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/
-->> ROLLBACK �� ���� �������� �ұ��ϰ�
-- 50�� ���ߺ� ����... �� �� �����ʹ� �ҽǵ��� �ʾ����� Ȯ��

--�� COMMIT �� ������ ���ķ� DML����(INSERT, UPDATE, DELETE)�� ����
-- ����� �����͸� ����� �� �ִ� ���ϻ�....
-- DML ����� ����� �� COMMIT �� �����ϰ� ���� ROLLBACK�� �����غ���
-- �ƹ��� �ҿ��� ����.



--�� ������ ����(UPDATE �� TBL_DEPT)
UPDATE TBL_DEPT
SET DNAME = '������', LOC = '���'
WHERE DEPTNO = 50;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	������	    ���
*/

ROLLBACK;
--==>> �ѹ� �Ϸ�.
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/
UPDATE TBL_DEPT
SET DNAME = '������', LOC = '��õ'
WHERE DEPTNO = 50;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
--==>> Ŀ�� �Ϸ�.

ROLLBACK;
ROLLBACK;
ROLLBACK;
ROLLBACK;
ROLLBACK;
ROLLBACK;

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	������	    ��õ
*/


--�� ������ ����(DELETE �� TBL_DEPT)
SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;

DELETE
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_DEPT;

ROLLBACK;

SELECT *
FROM TBL_DEPT;

COMMIT;
--==>> Ŀ�� �Ϸ�.


--------------------------------------------------------------------------------

--���� ORDER BY �� ����--
SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0)"����"
FROM EMP;
--==>>
/*
SMITH	20	CLERK	800	9600
ALLEN	30	SALESMAN	1600	19500
WARD	30	SALESMAN	1250	15500
JONES	20	MANAGER	2975	35700
MARTIN	30	SALESMAN	1250	16400
BLAKE	30	MANAGER	2850	34200
CLARK	10	MANAGER	2450	29400
SCOTT	20	ANALYST	3000	36000
KING	10	PRESIDENT	5000	60000
TURNER	30	SALESMAN	1500	18000
ADAMS	20	CLERK	1100	13200
JAMES	30	CLERK	950	11400
FORD	20	ANALYST	3000	36000
MILLER	10	CLERK	1300	15600
*/

SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0)"����"
FROM EMP
ORDER BY DEPTNO ASC;       -- DEPTNO �� ���� ����    : �μ���ȣ
                           -- ASC   �� ���� ����    : ��������
/*
CLARK	10	MANAGER	2450	29400
KING    	10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
JONES	20	MANAGER	2975	35700
FORD	    20	ANALYST	3000	36000
ADAMS	20	CLERK	1100	13200
SMITH	20	CLERK	800	9600
SCOTT	20	ANALYST	3000	36000
WARD    	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0)"����"
FROM EMP
ORDER BY DEPTNO;           -- DEPTNO �� ���� ���� : �μ���ȣ
                           -- ASC   �� ���� ���� : �������� �� ��������~!~!
/*
CLARK	10	MANAGER	    2450	29400
KING    	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	35700
FORD	    20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	9600
SCOTT	20	ANALYST	    3000	36000
WARD    	30	SALESMAN	    1250	15500
TURNER	30	SALESMAN	    1500	18000
ALLEN	30	SALESMAN	    1600	19500
JAMES	30	CLERK	    950	11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	    1250	16400
*/

SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0)"����"
FROM EMP
ORDER BY DEPTNO DESC;  -- DESC  �� ���� ����  : �������� �� ���� �Ұ�~!~!
--==>>
/*
BLAKE	30	MANAGER	2850	34200
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
MARTIN	30	SALESMAN	1250	16400
WARD	    30	SALESMAN	1250	15500
JAMES	30	CLERK	950	11400
SCOTT	20	ANALYST	3000	36000
JONES	20	MANAGER	2975	35700
SMITH	20	CLERK	800	9600
ADAMS	20	CLERK	1100	13200
FORD	    20	ANALYST	3000	36000
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
CLARK	10	MANAGER	2450	29400
*/


-- SELECT ���� �Ľ� ������ ����ϸ� �ܿ��� �ʾƵ� �ȴ�.
SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0) "����"
FROM EMP
ORDER BY ���� DESC;
/*
KING    	10	PRESIDENT	5000	60000
FORD	    20	ANALYST	    3000	36000
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975	35700
BLAKE	30	MANAGER	    2850	34200
CLARK	10	MANAGER	    2450	29400
ALLEN	30	SALESMAN	    1600	19500
TURNER	30	SALESMAN	    1500	18000
MARTIN	30	SALESMAN	    1250	16400
MILLER	10	CLERK	    1300	15600
WARD    	30	SALESMAN    	1250	15500
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	11400
SMITH	20	CLERK	    800	9600
*/

SELECT *
FROM EMP;


SELECT ENAME"�����", DEPTNO"�μ���ȣ", JOB"����", SAL"�޿�"
     , SAL*12+NVL(COMM,0) "����"
FROM EMP
ORDER BY 2;
-->> EMP ���̺��� ���� �ִ� ���̺��� ������ �÷� ����(2 �� ENAME)�� �ƴ϶�
-- SELECT ó�� �Ǵ� �� ��° �÷�(2 �� DEPTNO, �μ���ȣ)�� �������� ����
-- ASC�� ������ ���� �� �������� ����
-- ����Ŭ������ �⺻ �ε����� �ڹٿ� �޸� 1���� ����.
-- ���������� ���� ��ORDER BY 2�������� �桺ORDER BY DEPTNO ASC�������̴�.

-- SEELCT ���� 2��° 
--��, �μ���ȣ ���������ض�
--==>>
/*
CLARK	10	MANAGER	2450	29400
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
JONES	20	MANAGER	2975	35700
FORD	    20	ANALYST	3000	36000
ADAMS	20	CLERK	1100	13200
SMITH	20	CLERK	800	9600
SCOTT	20	ANALYST	3000	36000
WARD	    30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 4;
-- ORDER BY DEPTNO, SAL ASC
-- �μ���ȣ, �޿� ���� �������� ����;
--  (1)     (2)
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING    	10	PRESIDENT	5000
SMITH	20	CLERK	    800
ADAMS	20	CLERK	    1100
JONES	20	MANAGER	    2975
SCOTT	20	ANALYST	    3000
FORD	    20	ANALYST	    3000
JAMES	30	CLERK	    950
MARTIN	30	SALESMAN    	1250
WARD	    30	SALESMAN	    1250
TURNER	30	SALESMAN	    1500
ALLEN	30	SALESMAN	    1600
BLAKE	30	MANAGER	    2850
*/


SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 3, 4 DESC;
-- �� 2      �� DEPTNO(�μ���ȣ) ���� �������� ����
-- �� 3      �� JOB(������) ���� �������� ����
-- �� 4 DESC �� SAL(�޿�) ���� ��������(DESC) ����
-- (3�� ���� ����)
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	    10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD	    20	ANALYST	    3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	    800
JONES	20	MANAGER	    2975
JAMES	30	CLERK	    950
BLAKE	30	MANAGER	    2850
ALLEN	30	SALESMAN    	1600
TURNER	30	SALESMAN	    1500
MARTIN	30	SALESMAN    	1250
WARD	    30	SALESMAN	    1250
*/

--------------------------------------------------------------------------------
--�� CONCAT()
SELECT ENAME ||JOB"ù��° �÷�"
     ,CONCAT(ENAME, JOB) "�ι�° �÷�"
FROM EMP;
--==>>
/*
SMITHCLERK	    SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN	    WARDSALESMAN
JONESMANAGER	    JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	    BLAKEMANAGER
CLARKMANAGER	    CLARKMANAGER
SCOTTANALYST	    SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	    ADAMSCLERK
JAMESCLERK	    JAMESCLERK
FORDANALYST	    FORDANALYST
MILLERCLERK     	MILLERCLERK
*/



-- ���ڿ� ������� ������ ������ �����ϴ� �Լ� CONCAT( , )
-- ������ 2���� ���ڿ��� ���ս�ų �� �ִ�.
SELECT '�츮��' || '�⺻��' ||'��Ų��' "ù��° �÷�"
    , CONCAT('�츮��', '�⺻��','��Ų��');"�ι�° �÷�"
FROM DUAL;
--==>> ���� �߻�

SELECT ENAME|| JOB ||DEPTNO "ù��° �÷�"
        , CONCAT(CONCAT(ENAME, JOB),DEPTNO)"�ι�° �÷�"
FROM EMP;
--==>> 
/*
SMITHCLERK20	    SMITHCLERK20
ALLENSALESMAN30	ALLENSALESMAN30
WARDSALESMAN30	WARDSALESMAN30
JONESMANAGER20	JONESMANAGER20
MARTINSALESMAN30	MARTINSALESMAN30
BLAKEMANAGER30	BLAKEMANAGER30
CLARKMANAGER10	CLARKMANAGER10
SCOTTANALYST20	SCOTTANALYST20
KINGPRESIDENT10	KINGPRESIDENT10
TURNERSALESMAN30	TURNERSALESMAN30
ADAMSCLERK20	    ADAMSCLERK20
JAMESCLERK30	J   AMESCLERK30
FORDANALYST20	FORDANALYST20
MILLERCLERK10	MILLERCLERK10
*/
--> �������� �� ��ȯ�� �Ͼ�� ������ �����ϰԵȴ�.
-- CONCAT()�� ���ڿ��� ���ڿ��� ���ս����ִ� �Լ�������
-- ���������� ���ڳ� ��¥�� ���ڷ� �ٲپ��ִ� ������ ���ԵǾ� �ִ�.

/* java ������
obj.substring()
---
|
���ڿ� �� ���ڿ�.substring(n,m);
                      -----
                    ���ڿ��� n ���� m-1 ����..(�ε����� 0����)

*/


--�� SUBSTR() ���� ��� / SUBSTRB() ����Ʈ ��� (���ڵ� ����)

SELECT ENAME"COL1"
        , SUBSTR(ENAME, 1, 2)"COL2"
FROM EMP;
--> �� ���ڿ��� �����ϴ� ����� ���� �Լ� ��
-- ù ��° �Ķ���� ���� ��� ���ڿ�(������ ���, TARGET)
-- �� ��° �Ķ���� ���� ������ �����ϴ� ��ġ(�ε���, START) �� �ε����� 1���� ����
-- �� ��° �Ķ���� ���� ������ ���ڿ���(����, COUNT) �� ���� ��... ���ڿ��� ���� ������ ����.....

SELECT ENAME "COL1"
    , SUBSTR(ENAME, 3, 2) "COL2"
    , SUBSTR(ENAME, 3, 5) "COL3"
    , SUBSTR(ENAME, 3) "COL4"
    , SUBSTR(ENAME, 6, 1) "COL5"
FROM EMP;
--==>>
/*
COL1   COL2  COL3   COL4     COL5
SMITH	IT	ITH	    ITH	    (null)
ALLEN	LE	LEN	    LEN	    (null)
WARD	    RD	RD	    RD	    (null)
JONES	NE	NES	    NES	    (null)
MARTIN	RT	RTIN	    RTIN	    N
BLAKE	AK	AKE	    AKE	    (null)
CLARK	AR	ARK	    ARK     	(null)
SCOTT	OT	OTT	    OTT	    (null)
KING    	NG	NG	    NG	    (null)
TURNER	RN	RNER    	RNER	    R
ADAMS	AM	AMS	    AMS	    (null)
JAMES	ME	MES	    MES	    (null)
FORD    	RD	RD	    RD	    (null)
MILLER	LL	LLER	    LLER	    R
*/
--�� TBL_SAWON ���̺��� ������ ������ �����
-- �����ȣ, �����, �ֹι�ȣ, �޿� �׸��� ó���� �� �ֵ��� �Ѵ�.
-- ��, SUBSTR() �Լ��� Ȱ���Ͽ� ó���� �� �ֵ��� �Ѵ�. 

-- DO
SELECT �����ȣ, �����, �ֹι�ȣ, �޿�
FROM TBL_SAWON
WHERE ������ ����;

-- ���� Ÿ���̶� ���ڴ� Ʋ��
SELECT �����ȣ, �����, �ֹι�ȣ, �޿�
FROM TBL_SAWON
WHERE  JUBUN�� 7��°�� 1 �̰ų� 
     , JUBUN�� 7��°�� 3 �λ��;


-- 9411241903712
SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE  JUBUN  SUB(3, 7, 7);

SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE JUBUN �÷��� 7��° �ڸ��� '1'
   OR JUBUN �÷��� 7��° �ڸ��� '3';

SELECT SANO "�����ȣ"
    , SANAME "�����"
    , SUBSTR(JUBUN, 7) "�ֹι�ȣ"
    , SAL "�޿�"
FROM TBL_SAWON
WHERE JUBUN LIKE SUB'______1______'
   OR JUBUN LIKE SUB'______3______';



SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) = '1'
   OR SUBSTR(JUBUN, 7, 1) = '3';
/*
1004	���α�	9307131234567	2000
1005	������	7008161234567	1000
1009	������	6710261234567	1300
1012	���ù�	0102033234567	    2400
1013	����  	0210303234567	    2800
1016	���̰�	0605063234567  	1500
*/

SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ", SAL"�޿�"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) IN ('1', '3');

--�ڲ� ���ڿ� Ȭ����ǥ ��������..........!!!!!!!!!!

--�� LENGTH() ���� ��/ LENGTHB() ����Ʈ ��


SELECT ENAME"COL1"
    , LENGTH(ENAME)"COL2"
    , LENGTHB(ENAME)"COL3"
FROM EMP;
--==>>
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	4	4
MILLER	6	6
*/


--�� INSTR()

SELECT 'ORACLE ORAHOME BIORA' "COL1"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"       -- 1
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"       -- 8
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"       -- 8
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"          -- 8 (�� ���̶� ���� ����)
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"       -- 0 (3��°�� ��ã�Ƽ� 0) 
FROM DUAL;
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ�����...(��� ���ڿ�, TARGET)
--  �� ��° �Ķ���� ���� ���� �Ѱ��� ���ڿ��� �����ϴ� ��ġ�� ã�ƶ�~!!!
--  �� ��° �Ķ���� ���� ã�� �����ϴ�(��ĵ�� �����ϴ�) ��ġ
--  �� ��° �Ķ���� ���� �� ��° �����ϴ� ���� ã�� �������� ���� ����(�� 1�� ���� ����)



SELECT '���ǿ���Ŭ �����ο��� �մϴ�.'"COL1"
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 1) "COL2"     -- 3
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 2) "COL3"     -- 3    
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 10) "COL4"    -- 10   
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 11) "COL5"    -- 0
FROM DUAL;
--> ������ �Ķ���� ���� ������ ���·� ��� �� ������ �Ķ���� �� 1


--�� REVERSE()
SELECT 'ORACLE' "COL1"
    , REVERSE('ORACLE')"COL2"
    , REVERSE('����Ŭ')"COL3"
FROM DUAL;
--==>> ORACLE	ELCARO	???
-- ����ڿ��� �Ųٷ� ��ȯ�Ѵ�.( ��, �ѱ��� ���� - ���Ұ�)


-- �ǽ� ���̺� ���� (TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO    NUMBER(3)
, FILENAME  VARCHAR2(100)
);
--==>> Table TBL_FILES��(��) �����Ǿ����ϴ�.

--�� ������ �Է�(
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESERCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'C:\SHARE\F\TEST\FLOWER.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE\20220816_01_SCOTT.SQL');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 7


--�� Ȯ��
SELECT *
FROM TBL_FILES;
--==>> 
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XXLS
3	D:\RESERCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
6	C:\SHARE\F\TEST\FLOWER.PNG
7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT FILENO "���Ϲ�ȣ"
     , FILENAME "���ϸ�"
FROM TBL_FILES;

/*
-----------------------------------------
���Ϲ�ȣ    ���ϸ�
-----------------------------------------
    1	C:\AAA\BBB\CCC\SALES.DOC
    2	C:\AAA\PANMAE.XXLS
    3	D:\RESERCH.PPT
    4	C:\DOCUMENTS\STUDY.HWP
    5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
    6	C:\SHARE\F\TEST\FLOWER.PNG
    7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL
-------------------------------------------
*/
--�� TBL_FILES ���̺��� ��ȸ�Ͽ�
--  ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.
/*
-------- ---------------------------------
���Ϲ�ȣ    ���ϸ�
-------- ---------------------------------
    1	 SALES.DOC
    2	 PANMAE.XXLS
    3	 RESERCH.PPT
    4	 STUDY.HWP
    5	 SQL.TXT
    6	 FLOWER.PNG
    7	 20220816_01_SCOTT.SQL
-------- -----------------------------------
*/

--DO
--> �� ���ڿ��� �����ϴ� ����� ���� �Լ�
-- ù ��° �Ķ���� ���� ��� ���ڿ�(������ ���, TARGET)
-- �� ��° �Ķ���� ���� ������ �����ϴ� ��ġ(�ε���, START) �� �ε����� 1���� ����
-- �� ��° �Ķ���� ���� ������ ���ڿ���(����, COUNT) �� ���� ��... ���ڿ��� ���� ������.......
SELECT FILENO "���Ϲ�ȣ"
     , FILENAME "���ϸ�"
FROM TBL_FILES
WHERE FILENAME  SUBSTR(FILENAME, 16);
    , SUBSTR(FILENAME, 8)
    , SUBSTR(FILENAME, 4)
    , SUBSTR(FILENAME,14)
    , SUBSTR(FILENAME,28)
    , SUBSTR(FILENAME,17)
    , SUBSTR(FILENAME,17);



--�ƴ�
SELECT FILENO "���Ϲ�ȣ"
    , SUBSTR(FILENAME, 16)
    , SUBSTR(FILENAME, 8)
    , SUBSTR(FILENAME, 4)
    , SUBSTR(FILENAME,14)
    , SUBSTR(FILENAME,28)
    , SUBSTR(FILENAME,17)
    , SUBSTR(FILENAME,17)"���ϸ�"
FROM TBL_FILES;
/*
-----------------------------------------
���Ϲ�ȣ    ���ϸ�
-----------------------------------------
    1	C:\AAA\BBB\CCC\SALES.DOC
    2	C:\AAA\PANMAE.XXLS
    3	D:\RESERCH.PPT
    4	C:\DOCUMENTS\STUDY.HWP
    5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
    6	C:\SHARE\F\TEST\FLOWER.PNG
    7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL
-------------------------------------------
*/

WHERE
���Ϲ�ȣ�� 1�϶� ���ϸ��� 16��° ���� ������ ����
���Ϲ�ȣ�� 2�϶� ���ϸ��� 8��°���� ������ ����



SELECT FILENO "���Ϲ�ȣ"
     , FILENAME "���ϸ�"
FROM TBL_FILES
WHERE FILEN0 '1'  SUBSTR(FILENAME, 16)
    , FILEN0 '2' = SUBSTR(FILENAME, 8)
    , FILEN0 '3' = SUBSTR(FILENAME, 4)
    , FILEN0 '4' = SUBSTR(FILENAME,14)
    , FILEN0 '5' = SUBSTR(FILENAME,28)
    , FILEN0 '6' = SUBSTR(FILENAME,17)
    , FILEN0 '7' = SUBSTR(FILENAME,17);



SELECT FILENO "���Ϲ�ȣ"
    , SUBSTR(FILENAME, 16)
    , SUBSTR(FILENAME, 8)
    , SUBSTR(FILENAME, 4)
    , SUBSTR(FILENAME,14)
    , SUBSTR(FILENAME,28)
    , SUBSTR(FILENAME,17)
    , SUBSTR(FILENAME,17)"���ϸ�"
FROM TBL_FILES;


-- ģ���� �� ��1
SELECT SUBSTR(FILENAME, (LENGTH(FILENAME)-INSTR(REVERSE(FILENAME),'\',1)+2))"���ϸ�"
     , LENGTH(FILENAME)"����" ,INSTR(REVERSE(FILENAME),'\',1)"�������� �ε��� REV"
FROM TBL_FILES;

-- ��κ��� ģ���� �� ��2
SELECT FILENO "���Ϲ�ȣ"
  , REVERSE(SUBSTR(REVERSE(FILENAME), 1
  , INSTR(REVERSE(FILENAME), '\', 1) - 1)) "���ϸ�"
FROM TBL_FILES;


SELECT FILENO "���Ϲ�ȣ"
    , REVERSE(SUBSTR(REVERSE(FILENAME), 1
    , INSTR(   REVERSE(FILENAME), '\',1) -1)     ) "���ϸ�"
FROM TBL_FILES;


C:\AAA\BBB\CCC\SALES.DOC   COD.SELAS

