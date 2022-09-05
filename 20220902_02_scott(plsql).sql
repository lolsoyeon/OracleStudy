SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_�԰� ���̺� ���԰� �̺�Ʈ �߻���...
-- ���� ���̺� ����Ǿ�� �ϴ� ����

--�� INSERT �� TBL_�԰�

--�� UPDATE �� TBL_��ǰ

--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--      TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--      TBL_�԰� ���̺��� ������ �Է� �� �ƴ϶�
--      TBL_��ǰ ���̺� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�.
--      ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�.(������ ��� X)
--      TBL_�԰� ���̺� ���� �÷� - ����
--      : �԰��ȣ, -��ǰ�ڵ�, �԰�����, -�԰����, -�԰�ܰ�
--      ���ν����� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

--------- ���� �� ��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ� IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰���� IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ� IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS 
    --V_FLAG NUMBER := 1;
    V_�԰��ȣ   TBL_�԰�.�԰��ȣ%TYPE; 
    V_�԰�����   TBL_�԰�.�԰�����%TYPE; 
    V_��ǰ��     TBL_��ǰ.��ǰ��%TYPE;
    V_�Һ��ڰ��� TBL_��ǰ.�Һ��ڰ���%TYPE;
    V_������   TBL_��ǰ.������%TYPE;
    
BEGIN

    SELECT MAX(NVL(�԰��ȣ,0)) + 1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    --UPDATE �� �԰����̺�
    UPDATE TBL_�԰�
    SET �԰��ȣ= V_�԰��ȣ, ��ǰ�ڵ� = V_��ǰ�ڵ�, �԰����� = V_�԰�����, �԰���� = V_�԰����, �԰�ܰ� = V_�԰�ܰ�
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ� AND �԰���� = V_�԰���� AND �԰�ܰ� = V_�԰�ܰ�;

    --INSERT �� ��ǰ���̺� (UPDATE�� ������ ������� EHY?? ���ÿ� �Ͼ�� ������
    INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���, ������)
    VALUES(V_��ǰ�ڵ�, V_��ǰ��, V_�Һ��ڰ���, V_������);
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


---------------------------------------------������ Ǯ��
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ� IN TBL_�԰�.��ǰ�ڵ�%TYPE            -- TBL_��ǰ.��ǰ�ڵ�&TYPE
, V_�԰���� IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ� IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    --�Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    --�Ʒ��� �������� �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    
    SELECT NVL(MAX(�԰��ȣ), 0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    --INSERT �� �԰����̺�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES((V_�԰��ȣ+1) ,V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);

    --UPDATE �� ��ǰ���̺�
    UPDATE TBL_��ǰ
    --SET ������ = V_�԰���� (���������)
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó�� (���������� ó���������ϴ� �ٸ� ��Ȳ�̸� �ѹ��ض�)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

--���� ���ν��� �������� ���� ó�� ����--
--�� TBL_MEMBER ���̺� ������ �Է��ϴ� ���ν����� �ۼ�
-- ��, �� ���ν����� ���� �����͸� �Է� �� ���
-- CITY(����) �׸� '����','���','����' �� �Է� �����ϵ���  �����Ѵ�.
-- �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
-- (��, �Է��� �õ��ϴ°��)
-- ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.
-- ���ν����� : PRC_MEMBER_INSERT()
/*
���� ��)
EXEC PRC_MEMBER_INSERT('�ӽÿ�','010-1111-1111','����');
--==>> ������ �Է� ��
 
EXEC PRC_MEMBER_INSERT('�躸��','010-2222-2222','�λ�');
--==>> ������ �Է� X

*/

----------------------- IF�� ������ �κ�
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    TBL_MEMBER.NAME%TYPE
, V_TEL     TBL_MEMBER.TEL%TYPE
, V_CITY    TBL_MEMBER.CITY%TYPE  -- �μ�Ʈ���� ���ǰ˻簡 ����Ǿ��Ѵ�
)
IS
    -- ���� ������ ������ ������ ���� �ʿ��� ���� �߰� ����
    V_NUM TBL_MEMBER.NUM%TYPE;
BEGIN

    -- ���ν����� ���� �Է�ó���� ���������� �����ؾ��� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF(������ ���� ��� ��õ�� �ƴ϶��)
        THEN ���ܸ� �߻���Ű�ڴ�.
    END IF;
    

    -- ������ �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;

    -- ������ ���� �� INSERT 
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES ((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
    
    --���� ó������ (TRY CHACH ó�� )
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;       
    
END;



-------------------------------------- ���� ó�� ������ ����
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    TBL_MEMBER.NAME%TYPE
, V_TEL     TBL_MEMBER.TEL%TYPE
, V_CITY    TBL_MEMBER.CITY%TYPE  -- �μ�Ʈ���� ���ǰ˻簡 ����Ǿ��Ѵ�
)
IS
    -- ���� ������ ������ ������ ���� �ʿ��� ���� �߰� ����
    V_NUM TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����~!~! CHECK ���ܵ� ������
    USER_DEFINE_ERROR EXCEPTION;
    -- ������ ������Ÿ��;
BEGIN

    -- ���ν����� ���� �Է�ó���� ���������� �����ؾ��� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF(V_CITY NOT IN('����','���','����'))                 -- ������� �ʴٸ�
        -- THEN ���ܸ� �߻���Ű�ڴ�. RAISE  ����
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT ������ �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;

    --������ ���� �� INSERT 
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES ((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
        --���� ó������ (TRY ~ CHACH ó�� )
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'����, ���, ������ �Է��� �����մϴ�.');    -- ���� ���� �Լ�
        WHEN OTHERS 
            THEN ROLLBACK;   
            
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


------------------------------------------------------------------------------------

-- 
--��TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻���)
-- TBL_��ǰ ���̺��� ��� ������ �����Ǵ� ���ν����� �ۼ��Ѵ�.
-- ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ���� ó���Ѵ�.
-- ��� �׼� ó�� ��ü�� ��� �� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���...)
-- ���ν����� : PRC_���_INSERT()
/*
���� ��)
EXEC PRC_���_INSERT('H001', 50, 1000); ��ǰ�ڵ� ���� ����
*/
---------------- ���� �� �� ù ��°
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�      IN TBL_���.��ǰ�ڵ�%TYPE
, V_������      IN TBL_���.������%TYPE
, V_���ܰ�      IN TBL_���.���ܰ�%TYPE
)
IS
    V_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
     V_��ǰ���� TBL_��ǰ.��ǰ����%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����~!~!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --���ν����� ���� �Է�ó���� ���������� �����ؾ� �� ������ ����
        -- �ƴ��� ���θ� ������� Ȯ�� �� �� �ֵ��� �ڵ� ����
        IF(V_������ < V_������)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        --������ ������ ����ȣ�� ���� �� ���
        SELECT NVL(MAX(����ȣ), 0) INTO V_����ȣ
        FROM TBL_���;
        
        --UPDATE ������ ��ǰ���̺�
        UPDATE TBL_��ǰ
        SET ������  = ������ -V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        --WHERE ������ = V_������;
        
        
        --INSERT  ������ ������̺�
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES (V_����ȣ +1 , V_��ǰ�ڵ�, V_������, V_���ܰ�);
        
        
        -- ���� ó�� 
        EXCEPTION 
            WHEN USER_DEFINE_ERROR 
                THEN RAISE_APPLICATION_ERROR(-20101, '���������� �������� �� �����ϴ�.');
            WHEN OTHERS
                THEN ROLLBACK;
END;
---------------- ���� �� �� ������
/*
���� ���� �� �� �ڵ�~!~! �� �����ϱ� 
SELECT ������ INTO V_������
FROM TBL_��ǰ
WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

AND

�ʿ����(�Ⱦ��̴�) ���� ����
    -- V_��ǰ���� TBL_��ǰ.��ǰ����%TYPE;
    
--UPDATE ������ ��ǰ���̺�
    UPDATE TBL_��ǰ
    SET ������  = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    --WHERE ������ = V_������;  �������� ������ ���� �ʾҴ�.......
*/


---------------- ���� �� ��  �籸�� 
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�      IN TBL_���.��ǰ�ڵ�%TYPE
, V_������      IN TBL_���.������%TYPE
, V_���ܰ�      IN TBL_���.���ܰ�%TYPE
)
IS
    V_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    -- V_��ǰ���� TBL_��ǰ.��ǰ����%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����~!~!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --������ ���������� ���� ���θ� Ȯ���ϴ� ��������
        -- ����ľ� , ������ ��� Ȯ���ϴ� ������ ����Ǿ���Ѵ�.
        -- �׷���...��� ������ �񱳰� �����ϱ� ������
        SELECT ������ INTO V_������
        FROM TBL_��ǰ
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;


        --���ν����� ���� �Է�ó���� ���������� �����ؾ� �� ������ ����
        -- �ƴ��� ���θ� ������� Ȯ�� �� �� �ֵ��� �ڵ� ����
        IF(V_������ < V_������)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        --������ ������ ����ȣ�� ���� �� ���
        SELECT NVL(MAX(����ȣ), 0) INTO V_����ȣ
        FROM TBL_���;
        
        --UPDATE ������ ��ǰ���̺�
        UPDATE TBL_��ǰ
        SET ������  = ������ -V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        --WHERE ������ = V_������;
        
        
        --INSERT  ������ ������̺�
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES (V_����ȣ +1 , V_��ǰ�ڵ�, V_������, V_���ܰ�);
        
        
        -- ���� ó�� 
        EXCEPTION 
            WHEN USER_DEFINE_ERROR 
                THEN RAISE_APPLICATION_ERROR(-20101, '���������� �������� �� �����ϴ�.');
            WHEN OTHERS
                THEN ROLLBACK;
                
        -- Ŀ��
        COMMIT;
END;






---------------------- ������ T Ǯ�� ���� �� �Ͱ� ���غ���~~!~!~!~!~!~!~!

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ� IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V_������ IN TBL_���.������%TYPE
, V_���ܰ� IN TBL_���.���ܰ�%TYPE
)
IS
    -- ������ ������ ���� �߰� ���� ����
    v_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    
    -- ����� ���� ���� ����
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- ������ ���������� ���� ���θ� Ȯ���ϴ� ��������
    -- ����ľ� ������ ��� Ȯ���ϴ� ������ ����Ǿ���Ѵ�.
    -- �׷���,,, ��� ������ �񱳰� �����ϱ� ������
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
    -- �ľ��� ���������� ��� ������ ������ ���� �߻�
    
    IF(V_������ >V_������)
        --���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ),0) INTO V_����ȣ
    FROM TBL_���;
    -- ������ ���� �� INSERT(TBL_���)
    
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES ((V_����ȣ +1) , V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ������ ���� �� UPDATE(TBL_��ǰ)
        UPDATE TBL_��ǰ
        SET ������  = ������ - V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002, '������!~!!');
                    ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
        
        -- Ŀ��
        COMMIT;
     
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--  ���ν��� ��: PRC_���_UPDATE()

/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, ������ ����);

*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ IN TBL_���.����ȣ%TYPE
, V_������ IN TBL_���.������%TYPE
)
IS
    V_��ǰ�ڵ� TBL_���.��ǰ�ڵ�%TYPE;
    V_���ܰ� TBL_���.���ܰ�%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    
    -- ��������� ���� ����
    USER_DEFINE_ERROR  EXCEPTION;
BEGIN
    -- ������ ���������� ����ߺθ� Ȯ���ϴ� ��������
    -- ��� ���� �������� �� ū�� ���ϴ� ������ �ʿ��ϴ�.
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� ��������� ������ Ȯ��
    -- �ľ��� ���������� �������� ������ ���� �߻�
    IF(V_������ > V_������)
        -- ���ܹ߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- ������ ������ �� ��Ƴ��� ??
 

    -- ������ ���� �� UPDATE (TLB_���)
    UPDATE TBL_���
    SET ������ = V_������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ������ ���� �� INSERT (TBL_��ǰ)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES (V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '��� �������� ��� ����~!');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.


-----------------------------------T ������ Ǯ�� ���� 
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
(
    -- ��Ű����� ����
  V_����ȣ IN TBL_���.����ȣ%TYPE
, V_������ IN TBL_���.������%TYPE
)
IS
    -- �� �ʿ��� ���� �߰� ����
    -- ��� ���� ���࿩�� �Ǵ� �ʿ�
    --   ���� ������ ������ �� ������ ������ Ȯ�� �ؾ��Ѵ�.
    V_��ǰ�ڵ�     TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_���������� TBL_���.������%TYPE;
    V_������     TBL_��ǰ.������%TYPE;
    
BEGIN
    -- �� ������ ������ �� ��Ƴ���
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    -- 
    SELECT ������ INTO V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;



    -- �� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ)
    UPDATE TBL_���
    SET TBL_��� = V_������;
    WHERE ����ȣ = V_����ȣ;

END;





CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
(
    -- �� �Ű����� ����
  V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_������    IN TBL_���.������%TYPE
)
IS
    -- �� �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�      TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������  TBL_���.������%TYPE;
    V_������     TBL_��ǰ.������%TYPE;
    
    -- �� ���ܹ߻�
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    --  ������ ������ �� ��Ƴ���
    -- �� ��ǰ�ڵ�� ���� ������ �ľ�
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- �� ������ �� ��ǰ�ڵ带 Ȱ���Ͽ� ��� ���� �ľ�
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

 
    --�� ��� ���� ���࿩�� �Ǵ� �ʿ�
    --   ���� ������ ������ �� ������ ������ Ȯ�� �ؾ��Ѵ�.
    --IF(�ľ��� �������� ������ �������� ��ģ���� ������ ���������� ������ )
    --    ���ܸ� �߻���Ű���� �Ѵ�.
    --END IF;
    
    IF((V_������ + V_����������) < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;


    -- �� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ)
    UPDATE TBL_���
    SET TBL_��� = V_������
    WHERE ����ȣ = V_����ȣ;
    
    -- �� 30 + 20 - 50
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'������~!~!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --�� Ŀ��
    COMMIT;
END;




CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_������    IN TBL_���.������%TYPE
)
IS
    V_��ǰ�ڵ�      TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������  TBL_���.������%TYPE;
    V_������     TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;

    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    IF((V_������ + V_����������) < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE TBL_���
    -- �����~ �Ф�SET TBL_��� = V_������
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'������~!~!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
 
    COMMIT;
END;



--------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_������    IN TBL_���.������%TYPE
)
IS
    V_��ǰ�ڵ�      TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������  TBL_���.������%TYPE;
    V_������      TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    IF ((V_������ + V_����������) < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE TBL_���
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
            
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;
------------------------------------------------------------------------------------------

-- ���� 
/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����) -- ������ �ٲٴ°� ���ſ� �߻��ߴ�(INSERT) �԰� �ٲٴ°��̴�. 
    ��� ���̰� �԰� ���� ���� �԰� 100 ������� 100 ��� 100 ������� 0 ������� 20   ��� UPDATE ����
2. PRC_�԰�_DELETE(�԰��ȣ)  

3. PRC_���_DELETE(����ȣ)  �԰�INSERT ��������ŭ ���ش�     Ʈ������

*/

------------------------------------------------------------------------------------------

--���� CURSOR (Ŀ��) ����-- ��¦����

-- 1. ����Ŭ������ �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������(���� ���ڵ�)
--    �۾� ��������  SQL ���� �����ϰ� �� �������� �߻��� �����͸�
--    �����ϱ� ���� Ŀ��(CURSOR)�� ����ϸ�,
--    Ŀ������ �Ͻ����� Ŀ���� ������� Ŀ���� �ִ�.
                            -- ���� ���ڵ� ��


-- 2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�
--    SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ������(ROW)���� ������ ���
--    Ŀ��(CORSOR)�� ��������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�.

SET SERVEROUTPUT ON;

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���ٽ�)
DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
END;
--==>> ȫ�浿 - 011-2356-4528

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
END;
--==>> ���� �߻� ������ 
-- (ORA-01422: exact fetch returns more than requested number of rows)


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���ٽ�)

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
    V_NUM  TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
            DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
            V_NUM := V_NUM + 1;
            EXIT WHEN V_NUM>= 1062;

    END LOOP;
    
END;
--==>> 
/*
ȫ�浿 - 011-2356-4528
�̼��� - 010-4758-6532
�̼��� - 010-4231-1236
������ - 019-5236-4221
�Ѽ��� - 018-5211-3542
�̱��� - 010-3214-5357
����ö - 011-2345-2525
�迵�� - 016-2222-4444
������ - 019-1111-2222
������ - 011-3214-5555
������ - 010-8888-4422
���ѱ� - 018-2222-4242
���̼� - 019-6666-4444
Ȳ���� - 010-3214-5467
������ - 016-2548-3365
�̻��� - 010-4526-1234
����� - 010-3254-2542
�̼��� - 018-1333-3333
�ڹ��� - 017-4747-4848
������ - 011-9595-8585
ȫ�泲 - 011-9999-7575
�̿��� - 017-5214-5282
���μ� - 
�踻�� - 011-5248-7789
����� - 010-4563-2587
����� - 010-2112-5225
�迵�� - 019-8523-1478
�̳��� - 016-1818-4848
�踻�� - 016-3535-3636
������ - 019-6564-6752
����ȯ - 019-5552-7511
�ɽ��� - 016-8888-7474
��̳� - 011-2444-4444
������ - 011-3697-7412
������ - 
���翵 - 011-9999-9999
�ּ��� - 011-7777-7777
���μ� - 010-6542-7412
����� - 010-2587-7895
�ڼ��� - 016-4444-7777
����� - 016-4444-5555
ä���� - 011-5125-5511
��̿� - 016-8548-6547
����ȯ - 011-5555-7548
ȫ���� - 011-7777-7777
���� - 017-3333-3333
�긶�� - 018-0505-0505
�̱�� - 
�̹̼� - 010-6654-8854
�̹��� - 011-8585-5252
�ǿ��� - 011-5555-7548
�ǿ��� - 010-3644-5577
��̽� - 011-7585-7474
����ȣ - 016-1919-4242
���ѳ� - 016-2424-4242
������ - 010-7549-8654
�̹̰� - 016-6542-7546
����� - 010-2415-5444
�Ӽ��� - 011-4151-4154
��ž� - 011-4151-4444
������ - 010-7202-6306
*/

/*
����Ŭ���� �߿��� ���ϡ�(����)
������ ������Ÿ��
V_REAULT NUMBER;
USER_DEFINE_ERROR EXCEPTION;
*/


/* ����Ŭ���� �߿��� ���ϡ�
���̺� ����(����)
����� ����(����)
�Լ� ����
���ν��� ����
CREATE TABLE ���̺��
        INDEX �ε�����
        FUNCTION �Լ���
        PROCEDURE ���ν�����
        CURSOR Ŀ���� 

*/


--�� Ŀ�� �̿� �� ��Ȳ
DECLARE
    -- �����
    -- �ֿ� ���� ����
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;

    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����) ��¦ ����
     CURSOR CUR_INSA_SELECT
     IS
     SELECT NAME, TEL
     FROM TBL_INSA;
     
BEGIN
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    --Ŀ�� ���½� ����� ������ �����͵� ó��
    LOOP
        -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
         FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
         -- Ŀ������ ����������°� INTO�� �޴´�.
         
        
        -- Ŀ������ ���̻� �����Ͱ� ����� ������ �ʴ� ����
        -- ��, Ŀ�� ���ο��� �� �̻��� �����͸� ã���� ���»���
        -- �� �׸�~! �ݺ��� ����������
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
        
    END LOOP;
            
    -- Ŀ�� Ŭ����   �ڹٶ� ����ÿ� Ŭ���� ���� ��Ʈ��ó�� ������ 
    CLOSE CUR_INSA_SELECT;
    
END;
--==>> ���� ��� 







------------------------------------------------------------------------------------------





















