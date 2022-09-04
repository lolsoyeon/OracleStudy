
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

 -- �⺻Ʋ
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

-- 1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
-- �� UPDATE : ������ �ԷµǾ� �ִ� ���� ���� �� �� ULDATE�� �� ����Ѵ�.
-- TBL_�԰� ���̺��� UPDATE �� �Ͼ�� TBL_��ǰ ���̺����� UPDATE ��.��.��(Ʈ������) ����

-- EXEC PRC_�԰�_ULDATE(1, 10);

CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( V_�԰��ȣ   IN TBL_�԰�.�԰��ȣ%TYPE
, V_�԰����   IN TBL_�԰�.�԰����%TYPE
)
IS
    --  �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�        TBL_�԰�.��ǰ�ڵ�%TYPE;
    V_�����԰����    TBL_�԰�.�԰����%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
    
    -- ���� ���� ����
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    -- ������ �ۼ� �� �߰��� ������ �� ���
    -- ��ǰ�ڵ�� �����԰���� �ľ�
    SELECT ��ǰ�ڵ�, �԰���� INTO V_��ǰ�ڵ�, V_�����԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    --  �߰��� ������ ����� (������)
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    
    --  ������ ������ ���� ���� ����
    --  ���� ������ �԰���� �� ������ ������ Ȯ��
    IF (V_������ - V_�����԰����+ V_�԰���� < 0) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    --  ������ ���� �� UPDATE(TBL_�԰�)
    UPDATE TBL_�԰�
    SET �԰���� = V_�԰����
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    
    --  ������ ���� �� UPDATE(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = (V_������ - V_�����԰����) + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    
    --  ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
            
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.







-- 2. PRC_�԰�_DELETE(�԰��ȣ)  
--  �� DELETE : �����͸� ������ ���� DELETE ������ ����Ѵ�.
-- TBL_�԰� ���� DELETE�� �Ͼ�� TBL_��ǰ ���̺��� UPDATE ��.��.��(Ʈ������) ����

-- EXEC PRC_�԰�_DELETE(1);

CREATE OR REPLACE PROCEDURE  PRC_�԰�_DELETE
( V_�԰��ȣ    IN TBL_�԰�.�԰��ȣ%TYPE
)
IS
    -- �� �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�  TBL_�԰�.��ǰ�ڵ�%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    V_�԰����  TBL_�԰�.�԰����%TYPE;
    
    
    -- ��� ���� ���� ����
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- �� ������ �ۼ� �� �߰��� ������ �� ���
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- �� ������ �ۼ� �� �߰��� ������ �� ���
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;

    SELECT �԰���� INTO V_�԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    
    
    -- �� TLB_��ǰ ���̺��� �������� �԰�������� ���� ��� ���ܹ߻�
    
    IF(V_������ < V_�԰����)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �� ������ ���� �� DELETE(TBL_�԰�)
    DELETE        
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;

    -- �� ������ ���� �� UPDATE(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ -  V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    
    -- �� ����ó�� (���� �߻� �� �ѹ�)
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!~!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    -- �� Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.




--  3. PRC_���_DELETE(����ȣ)  �԰�INSERT ó�� ���� 
-- ��, TBL_��� ���̺��� DELETE �� �Ͼ��  TBL_��ǰ������ UPDATE ��.��.��(Ʈ������) ����
-- EXEC PRC_���_DELETE(1);

CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(V_����ȣ IN TBL_���.����ȣ%TYPE
)
IS
    -- �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������  TBL_���.������%TYPE;
    
BEGIN
    -- ������ ���� ��  ������ ���� �� ��Ƴ���
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;

    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;


    --DELETE �� ��� ���̺�
    DELETE
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    
    --UPDATE �� ��ǰ���̺�
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó�� (���������� ó���������ϴ� �ٸ� ��Ȳ�̸� �ѹ��ض�)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
        
    -- �� Ȯ�εǸ� Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.


------------------------------------------------------------------------------














