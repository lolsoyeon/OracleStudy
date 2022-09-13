-- ������ �Է� ���ν��� 

/*
-- �����ڵ�, ���, �ʱ�, �Ǳ�
-- EXEC PRC_GRADE_UPDATE (�����ڵ�, ���, �ʱ�, �Ǳ�)
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
( V_GRADE_CODE      IN GRADE.GRADE_CODE%TYPE
, V_GRADE_ATT       IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT        IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT        IN GRADE.GRADE_PT%TYPE
)
IS
    -- ���������ڵ� , ����������, �򰡳�¥
    V_OS_CODE                  OPENED_SUBJECT.OS_CODE%TYPE;
    V_OS_END                   OPENED_SUBJECT.OS_END%TYPE;
    V_GRADE_DATE               GRADE.GRADE_DATE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    SELECT OS_CODE, GRADE_DATE  INTO V_OS_CODE, V_GRADE_DATE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    
    SELECT OS_END INTO V_OS_END
    FROM GRADE GR JOIN OPENED_SUBJECT SU
    ON GR.OS_CODE = SU.OS_CODE
    WHERE GR.GRADE_CODE = V_GRADE_CODE;
    
    -- ������ 20221003 > ���� 20220913
    IF(V_OS_END < SYSDATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE GRADE
    SET GRADE_ATT =V_GRADE_ATT , GRADE_WT =V_GRADE_WT , GRADE_PT = V_GRADE_PT
    WHERE GRADE_CODE = V_GRADE_CODE; 
    
    COMMIT;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-206001,'�����Է��� ������ ����� �Ŀ� �����մϴ�.');
             ROLLBACK;
    WHEN OTHERS THEN ROLLBACK;
    
END;
--==>> Procedure PRC_GRADE_UPDATE��(��) �����ϵǾ����ϴ�.
*/

-- ���� ���� PRC_SCORE_UPDATE(����ID, ���, �ʱ�, �Ǳ�) --
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
( V_GRADE_CODE      IN GRADE.GRADE_CODE%TYPE
, V_GRADE_ATT       IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT        IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT        IN GRADE.GRADE_PT%TYPE
)
IS
BEGIN
    -- ���, �ʱ�, �Ǳ� ������Ʈ
    UPDATE GRADE
    SET GRADE_ATT = V_GRADE_ATT, GRADE_WT = V_GRADE_WT, GRADE_PT = V_GRADE_PT
    WHERE GRADE_CODE = V_GRADE_CODE;
END;
--==>> Procedure PRC_GRADE_UPDATE��(��) �����ϵǾ����ϴ�.


--  ���� �ڵ� ������ ����
CREATE SEQUENCE SEQ_GRADE_CODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;
--==>> Sequence SEQ_GRADE_CODE��(��) �����Ǿ����ϴ�.




-- ���� �Է� PRC_GRADE_INSERT(���������ڵ�,������û�ڵ�,���,�ʱ�,�Ǳ�) -- 
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
( V_OS_CODE             IN GRADE.OS_CODE%TYPE      
, V_APP_CODE            IN GRADE.APP_CODE%TYPE            
, V_GRADE_ATT           IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT            IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT            IN GRADE.GRADE_PT%TYPE
)
IS

    V_OS_END            OPENED_SUBJECT.OS_END%TYPE;          -- �������� ������    
    V_GRADE_DATE        GRADE.GRADE_DATE%TYPE;               -- �򰡳�¥   
    V_GRADE_CODE          GRADE.GRADE_CODE%TYPE;             -- ���� �ڵ�
    V_FAPP_ID           GRADE.APP_CODE%TYPE;                -- ������û�ڵ� �ߺ��˻�   
    V_FOP_SUB           GRADE.OS_CODE%TYPE;                 -- ���������ڵ� �ߺ��˻�
    V_MID_DROP          NUMBER;                            -- �ߵ����� 


    MID_DROP_STU_ERROR EXCEPTION;                   -- �ߵ����⿡��  
    APP_OVERLAP_ERROR EXCEPTION;                    -- ������û�ڵ�� �ߺ��� ���� 
    GRADE_DATE_ERROR   EXCEPTION;                  -- �������� �����߿� �����Է�X ����

    CURSOR CUR_CHECK_APP
    IS 
    SELECT APP_CODE, OS_CODE
    FROM GRADE
    WHERE APP_CODE = V_APP_CODE; 
    
BEGIN
    
    OPEN CUR_CHECK_APP;
        LOOP
        FETCH CUR_CHECK_APP INTO V_FAPP_ID, V_FOP_SUB;
        EXIT WHEN CUR_CHECK_APP%NOTFOUND;
        
        IF (V_OS_CODE = V_FOP_SUB AND  V_APP_CODE = V_FAPP_ID)
        THEN RAISE APP_OVERLAP_ERROR;
        END IF;
        END LOOP;
    CLOSE CUR_CHECK_APP;
    
    SELECT COUNT(*) INTO V_MID_DROP
    FROM QUITLIST
    WHERE APP_CODE = V_APP_CODE;
    
    IF (V_MID_DROP> 0)
        THEN RAISE MID_DROP_STU_ERROR;
    END IF;
    
    -- ���� ���� �߰��� ���� �Է� �Ұ� 
    -- ������ ��¥���� �̸��� �Է� �Ұ�
    SELECT OS_END INTO V_OS_END
    FROM OPENED_SUBJECT
    WHERE OS_CODE =  V_OS_CODE;

    IF (V_OS_END > SYSDATE)
        THEN RAISE GRADE_DATE_ERROR;
    END IF;
    --GRADE_CODE + ������ ��ȣ ǥ�� 
    V_GRADE_CODE := 'G'||TO_CHAR(SYSDATE,'YY');
    
    -- �������̺� INSERT
    INSERT INTO GRADE(GRADE_CODE, OS_CODE, GRADE_ATT, GRADE_WT, GRADE_PT, APP_CODE)
    VALUES(V_GRADE_CODE||LPAD(TO_CHAR(SEQ_GRADE_CODE.NEXTVAL),5,'0'), V_OS_CODE, V_APP_CODE, 
          V_GRADE_ATT, V_GRADE_WT, V_GRADE_PT);

    -- Ŀ��
    COMMIT;
    
    -- ����ó��
    EXCEPTION
        WHEN MID_DROP_STU_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20601, '�ߵ������� �����Դϴ�.');
                ROLLBACK;
        WHEN APP_OVERLAP_ERROR
            THEN RAISE_APPLICATION_ERROR(-20602, '�̹� ������ ��ϵ� �л��Դϴ�');
                ROLLBACK;
        WHEN GRADE_DATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20602, '�����Է±Ⱓ�� �ƴմϴ�');
                ROLLBACK;

         WHEN OTHERS
            THEN ROLLBACK;
END;

--==>> Procedure PRC_SCORE_INSERT��(��) �����ϵǾ����ϴ�.





-- ���� ���� PRC_GRADE_DELETE(���� �ڵ�) --
CREATE OR REPLACE PROCEDURE PRC_GRADE_DELETE
(
    V_GRADE_CODE    IN GRADE.GRADE_CODE%TYPE
)
IS
    NOTEXIST_ERROR EXCEPTION;
BEGIN
    DELETE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    -- ��� ������ ��� ROW ���� 0�̸� TRUE, �ƴϸ� FALSE�� ��ȯ
    -- ��ȸ ��� ���� 0�� ��쿣 ���� �߻�
    IF SQL%NOTFOUND
    THEN RAISE NOTEXIST_ERROR;
    END IF;
    
    COMMIT;
    
    EXCEPTION 
        WHEN NOTEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20605,'��ġ�ϴ� �����Ͱ� �����ϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_GRADE_DELETE��(��) �����ϵǾ����ϴ�.






--������ /���ǽ�/ �����/���� �Ⱓ /���� ��/ �����ڸ�
CREATE OR REPLACE VIEW VIEW_SUBJECT
AS
SELECT CO.COURSE_NAME "������"
    , CR.CR_NAME "���ǽ�"
    , SN.SUB_NAME "�����"
    , OS.OS_START || '-' || OS.OS_END "����Ⱓ"
    , TB.TB_NAME "�����"
    , PF.PROF_NAME "�����ڸ�"
FROM OPENED_SUBJECT OS JOIN OPENED_COURSE OC
ON OS.OC_CODE = OC.OC_CODE
JOIN CLASSROOM CR
ON OC.CR_CODE = CR.CR_CODE
JOIN COURSE CO
ON OC.COURSE_CODE = CO.COURSE_CODE
JOIN SUBJECT_NAME SN
ON OS.SUB_CODE = SN.SUB_CODE
JOIN TEXTBOOK TB
ON OS.TB_CODE = TB.TB_CODE
JOIN PROFESSOR PF
ON OS.PROF_ID = PF.PROF_ID;

SELECT *
FROM VIEW_SUBJECT;




--���� ���� �ο� PRC_SCORE_POINT ����--
CREATE OR REPLACE PROCEDURE PRC_SCORE_POINT
(
     V_OS_CODE   IN OPENED_SUBJECT.OS_CODE%TYPE
    ,V_OS_WT            IN OPENED_SUBJECT.OS_WT%TYPE     -- �ʱ����
    ,V_OS_PT            IN OPENED_SUBJECT.OS_PT%TYPE    -- �Ǳ����
    ,V_OS_ATT           IN OPENED_SUBJECT.OS_ATT%TYPE    -- ������
)
IS
BEGIN
    UPDATE OPENED_SUBJECT
    SET OS_WT = V_OS_WT, OS_PT = V_OS_PT, OS_ATT = V_OS_ATT
    WHERE OS_CODE = V_OS_CODE;
END;
--==>> Procedure PRC_SCORE_POINT��(��) �����ϵǾ����ϴ�.


--���� �������� ���� �Լ� TOTAL_SCORE ����--

CREATE OR REPLACE FUNCTION TOTAL_SCORE
(
    --���� GRADE,  ��������(����) OPENED_SUBJECT ȣ��
    V_GRADE_CODE   IN GRADE.GRADE_CODE%TYPE
   ,V_OS_CODE       IN OPENED_SUBJECT.OS_CODE%TYPE
)
    -- ���ڰ��� ����
    RETURN NUMBER
IS
    -- �ֿ� ���� ����
    RESULT NUMBER;
    
    V_P_POINT OS.PT%TYPE;
    V_W_POINT OS.WT%TYPE;
    V_A_POINT OS.ATT%TYPE;
    
    V_P_GRADE GRADE.GRADE.PT%TYPE;
    V_W_GRADE GRADE.GRADE.WT%TYPE;
    V_A_GRADE GRADE.GRADE.ATT%TYPE;
    
BEGIN
    -- ���� �޾ƿ��� 30
    -- NULL�� ��� 0���� ġȯ
    SELECT NVL(OS.PT,0), NVL(OS.WT,0), NVL(OS.ATT,0) INTO V_P_POINT, V_W_POINT, V_A_POINT
    FROM OPENED_SUBJECT
    WHERE OS_CODE = V_OS_CODE;
    
    -- ���� �޾ƿ��� 100
    -- NULL�� ��� 0���� ġȯ    
    SELECT NVL(GRADE.PT,0), NVL(GRADE.WT,0), NVL(GRADE.ATT,0) INTO V_P_GRADE, V_W_GRADE, V_A_GRADE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    -- (30 * 100 + 20 * 90 + 50 * 80)/100  3000 + 1800 + 4000 = 8800/100
    -- 30 * 0.01 = 0.3 /* 98 => 29.4  / 40 * 0.01 = 0.4/ * 56 = 22.4  / 30 * 0.01 = 0.3 /* 44 = 13.2 
    -- 29.4 + 22.4 + 13.2 = 65
    -- (V_P_POINT * 0.01 * V_P_SCORE) +(V_W_POINT* 0.01 * V_W_SCORE) + (V_A_POINT* 0.01 *V_A_SCORE);
    RESULT := (V_P_POINT*V_P_SCORE + V_W_POINT*V_W_SCORE + V_A_POINT*V_A_SCORE)/100;

    -- ���� ��� ��ȯ
    RETURN RESULT;
END;
