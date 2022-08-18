SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1 + 5 
FROM DUAL;
--==>> 6

SELECT      1 + 5
FROMDUAL;
--==>> �����߻�
--==>> ORA-00923: FROM keyword not found where expected

SELECT "������ ������ ����Ŭ"
from DUAL;
--==>> �����߻�
--==>> ORA-00904: "������ ������ ����Ŭ": invalid identifier

SELECT '������ ������ ����Ŭ'
FROM DUAL;
--===>> ������ ������ ����Ŭ

SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28

SELECT 10 * 5
FROM DUAL;
--==>> 50


SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2
FROM DUAL;
--==>> 2
SELECT 4 / 2.0
FROM DUAL;
--==>> 2


SELECT 4.0 / 2.0
FROM DUAL;
--==>> 

SELECT 5 / 2
FROM DUAL;
--==>> 2.5

SELECT 100 - 23
FROM DUAL;
--==>> 77

SELECT 100 - 3.14
FROM DUAL;
--==>> 96.86


SELECT '���¹�' + '������'
FROM DUAL;
--==>> ���� �߻�
-- (ORA-01722: invalid number) �������°� �ƴ϶� ���� ������ �ȵȴ�.

-- �� ����Ŭ ������ �����ϴ� ����� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	    LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

-- * �� ��ζ�� �ǹ�  ex) *.mp3  , *.* S
SELECT *
FROM DBA_USERS;
--==>> 
/*
SYS	0		        OPEN		23/02/06	SYSTEM	TEMP
SYSTEM	5		    OPEN		23/02/06	SYSTEM	TEMP
ANONYMOUS	35		OPEN		14/11/25	SYSAUX	TEMP
HR	43		        OPEN		23/02/06	USERS	TEMP
APEX_PUBLIC_USER	45	LOCKED	14/05/29	14/11/25	SYSTEM	TEMP
FLOWS_FILES	44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP
APEX_040000	47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP
OUTLN	9		    EXPIRED & LOCKED	22/08/10	22/08/10	SYSTEM	TEMP
DIP	14		        EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP
ORACLE_OCM	21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP
XS$NULL	2147483638	EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP
MDSYS	42		    EXPIRED & LOCKED	14/05/29	22/08/10	SYSAUX	TEMP
CTXSYS	32		    EXPIRED & LOCKED	22/08/10	22/08/10	SYSAUX	TEMP
DBSNMP	29		    EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP
XDB	34		        EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP
APPQOSSYS	30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP
*/
SELECT DEFAULT_TABLESPACE, USERNAME
FROM DBA_USERS;
/*
SYSTEM	SYS
SYSTEM	SYSTEM
SYSAUX	ANONYMOUS
USERS	HR
SYSTEM	APEX_PUBLIC_USER
SYSAUX	FLOWS_FILES
SYSAUX	APEX_040000
SYSTEM	OUTLN
SYSTEM	DIP
SYSTEM	ORACLE_OCM
SYSTEM	XS$NULL
SYSAUX	MDSYS
SYSAUX	CTXSYS
SYSAUX	DBSNMP
SYSAUX	XDB
SYSAUX	APPQOSSYS
*/

--> DBA �� �����ϴ� Oracle Data Dictionry Viwe ��
-- ������ ������ �������� ���� ������쿡�� ��ȸ�� �����ϴ�.
-- ���� ������ ��ųʸ� ������ �������ص� �������.

--�� ��HR ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ���� ��ȸ

SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
    :
HR	    LOCKED
    :
*/


--�� ��HR������� ������ �н����带 lion ���� ����
show user
ALTER USER HR IDENTIFIED BY lion;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ��HR�� ����� ������ ����� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.


SELECT USER
FROM DUAL;
--==>> SYS

--�� ��HR�� ����� ������ �ٽ� ���
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ��HR�� ����� ������ ����� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.


----------------------------------------------------------------------------

--��TABLESPACE ����

--�� TABLESPACE��?(������ ���屸��)
-->  ���׸�Ʈ(���̺�, �ε���,....) �� ��Ƶδ�(�����صδ�)
--   ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA              -- �����ϰڴ�. ���̺� �����̽��� TBU_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'   -- �������� ������ ���� ��� �� �̸�
SIZE 4M                                 -- ������(�뷮) 4�ް�
EXTENT MANAGEMENT LOCAL                 -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ������ �޶�
SEGMENT SPACE MANAGEMENT AUTO;          -- ���׸�Ʈ ���� ������ ����Ŭ ������ �˾Ƽ� ���� 

--�� ���̺� �����̽� ���� ������ �����ϱ� ����
--   �ش� ����� �������� ���͸� ���� �ʿ�

--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

--�� ������ ���̺����̽� ��ȸ

SELECT *
FROM DBA_TABLESPACES;
--==>> 
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/

--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES
WHERE FILE_NAME LIKE '%TBS_EDUA%';
--==>> C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE


--�� ����Ŭ ����� ���� ����
CREATE USER eomsoyeon IDENTIFIED BY java002$
DEFAULT TABLESPACE TBS_EDUA;
--> eomsoyeon �̶�� ����� ������ ���� �ϰڴ�. (����ڴ�.)
--  �� ����� ������ �н������ java002$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ��ü��(���׸�Ʈ��)
--  �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ���(�����������)
--  �����ϰڴ�.
--==>> User EOMSOYEON��(��) �����Ǿ����ϴ�. 


--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)�� ���� ���� �õ�
-- ������ �Ұ�(����)
-- create session ������ ���� ������ ���� �Ұ�.


--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����) ��
--   ����Ŭ ���� ������ ���� �Ҽ� �ֵ��� creat session ���� �ο� 
GRANT CREATE SESSION TO EOMSOYEON;
--==>> Grant��(��) �����߽��ϴ�.



--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)��
--  ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�

GRANT CREATE TABLE TO EOMSOYEON;
--==>> Grant��(��) �����߽��ϴ�.

--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)��
-- ���̺����̽�(TBS_EDUA)���� ����� ���ִ°��� ����
ALTER USER EOMSOYEON
QUOTA UNLIMITED ON TBS_EDUA;
-----  --------  ---------
--�Ҵ緮 ������   ���̺����̽���
-- �Ҵ緮 3M
--==>> User EOMSOYEON��(��) ����Ǿ����ϴ�.



--------------------------------------------------------------------------------
-- SCOTT ������ Ȱ���� �� �ִ� ����
--�� ����� ���� ����(SCOTT / TIGER)
create user scott
identified by tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

--�� ����� ������ ����(��) �ο�
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.


--�� SCOTT ����� ������ �⺻ ���̺����̽� USERS �� ����(����)
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.


--�� SCOTT ����� ������ �ӽ� ���̺����̽��� TEMP�� ����(����)
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.




































