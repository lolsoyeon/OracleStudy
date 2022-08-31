SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT FILENO "���Ϲ�ȣ"
    ,FILENAME "���ϸ�"
FROM TBL_FILES;
/*
--------  ------------------------------------
���Ϲ�ȣ  ���ϸ�
--------  ------------------------------------
        1	SALES.DOC
        2	PANMAE.XXLS
        3	RESERCH.PPT
        4	DOCUMENTS\STUDY.HWP
        5	SQL.TXT
        6	FLOWER.PNG
        7	20220816_01_SCOTT.SQL
*/

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "���ϸ�"
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "��� ���� ���ϸ�"
    ,SUBSTR(FILENAME,16,9) "���ϸ�"
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC



SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "��� ���� ���ϸ�"
    ,SUBSTR(FILENAME,16,9) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                SALES.DOC
2	C:\AAA\PANMAE.XXLS	                    XLS
3	D:\RESERCH.PPT	                        (null)
4	C:\DOCUMENTS\STUDY.HWP	                UDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	    MP\HOMEWO
6	C:\SHARE\F\TEST\FLOWER.PNG	            \FLOWER.P
7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL	\20220816
�ڿ��� ���� �����ϸ� ù ��°�� �����ϴ� ��������
*/

SELECT FILENO "���Ϲ�ȣ"
    , REVERSE(FILENAME) "�Ųٷε����ϸ�"
FROM TBL_FILES;
/*
1	COD.SELAS               \CCC\BBB\AAA\:C             �� ���� ��\������ ��ġ: 10 �� 1 ~ 9 ����
2	SLXX.EAMNAP             \AAA\:C                     �� ���� ��\������ ��ġ: 12 �� 1 ~ 11 ����
3	TPP.HCRESER             \:D                         �� ���� ��\������ ��ġ: 12 �� 1 ~ 11 ����
4	PWH.YDUTS               \STNEMUCOD\:C               �� ���� ��\������ ��ġ: 10 �� 1 ~ 9 ����
5	TXT.LQS                 \KROWEMOH\PMET\STNEMUCOD\:C �� ���� ��\������ ��ġ: 8 �� 1 ~ 7 ����
6	GNP.REWOLF              \TSET\F\ERAHS\:C            �� ���� ��\������ ��ġ: 11 �� 1 ~ 10 ����
7	LQS.TTOCS_10_61802202   \ELCARO\YDUTS\:E            �� ���� ��\������ ��ġ: 22 �� 1 ~ 21 ����
*/

--�� ���� �� �����ϰ� �������ϱ� �� ġȯ�� ����
SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILNAME) "�ŲٷεȰ�ι����ϸ�"
    , SUBSTR(����ڿ�, ���������ġ, ���� \ ������ġ -1) "�Ųٷε����ϸ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
    , SUBSTR(REVERSE(FILENAME), 1, ���� \ ������ġ -1) "�Ųٷε����ϸ�"
FROM TBL_FILES;


-- ���� ��\���� ������ġ
-- �� INSTR(REVERSE(FILENAME),'\',1 ,1)
-- �� INSTR(REVERSE(FILENAME),'\',1)          1 ���� ����


SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
    , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\',1) -1) "�Ųٷε����ϸ�"
FROM TBL_FILES;
--==>>
/*
COD.SELAS
SLXX.EAMNAP
TPP.HCRESER
PWH.YDUTS
TXT.LQS
GNP.REWOLF
LQS.TTOCS_10_61802202
*/


SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
    , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\',1) -1) "�Ųٷε����ϸ�"
    , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\',1) -1)) "���ϸ�"
FROM TBL_FILES;
--==>> 
/*
1	C:\AAA\BBB\CCC\SALES.DOC    	            COD.SELAS\CCC\BBB\AAA\:C	                COD.SELAS	            SALES.DOC
2	C:\AAA\PANMAE.XXLS	                    SLXX.EAMNAP\AAA\:C	                    SLXX.EAMNAP	            PANMAE.XXLS
3	D:\RESERCH.PPT	                        TPP.HCRESER\:D	                        TPP.HCRESER	            RESERCH.PPT
4	C:\DOCUMENTS\STUDY.HWP	                PWH.YDUTS\STNEMUCOD\:C	                PWH.YDUTS	            STUDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	    TXT.LQS\KROWEMOH\PMET\STNEMUCOD\:C	    TXT.LQS	                SQL.TXT
6	C:\SHARE\F\TEST\FLOWER.PNG	            GNP.REWOLF\TSET\F\ERAHS\:C	            GNP.REWOLF	            FLOWER.PNG
7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL	LQS.TTOCS_10_61802202\ELCARO\YDUTS\:E	LQS.TTOCS_10_61802202	20220816_01_SCOTT.SQL
*/

SELECT FILENO "���Ϲ�ȣ"
    , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\',1) -1)) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESERCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	FLOWER.PNG
7	20220816_01_SCOTT.SQL
*/
SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , INSTR(FILENAME, '\' ,-1) "������ ��ġ"
FROM TBL_FILES;
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                15
2	C:\AAA\PANMAE.XXLS	                     7
3	D:\RESERCH.PPT	                         3
4	C:\DOCUMENTS\STUDY.HWP	                \ �� ������ ��ġ��13 �̶�� 14���� ������
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	    27
6	C:\SHARE\F\TEST\FLOWER.PNG	            16
7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL	16
*/

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , INSTR(FILENAME, '\' ,-1) "������ ��ġ"
    , SUBSTR(FILENAME ,INSTR(FILENAME, '\' ,-1) +1) "���ϸ�"
FROM TBL_FILES;
--==>>
SELECT FILENO "���Ϲ�ȣ"
    , SUBSTR(FILENAME ,INSTR(FILENAME, '\' ,-1) +1) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESERCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	FLOWER.PNG
7	20220816_01_SCOTT.SQL
*/

--�� LPAD() 
--> Byte �� Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�

SELECT 'ORACLE' "COL1"
        , LPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
-->�� 10Byte ������ Ȯ���Ѵ�.                     �� �� ��° �Ķ���� ���� ����.....
-->�� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.      �� ù ��° �Ķ���� ���� ����.....
-->�� �����ִ� Byte ������ ���ʺ��� �� ��° �Ķ���� ������ ä���.
-->�� �̷��� ������ ���� ������� ��ȯ�Ѵ�.
--==>> ORACLE	****ORACLE


--�� RPAD()
--> Byte �� Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
        , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
-->�� 10Byte ������ Ȯ���Ѵ�.                     �� �� ��° �Ķ���� ���� ����.....
-->�� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.     �� ù ��° �Ķ���� ���� ����.....
-->�� �����ִ� Byte ������ �����ʺ��� �� ��° �Ķ���� ������ ä���.
-->�� �̷��� ������ ���� ������� ��ȯ�Ѵ�.
--==>> ORACLE	ORACLE****


-- �׳� TRIM()�� �ִ� ������̡�
--�� LTRIM()
SELECT 'ORAORAORAORACLEORACLE' "COL1" --���� ���� ���� ����Ŭ ����Ŭ
    ,LTRIM('ORAORAORAORACLEORACLE','ORA') "COL2"
    ,LTRIM('AAAAAAORAORACLEORACLE','ORA') "COL3"
    ,LTRIM('ORAORAoRAORACLEORACLE','ORA') "COL4"
    ,LTRIM('ORAORA ORAORACLEORACLE','ORA') "COL5"
    ,LTRIM('                ORACLE', ' ')"COL6"
    ,LTRIM('                ORACLE')"COL7" --�� ��° �Ķ���� ����(�� ���ʰ��� ���� �Լ�)
FROM DUAL;
--==>> 
/*
ORAORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE
 ORAORACLEORACLE
ORACLE
ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
-- ���ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
-- ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�.
-- ��, �ϼ������� ó������ �ʴ´�.

SELECT LTRIM('����̱���̱���̱���������̽ŽŽŹ��̱��','�����') "COL1"
FROM DUAL;
--==>> ���̱��


--�� RTRIM()
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
-- �����ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
-- ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�.
-- ��, �ϼ������� ó������ �ʴ´�.

SELECT RTRIM('����̱���̱���̱���������̽ŽŽŹ��̱��','�����') "COL1"
FROM DUAL;
--==>> ����̱���̱���̱���������̽ŽŽŹ�



--�� TRANSLATE()
--> 1:1 �� �ٲ��ش�.
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "COL1"
FROM DUAL;
--==>> my oracle server


SELECT TRANSLATE('010-4051-5510'
                , '0123456789'
                , '�����̻�����ĥ�ȱ�') "COL1"
FROM DUAL;
--==>> ���ϰ�-�������-�����ϰ�



--�� REPLACE()
-- REPLACE()�� �� ��° �Ķ���͸� ������ ����.
SELECT REPLACE('MY ORACLE SERVER ORAHOME','ORA', '����') "COL1"
FROM DUAL;
--==>> MY ����CLE SERVER ����HOME


--------------------------------------------------------------------------------
-------------- ���ڰ��� �Լ� --------------

--�� ROUND() �ݿø�ó���� �ִ� �Լ�
SELECT 48.678 "COL1"             -- 48.678
    , ROUND(48.678, 2) "COL2"    -- 48.68  �Ҽ��� ���� ��°�ڸ����� ǥ�� �� �ι�° �Ķ����
    , ROUND(48.674, 2) "COL3"    -- 48.67
    , ROUND(48.674, 1) "COL4"    -- 48.7
    , ROUND(48.674, 0) "COL5"    -- 49
    , ROUND(48.674) "COL6"       -- 49
    , ROUND(48.674, -1) "COL7"   -- 50
    , ROUND(48.674, -2) "COL8"   -- 0
    , ROUND(48.674, -3) "COL9"   -- 0
FROM DUAL;



--�� TRUNC() ������ ó���� �ִ� �Լ�
SELECT 48.678 "COL1"                  -- 48.678
        , TRUNC(48.678, 2) "COL2"     -- 48.67   -- �Ҽ��� ��°�ڸ����� ǥ�� �� �ι�° �Ķ����
        , TRUNC(48.674, 2) "COL3"     -- 48.67
        , TRUNC(48.674, 1) "COL4"     -- 48.6
        , TRUNC(48.674, 0) "COL5"     -- 48
        , TRUNC(48.674) "COL6"        -- 48      -- �� ��° �Ķ���� ���� 0�� ��� �������� 
        , TRUNC(48.674, -1) "COL7"    -- 40      
        , TRUNC(48.674, -2) "COL7"    -- 0
        , TRUNC(48.674, -3) "COL7"    -- 0
FROM DUAL;




--�� MOD() �������� ��ȯ�ϴ� �Լ� �� % 

SELECT MOD(5, 2) "COL1"
FROM DUAL;
--> 5�� 2�� ���� ������ ��� �� ��ȯ
--==>>1


--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "COL1"
FROM DUAL;
--==>> 125


--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�

SELECT SQRT(2) "COL1"
FROM DUAL;
--> ��Ʈ 2�� ���� ����� ��ȯ
--==>> 1.41421356237309504880168872420969807857


--�� LOG() �α� �Լ�
-- (����Ŭ, MSSQL�� ���α�, �ڿ��α� ��� �����Ѵ�.)
SELECT LOG(10,100) "COL1"
    , LOG(10,20) "COL2"
FROM DUAL;
--== 2	1.30102999566398119521373889472449302677

--�� �ﰢ�Լ�
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
-->���� ����, �ڽ���, ź��Ʈ ������� ��ȯ�Ѵ�.

--�� �ﰢ�Լ��� ���Լ�(����: -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5),ATAN(0.5)
FROM DUAL;
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/
-->���� �����, ���ڽ���, ��ź��Ʈ ������� ��ȯ�Ѵ�.




--��SING() ����, �ں�ȣ, Ư¡
--> ���� ������� ����̸� 1, 0 �̸� 0, �����̸� -1�� ��ȯ�Ѵ�.

SELECT SIGN(5-2) "COL1"
     , SIGN(5-5) "COL2"
     , SIGN(5-7) "COL3"
FROM DUAL;
--==>> 1	0	-1
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� ���� ���ȴ�.



--�� ASCII(), CHR() �� ���� ����(����) �ϴ� �Լ�

SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A


--> ��ASCII()��  : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
-->  ��CHR()��   : �Ű������� �Ѱܹ��� �ƽ�Ű�ڵ� ������ �ش� ���ڸ� ��ȯ�Ѵ�.

-------------------------------------------------------------------------------


-- ��¥���� ó�� ������ �Լ� SYSDATE()


--�� ��¥ ���� ���� ���� ����

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� ��¥ ������ �⺻ ������ �ϼ�(DAY) �̴�~!~!~!!!!!! CHACK~!!!
SELECT SYSDATE "COL1"       -- 2022-08-17 11:14:35
     , SYSDATE + 1 "COL2"   -- 2022-08-18 11:14:35
     , SYSDATE - 2 "COL3"   -- 2022-08-15 11:14:35
     , SYSDATE + 30 "COL3"  -- 2022-09-16 11:14:35
FROM DUAL;
--==>> 2022-08-17 11:12:04


--�� �ð� ���� ����
SELECT SYSDATE "COL1"           -- 2022-08-17 11:16:02
     , SYSDATE + 1/24 "COL2"    -- 2022-08-17 12:16:02
     , SYSDATE - 2/24 "COL2"    -- 2022-08-17 09:16:27
FROM DUAL;

--�� ���� �ð���... ���� �ð� ���� +1 �� 2�ð� 3 �� 4�� �ĸ� ��ȸ�Ѵ�.DO
/*
-----------------  -----------------
����ð�            ������ �ð�
------------------  ----------------
2022-08-17 11:16:27  2022-08-18 13:18:29
------------------- ---------------------
 */
-- ���� �� ��
-- 1�ð��� 60�� 
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 "���� +1��"
     , SYSDATE + 1  + 2/24 "���� +1�� +2�ð�"
     , SYSDATE + 1  + 2/24 + 3���� 2 "���� +1�� +2�ð� +3��"
FROM DUAL;

-- ��� 1.
SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))"���� �� �ð�"
FROM DUAL;
--==>>2022-08-17 11:25:18	
--    2022-08-18 13:28:22


-- ��� 2.
SELECT SYSDATE "���� �ð�"
      ,SYSDATE + ((1*24*60*60)+ (2*60*60) + (3*60) + 4) / (24*60*60) "���� �� �ð�"
FROM DUAL;
--==>> 2022-08-17 11:27:26	
--     2022-08-18 13:30:30

--�� ��¥ - ��¥ �� �ϼ� 
SELECT TO_DATE('2023-01-16', 'YYYY-MM-DD') - TO_DATE('2022-06-27', 'YYYY-MM-DD')"COL1"
FROM DUAL;
--==>> 203 �ϼ�

--�� ������ Ÿ���� ��ȯ
SELECT TO_DATE('2022-08-17', 'YYYY-MM--DD') "COL1"
FROM DUAL;
--==>> 2022-08-17 00:00:00


SELECT TO_DATE('2022-08-32', 'YYYY-MM--DD') "COL1"
FROM DUAL;
--==>> ���� �߻�
--  ORA-01861: literal does not match format string

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> ���� �߻�
--  ORA-01839: date not valid for month specified


SELECT TO_DATE('2022-13-17', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> ���� �߻�
--  ORA-01843: not a valid month

--�� TO_DATE()�Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� �����ϴ� ��������
-- ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������.


--�� ADD_MONTHS() ���� ���� �����ִ� �Լ�
 SELECT SYSDATE "COL1"
        , ADD_MONTHS(SYSDATE, 2) "COL2"
        , ADD_MONTHS(SYSDATE, 3) "COL3"
        , ADD_MONTHS(SYSDATE, -2) "COL4"
        , ADD_MONTHS(SYSDATE, -3) "COL5"
 FROM DUAL;
--==>>
/*
2022-08-17 11:37:28	    ����
2022-10-17 11:37:28	    2���� ��
2022-11-17 11:37:28	    3���� ��
2022-06-17 11:37:28	    2���� ��
2022-05-17 11:37:28     3���� ��
*/
--> ���� ���ϰ� ���� �Լ�


--�� MONTHS_BETWEEN()
-- ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ�Ѵ�.  �� ���� : ���� ��
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-30', 'YYYY-MM-DD')) "COL1"
FROM DUAL;
--==>> 242.564095728793309438470728793309438471
--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
-- ������� ��ȣ�� ��-��(����)�� ��ȯ�Ǿ��� ��쿡��
-- ù ��° ���ڰ��� �ش��ϴ� ��¥����
-- �� ��° ���ڰ��� �ش��ϴ� ��¥�� ���̷��� ��� �ǹ̷� Ȯ���� �� �ִ�.


--�� NEXT_DAY()
-- ���ƿ��� ������ ��¥�� Ȯ���ϴ� �Լ�
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
     , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;
--==>> 2022-08-20 11:44:28	
--     2022-08-22 11:44:28


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.
 
 
SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==>> 2022-08-20 11:47:33	
--     2022-08-22 11:47:33


--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� LAST_DAY()
--> �ش� ��¥�� ���ԵǾ��ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE) "COL1"
    , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
    , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL3"
FROM DUAL;
--==>> 
/*
2022-08-31	
2020-02-29	
2019-02-28
*/


--�� ���úη�... �¹��̰� ���뿡 �ٽ� ����(?)����....
-- ���� �Ⱓ�� 22������ �Ѵ�.DO

-- 1. ���� ���ڸ� ���Ѵ�.
SELECT SYSDATE "�Դ���"
     , ADD_MONTHS(SYSDATE , 22) " ���� ��¥"
FROM DUAL;
--==>> 2022-08-17	2024-06-17

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �Ѵٰ� �����ϸ� 
-- �¹��̰� �� ���� �Ծ�� ���� �����ٱ�......

SELECT SYSDATE "�Դ���"
     , ADD_MONTHS(SYSDATE , 22) " ���� ��¥"
FROM DUAL;


SELECT TO_DATE('2024-06-17', 'YYYY-MM-DD') - TO_DATE('2022-08-17', 'YYYY-MM-DD') "�ϼ�"
    , (TO_DATE('2024-06-17', 'YYYY-MM-DD') - TO_DATE('2022-08-17', 'YYYY-MM-DD'))*3 "��� ������ ����?"
FROM DUAL;
--==>> 670�� 2010��


-- ���� �Ⱓ * 3
-- ---------
-- (�������� - ��������)
-- (�������� - ��������) *3

SELECT (�������� - ��������) *3
FROM DUAL;

-- T
SELECT (ADD_MONTHS(SYSDATE , 22) - SYSDATE) *3
FROM DUAL;

--�� Ȯ��
SELECT MONTHS_BETWEEN(TO_DATE('2024-06-17', 'YYYY-MM-DD'), TO_DATE('2022-08-17', 'YYYY-MM-DD')) "COL1"
FROM DUAL;

-- ���� ��¥ �� �ð����� ����



ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.
-- ������(2023-01-16 18:00:00)����
-- �����Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------  ----------------------  -----  ----- ---- ---------
���� �ð�              ������                  ��     �ð�  ��  ��
--------------------  ----------------------  -----  ----- ---- --------
2022-08-17 12:36:20     2023-01-16 18:00:00     130     5    22   40
*/
SELECT SYSDATE "����ð�"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TRUNC(TO_DATE('2023-01-16', 'YYYY-MM-DD') - SYSDATE) "��"
FROM DUAL;

SELECT SYSDATE "����ð�"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TRUNC(TO_DATE('2023-01-16', 'YYYY-MM-DD') - SYSDATE) "��"
    , ������ �ð� - ������ �ð����� �ϼ��� ����  "�����ð�" 
    , (24*60)"��"
    , (24*60*60 )"��"
FROM DUAL;

/*
--�� �ð� ���� ����
SELECT SYSDATE "COL1"           -- 2022-08-17 11:16:02
     , SYSDATE + 1/24 "COL2"    -- 2022-08-17 12:16:02
     , SYSDATE - 2/24 "COL2"    -- 2022-08-17 09:16:27
FROM DUAL;

*/
-- ���� �� ��
SELECT SYSDATE "����ð�"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "��"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE "����?"
    , (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - (TO_DATE(SYSDATE)))/ 24 /60 "��" 
    , (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - (TO_DATE(SYSDATE)))/ 24 /60/ 60"��" 
FROM DUAL;

SELECT SYSDATE "����ð�"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE "��"
    , ((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)- TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)) * 24 "�ð�" 
    , TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)-152) * 60) "��"
    --, TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)-152) * 24 / 60 / 60) "��" 
FROM DUAL;

SELECT SYSDATE "����ð�"
    , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "��"
    , TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)- TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)) * 24) "�ð�" 
    , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)- TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)) * 24),60) "��"
    , MOD(MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)- TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)) * 24),60),60) "��" 
FROM DUAL;





--��1�� 2�ð� 3�� 4�� ���� ���ʡ� �� ȯ���ϸ�.....

SELECT (1��) + (2�ð�) + (3��) +(4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) +(4)
FROM DUAL;
--==>> 93784

-- �� ��93784�ʡ��� �ٽ� ����, �ð�, ��, �ʡ� �� ȯ���ϸ�
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "��"
     , MOD(TRUNC(TRUNC(93784/60)/60), 24) "�ð�"
     , MOD(TRUNC(93784/60),60) "��"
     , MOD(93784 , 60) "��"�¹ξ�
FROM DUAL;


SELECT TRUNC(TRUNC(TRUNC(13140184/60)/60)/24) "��"
       , MOD(TRUNC(TRUNC(13140184/60)/60), 24) "�ð�"
       , MOD((13140184/60) , 60) "��" -- 13140180 / 60
       , MOD(13140184, 60) "��"
FROM DUAL;
--==>> 152	2	3.0666666666666666666666666666666667  	4


SELECT TRUNC(TRUNC(TRUNC(13140184/60)/60)/24) "��"
       , MOD(TRUNC(TRUNC(13140184/60)/60), 24) "�ð�"
       , MOD(TRUNC(13140184/60) , 60) "��" -- 13140180 / 60
       , MOD(13140184, 60) "��"
FROM DUAL;
--==>> 152	2	3	4


-- T
--������ ���� �����Ⱓ Ȯ�� (���� : �ϼ�)
SELECT ��������- ��������
FROM DUAL;

SELECT TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--������ ���� �����Ⱓ Ȯ�� (���� : ��)
SELECT (�����Ⱓ) * (�Ϸ縦�����ϴ���ü��)
FROM DUAL;

SELECT (�����Ⱓ) * (24*60*60)
FROM DUAL;


SELECT (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;


SELECT ((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))
FROM DUAL;


-- ���� 
SELECT TRUNC(TRUNC(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60)/24) "��"
       , MOD(TRUNC(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60), 24) "�ð�"
       , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60) , 60) "��"
       , TRUNC(MOD(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60)) "��"
FROM DUAL;
--==>> 152	2	15	0
--==>> 152	2	14	48




--�� ���� �¾ ��¥ �� �ð����� ����....������� 
-- �󸶸�ŭ �ð��� ��� �ִ��� ....
-- ������ ���� ���·� ��ȸ �� �� �ֵ��� �������� �ۼ��Ѵ�.
/*
--------------------  ----------------------  -----   ----- ---- --------
���� �ð�              �������                ��      �ð�  ��  ��
--------------------  ----------------------  -----   ----- ---- --------
2022-08-17 15:46:20     1994-11-24 21:15:00    100000    5    22   40
*/
--�� �����ؾ��ϴ� �Լ�

--�� MOD(�Ķ����1, �Ķ����2)  �������� ��ȯ�ϴ� �Լ�         java �� %
--> �Ķ���� 1�� �Ķ���� 2�� ���� ������ ��� �� ��ȯ


--�� TRUNC(�Ķ����1, �Ķ����2)  ������ ó���� �ִ� �Լ� (�ݿø�X)
--> �Ķ����1�� ���ϴ� �Ķ����2 ���� ǥ���ϰ� �����Ѵ�.
--> �Ķ����2 �� 0�� ��� ���� �����ϴ�. 
--> TRUNC(�Ķ����1) �̸� ���� ��ȯ!

-- ���� ���� ������� �� ���� ��ƿ� ��¥ (���� : �ϼ�)
SELECT �������� - ������
FROM DUAL;

SELECT SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 10127.7746643518518518518518518518518519
--==>> 10127�� 

-- ���� ���� ��������� ���� ��ƿ� �� (���� : ��)
SELECT (�� �� ��) * (�Ϸ縦�����ϴ���ü��)
FROM DUAL;

SELECT (SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)
FROM DUAL;
--==>> 875041127.999999999999999999999999999997


SELECT SYSDATE "���� �ð�"
       , TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS') "�������"
       , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60)/60)/24) "��"
       , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60)/60), 24) "�ð�"
       , MOD(TRUNC((SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60) , 60) "��" 
       , TRUNC(MOD((SYSDATE - TO_DATE('1994-11-24 21:15:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60), 60)) "��"
FROM DUAL;

--==>> ���� �ð�            �������            ��      �ð�    ��  ��
--------------------------------------------------------------------------------
--==>> 2022-08-17 16:14:02	1994-11-24 21:15:00	10127	18  	59	2
--==>> 2022-08-17 16:15:24	1994-11-24 21:15:00	10127	19	    0	23
--�� �¾ �� ���� ��� ��� �ֱ⶧���� ����(��, �ð�,��, ��)�� �ö󰣴�.


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.
--�� ��¥ �����͸� ������� �ݿø�, ���� ���� ������ ������ �� �ִ�.

-- �� ��¥ �ݿø�
SELECT SYSDATE "COL1"                   -- 2022-08-17 �� �⺻ ���� ��¥ 
    , ROUND(SYSDATE, 'YEAR') "COL2"     -- 2023-01-01 �� �������� ��ȿ�� ������(��ݱ� / �Ϲݱ� ����) 
    , ROUND(SYSDATE, 'MONTH') "COL3"    -- 2022-09-01 �� �� ���� ��ȿ�� ������(15�� ����)
    , ROUND(SYSDATE, 'DD') "COL4"       -- 2022-08-18 �� �ϱ��� ��ȿ�� ������ (���� ����)
    , ROUND(SYSDATE, 'DAY') "COL5"      -- 2022-08-21 �� �ϱ��� ��ȿ�� ������ (������ ���� ����)
                                        -- 2022-08-14 �� �ϱ��� ��ȿ�� ������ (������ ���� ���̾��ٸ�)
FROM DUAL;


-- �� ��¥ ����
SELECT SYSDATE "COL1"                   -- 2022-08-17 �� �⺻ ���� ��¥ 
    , TRUNC(SYSDATE, 'YEAR') "COL2"     -- 2022-01-01 �� �������� ��ȿ�� ������
    , TRUNC(SYSDATE, 'MONTH') "COL3"    -- 2022-08-01 �� �� ���� ��ȿ�� ������
    , TRUNC(SYSDATE, 'DD') "COL4"       -- 2022-08-17 �� �ϱ��� ��ȿ�� ������ 
    , TRUNC(SYSDATE, 'DAY') "COL5"      -- 2022-08-14 �� �� �� �ֿ� �ش��ϴ� �Ͽ���
FROM DUAL;



----------------------------------------------------------------------------------
--���� ��ȯ �Լ� ����-- 


--TO_CHAR()     : ���ڳ� ��¥ �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
--TO_DATE()     : ���� �����͸� ��¥Ÿ������ ��ȯ�����ִ� �Լ�
--TO_NUMBER()   : ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�


-- �� ��¥�� �� ������
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"    -- 2022-08-17
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"          -- 2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"          -- TWENTY TWENTY-TWO
     , TO_CHAR(SYSDATE, 'MM') "COL4"            -- 08
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"         -- 8��
     , TO_CHAR(SYSDATE, 'MON') "COL6"           -- 8��
     , TO_CHAR(SYSDATE, 'DD') "COL7"            -- 17
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"         -- 08-17
     , TO_CHAR(SYSDATE, 'DAY') "COL9"           -- ������
     , TO_CHAR(SYSDATE, 'DY') "COL10"           -- ��
     , TO_CHAR(SYSDATE, 'HH24') "COL11"         -- 17
     , TO_CHAR(SYSDATE, 'HH') "COL12"           -- 05
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"        -- 05 ����
     , TO_CHAR(SYSDATE, 'HH24 AM') "COL133"     -- 17 ����
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"        -- 05 ����
     , TO_CHAR(SYSDATE, 'MI') "COL15"           -- 12
     , TO_CHAR(SYSDATE, 'SS') "COL16"           -- 00
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"        -- 62302 ���� �������� ���ݱ��� �귯�� �ʸ� ���� Ÿ������ ��ȯ
     , TO_CHAR(SYSDATE, 'Q') "COL18"            -- 3 �б�
FROM DUAL;


--�� ��¥�� ��ȭ ������ ���� ���� ���..
-- ���� ���� ���� ������ ���� �� ���ִ�.

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\';           -- �� 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT 7 "COL1"
        , '7' "COL2"
        , TO_CHAR(7) "COL3"
FROM DUAL;
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~!!!
--> ���ڴ� �����ʿ� �پ��ִ�
--> ���ڴ� ���ʿ� �پ��ִ�.

SELECT TO_NUMBER('4') "COL1"
    , '4' "COL2"
    , 4 "COL3"
    , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~!!!


--�� ���� ��¥���� ���� �⵵(2022)�� ���� ���·� ��ȸ(��ȯ)
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) "RESULT"
FROM DUAL;
--==>>      2022
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~!!!

--�� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"   -- 2022(������)  �� ������ �����Ͽ� ���� Ÿ������
    , TO_CHAR(SYSDATE, 'MM') "COL2"      -- 08(������)    �� ���� �����Ͽ� ����Ÿ������
    , TO_CHAR(SYSDATE, 'DD') "COL3"      -- 17(������)    �� ���� �����Ͽ� ����Ÿ������
    , EXTRACT(YEAR FROM SYSDATE) "COL4"  -- 2022(������)  �濬���� �����Ͽ� ����Ÿ������
    , EXTRACT(MONTH FROM SYSDATE) "COL5" -- 8(������)     �� ���� �����Ͽ� ����Ÿ������
    , EXTRACT(DAY FROM SYSDATE) "COL6"   -- 17(������)    �� ���� �����Ͽ� ����Ÿ������
FROM DUAL;
--> �� �� �� ���� �ٸ� �׸��� �Ұ�~!!!


--�� TO_CHAR() Ȱ�� ���� ���� ǥ�� ����� ��ȯ

SELECT 60000 "COL1"
    , TO_CHAR(60000,'99,999') "COL2"  --60000	 60,000
    , TO_CHAR(60000, '$99,999') "COL3" 
    , TO_CHAR(60000, 'L99,999') "COL4"
    , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5"
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� ���� �ð��� �������� 1�� 2�ð� 3�� 4���ĸ� ��ȸ�Ѵ�.

SELECT SYSDATE "����ð�"
     , SYSDATE + 1 + (2/24) + (3/(24*60))  + (4/(24*60*60))"1�� 2�ð� 3�� 4����"
FROM DUAL;
--==>> 2022-08-17 17:44:00	
--     2022-08-18 19:47:04



--�� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ�Ѵ�.
--�� TO_YMINTERVAL(), TO_DSINTERVAL()

SELECT SYSDATE "����ð�"
    , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "������"
FROM DUAL;
--==>> 2022-08-17 17:48:08	
--     2023-10-20 21:53:14

---------------------------------------------------------------------------------







