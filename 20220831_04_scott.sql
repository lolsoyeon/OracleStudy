SELECT USER
FROM DUAL;
--==>> SCOTT
SELECT *
FROM TBL_INSA;

--�� TBL_INSA ���̺��� ������� 
-- �ֹι�ȣ(SSN)�� ������ ������ ��ȸ�Ѵ�.

SELECT NAME,  SSN
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '2', '����', '3', '����', '4', '����Ȯ�κҰ�')"����"
FROM TBL_INSA;

SELECT NAME, SSN
     , FN_GENDER(SSN) "����"
FROM TBL_INSA;
























