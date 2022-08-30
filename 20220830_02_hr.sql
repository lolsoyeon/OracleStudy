SELECT USER
FROM DUAL;
--==>> HR

--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   �� �μ����� 'IT'�� �����鸸 �����Ѵ�.
--  (���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�.)

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
WHERE JOB_ID�� IT�� ����;


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1 
WHERE SUBSTR(JOB_ID, 1, 2) = 'IT';
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

ROLLBACK;

-- Ȯ��
SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS;


-- IT �μ� �������� FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID ��ȸ
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE �μ��� = 'IT';

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE �μ���ȣ = �μ����� 'IT'�� �μ��� �μ���ȣ;


SELECT FIRST_NAME, LAST_NAME, SALARY, DEPTMENT_ID
FROM EMPLOYEES
WHERE �μ���ȣ = 60;

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

SELECT FIRST_NAME, LAST_NAME, SALARY, salary *1.1 "10%�λ�޿�",  DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');


UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT');
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- Ȯ��
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
--==>> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� JOB_TITLE �� Sales Manager �� �������
-- SALARY �� �ش� ����(����) �� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
-- ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���� ������ �� �ֵ��� ó���Ѵ�.
-- (���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�.)
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

-- Ȯ��

SELECT *
FROM EMPLOYEES;

------------------------------------- T ������ Ǯ��
UPDATE EMPLOYEES
SET SALARY = ('Sales Manager'�� MAX_SALARY)
WHERE JOB_ID = ('Sales Manager'�� JOB_ID)
 AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY'))<2006;
 
 -- ('Sales Manager'�� MAX_SALARY)
SELECT MAX_SALARY
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';
--==>> 20080


-- ('Sales Manager'�� JOB_ID)
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
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�.




SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;
--�� EMPLOYEES ���̺��� SALARY ��
-- �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--  Finance �� 10% �λ�    �� SALARY *1.1
--  Executive �� 15% �λ�  �� SALARY * 1.15
--  Accounting �� 20% �λ�  �� SALARY * 1.2
-- �ٸ� ������ �μ���        �� SALARY
--  (���濡 ���� ��� Ȯ�� �� BOLLBACK)

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
SET SALARY 10% �λ�
WHERE Finance 

UPDATE EMPLOYEES
SET SALARY 10% �λ�
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
--==>> 6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.15
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID
                     FROM DEPARTMENTS
                     WHERE DEPARTMENT_NAME = 'Executive'); 
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.2
WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID
                     FROM DEPARTMENTS
                     WHERE DEPARTMENT_NAME = 'Accounting'); 
--==>> 2�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM EMPLOYEES;


ROLLBACK;
--==>> �ѹ� �Ϸ�.



------------------------ T ������ 
UPDATE EMPLOYEES
WHERE 



UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN('Finance'�� �μ� ���̵�) 
                               THEN SALARY *1.1 
                               WHEN('Executive'�� �μ� ���̵�) 
                               THEN SALARY *1.15  
                               WHEN('Accounting'�� �μ� ���̵�) 
                               THEN SALARY *1.12
                               ELSE SALARY 
             END;

-- ('Finance'�� �μ� ���̵�) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance'
--==>> 100

-- ('Executive'�� �μ� ���̵�) 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive'
--==>> 90

-- ('Accounting'�� �μ� ���̵�) 
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

--==>>Ǯ��ĵ ���޸𸮰� �ۿ÷�����.

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
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�. 

ROLLBACK;
--==>> �ѹ� �Ϸ�.

--------------------------------------------------------------------------------

--���� DELETE ����--

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];


-- ���̺� ����(������ ����)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==> ��ȸ�ϰ��� �������� (�⺻�� ��Ű��) 

DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;


--�� EMPLOYEES ���̺��� �������� �����͸� �����Ѵ�.
-- ��, �μ����� 'IT'�� ���� �����Ѵ�.
-- �� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
-- �ٸ� ���ڵ忡 ���� �������ϰ� �ִ� ���(�θ��)
-- �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
-- �׿� ���� ������ �˾ƾ� �Ѵ�.
SELECT *
FROM TBL_EMPLOYEES
WHERE �μ����� 'IT'


SELECT *
FROM TBL_EMPLOYEES
WHERE �μ����� 'IT'

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
--==>> 5�� �� ��(��) �����Ǿ����ϴ�.
ROLLBACK;
--==>> �ѹ� �Ϸ�.

-------------------������ Ǯ��

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT'�μ��� �μ����̵�);

-- ('IT'�μ��� �μ����̵�)
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
--==>> ���� �߻�
-- (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)



--------------------------------------------------------------------------------

--���� ��(VIEW)����--

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--  �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--  ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ�
--  �������� ������ ���̺�� �����Ǽ� �� ���ȿ� ������ �ִ�.

--  ������ ���̺��̶�... �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--  �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
--  �� ������ �����س��� SQL�����̶�� �� �� �ִ�.

-- 2. ���� �� ����
-- CREATE [OR REPLACE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

--�� ��(VIEW) ����

CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.
--> ��� ��� ������ �ϸ鼭 ��� �� �� �ִ�.


--�� ��(VIEW) ��ȸ
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

--�� ��(VIEW)�� ���� ��ȸ

DESC VIEW_EMPLOYEES;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 

*/


-- �� ��(VIEW) �ҽ� Ȯ�� --�� CHECK~!! ��

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



--==> �� �����Ҷ� �ҽ��� Ȯ�� �� �� �ִ�.
*/


-- PL SQL










