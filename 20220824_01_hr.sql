--------------------------------------------------------------------------------
/*
--���� ���Ἲ(Integrity) ����--

1. ���Ἲ���� ��ü ���Ἲ(Entity Integrity)
              ���� ���Ἲ(Relation Integrity)
              ������ ���Ἲ(Domain Integrity)�� �ִ�.
              
-- ���Ἲ�� �����Ƿ��� ���������� �־���Ѵ�.
--�����Ӱ� �Է��������ϵ��� ������� ���, ����Ŭ�� ���´�.

2. ��ü ���Ἲ(Entity Integrity)
   ��ü ���Ἲ�� �����̼ǿ��� ����Ǵ� Ʃ��(tuple)��
   ���ϼ��� �����ϱ� ���� ���������̴�.
   
   
3. ���� ���Ἲ(Relation Integrity)��
   ���� ���Ἲ�� �����̼� ���� ������ �ϰ�����
   �����ϱ����� ���������̴�.
    
4. ������ ���Ἲ(Domain Integrity)�� �ִ�.
   ������ ���Ἲ�� ��밡���� ���� ������
   �����ϱ� ���� ���������̴�.

5. ���������� ����

 - PRIMARY KEY(PK : P) �� �⺻Ű, ����Ű, �ĺ�Ű, �ĺ���
   �ش� �÷��� ���� �ݵ�� �����ؾ� �ϸ�, �����ؾ��Ѵ�.
   (NOT NULL �� UNIQUE �� ���յ� ����)

 - FOREIGN KEY(FK : F : R) �� �ܷ�Ű, �ܺ�Ű, ����Ű
   �ش� �÷��� ���� �����Ǵ� ���̺��� �÷� �����͵� �� �ϳ���
   ��ġ�ϰų� NULL�� ������.
   -- EMP���̺� �� DEPTNO   DEPT ���̺���DEPTNO �ϳ��̰ų� ����(NULL)�̰ų�  
 
 - UNIQUE(UK : U) 
   ���̺� ������ �ش� �÷��� ���� �׻� �����ؾ� �Ѵ�.

 - NOT NULL(NN : CK : C) üũ
   �ش� �÷��� NULL �� ������ �� ����.
   
 - CHECK(CK : C)
   �ش� �÷��� ���� ������ �������� ������ ������ �����Ѵ�.

*/

--���� PRIMARY KEY ����--

--1. ���̺� ���� �⺻ Ű�� �����Ѵ�.


                                        -- �̱� ,  ����  
--2. ���̺��� �� ���� �����ϰ� �ĺ��ϴ� �÷� �Ǵ� �÷��� �����̴�.
--  �⺻Ű�� ���̺� �� �ִ� �ϳ��� �����Ѵ�.
--  �׷��� �ݵ�� �ϳ��� �÷����θ� �����Ǵ� ���� �ƴϴ�.
--  NULL�� �� ����, �̹� ���̺� �����ϰ� �ִ� �����͸�
--  �ٽ� �Է��� �� ������ ó���Ѵ�. (���ϼ�)
--  UNIQUE INDEX �� ����Ŭ ���������� �ڵ����� �����ȴ�.

--3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ��[CONSTRAINT CONSTRAINT��] PRIMARY KEY[(�÷���,..)]

-- �� ���̺� ������ ����     ���ڡڡڡ���õ
-- �÷��� ������ Ÿ��,
-- �÷��� ������ Ÿ��,
-- CONSTRAINT CONSTRAINT�� PRIMARY KEY[(�÷���,..)

-- 4. CONSTRAINT �߰� �� CONSTRAINT���� �����ϸ�
--    ����Ŭ ������ �ڵ������� CONSTRAINT���� �ο��Ѵ�.
--    �Ϲ������� CONSTRAINT���� �����̺��_�÷���_CONSTRAINT���ڡ�
--    �������� ����Ѵ�.               


--�� PK���� �ǽ� (�� �÷� ������ ����)
--���̺����

CREATE TABLE TBL_TEST1
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.
SELECT *
FROM TBL_TEST1;

DESC TBL_TEST1;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 

*/
-- ������ �Է�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');  
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');  --> �����߻�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'ABCD');  --> �����߻�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2,'ABCD');  
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3,NULL);    
INSERT INTO TBL_TEST1(COL1) VALUES(4);              --> �� ���� �Ϸ�, 502�� ���� ����
INSERT INTO TBL_TEST1(COL1) VALUES(4);              --> �����߻�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5,'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL,NULL); --> �����߻�


COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/

DESC TBL_TEST1;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)         �� PK �������� Ȯ�� �Ұ�    
COL2          VARCHAR2(30) 

*/


--�� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	LOC_CITY_NN	C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	DEPT_LOC_FK	R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	LOC_C_ID_FK	R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE
HR	DEPT_ID_PK	P	DEPARTMENTS					ENABLED	NOT DEFERRABLE
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE
HR	JOB_ID_PK	P	JOBS					ENABLED	NOT DEFERRABLE
HR	LOC_ID_PK	P	LOCATIONS					ENABLED	NOT DEFERRABLE
HR	REG_ID_PK	P	REGIONS					ENABLED	NOT DEFERRABLE
HR	SYS_C007063	P	TBL_TEST1					ENABLED	NOT DEFERRABLE
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007063	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME

--�� ���������� ������ �÷��� Ȯ��(��ȸ)
SELECT *
FROM USER_CONS_COLUMNS;
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007063	TBL_TEST1	COL1	1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007063	TBL_TEST1	COL1	1


--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
-- ���������� ������ ������, ���� ���Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.
-- �����Ѱ�
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';



SELECT *
FROM USER_CONSTRAINTS C1 , USER_CONS_COLUMS C2
WHERE C1.TABLE_NAME = C2.TABLE_NAME;



SELECT *
FROM USER_CONSTRAINTS C1 , USER_CONS_COLUMS C2
WHERE C1.TABLE_NAME = C2.TABLE_NAME;



SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'P';



SELECT *
FROM USER_CONSTRAINTS C1 JOIN USER_CONS_COLUMS C2
ON C1.TABLE_NAME = C2.TABLE_NAME
AND CONSTRAINT_TYPE = 'P';



SELECT *
FROM USER_CONSTRAINTS C1 JOIN USER_CONS_COLUMS C2
ON CONSTRAINT_TYPE = 'P'
WHERE C1.TABLE_NAME = C2.TABLE_NAME;


------------------ T ������
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
 

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST1';


--�� PK���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� ������ �Է�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'TEST');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'TEST');  --> �����߻�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'ABCD');  --> �����߻�
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (2,'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (3,NULL);
INSERT INTO TBL_TEST2(COL1) VALUES (4);
INSERT INTO TBL_TEST2(COL1) VALUES (4);             --> �����߻�

INSERT INTO TBL_TEST2(COL1,COL2) VALUES (5,'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (NULL,NULL); --> �����߻�
INSERT INTO TBL_TEST2(COL2) VALUES ('KKKK');         --> �����߻�


COMMIT;

SELECT *
FROM TBL_TEST2;
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
-- ���������� ������ ������, ���� ���Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST2';
--==>> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1




--�� PK���� �ǽ�(����� �÷� PK ����)
-- ���̺� ����
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
             --------------     ----------------------
               -- �̸�            ���� ���������� �ɸ��� ����
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.


-- ������ �Է�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');    --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');                       -->�� ���� �ȳ� ��
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'TEST'); --> �����߻�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL);   --> �����߻�


COMMIT;

SELECT *
FROM TBL_TEST3;


/*
1	ABCD
1	TEST
2	ABCD
2	TEST
3	NULL
*/


--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
-- ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST3';
 
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2

���������� �̸��� ������ ���������� �ϳ���
*/


--�� PK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰� ����)
-- ���̺����

CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST4��(��) �����Ǿ����ϴ�.

--�� �̹� ������(������� �ִ�)���̺�
--   �ο��Ϸ��� ���������� ������ �����Ͱ� (�� �ϳ���)���ԵǾ� ���� ���
--   �ش� ���̺� ���������� �߰��ϴ� ���� �Ұ����ϴ�.

-- �������� �߰�  -- �������� ����
ALTER TABLE TBL_TEST4
ADD �÷��� ������Ÿ��;

ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4��(��) ����Ǿ����ϴ�.

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
-- ���������� ������ ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1


--�� �������� Ȯ�� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER"OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME"TABLE_NAME"
     , UC.CONSTRAINT_TYPE"CONSTRAINT_TYPE"
     , UCC.COLUMN_NAME "COLUMN_NAME"
     , UC.SEARCH_CONDITION"SEARCH_CONDITION"
     , UC.DELETE_RULE"DELETE_RULE" 
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.


--
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		


--���� UNIQUE ����--

--1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ� ���� �� �� �ֵ��� �����ϴ� ��������
--   PRIMARY KEY �� ������ ��������������, ��NULL�� ����Ѵٴ� �������� �ִ�.
--   ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ������ȴ�.
--   �ϳ��� ���̺� ������ �� UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�.
--   ��,  �ϳ��� ���̺� UNIQUE ���������� �÷��� ���� �� ����� ���� �����ϴ� ���̴�.
-- �����ϱ⸸ �ϸ�ȴ�.

--2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������ Ÿ��[CONSTRAUNT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
-- �÷��� ������ Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� UNIQUE(�÷���,....)

--�� UK ���� �ǽ�( �� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)     UNIQUE
);
--==>> Table TBL_TEST5��(��) �����Ǿ����ϴ�.

-- �������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
/*
HR	SYS_C007067	TBL_TEST5	P	COL1		
HR	SYS_C007068	TBL_TEST5	U	COL2		
*/



-- ������ �Է�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1,'TEST');          --> ���� �߻�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3,'ABCD');          --> ���� �߻�
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3,NULL);   
-- NULL �� �����Ͱ� �ƴϴ�
INSERT INTO TBL_TEST5(COL1) VALUES(4);  
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5,'ABCD');          --> ���� �߻�

-- Ȯ��
SELECT *
FROM TBL_TEST5;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/




--�� UK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2			
*/


--�� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)

--���̺� ����

CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST7';
--==>> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
--  +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);
----��

ALTER TABLE TBL_TEST7
ADD(CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
  , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2));
--==>>Table TBL_TEST7��(��) ����Ǿ����ϴ�.


-- �������� �߰� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/




--------------------------------------------------------------------------------

-- ���� CHECK(CK:C) ����--


--1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������
             -------------------------------
--          ������Ÿ�԰� ���̷� 1�� ���͸� ���� ������
-- NUMBER(3) = -999 ~ 999  

--   �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ��� �Ѵ�.
--   ����, �÷����� �����Ǵ� �����͸� �˻��Ͽ� ���ǿ� �´� �����ͷ� �����Ǵ� �͸�
--   ����ϴ� ����� �����ϰ� �ȴ�.
 
--2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ��[CONSTRAINT CONSTRAINT��] CHECK(�÷��� ����)

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� CHECK(�÷� ����)


--�� CK ���� �ǽ�(�� �÷� ������ ����)

CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)    
, COL3 NUMBER(3)        CHECK (COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8��(��) �����Ǿ����ϴ�.

--������ �Է�

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '������', 100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '������', 100);  --> ���� �߻�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '������', 101);  --> ���� �߻�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '������', -1);   --> ���� �߻�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '������', 80);


-- Ȯ��
SELECT *
FROM TBL_TEST8;
/*
1	������	100
2	������	80
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- ���� ����Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
/*
HR	SYS_C007073	TBL_TEST8	C	COL3	    COL3 BETWEEN 0 AND 100	
HR	SYS_C007074	TBL_TEST8	P	COL1		(null)
*/

--��  CK ���� �ǽ� (�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9��(��) �����Ǿ����ϴ�.
--==> �ٽ��ؾ��� ........

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '������', 100);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '������', 100);  --> ���� �߻�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '������', 101);  --> ���� �߻�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '������', -1);   --> ���� �߻�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '������', 80);



-- ���� ����Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';


--�� CK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)

CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==>> Table TBL_TEST10��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST10
ADD( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
   , CONSTRAINT TEST10_COL3_CK CHECK (COL3 BETWEEN 0 AND 100));
--==>> Table TBL_TEST10��(��) ����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	    COL3 BETWEEN 0 AND 100	
*/


-- ���̺� ����
CREATE TABLE TBL_TESTMEMBER
( SID NUMBER
, NAME VARCHAR2(30)
, SSN CHAR(14)          -- �Է����� �� 'YYMMDD-NNNNNNN'
, TEL VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

--�� TBL_TESTMEMBER ���̺��� SSN �÷�(�ֹε�Ϲ�ȣ �÷�) ����
-- ������ �Է��̳� ������ ������ ��ȿ�� �����͸� �Է� �� �� �ֵ���
-- üũ ���������� �߰� �� �� �ֵ��� �Ѵ�.
-- (��  �ֹε�� Ư���ڸ��� �Է� ������ �����͸� 1,2,3,4, �� �����ϵ��� ó��)
-- ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ����Ѵ�. DO


SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';


-- ���� �� �� Ʋ��.......
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT TESTMEMBER_SSN_CK CHECK (SSN BETWEEN '_______1______' AND '_______4______'));
--==>> Table TBL_TESTMEMBER��(��) ����Ǿ����ϴ�.


-- ģ���� �� ��
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT TESTMEMBER_SSN_CK CHECK(TO_NUMBER(SUBSTR(SSN,8,1)BETWEEN 1 AND 4)) );



ALTER TABLE TBL_TESTMEMBER
DROP CHECK;


-- DROP ���
ALTER TABLE TBL_TESTMEMBER
DROP CONSTRAINT TESTMEMBER_SSN_CK;

ROLLBACK;

DESC TBL_TESTMEMBER;

-- ���� ���� �߰�
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(�ֹι�ȣ 8��°�ڸ� 1���� '1' �Ǵ� '2' �Ǵ� '3' �Ǵ�'4'));

ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN 8,1)�� '1' �Ǵ� '2' �Ǵ� '3' �Ǵ�'4'));

ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN 8,1) IN ('1','2','3','4')) );
--==>> 
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN, 8,1) IN ('1','2','3','4')) );





-- 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';



-- ������
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '���ҿ�', '941124-2234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(2, '�ֵ���', '950222-1234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(3, '������', '040601-3234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(4, '������', '050215-4234567','010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)           
VALUES(5, '������', '050215-5234567','010-5555-5555');     --> ���� �߻�
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(6, '������', '050215-6234567','010-6666-6666');     --> ���� �߻�


SELECT *
FROM TBL_TESTMEMBER;
/*
���ҿ�	941124-2234567	010-1111-1111
�ֵ���	950222-1234567	010-2222-2222
������	040601-3234567	010-3333-3333
������	050215-4234567	010-3333-3333
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--------------------------------------------------------------------------------

--���� FOREIGN KEY(FK:F:R) ����--

--1. ���� Ű(R) �Ǵ� �ܷ� Ű(FK:F)�� �� ���̺��� ������ �� ������ �����ϰ�
--   ���� �����Ű�µ� ���Ǵ� ���̴�.
--   �� ���̺��� �⺻ Ű ���� �ִ� ����
--   ���� ���̺� �߰��ϸ� ���̺� �� ������ ���� �� �� �ִ�.
--   �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ�Ű�� �ȴ�.


--2. �� �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--   �� �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
--   �� ��, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.

--3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                  REFERENCES �������̺��(�����÷���)
--                  [ON DELETE CASCADE | ON DELETE SET NULL] �� �߰��ɼ�(�������� ������������)


-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
--CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷���)
--           REFERENCES �������̺��(�����÷���)
--           [ON DELETE CASCADE | ON DELETE SET NULL] �� �߰��ɼ�


-- �� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
--   �θ� ���̺��� ���� �۾��� ���� �����ؾ��Ѵ�.
--   �׸��� �̶�, �θ� ���̺����� �ݵ�� PK �Ǵ� UK ����������
--   ������ �÷��� �����ؾ��Ѵ�.


/*
�� �� ����صα� ��
-- ���̸� �������� ������
�÷��� CHAR        -- �� ����
�÷��� NUMBER      -- ǥ�������� �� ���°� 10�� 38��(��� ���ڰ� ����)
*/


-- �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.

-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1,'���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2,'�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3,'����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4,'����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4


-- Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/


-- �ǵ��� ��� �� ������ Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� FK ���� �ǽ� (�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP1
( SID       NUMBER      PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER      REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';

/*
HR	SYS_C007082	TBL_EMP1    	P	SID		
HR	SYS_C007083	TBL_EMP1	    R	JIKWI_ID		NO ACTION
                                           �߰��ɼ�����
*/

-- ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1,'���̰�', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2,'�ֳ���', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3,'������', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4,'������', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'����', 5);   --> ���� �߻�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'����', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6,'���¹�');


-- Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	4
5	����	1
6	���¹�	(null)
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.



--�� FK ���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);


--�� FK ���� �ǽ�(�� ���̺� ������ �������� �߰�)
CREATE TABLE TBL_EMP3
( SID   NUMBER
, NAME  VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.


-- ���������߰�
ALTER TABLE TBL_EMP3
ADD( CONSTRAINT EMP3_SID_PK  PRIMARY KEY(SID)
   , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.


-- �������� ����
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		


-- �ٽ� �������� �߰�

ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.               
                
-- �ٽ� ��������Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';

/*
HR	EMP3_SID_PK	    TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY ���� �� ���ǻ���
--      �����ϰ����ϴ� �θ� ���̺��� ���� �����ؾ��Ѵ�.
--      �����ϰ��� �ϴ� �÷��� PRIMARY KEY �Ǵ� UNIQUE ���������� �����Ǿ� �־���Ѵ�.
--      ���̺� ���̿� PRIMARY KEY �� FOREIGN KEY �� ���ǵǾ� ������
--      PRIMARY KEY ���������� ������ ������ ���� ��
--      FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.
--      (��, �ڽ����̺� �����ϴ� ���ڵ尡 ������ ���
--      �θ� ���̺��� �����޴� �ش� ���ڵ�� ���� �� �� ���ٴ� ���̴�.)
--      ��, FK ���� �������� ��ON DELETE CASCADE����ON DELETE SET NULL���ɼ���
--      ����Ͽ� ������ ��쿡�� ������ �����ϴ�.
--      ����, �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ��Ѵ�.


-- �θ����̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/
-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	4
5	����	1
6	���¹�	(null)      
*/

-- �θ� ���̺� ���� �õ�
DROP TABLE TBL_JOBS;
--==>> ���� �߻�

-- �θ� ���̺��� ���� ���� ���� �õ�
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 4	����

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> ���� �߻�


-- ������ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID  = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.



-- Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	1
5	����	1
6	���¹�	(null)
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �θ� ���̺�(TBL_JOBS)�� ����(4) �����͸� �����ϰ� �ִ� 
-- �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� �������� �ʴ� ��Ȳ

-- �̿� ���� ��Ȳ���� �θ����̺�(TBL_JOBS)DML
-- ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �θ� ���̺�(TBL_JOBS)�� ��� ������ ����
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1	���


DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> ���� �߻�


-- �� �θ� ���̺��� �����͸� �����Ӱ�(?) �����ϱ� ���ؼ���
-- ON DELETE CASCADE �ɼ� ������ �ʿ��ϴ�.

-- TBL_EMP1 ���̺�(�ڽ� ���̺�) ���� FK ���������� ������ ��
-- CASECADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�.



-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';    
/*
HR	SYS_C007082	TBL_EMP1	P	SID		
HR	SYS_C007083	TBL_EMP1	R	JIKWI_ID		NO ACTION  ������
*/



-- ���� ��������
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007083;        -- ������ FK FOREIGN KEY, ����Ű, �ܷ�Ű�� ���� 
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.




-- �������� ���� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1'; 
--==>> HR	SYS_C007082	TBL_EMP1	P	SID		




--��ON DELETE CASCADE���ɼ��� ���Ե� �������� �������� �ٽ� ����
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID)
                ON DELETE CASCADE; 
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- �������� �������� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';  
/*
HR	SYS_C007082	    TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

-- �� CASECADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�.
--   ��, ....�θ� ���̺��� �����Ͱ� ������ ���...
--   �̸� �����ϴ� �ڽ� ���̺��� �����͵� ��~~~~�� �Բ� �����ȴ�.



-- �θ����̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
*/
-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	���̰�	1
2	�ֳ���	2
3	������	3
4	������	1
5	����	1
6	���¹�	(null)    
*/

-- �θ� ���̺�(TBL_JOBS)���� ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_EMP1;
/*
1	���̰�	1
2	�ֳ���	2
4	������	1
5	����	1
6	���¹�	(null)    
*/




-- �θ� ���̺�(TBL_JOBS)���� ���(1) ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.




-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
2	�ֳ���	2
6	���¹�	(null)
*/
--==>> ���(1)�� ���ϴ� �ڽĵ����� �� �����




DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.
-- ���� �ÿ��� �θ� �� �ڽ� ����
-- ���� �ÿ��� �ڽ� �� �θ� ���� ��, �ݴ��

DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.

DROP TABLE TBL_JOBS;
--==>> ���� �߻�

DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.


DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.

