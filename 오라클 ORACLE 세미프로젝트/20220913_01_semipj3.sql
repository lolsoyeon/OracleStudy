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





---�������� ���� �Լ� TOTAL_SCORE ---
CREATE OR REPLACE FUNCTION TOTAL_SCORE
(
    --���� SCORE,  ��������(����) OPENED_SUBJECT ȣ��
    V_GRADE_CODE IN GRADE.GRADE_CODE%TYPE
   ,V_OS_CODE    IN OPENED_SUBJECT.OS_CODE%TYPE
)
    -- ���ڰ��� ����
    RETURN NUMBER
IS
    -- �ֿ� ���� ����
    RESULT NUMBER;
    
    V_P_POINT OPENED_SUBJECT.OS_PT%TYPE;
    V_W_POINT OPENED_SUBJECT.OS_WT%TYPE;
    V_A_POINT OPENED_SUBJECT.OS_ATT%TYPE;
    
    V_P_SCORE GRADE.GRADE_PT%TYPE;
    V_W_SCORE GRADE.GRADE_WT%TYPE;
    V_A_SCORE GRADE.GRADE_ATT%TYPE;
    
BEGIN
    -- ���� �޾ƿ��� 
    -- NULL�� ��� 0���� ġȯ
    SELECT NVL(OS_PT,0), NVL(OS_WT,0), NVL(OS_ATT,0) INTO V_P_POINT, V_W_POINT, V_A_POINT
    FROM OPENED_SUBJECT
    WHERE OS_CODE = V_OS_CODE;
    
    -- ���� �޾ƿ���
    -- NULL�� ��� 0���� ġȯ    
    SELECT NVL(GRADE_PT,0), NVL(GRADE_WT,0), NVL(GRADE_ATT,0) INTO V_P_SCORE, V_W_SCORE, V_A_SCORE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    RESULT := (V_P_POINT*V_P_SCORE + V_W_POINT*V_W_SCORE + V_A_POINT*V_A_SCORE)/100;

    -- ���� ��� ��ȯ
    RETURN RESULT;
END;
--==>> Function TOTAL_SCORE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
-- ���� �ο� PRC_SCORE_POINT --
CREATE OR REPLACE PROCEDURE PRC_SCORE_POINT
(
     V_OS_CODE        IN OPENED_SUBJECT.OS_CODE%TYPE
    ,V_OS_WT          IN OPENED_SUBJECT.OS_WT%TYPE     -- �ʱ����
    ,V_OS_PT          IN OPENED_SUBJECT.OS_PT%TYPE      -- �Ǳ����
    ,V_OS_ATT         IN OPENED_SUBJECT.OS_ATT%TYPE    -- ������
)
IS
BEGIN
    UPDATE OPENED_SUBJECT
    SET OS_WT = V_OS_WT, OS_PT = V_OS_PT, OS_ATT = V_OS_ATT
    WHERE OS_CODE = V_OS_CODE;
END;
--==>> Procedure PRC_SCORE_POINT��(��) �����ϵǾ����ϴ�.




/*
���� ����� �� �䱸�м�(�л�) - ���� ��� ��� ���� ����
�л� �̸�, ������, �����, ���� �Ⱓ(���� ������, �� ������), ���� ��, ���, �Ǳ�, �ʱ�, ����, ��� 
���� �ȳ��� ������ ��� �Ұ�

*/

CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE  
AS 
SELECT DISTINCT T1.�л��̸�
    , T1.������
    , T1.�����
    , T1.���������
    , T1.����������
    , T1.�����
    , T1.��Ἲ��
    , T1.�ʱ⼺��
    , T1.�Ǳ⼺��
    , T1.����
    , T1.���
FROM(    
    SELECT S.STU_NAME �л��̸�
    , C.COURSE_NAME ������
    , SUB.SUB_NAME �����
    , OS.OS_START ���������
    , OS.OS_END ����������
    , B.TB_NAME �����
    , NVL(G.GRADE_ATT * OS.OS_ATT, 0) / 100 ��Ἲ��
    , NVL(G.GRADE_PT * OS.OS_PT, 0) / 100 �Ǳ⼺��
    , NVL(G.GRADE_WT * OS.OS_WT, 0) / 100 �ʱ⼺�� 
    , NVL(G.GRADE_ATT * OS.OS_ATT, 0) / 100 + NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 
    + NVL(G.GRADE_WT * OS.OS_WT, 0) / 100 "����"
    , S.STU_ID �л��ڵ�
    ,SUB.SUB_CODE �����ڵ�
    , RANK() OVER(PARTITION BY OS.SUB_CODE||OC.OS_START||OC.PROF_ID ORDER BY SC.ATTEND_SCORE + SC.WRITE_SCORE + SC.PRACTICE_SCORE DESC) ���
    FROM OPENED_COURSE OC, COURSE C, STUDENT S, SUBJECT_NAME SUB, OPENED_SUBJECT OS, APP A, TEXTBOOK B, GRAGD G
    WHERE S.STU_ID = A.STU_ID
    AND OC.COURSE_ID = C.COURSE_ID
    AND OS.OC_CODE = OC.OC_CODE
    AND OS.SUB_CODE = SUB.SUB_CODE
    AND OS.BOOK_ID = B.BOOK_ID
    AND G.APP_ID = A.APP_ID
    AND OS.SUBJECT_ID = G.SUBJECT_ID) T1;   
SELECT *
FROM VIEW_STUDENT_GRADE
WHERE �л��̸� = '?�����������Է�';










