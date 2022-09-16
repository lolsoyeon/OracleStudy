SELECT USER
FROM DUAL;
--==>> SCOTT

-- ���� TRIGER(Ʈ����) ���� --

-- �������� �ǹ� : ��Ƽ�, �˹߽�Ű��, �߱��ϴ�, �����ϴ�.
-- (�κ�Ʈ��, �������� �ǵ鿩�� �Ѵ�.)

-- 1. TRIGER(Ʈ����)�� DML�۾� ��, INSERT, UPDATE, DELETE �۾��� �Ͼ ��
--    �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿Ͱ��� Ư¡�� �����Ͽ� DML TRIGER ��� �θ��⵵�Ѵ�.
--    TRIGGER�� ���Ἲ �� �ƴ϶� ������ ���� �۾����� �θ� ���ȴ�.

-- �ڵ����� �Ļ��� �� �� ���� ( ������ ���� ���� ������ �̸� �����)
-- �߸��� Ʈ����� ����
-- ������ ���� ���� ���� ����
-- �л� �����ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ����
-- ������ ���� ��Ģ ���� ���� 
-- ������ �̺�Ʈ �α� ���� ( ���� ��ÿ� �����۾��� ���� �ߴٴ� ����)
-- ������ ���� ���� 
-- ���� ���̺� ���� ��������
-- ���̺� ������ ��� ���� ( ���� �����߰� ���...)

-->> ���� ����͸� ���� �ʴ��� ����Ŭ���������� ���� �� ���ְ��ϴ� �۾�.
-->> ���� ���� ���ν���  

-- 2. TRIGGER �������� COMMIT, ROLLBACK ���� ����� �� ����. ��

-- 3. Ư¡ �� ����
--     - BEFORE STATEMENT
--      : SQL ������ ����Ǳ� ���� �� ���忡 ���� �� �� ����
--     - BEFORE ROW 
--      : SQL ������ ����Ǳ� ���� (DML �۾��� �����ϱ� ����)
--          �� ��(ROW)�� ���� �� ���� ����
--     - AFTER STATMENT 
--      : SQL ������ ����� �Ŀ� �� ���忡 ���� �� �� ����
--     - AFTER ROW
--      : SQL ������ ����� �Ŀ�(DML �۾��� ������ �Ŀ�)
--         �� ��(ROW)�� ���� �� ���� ����

-- 4. ���� �� ����

/*
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺�� 
    [FOR EACH ROW [WHEN TREGGER ����]]
[DECLARE]
    -- ���� ����;
BEGIN
    -- ���� ����;
END;

*/
--���� AFTER STATMENT TRIGGER ��Ȳ �ǽ� ����--
--�� DML �۾��� ���� �̺�Ʈ ���

--�� TREGGER(Ʈ����) ����
-- Ʈ���� �� : TRG_EVENTLOG

CREATE OR REPLACE TRIGGER TRG_EVENTLOG
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    -- �̺�Ʈ ���� ����( ���ǹ��� ���� �б�)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT ������ ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE ������ ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE ������ ����Ǿ����ϴ�.');
    END IF;
    
    -- COMMIT;
    -- �� TREGGER �������� COMMIT / ROLLBACK ���� ��� �Ұ�~!!!
END;
--==>> Trigger TRG_EVENTLOG��(��) �����ϵǾ����ϴ�.

--���� BEFORE STATMENT TGIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾� ���� ���� �۾��� ���� ���� ���� Ȯ��
-- ���� 8�� ~ ���� 6�� ���� ���ǿ� �ȸ����ϱ� �������� �ʵ��� �ؾ��Ѵ�.

--�� TRIGGER (Ʈ���� ����)
-- Ʈ���Ÿ�: TRG_TEST1_DML
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF(�۾��ð��� ���� 8�� �����̰ų�..... ���� 6�� ���Ķ��)
        THEN �۾��� �������� ���ϵ��� ó���ϰڴ�.
END;




CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF(BETWEEN TO_DATE('YYYY-MM-DD 08:00:00') AND TO_DATE('YYYY-MM-DD 18:00:00'))
        THEN VALUES (�۾��� �������� ���ϵ��� ó���ϰڴ�.)
    END IF;
END;


CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF(TO_NUMBER(TO_CHAR(SYSDATE, HH24))< 8
        OR TO_NUMBER(TO_CHAR(SYSDATE, HH24))>= 18 )
        THEN RAISE_APPLICATION_ERROR(-20003, '���� 08:00 ~ ���� 18:00 �ð��� �۾������մϴ�.')
    END IF;
END;


--------------------------------------- ������ Ǯ��

CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8 
        OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )
        THEN ����� ���� ���ܸ� �߻���ų �� �ֵ��� ó���ϰڴ�.
    END IF;
END;





CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 11 
        OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )
        THEN RAISE_APPLICATION_ERROR(-20003, '�۾��� 11:00 ~ 18:00 ������ �����մϴ�.');
    END IF;
END;
--==>> Trigger TRG_TEST1_DML��(��) �����ϵǾ����ϴ�.



--���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ����--
-- �� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��


--�� TRIGGER(Ʈ����)����
-- Ʈ���� �� : TRG_TEST2_DELETE
-- �ڽ��� �׳� �������� �θ� ��������ϸ� �ð��� ���߰� ������ ���ư��� 
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE
        DELETE ON TBL_TEST2
        FOR EACH ROW 
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
END;
--==>> Trigger TRG_TEST2_DELETE��(��) �����ϵǾ����ϴ�.


-- �� ��:OLD��
-- ���� �� ���� ��
-- (INSERT :�Է��ϱ� ���� ������, DELETE : �����ϱ� ���� ������ ��, ������ ������)

--�� UPDATE : DELETE �׸��� INSERT �� ���յ� ����
--           UPDATE �ϱ� ������ �����ʹ� ��:OLD��
--           UPDATE �� ���� �����ʹ� ��:NEW��
-- ����� �����Է��ϴ� �����̴�.



--���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����--
--�� ���� ���̺� ���� Ʈ����� ó��

-- TBL_�԰�, TBL_���, TLB_��ǰ

--�� TBL_�԰� ���̺��� ������ �Է� �� (��, �԰� �̺�Ʈ �߻� ��)
-- TBL_��ǰ ���̺��� ������ ���� Ʈ���� ����
-- Ʈ���� �� : TRG_IBG0

CREATE OR REPLACE TRIGGER TGR_IBGO
        AFTER
        INSERT ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = �����԰���� + �����԰�Ǵ� ��ǰ�� �԰����
             WHERE ��ǰ�ڵ� = �����԰�Ǵ� ��ǰ�� ��ǰ�ڵ�;
    END IF;
END;



CREATE OR REPLACE TRIGGER TGR_IBGO
        AFTER
        INSERT ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;






CREATE OR REPLACE TRIGGER TGR_IBGO
        AFTER
        INSERT ON TBL_�԰�
        FOR EACH ROW
BEGIN
    UPDATE TBL_��ǰ
    SET ������ = ������ + :NEW.�԰����
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
END;
--==>> Trigger TGR_IBGO��(��) �����ϵǾ����ϴ�.



--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO

CREATE OR REPLACE TRIGGER TGR_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN DELETE
             FROM TBL_��ǰ
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
END;



CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT ON TBL_�԰�
        FOR EACH ROW
BEGIN
    IF(INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW �԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;




CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_�԰�
        FOR EACH ROW
BEGIN
     UPDATE TBL_��ǰ
     SET ������ = ������ + :NEW.�԰����
     WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
END;


--�� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_CHULGO

CREATE OR REPLACE TRIGGER TRG_CHULGO
         AFTER
         INSERT OR UPDATE OR DELETE ON TBL_���
         FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�; 
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ +:NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSE IF (DELETING)
        THEN DELETE
             FROM TBL_��ǰ
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
    
END;



-- ģ���� �Ѱ�


CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_���
        FOR EACH ROW
BEGIN
    IF(INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
            SET ������ = ������ + :OLD.������
            WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
            
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
            SET ������ = ������ + :OLD.������ - :NEW.������
            WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;


--------------------------------------------------------------------------------

--���� PACKAGE(��Ű��) ����--

-- 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--    ���� ���α׷�(PROCEDURE, FUNCTION ��)��
--    �������� ������� ������
--    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT���̴�.

-- 2. ��Ű���� ���� ������ ������ ����ϴ� ���� ���� ���ν����� �Լ���
--    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
--    ��ü ���α׷��� ���ȭ �� �� �ִ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)��
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������
--    �� �κп���  TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM �� ����ǰ�
--    ��ü�κп��� �̵��� ���� ������ �����ϰ� �ȴ�.
--    �׸���, ȣ�� �Ҷ����� ����Ű����. ���ν����� ������ ������ �̿��ؾ��Ѵ�.

-- 4. ���� �� ����(����)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
      :
      
END ��Ű����;
*/

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü �����ڵ�;
    END;
END ��Ű����;
*/

-- ��Ű�� ��� �ǽ�

-- �� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK;
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.




-- �� ��ü�� �ۼ� (BODY �� ���̳���)
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF(SUBSTR(V_SSN, 8 ,1) IN ('1','3'))
            THEN V_RESULT := '����';
        ELSIF(SUBSTR(V_SSN, 8 ,1) IN ('2','4'))
            THEN V_RESULT := '����';
        ELSE 
            V_RESULT := 'Ȯ�κҰ�';
    
        END IF;
        
        RETURN V_RESULT;
        
    END;
    
END INSA_PACK;

--==>> Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.

-- CREATE OR REPLACE FUNCTION �Լ���;

--=======================================================--����Ŭ �� ���� ������Ʈ ����



