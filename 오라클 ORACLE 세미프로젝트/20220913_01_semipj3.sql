SELECT USER
FROM DUAL;
--==>> SEMIPJ3

-- ���� ���̺�
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                      -- �����ڵ�
, GRADE_DATE       DATE               DEFAULT SYSDATE               -- �򰡳�¥
, GRADE_ATT       NUMBER(3)                                         -- ���
, GRADE_WT       NUMBER(3)                                          -- �ʱ�
, GRADE_PT       NUMBER(3)                                          -- �Ǳ�
, OS_CODE       VARCHAR2(10)       NOT NULL                         -- ���������ڵ�
, APP_CODE       VARCHAR2(10)       NOT NULL                        -- ������û�ڵ�
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);

ALTER TABLE GRADE
ADD CONSTRAINT GRADE_OS_CODE_FK FOREIGN KEY (OS_CODE)
    REFERENCES OPENED_SUBJECT(OS_CODE);


ALTER TABLE GRADE
ADD CONSTRAINT GRADE_APP_CODE_FK FOREIGN KEY (APP_CODE)
    REFERENCES APP(APP_CODE);





-- ������ �Է� ���ν��� 
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

-- 





