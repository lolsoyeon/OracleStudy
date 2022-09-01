SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;

--TBL_INSA ���̺��� ���� ���� ������ �������� ������ ����
-- (�ݺ��� Ȱ��)


SELECT *
FROM TBL_INSA;

DESC TBL_INSA;

DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    --V_NAME
    --V_TEL
    --V_BUSEO
    V_NUM   TBL_INSA.NUM%TYPE := 1001;

BEGIN
    LOOP
        -- ��ȸ
        SELECT NAME, TEL, BUSEO
            INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;      -- 1001 �Ʊ�� WHERE �����µ� 1002, 1003, ����ϰ� ������Ű�� 
        
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' ||V_INSA.TEL || ' - ' || V_INSA.BUSEO);
        
        -- ������
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM > 1060;
    END LOOP;
END;


-----------------------------------------------------------------------------------------

--���� FUNCTION(�Լ�) ����--

-- 1 .�Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--   �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ�ϴµ� ���ȴ�.
--   ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--   ���� ������ �Լ��� ���� �� �ִ�.(�� ����� ���� �Լ�)
--   �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--   ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLCE] FUNCTION �Լ���
[( �Ű�������1 �ڷ���
 , �Ű�������2 �ڷ���
)]
RETURN ������ Ÿ��               --�Լ��� ��ȯ���� �ִ�.
IS
    -- �ֿ� ���� ����
BEGIN 
    --���๮;
    ...
    RETURN (��);
    
    [EXCEPTION]
        --���� ó�� ����;
END;
*/

-- �� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������ Ÿ����  RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�. 

--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ���: FN_GENDER( )
--                  �� SSN(�ֹε�Ϲ�ȣ) �� '771212-0122432'�� 'YYMMDD-NNNNNNN'

DESC TBL_INSA;


--CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2(14) )      -- �Ű����� : �ڸ���(����) ���� ����

CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
--RETURN VARCHAR2(24)                                           -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
RETURN VARCHAR2
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(24);
BEGIN  
    -- ����� �� ���� �� ó��
    
    -- �� ����� ��ȯ CHECK~!~!�� 
END;



CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
RETURN VARCHAR2
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(24);
BEGIN  
    -- ����� �� ���� �� ó��
    IF(�ֹε�Ϲ�ȣ 8��° 1���� '2' �Ǵ� '4')
        THEN ��������� '����'��Ƴ���;
    ELSIF (�ֹε�Ϲ�ȣ 8��° 1���� '1' �Ǵ� '3')
        THEN ��������� '����'��Ƴ���;
    ELSE
        ��������� '����Ȯ�κҰ�'��Ƴ���;
    END IF;
    
    -- �� ����� ��ȯ CHECK~!~!��
    RETURN V_RESULT;
END;



CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )--�ֹε�Ϲ�ȣ 8��° 1����
RETURN VARCHAR2
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(24);
BEGIN  
    -- ����� �� ���� �� ó��
    IF( SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '����';
    ELSIF (SUBSTR(V_SSN,8,1) IN ('1', '3'))
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- �� ����� ��ȯ CHECK~!~!��
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.



--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A,B)
-- A�� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
-- �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

ACCEPT A PROMPT '������ ���� �ϳ� �Է����ּ���';
ACCEPT B PROMPT '������ ���� �ϳ� �Է����ּ���';
CREATE OR REPLACE FUNCTION FN_POW
(  A NUMBER
 , B NUMBER)
RETURN NUMBER
IS 
    -- �����
     A1 := &A;
     B1 := &B;
BEGIN 
    --����� 
    
    
END;



ACCEPT A PROMPT '������ ���� �ϳ� �Է����ּ���';
ACCEPT B PROMPT '������ ���� �ϳ� �Է����ּ���';
CREATE OR REPLACE FUNCTION FN_POW
(  A NUMBER
 , B NUMBER)
RETURN NUMBER
IS 
    -- �����
     A1 := &A;
     B1 := &B;
     V_RESULT NUMBER := 0;
BEGIN 
    --����� ����� ó�� 
    
    -- 2�� 3�� => 2 * 2 * 2           A1 * A1 * A1
    -- 4�� 4�� => 4 * 4 * 4 *4        A1 * A1 * A1 *A1
    FOR A1 IN A1 .. B2 LOOP
        FOR A1 .. B2 LOOP
        END LOOP;
    END LOOP;
    
    -- ��� �� ��ȯ
    RESULT V_RESULT;  --A1�� B1�� �� �����
    
    
END;

----------------------------------- T ������ Ǯ��
/*
FN_POW(10, 3) �� 1000
    1 * 10 * 10 * 10 = 1000
    0 * 10 * 10 * 10 = 0

*/

CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
BEGIN
END;

CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_RESULT    NUMBER := 1;
    V_NUM       NUMBER;     --ī���� ��������
BEGIN
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    RETURN V_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.


SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000


SELECT FN_POW(2, 5)
FROM DUAL;
--==>> 32


--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
-- �޿��� ��(�⺻�� *12) + ���硻 ������� ������ �����Ѵ�.
-- �Լ��� : FN_PAY(�⺻��, ����)

CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER ,V_SUDANG NUMBER)
RETURN NUMBER
IS 
BEGIN
END;

CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER ,V_SUDANG NUMBER)
RETURN NUMBER
IS 
    -- ����
    
BEGIN
    -- ���� �� ó��
END;


















