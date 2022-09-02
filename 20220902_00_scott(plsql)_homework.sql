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


CREATE OR REPLACE PROCEDURE

IS
BEGIN
END;

SELECT *
FROM TBL_���;


SELECT *
FROM TBL_��ǰ;

SELECT *
FROM TBL_�԰�;
-- ���� 
/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����) -- ������ �ٲٴ°� ���ſ� �߻��ߴ�(INSERT) �԰� �ٲٴ°��̴�. 
    ��� ���̰� �԰� ���� ���� �԰� 100 ������� 100 ��� 100 ������� 0 ������� 20   ��� UPDATE ����
2. PRC_�԰�_DELETE(�԰��ȣ)  

3. PRC_���_DELETE(����ȣ)  �԰�INSERT ��������ŭ ���ش�     Ʈ������


���� �԰�(��INSERT) �� ��ǰ ���� �԰�ó��(��UPDATE)  �� ��� ���� ���� (��INSERT)
                                       (��UPDATE)
        (��UPDATE)                      (��UPDATE)
                                        (��UPDATE)                   (��DELETE)
*/



-- 2. PRC_�԰�_DELETE(�԰��ȣ)  
-- TBL_�԰� ���� DELETE�� �Ͼ�� ��ǰ ���̺��� UPDATE
CREATE OR REPLACE PROCEDURE  PRC_�԰�_DELETE
( V_�԰��ȣ    IN TBL_�԰�.�԰��ȣ%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
)
IS
    -- �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�  TBL_�԰�.��ǰ�ڵ�%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- ������ �ۼ� �� �߰��� ������ �� ���
    SELECT ������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;


    
    -- ������ ���� �� DELETE(TBL_�԰�)
    DELETE        
    FROM TBL_�԰�
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�

    -- ������ ���� �� UPDATE(TBL_��ǰ)

    UPDATE TBL_��ǰ
    SET 
    WHERE ������ = V_������
    
    
    -- ����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR();
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    -- Ŀ��
    COMMIT;
END;









--  3. PRC_���_DELETE(����ȣ)  �԰�INSERT ó�� ���� 
-- ��, TBL_��� ���� DELETE �Ǹ� TBL_��ǰ������ UPDATE ��.��.��(Ʈ������) ����

CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(V_����ȣ IN TBL_���.����ȣ%TYPE
)
IS
    -- �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    V_������  TBL_���.������%TYPE;
BEGIN
    -- ������ ���� ��  ������ ���� �� ��Ƴ���
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;


    --DELETE �� ��� ���̺�
    DELETE
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    
    --UPDATE �� ��ǰ���̺�
    UPDATE TBL_��ǰ
    SET ������ = V_������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó�� (���������� ó���������ϴ� �ٸ� ��Ȳ�̸� �ѹ��ض�)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
        
    -- �� Ȯ�εǸ� Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.


------------------------------------------------------------------------------














