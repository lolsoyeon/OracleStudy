SELECT USER
FROM DUAL;
--==>> SCOTT



SELECT CASE T.���� WHEN 1 THEN '����' 
		   WHEN 2 THEN '����' 
		ELSE '�����' 
		END"����"
		SUM(T.�޿�) "�޿���"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '3') THEN 1
	   	 WHEN SUBSTR(JUBUN, 7,1) IN ('2' ,'4') THEN 2
	  	 ELSE 0
	   	END"����"
	  	, SAL(�޿�)
	FROM TBL_SAWON 
)T
GROUP BY ROULLUP(T.����);





SELECT NVL(T.���� , '�����')"����"
	, SUM(T.�޿�)"�޿���"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1','3')THEN '��'
	   	    WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4')THEN '��'  
		ELSE '�����ĺ��Ұ�' 
		END "����"
		, SAL"�޿�"
	FROM TBL_SAWON
) T
GROUP BY ROULLUP(T.����);



-- TBL_SAWOM ���̺��� �������
-- ������ ���� ��ȸ �� �� �ֵ��� �������� �����Ѵ�.
/*
---------------  ------------------
    ����              �޿���
---------------  ------------------
    ��                  XXXX
    ��                  XXXX
    �����          XXXXXX
---------------  ------------------
*/









--�� TBL_SAWON ���̺��� �������
-- ������ ���� ��ȸ �� �� �ֵ��� �������� �����Ѵ�.
/*
1. ���糪�̸� �������ִ� ��������
2. ���糪�̷� ���ɴ븦 ������.
3. COUNT�� 10�� COUNT 
   20,30 �� ROULLUP�� COUNT�� ����.
----------  --------------
���ɴ�         �ο���
----------  --------------
    10          X
    20          X
    30          X
    50          X
    ��ü        16
----------  --------------
*/

SELECT CASE GROUPUNG(T.���糪��) WHEM  0 THEN TO_CHAR(T.���糪��)
	 ELSE NVL(TO_CHAR(T.���糪��),'��ü')  END"���ɴ�"
	COUNT(*)"�ο���"
FROM
(
	SELECT CASE WHEN SUBSTR(JUBUN, 7,1) IN ('1', '2') 
			THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1899)),-1)
	    	    WHEN SUBSTR(JUBUN, 7,1) IN ('3', '4') 
			THEN TRUNC(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2) + 1999)), -1)
			ELSE -1 END"���糪��"
	FROM TBL_SAWON 
) T
GROUP BY ROLLUP(T.���糪��);




SELECT CASE WHEN T.���糪�� 50 >= THEN 50
            WHEN T.���糪�� 30 >= THEN 30
            WHEN T.���糪�� 20 >= THEN 20
            WHEN T.���糪�� 10 >= THEN 10
                       ELSE 0 
                       END "���ɴ�"
            , COUNT(*) "�ο���"
            
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "���糪��"  
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T. ���糪��);





SELECT CASE WHEN T1. ���糪�� >=50 THEN 50
            WHEN T1. ���糪�� >=40 THEN 40
            WHEN T1. ���糪�� >=30 THEN 30
            WHEN T1. ���糪�� >=20 THEN 20
            WHEN T1. ���糪�� >=10 THEN 10
            ELSE 0  END"���ɴ�"
FROM
(
    -- ����
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1', '2') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899) 
                   WHEN SUBSTR(JUBUN,7,1) IN ('3', '4') 
                   THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999) 
                    ELSE -1
              END "���糪��"  
    FROM TBL_SAWON
) T1;




GROUPING SETS




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
, TO_CHAR(SYSDATE, 'MM-DD') "COL8"         -- 08-17



SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY=MM'));


















