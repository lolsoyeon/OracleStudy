SELECT USER
FROM DUAL;
--==>>SEMIPJ3
SELECT *
FROM TAB;
SELECT *
FROM RECYCLEBIN;
--������ ���̺� 
--[������ID - PK]
CREATE TABLE ADMIN                                             
( AD_ID   VARCHAR2(20)                                           -- ������ID 
, AD_PW   VARCHAR2(20)      NOT NULL                            -- ��й�ȣ
, AD_NAME   VARCHAR2(30)                                        -- �����ڸ�
, CONSTRAINT ADMIN_AD_ID_PK PRIMARY KEY(AD_ID)                  -- PK �������� �߰�
);

 -- ������ ���̺�(�������� ���̺��� �θ�)
 --[����ID - PK]
CREATE TABLE PROFESSOR                      -- ������ ���̺�
( PROF_ID       VARCHAR2(20)                -- ����ID
, PROF_PW       CHAR(7)         NOT NULL    -- ��й�ȣ
, PROF_NAME     VARCHAR2(30)    NOT NULL    -- ������
, PROF_DATE     DATE            NOT NULL    -- ��ϳ�¥
, CONSTRAINT PROFESSOR_PROF_ID_PK PRIMARY KEY(PROF_ID)
);

-- �л� ���̺� (������û ���̺��� �θ�)
-- ���л�ID, ��й�ȣ, �л��̸�, ��ϳ�¥
CREATE TABLE STUDENT
( STU_ID       VARCHAR2(20)                             -- �л�ID
, STU_PW       CHAR(7)                  NOT NULL             -- ��й�ȣ
, STU_NAME     VARCHAR2(30)             NOT NULL             -- �л��̸�
, STU_DATE     DATE    DEFAULT SYSDATE                       -- DEFAULT ?
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);




--���� ���̺� (�������� ���̺��� �θ�)
-- [�����ڵ�-PK]
CREATE TABLE COURSE 
( COURSE_CODE   VARCHAR2(10)                    --�����ڵ�
, COURSE_NAME   VARCHAR2(40)      NOT NULL     --�����̸�
, CONSTRAINT COURSE_COURSE_CODE_PK PRIMARY KEY(COURSE_CODE)
);


--���ǽ� ���̺� (�������� ���̺��� �θ�)
-- [���ǽ��ڵ�-PK]
CREATE TABLE CLASSROOM
( CR_CODE       VARCHAR2(10)                     --���ǽ��ڵ�
, CR_NAME    VARCHAR2(10)         NOT NULL      --���ǽǸ�
, CR_CAPACTIY   NUMBER(4)         NOT NULL      --���밡���ο�
, CONSTRAINT CLASSROOM_CR_CODE_PK PRIMARY KEY(CR_CODE)
);

COMMENT ON COLUMN CLASSROOM.CR_CODE IS 'ClassRoom_CODE';


--�������� ���̺� (�������� ���̺��� �θ�/ ������û ���̺��� �θ�)
--(���������ڵ�/ ����������/ ����������/ ���ǽ��ڵ�/ �����ڵ�)
-- [���������ڵ�-PK] / [���ǽ��ڵ�-FK && �����ڵ�-FK]
CREATE TABLE OPENED_COURSE   
( OC_CODE       VARCHAR2(10)    
, OC_START      DATE              NOT NULL
, OC_END        DATE              NOT NULL
, CR_CODE       VARCHAR2(10)      NOT NULL
, COURSE_CODE   VARCHAR2(10)      NOT NULL
, CONSTRAINT OC_OC_CODE_PK PRIMARY KEY(OC_CODE)
);

--��FK �������� �߰�
--���ǽ����̺��� ���ǽ��ڵ�(CR_CODE)�� �θ�� ��� FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_CR_CODE_FK FOREIGN KEY (CR_CODE)
                              REFERENCES CLASSROOM(CR_CODE);
--�������̺��� �����ڵ�(COURSE_CODE)�� �θ�� ��� FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_COURSE_CODEE_FK FOREIGN KEY (COURSE_CODE)
                                    REFERENCES COURSE(COURSE_CODE);


COMMENT ON COLUMN OPENED_COURSE.OC_CODE IS 'OPENEDCourse_CODE';
COMMENT ON COLUMN OPENED_COURSE.CR_CODE IS 'ClassRoom_CODE';


--���� ���̺� (�������� ���̺��� �θ�)
CREATE TABLE SUBJECT_NAME                                       -- ����  ���̺�     
( SUB_CODE   VARCHAR2(10)                                       -- �����ڵ�
, SUB_NAME   VARCHAR2(40)      NOT NULL                         -- �����
, CONSTRAINT SUBJECT_NAME_SUB_CODE_PK PRIMARY KEY(SUB_CODE)      -- PK �������� �߰�
);

COMMENT ON COLUMN SUBJECT_NAME.SUB_CODE IS 'SUBject_CODE';




--���� ���̺�(�������� ���̺��� �θ�)
CREATE TABLE TEXTBOOK                                           -- ���� 
( TB_CODE   VARCHAR2(10)                                        -- �����ڵ�
, TB_NAME   VARCHAR2(40)      NOT NULL                          -- �����
, PUB   VARCHAR2(40)                                            -- ���ǻ�
, CONSTRAINT TEXTBOOK_TB_CODE_PK PRIMARY KEY(TB_CODE)           -- PK �������� �߰�
);

COMMENT ON COLUMN TEXTBOOK.TB_CODE IS 'TextBook_CODE';

COMMENT ON COLUMN TEXTBOOK.TB_NAME IS 'TextBook_NAME';

COMMENT ON COLUMN TEXTBOOK.PUB IS 'Publisher';



--�������� ���̺�(���� ���̺��� �θ�)
CREATE TABLE OPENED_SUBJECT                                                  --�������� ���̺�
( OS_CODE   VARCHAR2(10)                                                    --���������ڵ�
, OS_START  DATE            CONSTRAINT OP_SUBJECT_OS_START_NN  NOT NULL    --���������
, OS_END    DATE            CONSTRAINT OP_SUBJECT_OS_END_NN    NOT NULL    --����������
, OS_DATE   DATE            CONSTRAINT OP_SUBJECT_OS_DATE_NN   NOT NULL    --������¥
, OS_PT     NUMBER(3)                                                       --�Ǳ����
, OS_WT     NUMBER(3)                                                       --�ʱ����
, OS_ATT    NUMBER(3)                                                       --������
, TB_CODE   VARCHAR2(10)    CONSTRAINT OP_SUBJECT_TB_CODE_NN   NOT NULL   --�����ڵ�
, PROF_ID   VARCHAR2(20)    CONSTRAINT OP_SUBJECT_PROF_ID_NN   NOT NULL   --����ID
, SUB_CODE  VARCHAR2(10)    CONSTRAINT OP_SUBJECT_SUB_CODE_NN  NOT NULL   --�����ڵ�
, OC_CODE   VARCHAR2(10)    CONSTRAINT OP_SUBJECT_OC_CODE_NN   NOT NULL   --���������ڵ�
, CONSTRAINT OP_SUBJECT_OS_CODE_PK PRIMARY KEY(OS_CODE)
);

ALTER TABLE OPENED_SUBJECT
ADD
( CONSTRAINT OP_SUBJECT_TB_CODE_FK FOREIGN KEY(TB_CODE) 
             REFERENCES TEXTBOOK(TB_CODE)
, CONSTRAINT OP_SUBJECT_PROF_ID_FK FOREIGN KEY(PROF_ID) 
             REFERENCES PROFESSOR(PROF_ID)
, CONSTRAINT OP_SUBJECT_SUB_CODE_FK FOREIGN KEY(SUB_CODE) 
             REFERENCES SUBJECT_NAME(SUB_CODE)
, CONSTRAINT OP_SUBJECT_OC_CODE_FK FOREIGN KEY(OC_CODE) 
             REFERENCES OPENED_COURSE(OC_CODE)
);








COMMENT ON TABLE OPENED_SUBJECT IS '�������� ���̺�';

COMMENT ON COLUMN OPENED_SUBJECT.OS_CODE IS '���������ڵ�';
COMMENT ON COLUMN OPENED_SUBJECT.OS_START IS '���������';
COMMENT ON COLUMN OPENED_SUBJECT.OS_END IS '����������';
COMMENT ON COLUMN OPENED_SUBJECT.OS_DATE IS '������¥';
COMMENT ON COLUMN OPENED_SUBJECT.OS_PT IS '�Ǳ����';
COMMENT ON COLUMN OPENED_SUBJECT.OS_WT IS '�ʱ����';
COMMENT ON COLUMN OPENED_SUBJECT.OS_ATT IS '������';
COMMENT ON COLUMN OPENED_SUBJECT.TB_CODE IS '�������̺� �����ڵ� ����Ű';
COMMENT ON COLUMN OPENED_SUBJECT.PROF_ID IS '���������̺� �����ڵ� ����Ű';
COMMENT ON COLUMN OPENED_SUBJECT.SUB_CODE IS '�������̺� �����ڵ� ����Ű';
COMMENT ON COLUMN OPENED_SUBJECT.OC_CODE IS '�����������̺� ���������ڵ� ����Ű';

--------------------------------------------------------
-- ������û ���̺�(�ߵ�Ż�� ���̺��� �θ�)

CREATE TABLE APP 
( APP_CODE   VARCHAR2(10)                                      -- ������û�ڵ�
, APP_DATE   DATE                DEFAULT SYSDATE              -- ������û��
, STU_ID     VARCHAR2(20)       NOT NULL                       -- �л�ID
, OC_CODE    VARCHAR2(10)       NOT NULL                        -- ���������ڵ�
, CONSTRAINT APP_APP_CODE_PK PRIMARY KEY (APP_CODE)
);

ALTER TABLE APP
ADD CONSTRAINT APP_STU_ID_FK FOREIGN KEY (STU_ID)
    REFERENCES STUDENT(STU_ID);


ALTER TABLE APP
ADD CONSTRAINT APP_OC_CODE_FK FOREIGN KEY (OC_CODE)
    REFERENCES OPENED_COURSE(OC_CODE);



-- COMMENT
/*
APP_CODE                COMMENT 'APP_CODE',                   
STU_ID                   COMMENT 'STUdent_ID',
SUB_CODE   VARCAHR2(10)        COMMENT 'OPENEDCourse_CODE'
*/


-- ���� ���̺�
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                        -- �����ڵ�
, GRADE_DATE       DATE               DEFAULT SYSDATE     -- �ʱ⳯¥
, GRADE_ATT       NUMBER(3)                                      -- ���
, GRADE_WT       NUMBER(3)                                      -- �ʱ�
, GRADE_PT       NUMBER(3)                                      -- �Ǳ�
, OS_CODE       VARCHAR2(10)       NOT NULL                       -- ���������ڵ�
, APP_CODE       VARCHAR2(10)       NOT NULL                        -- ������û�ڵ�
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);

ALTER TABLE GRADE
ADD CONSTRAINT GRADE_OS_CODE_FK FOREIGN KEY (OS_CODE)
    REFERENCES OPENED_SUBJECT(OS_CODE);


ALTER TABLE GRADE
ADD CONSTRAINT GRADE_APP_CODE_FK FOREIGN KEY (APP_CODE)
    REFERENCES APP(APP_CODE);




-- COMMENT
/*
    GRADE_ATT   COMMENT 'Record Of Attendance',
   GRADE_WT      COMMENT 'Record Of Written Test',
   GRADE_PT       COMMENT 'Record Of Practice Test',
   OS_CODE       COMMENT 'OPENEDCourse_CODE',
   APP_CODE   COMMENT 'APP_CODE'
*/



-- �ߵ�Ż�� ���̺� ����
-- ���ߵ�Ż���ڵ�, �ߵ�Ż������, ������û�ڵ�, Ż�������ڵ�
CREATE TABLE QUITLIST
( QUIT_CODE    VARCHAR2(10)                                     -- ���ߵ�Ż���ڵ�
, QUIT_DATE    DATE    DEFAULT SYSDATE                         --�ߵ�Ż������
, APP_CODE     VARCHAR2(10)                   NOT NULL          --������û�ڵ�
, QR_CODE      VARCHAR2(10)                   NOT NULL          --Ż�������ڵ�
, CONSTRAINT QUITLIST_QUIT_CODE_PK PRIMARY KEY(QUIT_CODE)
);

ALTER TABLE QUITLIST 
ADD CONSTRAINT QUITLIST_APP_CODE_FK FOREIGN KEY (APP_CODE)       
                REFERENCES APP(APP_CODE);

ALTER TABLE QUITLIST 
ADD CONSTRAINT QUITLIST_QR_CODE_FK FOREIGN KEY (QR_CODE)       
                REFERENCES QUIT_REASON(QR_CODE);




-- �ߵ�Ż�� ���� ���̺� (�ߵ�Ż�� ���̺��� �θ�)
-- ��Ż�������ڵ�, �ߵ�Ż������
CREATE TABLE QUIT_REASON
( QR_CODE        VARCHAR2(10)   
, QUIT_REASON   VARCHAR2(40)                  NOT NULL         
, CONSTRAINT QUIT_REASON_PK PRIMARY KEY(QR_CODE)
);

--CONSTCHECK �� ����
--�� �������� Ȯ�� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER"OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME"TABLE_NAME"
     , UC.CONSTRAINT_TYPE"CONSTRAINT_TYPE"
     , UCC.COLUMN_NAME "COLUMN_NAME"
     , UC.SEARCH_CONDITION"SEARCH_CONDITION"
     , UC.DELETE_RULE"DELETE_RULE" 
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.

--���� ���� Ȯ�� 
SELECT *
FROM VIEW_CONSTCHECK;
WHERE TABLE_NAME = 'QUITLIST';

---------------------------------------------------------------------------------

--������
--�ҿ�
-- ���� ������
CREATE SEQUENCE BOOK_SEQ
START WITH 101
INCREMENT BY 1 
MAXVALUE 99999
NOCYCLE
NOCACHE;

--����

CREATE SEQUENCE SEQ_STU
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;

--������
--�¹�
CREATE SEQUENCE OPSUB_SEQ
START WITH 1
INCREMENT BY 1 
MAXVALUE 999999
NOCYCLE
NOCACHE;

SELECT *
FROM USER_SEQUENCES;



--������
--����
CREATE SEQUENCE SEQ_PROF
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;
--==>> Sequence SEQ_PROF��(��) �����Ǿ����ϴ�.

SELECT *
FROM USER_SEQUENCES;

--������û �ڵ�
CREATE SEQUENCE SEQ_APP
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;
--==>> Sequence SEQ_APP��(��) �����Ǿ����ϴ�.
---------------------------------------------------------------------------------------
--�α���(������,������,�л�)
--������ �α���
CREATE OR REPLACE PROCEDURE PRC_ADMIN_LOGIN
( V_AD_ID       IN      ADMIN.AD_ID%TYPE
, V_AD_PW       IN      ADMIN.AD_PW%TYPE
)
IS
    V_AD_ID_CHECK   ADMIN.AD_ID%TYPE;        --��ġ�ϴ� ID�� ������ ���� ����
    V_AD_PW_CHECK   ADMIN.AD_PW%TYPE;        --��й�ȣ ������ ���� ����
    
    USER_DEFINE_ERROR1 EXCEPTION;      --ID������ ��� ����
    USER_DEFINE_ERROR2 EXCEPTION;      --��й�ȣ ��ġ���� ������ ��� ����
BEGIN
    
    SELECT NVL(MAX(AD_ID),'0') INTO V_AD_ID_CHECK
    FROM ADMIN
    WHERE AD_ID = V_AD_ID; 
    IF(V_AD_ID_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    SELECT AD_PW INTO V_AD_PW_CHECK
    FROM ADMIN
    WHERE AD_ID = V_AD_ID;
    
    IF(V_AD_PW != V_AD_PW_CHECK)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�����ڰ� �α��� �Ͽ����ϴ�~!!!');
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1 THEN RAISE_APPLICATION_ERROR(-20760 , '��ġ�ϴ� ID�� �������� �ʽ��ϴ�~!!!');
    WHEN USER_DEFINE_ERROR2 THEN RAISE_APPLICATION_ERROR(-20761 , '��й�ȣ�� ��ġ ���� �ʽ��ϴ�~!!!');
    WHEN OTHERS THEN ROLLBACK;
    --Ŀ��
    COMMIT;
END;


--������ �α���
CREATE OR REPLACE PROCEDURE PRC_PROF_LOGIN
( V_PROF_ID     IN      PROFESSOR.PROF_ID%TYPE
, V_PROF_PW     IN      PROFESSOR.PROF_PW%TYPE
)
IS
    V_PROF_ID_CHECK     PROFESSOR.PROF_ID%TYPE;     --������ID üũ�� ���� ����
    V_PROF_PW_CHECK     PROFESSOR.PROF_PW%TYPE;     --������PW üũ�� ���� ����
    
    USER_DEFINE_ERROR1 EXCEPTION;                   --ID�� �������� ������ ��� ����
    USER_DEFINE_ERROR2 EXCEPTION;                   --PW�� ��ġ���� ������ ��� ����
BEGIN
    SELECT NVL(MAX(PROF_ID),'0') INTO V_PROF_ID_CHECK
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID; 
    IF(V_PROF_ID_CHECK= '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    SELECT PROF_PW INTO V_PROF_PW_CHECK
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;
    
    IF(V_PROF_PW != V_PROF_PW_CHECK)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�����ڰ� �α��� �Ͽ����ϴ�~!!!');
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1 THEN RAISE_APPLICATION_ERROR(-20762 , '��ġ�ϴ� ID�� �������� �ʽ��ϴ�~!!!');
    WHEN USER_DEFINE_ERROR2 THEN RAISE_APPLICATION_ERROR(-20763 , '��й�ȣ�� ��ġ ���� �ʽ��ϴ�~!!!');
    WHEN OTHERS THEN ROLLBACK;
    --Ŀ��
    COMMIT;

END;


--�л� �α���
CREATE OR REPLACE PROCEDURE PRC_STU_LOGIN
( V_STU_ID      IN STUDENT.STU_ID%TYPE
, V_STU_PW      IN STUDENT.STU_PW%TYPE
)
IS
    --�����
    V_IDCHECK   NUMBER;
    V_STU_NAME  STUDENT.STU_NAME%TYPE;  
    V_PWCHECK    STUDENT.STU_PW%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    -- ID�� �ִ��� Ȯ��
    SELECT COUNT(*) INTO V_IDCHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- �Է��� ID�� �������� �ʴ� ��� ���� �߻�
    IF (V_IDCHECK = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �Է��� ID�� PW Ȯ��
    SELECT STU_PW INTO V_PWCHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- �Է��� ID�� ��й�ȣ�� Ʋ���� �� ���� �߻�
    IF (V_STU_PW != V_PWCHECK)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�ش��ϴ� �л��� �̸��� V_STU_NAME ������ ���
    SELECT STU_NAME INTO V_STU_NAME 
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- �α��� ������ ���� ���
    DBMS_OUTPUT.PUT_LINE(V_STU_NAME || '�� �������~!!!');
    
    --���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20211,'���̵� �Ǵ� ��й�ȣ�� �߸� �Է��߽��ϴ�. �Է��Ͻ� ������ �ٽ� Ȯ�����ּ���');
    --Ŀ��
    COMMIT;
END;


-----------------------------------------------------------------------------------
--����
--������

--������ �μ�Ʈ ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
( V_PROF_PW      IN PROFESSOR.PROF_PW%TYPE  
, V_PROF_NAME    IN PROFESSOR.PROF_NAME%TYPE
, V_PROF_DATE    IN PROFESSOR.PROF_DATE%TYPE
)
IS
    V_PROF_ID    PROFESSOR.PROF_ID%TYPE;
    V_PW_CHECK     PROFESSOR.PROF_PW%TYPE;
    PW_CHECK    NUMBER(1);

        
    USER_DEFINE_ERROR   EXCEPTION;  
BEGIN
    --�ߺ� �� ã��
    SELECT NVL( ( SELECT PROF_PW
                  FROM PROFESSOR
                  WHERE PROF_NAME = V_PROF_NAME
                  AND PROF_PW = V_PROF_PW ),'0' ) INTO V_PW_CHECK    
    FROM DUAL;
   
    IF (V_PW_CHECK != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    SELECT COUNT(*)     INTO PW_CHECK
    FROM PROFESSOR
    WHERE PROF_PW = V_PROF_PW;
    
    IF (PW_CHECK != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    V_PROF_ID := TO_CHAR(SYSDATE,'YYYY') || LPAD(TO_CHAR(SEQ_PROF.NEXTVAL),4,'0');
    
    INSERT INTO PROFESSOR(PROF_ID,PROF_PW,PROF_NAME, PROF_DATE)VALUES(V_PROF_ID,V_PROF_PW,V_PROF_NAME, V_PROF_DATE);
   
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20400,'�̹� ��ϵ� �������Դϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_PROFESSOR_INSERT��(��) �����ϵǾ����ϴ�.



--������ ������Ʈ ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
( V_PROF_ID      IN PROFESSOR.PROF_ID%TYPE  
, V_PROF_NAME    IN PROFESSOR.PROF_NAME%TYPE
)
IS
    ID_CHECK    NUMBER(1);
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --�ش� ID�� �������� �������
    SELECT COUNT(*) INTO ID_CHECK
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;
    
    IF (ID_CHECK = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE PROFESSOR
    SET PROF_NAME = V_PROF_NAME
    WHERE PROF_ID = V_PROF_ID;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20400,'�Էµ� ������ ��ġ�ϴ� �����ڰ� �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PROFESSOR_UPDATE��(��) �����ϵǾ����ϴ�.


--������ ����Ʈ ���ν���
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
( V_PROF_ID          IN PROFESSOR.PROF_ID%TYPE
)
IS
    V_CHECK             NUMBER;

    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    --�ش� ������ ������ �ִ��� Ȯ��
    SELECT COUNT(*)     INTO V_CHECK
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;
    
    --������ ������� ���� �߻�
    IF (V_CHECK = 0)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ����    
    DELETE
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20400,'�Էµ� ������ ��ġ�ϴ� �����ڰ� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PROFESSOR_DELETE��(��) �����ϵǾ����ϴ�.



CREATE OR REPLACE TRIGGER PRC_PROFESSOR_DELETE1
    BEFORE
    DELETE ON PROFESSOR
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPENED_SUBJECT
    WHERE PROF_ID = :OLD.PROF_ID;
END;

--==>> Trigger PRC_PROFESSOR_DELETE1��(��) �����ϵǾ����ϴ�.

-------------------------------------------------------------------------------------
--�ҿ�
--���� ��� PRC_TEXTBOOK_INSERT(�����, ���ǻ�)--
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_INSERT
( V_TB_NAME  IN TEXTBOOK.TB_NAME%TYPE
, V_PUB      IN TEXTBOOK.PUB%TYPE
)
IS
    -- �����
    CHECK_TB_NAME   TEXTBOOK.TB_NAME%TYPE;
    V_TB_CODE       TEXTBOOK.TB_CODE%TYPE := 'BK' || TO_CHAR(BOOK_SEQ.NEXTVAL);
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT TB_NAME
               FROM TEXTBOOK
               WHERE TB_NAME = V_TB_NAME), '0') INTO CHECK_TB_NAME
    FROM DUAL;
    
    IF (CHECK_TB_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;


    -- INSERT ������ ����
    INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB)
    VALUES(V_TB_CODE, V_TB_NAME, V_PUB);
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20610, '�̹� ��ϵ� �����Դϴ�.');
    ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;

--==>> Procedure PRC_TEXTBOOK_INSERT��(��) �����ϵǾ����ϴ�.


-----------------------------------------------------------------------------------

--���� ���� ���� PRC_TEXTBOOK_UPDATE(�����ڵ�, �����, ���ǻ�) ����--
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_UPDATE
( V_TB_CODE       IN TEXTBOOK.TB_CODE%TYPE
, NEW_TB_NAME     IN TEXTBOOK.TB_NAME%TYPE
, NEW_PUB         IN TEXTBOOK.PUB%TYPE
)
IS
-- �����
    CHECK_BOOK_NAME   TEXTBOOK.TB_NAME%TYPE;
    CHECK_BOOK_CODE     TEXTBOOK.TB_CODE%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- ����ID�� ������ ����
    SELECT NVL((SELECT TB_CODE
               FROM TEXTBOOK
               WHERE TB_CODE = V_TB_CODE),'0') INTO CHECK_BOOK_CODE
    FROM DUAL;
    
    IF (CHECK_BOOK_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �̹� ��ϵ� ������̸� ����
    SELECT NVL((SELECT TB_NAME
               FROM TEXTBOOK
               WHERE TB_NAME = NEW_TB_NAME),'0') INTO CHECK_BOOK_NAME
    FROM DUAL;
    
    IF (CHECK_BOOK_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- UPDATE ������ ����
    UPDATE TEXTBOOK
    SET TB_NAME = NEW_TB_NAME, PUB = NEW_PUB
    WHERE TB_CODE = V_TB_CODE;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20611, '��ϵ��� ���� ����ID�Դϴ�.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20612, '�̹� ��ϵ� �����Դϴ�.' );
    ROLLBACK;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_TEXTBOOK_UPDATE��(��) �����ϵǾ����ϴ�.


------------------------------------------------------------------------------------
-- ���� ���� PRC_TEXTBOOK_DELETE(�����ڵ�) --
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_DELETE
(V_TB_CODE  IN TEXTBOOK.TB_CODE%TYPE
)
IS
    -- �����
    CHECK_TB_CODE  TEXTBOOK.TB_CODE%TYPE;
    
    USER_DEFINE_ERROR    EXCEPTION;
    USER_DIFINE_ERROR2   EXCEPTION;

BEGIN
    -- �����ڵ尡 ������ ���ܹ߻� ERROR
    SELECT NVL((SELECT TB_CODE
                FROM TEXTBOOK
                WHERE TB_CODE = V_TB_CODE), '0') INTO CHECK_TB_CODE
    FROM DUAL;
    
    IF (CHECK_TB_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- �ش� ���縦 �̹� ��� ���� ������ �ֽ��ϴ�. ERROR2
    SELECT NVL((SELECT TB_CODE
                FROM OPENED_SUBJECT
                WHERE TB_CODE = V_TB_CODE), '0') INTO CHECK_TB_CODE
    FROM DUAL;
    
    IF (CHECK_TB_CODE = V_TB_CODE)
        THEN RAISE USER_DIFINE_ERROR2;
    END IF;


    -- DELETE ������ ����
    DELETE 
    FROM TEXTBOOK
    WHERE TB_CODE = V_TB_CODE;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20613, '��ϵ��� ���� �����Դϴ�.');
    WHEN USER_DIFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20614, '�ش米�縦 �̹� ������� ������ �ֽ��ϴ�.');
    ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;

--==>> Procedure PRC_TEXTBOOK_DELETE��(��) �����ϵǾ����ϴ�.



-----------------------------------------------------------------------------------
--����
--1.�л� ��� ���ν���
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(  V_STU_PW      IN STUDENT.STU_PW%TYPE  -- SSN �÷��� ���� �������� �ʾ���
,  V_STU_NAME    IN STUDENT.STU_NAME%TYPE
,  V_STU_DATE    IN STUDENT.STU_DATE%TYPE
)
IS
    V_STU_ID    STUDENT.STU_ID%TYPE;
    V_CHECK     STUDENT.STU_PW%TYPE;
    PW_CHECK    NUMBER(1);

    
    USER_DEFINE_ERROR   EXCEPTION;  
BEGIN
    --�ߺ� �� ã��
    SELECT NVL( ( SELECT STU_PW
                  FROM STUDENT
                  WHERE STU_NAME = V_STU_NAME
                  AND STU_PW = V_STU_PW ),'0' ) INTO V_CHECK    
    FROM DUAL;
   
    IF (V_CHECK != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    SELECT COUNT(*)     INTO PW_CHECK
    FROM STUDENT
    WHERE STU_PW = V_STU_PW;
    
    IF (PW_CHECK != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    V_STU_ID := TO_CHAR(SYSDATE,'YYYY') || LPAD(TO_CHAR(SEQ_STU.NEXTVAL),4,'0');
    
    INSERT INTO STUDENT(STU_ID,STU_PW,STU_NAME,STU_DATE)VALUES(V_STU_ID,V_STU_PW,V_STU_NAME,V_STU_DATE);
    --INSERT INTO STUDENT(STU_ID,STU_PW,STU_NAME,STU_SSN)VALUES(V_STU_ID,SUBSTR(V_STU_SSN,8),V_STU_NAME,V_STU_SSN);
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20200,'�̹� ��ϵ� �л��Դϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    COMMIT;
    
END;

--2.�л� ���� ���ν���
--���̵� , ������ �̸� �ش� �л��� �̸� ����
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_STU_ID      IN STUDENT.STU_ID%TYPE  
, V_STU_NAME    IN STUDENT.STU_NAME%TYPE
)
IS
    ID_CHECK    NUMBER(1);
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --�ش� ID�� �������� �������
    SELECT COUNT(*) INTO ID_CHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    IF (ID_CHECK = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE STUDENT
    SET STU_NAME = V_STU_NAME
    WHERE STU_ID = V_STU_ID;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20201,'�Էµ� ������ ��ġ�ϴ� �л��� �������� �ʽ��ϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_STU_UPDATE��(��) �����ϵǾ����ϴ�.

--3�л� ���� ���ν���
--���̵� �Է½� �ش� �л��� �������� �� �л����� ����
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
( V_STU_ID          IN STUDENT.STU_ID%TYPE
)
IS
    V_CHECK             NUMBER;
--    V_APP_CODE          APP.APP_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    --�ش� �л������� �ִ��� Ȯ��
    SELECT COUNT(*)     INTO V_CHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    --�л������� ������� ���� �߻�
    IF (V_CHECK = 0)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
-- �л����� ����    
    DELETE
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
-- �������� ����
--    DELETE
--    FROM APP
--    WHERE STU_ID = V_STU_ID;
-- ���� ����
--    DELETE
--    FROM GRADE
--    WHERE APP_CODE = V_APP_CODE;

--SELECT OC_CODE
--FROM APP
--WHERE STU_ID = V_STU_ID;
    --����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20201,'�Էµ� ������ ��ġ�ϴ� �л��� �������� �ʽ��ϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    COMMIT;
END;



CREATE OR REPLACE TRIGGER PRC_STUDENT_DELETE1
    BEFORE
    DELETE ON STUDENT
    FOR EACH ROW
BEGIN
    DELETE
    FROM APP
    WHERE STU_ID = :OLD.STU_ID;
END;

------------------------------------------------------------------------------------
--����
--����
-- ���� ���� �Է� --------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
(
  V_COURSE_CODE   IN COURSE.COURSE_CODE%TYPE
, V_COURSE_NAME   IN COURSE.COURSE_NAME%TYPE
)
IS
    V_COURSE_NAME_CHECK   COURSE.COURSE_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN

    SELECT NVL((SELECT COURSE_NAME
               FROM COURSE
               WHERE COURSE_NAME = V_COURSE_NAME),'0') INTO V_COURSE_NAME_CHECK
    FROM DUAL;

    IF (V_COURSE_NAME_CHECK != '0')
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
   
    INSERT INTO COURSE(COURSE_CODE, COURSE_NAME)
        VALUES(V_COURSE_CODE, V_COURSE_NAME);
        
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20500, '�̹� ��ϵ� ����');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


-- ���� ���� ���� --------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
(
  V_COURSE_CODE   IN COURSE.COURSE_CODE%TYPE
, V_COURSE_NAME   IN COURSE.COURSE_NAME%TYPE
)
IS
    CHECK_COURSE_CODE   COURSE.COURSE_CODE%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN

    SELECT NVL((SELECT COURSE_CODE
               FROM COURSE
               WHERE COURSE_CODE = V_COURSE_CODE),'0') INTO CHECK_COURSE_CODE
    FROM DUAL;
    
    IF (CHECK_COURSE_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE COURSE
    SET COURSE_NAME = V_COURSE_NAME
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20501, '�������� �ʴ� �����̹Ƿ� ���� �Ұ���');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��       
    COMMIT;
    
END;

-- ���� ���� ���� ---------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
(
  V_COURSE_CODE    IN OPENED_COURSE.COURSE_CODE%TYPE
)
IS
    V_COURSE_CODE_CHECK   COURSE.COURSE_CODE%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT COUNT(*) INTO V_COURSE_CODE_CHECK
    FROM COURSE
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    IF(V_COURSE_CODE_CHECK = 0)
     THEN RAISE USER_DEFINE_ERROR;
    END IF;


    DELETE 
    FROM COURSE
    WHERE COURSE_CODE = V_COURSE_CODE;

    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20502, '�������� �ʴ� �����̹Ƿ� ���� �Ұ���');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;

--------------------------------------------------------------------------------
-- ���� ���� Ʈ���� -------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRI_COURSE_DELETE
    BEFORE
    DELETE ON COURSE
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPENED_COURSE
    WHERE COURSE_CODE = :OLD.COURSE_CODE;
END;     
--------------------------------------------------------------------------------
-- �������� ���� �Է� -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_INSERT
( V_OC_START    IN      OPENED_COURSE.OC_START%TYPE
, V_OC_END      IN      OPENED_COURSE.OC_END%TYPE
, V_CR_CODE     IN      CLASSROOM.CR_CODE%TYPE
, V_COURSE_CODE IN      COURSE.COURSE_CODE%TYPE

)
IS
    -- �������� �ڵ� 
    V_OC_CODE                   OPENED_COURSE.OC_CODE%TYPE;
    -- �����ڵ� ���� ���θ� Ȯ���� ����
    V_COURSE_CODE_CHECK          COURSE.COURSE_CODE%TYPE;
    -- ���ǽ��ڵ� ���� ���θ� Ȯ���� ����
    V_CR_CODE_CHECK             CLASSROOM.CR_CODE%TYPE;
    

-- ���� �߻� ���
-- 1. ���� �ڵ尡 �������� ���� ��
    USER_DEFINE_ERROR1 EXCEPTION;
-- 2. ������������ ���������� ���� ������ ��
    USER_DEFINE_ERROR2 EXCEPTION;    
-- 3. ���ǽ� ��尡 �������� ���� ��
    USER_DEFINE_ERROR3 EXCEPTION;


BEGIN
    -- 1. ���� �ڵ尡 �������� ���� ��
    SELECT NVL(MAX(COURSE_CODE), '0') INTO V_COURSE_CODE_CHECK 
    FROM COURSE
    WHERE COURSE_CODE =V_COURSE_CODE;
    
    IF (V_COURSE_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;

    -- 2. ������������ ���������� ���� ������ ��
    
    IF(V_OC_START >= V_OC_END)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    -- 3. ���ǽ� ��尡 �������� ���� ��
    SELECT NVL(MAX(CR_CODE), '0') INTO V_CR_CODE_CHECK 
    FROM CLASSROOM
    WHERE CR_CODE = V_CR_CODE;
    
    IF (V_CR_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

    
    V_OC_CODE := 'OC' || SUBSTR(V_COURSE_CODE,1,1);
    
     INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
    VALUES(V_OC_CODE||TO_CHAR(OPENED_COURSE_SEQ.NEXTVAL), V_OC_START, V_OC_END, V_CR_CODE, V_COURSE_CODE);

    --COMMIT;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20503, '������ �������� ����');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20504, '���������� �� ������ ����');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20505, '���ǽ��� �������� ����');
    
    WHEN OTHERS THEN ROLLBACK;
    
    --Ŀ��
    COMMIT;
       
END;


--------------------------------------------------------------------------------
-- �������� ���� ���� -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_UPDATE
( V_OC_CODE        IN OPENED_COURSE.OC_CODE%TYPE
, V_OC_START       IN OPENED_COURSE.OC_START%TYPE
, V_OC_END         IN OPENED_COURSE.OC_END%TYPE
, V_CR_CODE        IN CLASSROOM.CR_CODE%TYPE
, V_COURSE_CODE    IN COURSE.COURSE_CODE%TYPE
)
IS
    -- �������� �ڵ� ���� ���θ� Ȯ���� ����
    V_OC_CODE_CHECK             OPENED_COURSE.OC_CODE%TYPE;
    -- �����ڵ� ���� ���θ� Ȯ���� ����
    V_COURSE_CODE_CHECK          COURSE.COURSE_CODE%TYPE;
    -- ���ǽ��ڵ� ���� ���θ� Ȯ���� ����
    V_CR_CODE_CHECK             CLASSROOM.CR_CODE%TYPE;
    

-- ���� �߻� ���
-- 1. �������� �ڵ尡 �������� ���� ��
    USER_DEFINE_ERROR1 EXCEPTION;
-- 2. ���� �ڵ尡 �������� ���� ��
    USER_DEFINE_ERROR2 EXCEPTION;
-- 3. ������������ ���������� ���� ������ ��
    USER_DEFINE_ERROR3 EXCEPTION;    
-- 4. ���ǽ� ��尡 �������� ���� ��
    USER_DEFINE_ERROR4 EXCEPTION;
    
BEGIN
    -- 1. �������� �ڵ尡 �������� ���� ��
    SELECT NVL(MAX(OC_CODE), '0') INTO V_OC_CODE_CHECK 
    FROM OPENED_COURSE
    WHERE OC_CODE =V_OC_CODE;
    
    IF (V_OC_CODE_CHECK= '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
     -- 2. ���� �ڵ尡 �������� ���� ��
    SELECT NVL(MAX(COURSE_CODE), '0') INTO V_COURSE_CODE_CHECK 
    FROM COURSE
    WHERE COURSE_CODE =V_COURSE_CODE;
    
    IF (V_COURSE_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    -- 3. ������������ ���������� ���� ������ ��
    
    IF(V_OC_START >= V_OC_END)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

    -- 4. ���ǽ� ��尡 �������� ���� ��
    SELECT NVL(MAX(CR_CODE), '0') INTO V_CR_CODE_CHECK 
    FROM CLASSROOM
    WHERE CR_CODE = V_CR_CODE;
    
    IF (V_CR_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR4;
    END IF;

    UPDATE OPENED_COURSE
    SET OC_CODE=V_OC_CODE, OC_START=V_OC_START , OC_END=V_OC_END, CR_CODE=V_CR_CODE, COURSE_CODE=V_COURSE_CODE
    WHERE OC_CODE = V_OC_CODE;
       
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20506, '�������� �ʴ� ���������̹Ƿ� ���� �Ұ���');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20507, '������ �������� �ʾ� ���� �Ұ���');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20508, '���������� �� ������ ������ ���� �Ұ���');
    
    WHEN USER_DEFINE_ERROR4
    THEN RAISE_APPLICATION_ERROR(-20509, '���ǽ��� �������� �ʾ� ���� �Ұ���');
    
    WHEN OTHERS THEN ROLLBACK;
    --Ŀ��
    COMMIT;
    
END;

--------------------------------------------------------------------------------
-- �������� ���� ���� -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_DELETE
( V_OC_CODE     IN      OPENED_COURSE.OC_CODE%TYPE
)
IS
    -- �������� �ڵ� ���� ���θ� Ȯ���� ����
    OC_CODE_CHECK   OPENED_COURSE.OC_CODE%TYPE;
    
    -- �����ϴ� ���������� ���ٸ� ���� �߻�
    USER_DEFINE_ERROR EXCEPTION;
BEGIN   
        SELECT NVL(MAX(OC_CODE), '0') INTO OC_CODE_CHECK
        FROM OPENED_COURSE
        WHERE OC_CODE =V_OC_CODE;
        
        IF (OC_CODE_CHECK='0')
            THEN RAISE USER_DEFINE_ERROR; 
        END IF;
        
        DELETE
        FROM OPENED_COURSE
        WHERE OC_CODE = V_OC_CODE;
        
        EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20510, '�������� �ʴ� �����̹Ƿ� ���� �Ұ���'); 
        --Ŀ��
        COMMIT;
END;
--------------------------------------------------------------------------------
-- �������� ���� Ʈ���� -------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_OPENED_COURSE_DELETE
        BEFORE
        DELETE ON OPENED_COURSE
        FOR EACH ROW
BEGIN
    DELETE
    FROM APP
    WHERE OC_CODE = :OLD.OC_CODE;
    
    DELETE
    FROM OPENED_SUBJECT
    WHERE OC_CODE = :OLD.OC_CODE;
END;

-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------
--�¹�
--1. ���� ��� PRC_SUBJECT_INSERT(�����ڵ�,�����) 
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUB_CODE IN SUBJECT_NAME.SUB_CODE%TYPE
, V_SUB_NAME IN SUBJECT_NAME.SUB_NAME%TYPE
)
IS
-- �����
    CHECK_SUB_NAME   SUBJECT_NAME.SUB_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT SUB_NAME
               FROM SUBJECT_NAME
               WHERE SUB_NAME = V_SUB_NAME),'0') INTO CHECK_SUB_NAME
    FROM DUAL;
    
    --�̹� �ߺ��� �����̶�� ���� �߻� ��ų ��
    IF (CHECK_SUB_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --������ �μ�Ʈ (�޾ƿ� �Ű�������� SUB_CODE�� SUB_NAME�� ���� INSERT)
    INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME)
    VALUES(V_SUB_CODE, V_SUB_NAME);
    
    --�ߺ��� �����̶�� ���� �߻� ó��
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20700, '�̹� ��ϵ� �����Դϴ�~!!!' );
    
    -- Ŀ��
    COMMIT;
END;
--------------------------------------------------------------------------------
--2. ���� ���� PRC_SUBJECT_UPDATE(�����ڵ�, �����)
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_UPDATE
( V_SUB_CODE        IN SUBJECT_NAME.SUB_CODE%TYPE
, V_SUB_NAME	    IN SUBJECT_NAME.SUB_NAME%TYPE
)
IS
    CHECK_SUB_CODE   SUBJECT_NAME.SUB_CODE%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    
    SELECT NVL((SELECT SUB_CODE
               FROM SUBJECT_NAME
               WHERE SUB_CODE = V_SUB_CODE),'0') INTO CHECK_SUB_CODE
    FROM DUAL;
    
    --��ϵ� ������ �ִ� �� Ȯ���ϰ� ���ٸ� ���ܹ߻� ��ų ��
    IF (CHECK_SUB_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ���� �̸� ����
    UPDATE SUBJECT_NAME
    SET SUB_NAME = V_SUB_NAME
    WHERE SUB_CODE = V_SUB_CODE;
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20701, '��ϵ� ������ �����ϴ�~!!!' );

    
    -- Ŀ��
    COMMIT;
    
END;
--------------------------------------------------------------------------------
--3. ���� ���� PRC_SUBJECT_DELETE(����CODE) 
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_DELETE
(
    V_SUB_CODE IN SUBJECT_NAME.SUB_CODE%TYPE
)
IS  
    V_CHECK_CODE SUBJECT_NAME.SUB_CODE%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_CHECK_CODE
    FROM SUBJECT_NAME
    WHERE SUB_CODE = V_SUB_CODE;
    
    IF(V_CHECK_CODE = 0)
     THEN RAISE USER_DEFINE_ERROR ;
    END IF;
    
    DELETE
    FROM SUBJECT_NAME
    WHERE SUB_CODE = V_SUB_CODE;
      

    
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20702,'��ġ�ϴ� �����Ͱ� �����ϴ�~!!!');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;            
END;
--------------------------------------------------------------------------------
-- 4. ���� ����2 PRC_SUBJECT_DELETE_1 (Ʈ����)
--�� ���� ���� Ʈ���� ����
-- ���񿡼� DELETE�� ������� �� 
-- �������� ���̺����� ������ ���� �ؾ���
-- �������񿡼� ���� ����
CREATE OR REPLACE TRIGGER PRC_SUBJECT_DELETE_1
    BEFORE
    DELETE ON SUBJECT_NAME
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPENED_SUBJECT
    WHERE SUB_CODE = :OLD.SUB_CODE;
END;                    

--------------------------------------------------------------------------------
--                                                                      
--5. �������� �߰� PRC_OPSUB_INSERT
--(���������ڵ�,
--(���������,����������,������¥,�Ǳ����,�ʱ����,������,�����ڵ�,����ID,�����ڵ�,���������ڵ�)

--EXEC PRC_OPSUB_INSERT(���������,����������,������¥,�Ǳ����,�ʱ����,������,�����ڵ�,����ID,�����ڵ�,���������ڵ�)


CREATE OR REPLACE PROCEDURE PRC_OPSUB_INSERT
( V_OS_START    IN      OPENED_SUBJECT.OS_START%TYPE
, V_OS_END      IN      OPENED_SUBJECT.OS_END%TYPE
, V_OS_DATE     IN      OPENED_SUBJECT.OS_DATE%TYPE
, V_OS_PT       IN      OPENED_SUBJECT.OS_PT%TYPE
, V_OS_WT       IN      OPENED_SUBJECT.OS_WT%TYPE 
, V_OS_ATT      IN      OPENED_SUBJECT.OS_ATT%TYPE
, V_TB_CODE     IN      TEXTBOOK.TB_CODE%TYPE
, V_PROF_ID     IN      PROFESSOR.PROF_ID%TYPE
, V_SUB_CODE    IN      SUBJECT_NAME.SUB_CODE%TYPE
, V_OC_CODE     IN      OPENED_COURSE.OC_CODE%TYPE
)
IS
--���������ڵ�� �Ű������� �Է¹޴� ���� �ƴϹǷ� ���� ������ ���� ����
--���ڿ� + TO_CHAR(������)�� ���� ��� �� ��
    V_OS_CODE  OPENED_SUBJECT.OS_CODE%TYPE; 
    
--���������ڵ� ������ ���� ����
    OC_CODE_CHECK  OPENED_COURSE.OC_CODE%TYPE;

--���������ڵ� �̸� �ٿ��� ���� ���� (�����ڵ��� ù���ڸ� ���ð�)
--    V_NAMING    SUBJECT_NAME.SUB_CODE%TYPE := SUBSTR(V_SUB_CODE,1,1);
    
    
--���� �߻� ����

--������� ������ 100���� ��ġ�� ���� ���
    USER_DEFINE_ERROR1 EXCEPTION;
--�谳����¥�� ��ĥ ���(���� �ִ� ������)
    USER_DEFINE_ERROR2 EXCEPTION;    
--�鰳�������� �Ⱓ�� ���������� �Ⱓ�� ���� ���� ���
    USER_DEFINE_ERROR3 EXCEPTION;

    OC_START    DATE;   --���� ���� ������ ���� ���� 
    OC_END      DATE;   --���� ���� ������ ���� ����
    
    EX_START    DATE;   --���� ���� ������
    EX_END      DATE;   --���� ���� ������
    
    CURSOR CUR_DATE_CHECK
    IS
    SELECT OS_START,OS_END
    FROM OPENED_SUBJECT
    WHERE OC_CODE = V_OC_CODE;
BEGIN
    --������� ������ 100���� �ƴ� ��� ���� �߻�
    IF(V_OS_PT+V_OS_WT+V_OS_ATT!=100)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    


    --�谳����¥�� ��ĥ ���(���� �ִ� ������) 
    OPEN CUR_DATE_CHECK;
    LOOP   
    FETCH CUR_DATE_CHECK INTO EX_START,EX_END;
    
    EXIT WHEN CUR_DATE_CHECK%NOTFOUND;
    
    IF(V_OS_START<=EX_START AND V_OS_END>=EX_START)
        THEN RAISE USER_DEFINE_ERROR2;
    ELSIF(V_OS_START<=EX_START AND V_OS_END>=EX_END)
        THEN RAISE USER_DEFINE_ERROR2;    
    ELSIF(V_OS_START>=EX_START AND V_OS_END <=EX_END)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    END LOOP;
    CLOSE CUR_DATE_CHECK;

    --�鰳�������� �Ⱓ�� ���������� �Ⱓ�� ���� ���� ���
    SELECT OC_START, OC_END INTO OC_START,OC_END
    FROM OPENED_COURSE
    WHERE OC_CODE = V_OC_CODE;
    
    --�����ϴ� ���������� �������� �ش� ������������ ������ ���� �ռ��ų�
    --�����ϴ� ���������� �������� �ش� ������������ ������ ���� �ʴ´ٸ� ���� �߻�
    IF(V_OS_START<OC_START OR OC_END<V_OS_END)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

    V_OS_CODE := 'OS' || SUBSTR(V_SUB_CODE,1,1);
    
    INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT
    , TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
    VALUES(V_OS_CODE||TO_CHAR(OPSUB_SEQ.NEXTVAL), V_OS_START, V_OS_END, V_OS_DATE, V_OS_PT, V_OS_WT, V_OS_ATT
    , V_TB_CODE, V_PROF_ID, V_SUB_CODE, V_OC_CODE);

    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20703, '������ ������ 100���� �ƴմϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20704, '������ ������ ��¥�� ���� �����Ҽ� �����ϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20705, '���������� �Ⱓ�� ���������� �Ⱓ�� ���ԵǾ�� �մϴ�~!!!');
    
    WHEN OTHERS THEN ROLLBACK;

    
    --Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--6.�������� ���� PRC_OPSUB_UPDATE
CREATE OR REPLACE PROCEDURE PRC_OPSUB_UPDATE
( V_OS_CODE     IN      OPENED_SUBJECT.OS_CODE%TYPE
, V_OS_START    IN      OPENED_SUBJECT.OS_START%TYPE
, V_OS_END      IN      OPENED_SUBJECT.OS_END%TYPE
, V_OS_DATE     IN      OPENED_SUBJECT.OS_DATE%TYPE
, V_OS_PT       IN      OPENED_SUBJECT.OS_PT%TYPE
, V_OS_WT       IN      OPENED_SUBJECT.OS_WT%TYPE 
, V_OS_ATT      IN      OPENED_SUBJECT.OS_ATT%TYPE
, V_TB_CODE     IN      TEXTBOOK.TB_CODE%TYPE
, V_PROF_ID     IN      PROFESSOR.PROF_ID%TYPE
, V_SUB_CODE    IN      SUBJECT_NAME.SUB_CODE%TYPE
, V_OC_CODE     IN      OPENED_COURSE.OC_CODE%TYPE
)
IS

--�����ڵ�� ������ ���� ����
    TB_CODE_CHECK TEXTBOOK.TB_CODE%TYPE;
--����ID�� ������ ���� ����
    PROF_ID_CHECK PROFESSOR.PROF_ID%TYPE;
--�����ڵ�� ������ ���� ����
    SUB_CODE_CHECK SUBJECT_NAME.SUB_CODE%TYPE;
--���������ڵ� ������ ���� ����
    OC_CODE_CHECK  OPENED_COURSE.OC_CODE%TYPE;
--���������ڵ� ������ ���� ����
    OS_CODE_CHECK  OPENED_SUBJECT.OS_CODE%TYPE;
    
    
--���� �߻� ����
--�� ���������ڵ尡 ��ġ���� ���� ��� �߻���ų ����(PL/SQL���������� ����Ǿ����ϴ�. ��Ƴ������� ó��)
    USER_DEFINE_ERROR EXCEPTION;

--������� ������ 100���� ��ġ�� ���� ���
    USER_DEFINE_ERROR1 EXCEPTION;
--�谳����¥�� ��ĥ ���(���� �ִ� ������)
    USER_DEFINE_ERROR2 EXCEPTION;    
--�鰳�������� �Ⱓ�� ���������� �Ⱓ�� ���� ���� ���
    USER_DEFINE_ERROR3 EXCEPTION;

--�� �����ڵ尡 �������� ���� ��� �߻���ų ����
     USER_DEFINE_ERROR4 EXCEPTION;
--�� ����ID�� �������� ���� ��� �߻���ų ����
     USER_DEFINE_ERROR5 EXCEPTION;
--�� �����ڵ尡 �������� ���� ��� �߻���ų ���� 
     USER_DEFINE_ERROR6 EXCEPTION;
--�� ���������ڵ� �������� ���� ��� �߻���ų ����
     USER_DEFINE_ERROR7 EXCEPTION;
     
    OC_START    DATE;   --���� ���� ������ ���� ���� 
    OC_END      DATE;   --���� ���� ������ ���� ����
    
    EX_START    DATE;   --���� ���� ������
    EX_END      DATE;   --���� ���� ������
    
    CURSOR CUR_DATE_CHECK
    IS
    SELECT OS_START,OS_END
    FROM OPENED_SUBJECT
    WHERE OC_CODE = V_OC_CODE;
BEGIN

    --������� ������ 100���� �ƴ� ��� ���� �߻�
    IF(V_OS_PT+V_OS_WT+V_OS_ATT!=100)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    


    --�谳����¥�� ��ĥ ���(���� �ִ� ������) 
    OPEN CUR_DATE_CHECK;
    LOOP   
    FETCH CUR_DATE_CHECK INTO EX_START,EX_END;
    
    EXIT WHEN CUR_DATE_CHECK%NOTFOUND;
    
    IF(V_OS_START<=EX_START AND V_OS_END>=EX_START)
        THEN RAISE USER_DEFINE_ERROR2;
    ELSIF(V_OS_START<=EX_START AND V_OS_END>=EX_END)
        THEN RAISE USER_DEFINE_ERROR2;    
    ELSIF(V_OS_START>=EX_START AND V_OS_END <=EX_END)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    END LOOP;
    CLOSE CUR_DATE_CHECK;

    --�鰳�������� �Ⱓ�� ���������� �Ⱓ�� ���� ���� ���
    SELECT OC_START, OC_END INTO OC_START,OC_END
    FROM OPENED_COURSE
    WHERE OC_CODE = V_OC_CODE;
    
    --�����ϴ� ���������� �������� �ش� ������������ ������ ���� �ռ��ų�
    --�����ϴ� ���������� �������� �ش� ������������ ������ ���� �ʴ´ٸ� ���� �߻�
    IF(V_OS_START<OC_START OR OC_END<V_OS_END)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

--������ �� ��Ƴ���
--���������ڵ�� ������ ������ �� ��Ƴ���
   SELECT NVL(MAX(OS_CODE), '0') INTO OS_CODE_CHECK
    FROM OPENED_SUBJECT
    WHERE OS_CODE =V_OS_CODE;

--�����ڵ�� ������ ������ �� ��Ƴ���
   SELECT NVL(MAX(TB_CODE), '0') INTO TB_CODE_CHECK
    FROM TEXTBOOK
    WHERE TB_CODE =V_TB_CODE;
--����ID�� ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(PROF_ID), '0') INTO PROF_ID_CHECK 
    FROM PROFESSOR
    WHERE PROF_ID =V_PROF_ID;
    
--�����ڵ��  ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(SUB_CODE), '0') INTO SUB_CODE_CHECK
    FROM SUBJECT_NAME
    WHERE SUB_CODE =V_SUB_CODE;
--���������ڵ� ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(OC_CODE), '0') INTO OC_CODE_CHECK 
    FROM OPENED_COURSE
    WHERE OC_CODE =V_OC_CODE;
    
    
--�� �����ڵ尡 �������� ���� ��� �߻���ų ����
    IF (TB_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR4; 
    END IF;
--�� ����ID�� �������� ���� ��� �߻���ų ����
    IF (PROF_ID_CHECK ='0')
        THEN RAISE USER_DEFINE_ERROR5; 
    END IF;
--�� �����ڵ尡 �������� ���� ��� �߻���ų ���� 
    IF (SUB_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR6; 
    END IF;
--�� ���������ڵ� �������� ���� ��� �߻���ų ����
    IF (OC_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR7; 
    END IF;
--�� ���������ڵ尡 �������� ���� ��� �߻���ų ����
    IF (OS_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;  
--����üũ �������Ƿ�, ������Ʈ ���� ����
    UPDATE OPENED_SUBJECT
    SET OS_START = V_OS_START , OS_END= V_OS_END, OS_DATE=V_OS_DATE, OS_PT=V_OS_PT
    , OS_WT=V_OS_WT,OS_ATT=V_OS_ATT, TB_CODE=V_TB_CODE, PROF_ID=V_PROF_ID, SUB_CODE=V_SUB_CODE, OC_CODE =V_OC_CODE
    WHERE OS_CODE = V_OS_CODE;

   EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20709, '������ ������ 100���� �ƴմϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20710, '������ ������ ��¥�� ���� �����Ҽ� �����ϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20711, '���������� �Ⱓ�� ���������� �Ⱓ�� ���ԵǾ�� �մϴ�~!!!');
    
     WHEN USER_DEFINE_ERROR4
    THEN RAISE_APPLICATION_ERROR(-20712, '�ش� �����ڵ尡 �������� �ʽ��ϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR5
    THEN RAISE_APPLICATION_ERROR(-20713, '�ش� ����ID�� �������� �ʽ��ϴ�~!!!');
    
    WHEN USER_DEFINE_ERROR6
    THEN RAISE_APPLICATION_ERROR(-20714, '�ش� �����ڵ尡 �������� �ʽ��ϴ�~!!!');   
    
    WHEN USER_DEFINE_ERROR7
    THEN RAISE_APPLICATION_ERROR(-20715, '�ش� ���������ڵ尡 �������� �ʽ��ϴ�~!!!'); 
    
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20716, '�ش� ���������ڵ尡 �������� �ʽ��ϴ�~!!!'); 
    
    WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
END;


 

--------------------------------------------------------------------------------
--7.�������� ���� PRC_OPSUB_DELETE  (Ʈ���� Ȱ��)
-- ���� ����� �����ִ� ������ ���� �ȵǰ� �����ؾ���.
-- �Ű������� �޾ƿ;��Ұ�? 
CREATE OR REPLACE PROCEDURE PRC_OPSUB_DELETE
( V_OS_CODE     IN      OPENED_SUBJECT.OS_CODE%TYPE
)
IS
    --�Ű������� ���������ڵ带 ������ ���� 
    OS_CODE_CHECK   OPENED_SUBJECT.OS_CODE%TYPE;
    --��ġ���� ������ ���� �߻�
    USER_DEFINE_ERROR EXCEPTION;
BEGIN   
        SELECT NVL(MAX(OS_CODE), '0') INTO OS_CODE_CHECK
        FROM OPENED_SUBJECT
        WHERE OS_CODE =V_OS_CODE;
        
        IF (OS_CODE_CHECK='0')
            THEN RAISE USER_DEFINE_ERROR; 
        END IF;
        
        DELETE
        FROM OPENED_SUBJECT
        WHERE OS_CODE = V_OS_CODE;
        
        EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20717, '�ش� ���������ڵ尡 �������� �ʽ��ϴ�~!!!'); 
END;

--8.�������� ������ ���� Ʈ���� ����
--�ڽ� ���̺��� �����͸� ����� �;� �ϱ⿡ BEFORE ROW TRIGGER
--������ �����Ͱ� ������ �������� �����ϸ� �ȵǱ⿡ DROP��Ŵ.
CREATE OR REPLACE TRIGGER TRG_OPSUB_DELETE
        BEFORE
        DELETE ON OPENED_SUBJECT
        FOR EACH ROW
BEGIN
    DELETE
    FROM GRADE
    WHERE OS_CODE = :OLD.OS_CODE;
END;

DROP TRIGGER TRG_OPSUB_DELETE;


--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--������û ���
--PRC_APP_INSERT(�����ڵ�,�л�ID)
CREATE OR REPLACE PROCEDURE PRC_APP_INSERT
( V_APP_DATE        IN APP.APP_DATE%TYPE
, V_STU_ID          IN STUDENT.STU_ID%TYPE
, V_OC_CODE         IN OPENED_COURSE.OC_CODE%TYPE
)
IS
        V_APP_CODE      APP.APP_CODE%TYPE;
        ID_CHECK        NUMBER;
        OC_CHECK        NUMBER;
        START_CHECK     OPENED_COURSE.OC_START%TYPE;
        APP_CHECK       NUMBER;
        
        USER_DEFINE_ERROR1   EXCEPTION;
        USER_DEFINE_ERROR2   EXCEPTION;
        USER_DEFINE_ERROR3   EXCEPTION;
BEGIN
        -- �ش� �л��� �ִ��� Ȯ��
        SELECT COUNT(*)     INTO ID_CHECK
        FROM STUDENT
        WHERE STU_ID = V_STU_ID;
        -- �ش� �л��� �������� �ʴٸ� ���� �߻�
        IF(ID_CHECK = 0)
            THEN RAISE USER_DEFINE_ERROR1;
        END IF;
        
        -- �ش� ������ �ִ��� Ȯ��
        SELECT COUNT(*)     INTO OC_CHECK
        FROM OPENED_COURSE
        WHERE OC_CODE = V_OC_CODE;
        -- �ش� ������ �������� �ʴٸ� ���� �߻�
        IF(OC_CHECK = 0)
            THEN RAISE USER_DEFINE_ERROR1;
        END IF;
        
        -- ������û�� ������ ��¥���� Ȯ��
        SELECT OC_START     INTO START_CHECK
        FROM OPENED_COURSE
        WHERE OC_CODE = V_OC_CODE;
        -- �̹� ������ ���
        IF(V_APP_DATE > START_CHECK)
            THEN RAISE USER_DEFINE_ERROR2;
        END IF;
        
        --�̹� ������û�� ���
        SELECT COUNT(*)     INTO APP_CHECK
        FROM APP
        WHERE STU_ID = V_STU_ID;
        
        IF(APP_CHECK != 0)
            THEN RAISE USER_DEFINE_ERROR3;
        END IF;
            
        INSERT INTO APP(APP_CODE, APP_DATE, STU_ID,OC_CODE)VALUES(('AP'||LPAD(TO_CHAR(SEQ_APP.NEXTVAL),4,'0')),V_APP_DATE,V_STU_ID,V_OC_CODE);
              
        EXCEPTION
            WHEN USER_DEFINE_ERROR1
                THEN RAISE_APPLICATION_ERROR(-20202,'�ش� �л��̳� ������ ã�� �� �����ϴ�.');
                     ROLLBACK;
            WHEN USER_DEFINE_ERROR2
                THEN RAISE_APPLICATION_ERROR(-20203,'������û���� �ƴմϴ�.');
                     ROLLBACK;
            WHEN USER_DEFINE_ERROR3
                THEN RAISE_APPLICATION_ERROR(-20204,'�̹� ������û�� �����Դϴ�.');
                     ROLLBACK;
            WHEN OTHERS 
                THEN ROLLBACK;
        COMMIT;
END;
--==>> Procedure PRC_APP_INSERT��(��) �����ϵǾ����ϴ�.

-----------------------------------------------------------------------------------------------------------
-- 1. ���� �Է� PRC_GRADE_INSERT(���, �ʱ�, �Ǳ�, ���������ڵ�, ������û�ڵ�) �۵�Ȯ��
-- EXEC PRC_GRADE_INSERT(���, �ʱ�, �Ǳ�, ���������ڵ�, ������û�ڵ�);
CREATE OR REPLACE PROCEDURE PRC_GRADE_INSERT
( V_GRADE_ATT           IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT            IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT            IN GRADE.GRADE_PT%TYPE
, V_OS_CODE             IN GRADE.OS_CODE%TYPE 
, V_APP_CODE            IN GRADE.APP_CODE%TYPE
)
IS
    V_GRADE_CODE    GRADE.GRADE_CODE%TYPE;
    V_GRADE_DATE    GRADE.GRADE_DATE%TYPE := SYSDATE;
    

    V_OS_END            OPENED_SUBJECT.OS_END%TYPE;          -- �������� ������       
    V_FAPP_ID           GRADE.APP_CODE%TYPE;                -- ������û�ڵ� �ߺ��˻�   
    V_FOP_SUB           GRADE.OS_CODE%TYPE;                 -- ���������ڵ� �ߺ��˻�
    V_MID_DROP          NUMBER;                            -- �ߵ����� 
    
    
    MID_DROP_STU_ERROR EXCEPTION;                   -- �ߵ����⿡��  
    APP_OVERLAP_ERROR EXCEPTION;                    -- ������û�ڵ� �ߺ��� ���� 
    GRADE_DATE_ERROR   EXCEPTION;                  -- �������� �����߿� �����Է�X ����

    CURSOR CUR_CHECK_APP
    IS 
    SELECT APP_CODE, OS_CODE
    FROM GRADE
    WHERE APP_CODE = V_APP_CODE; 
    
BEGIN

    V_GRADE_CODE :=('GR'||TO_CHAR(SEQ_GRADE.NEXTVAL));
    
    
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
    
    IF (V_MID_DROP > 0)
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

    INSERT INTO GRADE(GRADE_CODE, GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE)
    VALUES(V_GRADE_CODE, V_GRADE_DATE, V_GRADE_ATT, V_GRADE_WT, V_GRADE_PT, V_OS_CODE, V_APP_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20603, '�����Է±Ⱓ�� �ƴմϴ�');
                ROLLBACK;

         WHEN OTHERS
            THEN ROLLBACK;
    
END;

--==>> Procedure PRC_GRADE_INSERT��(��) �����ϵǾ����ϴ�.





-- 2. ���� ���� PRC_SCORE_UPDATE(�����ڵ�, ���, �ʱ�, �Ǳ�)  �۵�Ȯ��
-- EXEC PRC_SCORE_UPDATE(�����ڵ�, ���, �ʱ�, �Ǳ�); 
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

---------------------------------------------------------------------------
-- 3. ���� ���� PRC_GRADE_DELETE(���� �ڵ�) -- �۵�Ȯ��
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


-------------------------------------------------------------------------------------
--�ߵ�Ż�� �Է�
CREATE OR REPLACE PROCEDURE PRC_QUITLIST_INSERT
( V_QUIT_DATE    IN QUITLIST.QUIT_DATE%TYPE
, V_APP_CODE     IN QUITLIST.APP_CODE%TYPE
, V_QR_CODE      IN QUIT_REASON.QR_CODE%TYPE

)
IS  
    V_QUIT_CODE   QUITLIST.QUIT_CODE%TYPE;   -- �ߵ����� �ڵ� 
    
    V_START_DATE   OPENED_COURSE.OC_START%TYPE; -- ���� ������ ���
    V_END_DATE     OPENED_COURSE.OC_END%TYPE;   -- ���� ������ ���
    
    USER_DEFINE_ERROR1 EXCEPTION;              -- �ߵ��������� �����Ⱓ �ȿ� ������ ����
    USER_DEFINE_ERROR2 EXCEPTION;              -- �̹� �ߵ������� �л��̸� ���� �߻�
    
    CHECK_APP_CODE   QUITLIST.APP_CODE%TYPE;
BEGIN

    SELECT NVL(MAX(APP_CODE),'0') INTO CHECK_APP_CODE
    FROM QUITLIST
    WHERE APP_CODE = V_APP_CODE;
    
    
    IF (CHECK_APP_CODE != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    SELECT OC_START, OC_END INTO V_START_DATE, V_END_DATE
    FROM OPENED_COURSE
    WHERE OC_CODE = (SELECT OC_CODE
                          FROM APP
                          WHERE APP_CODE = V_APP_CODE);
    
    IF (V_QUIT_DATE NOT BETWEEN V_START_DATE AND V_END_DATE) 
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    
    
    INSERT INTO QUITLIST(QUIT_CODE, QUIT_DATE, APP_CODE, QR_CODE)
         VALUES('Q' || LPAD(TO_CHAR(QUITLIST_SEQ.NEXTVAL), 5, '0'),V_QUIT_DATE, V_APP_CODE, V_QR_CODE);
          
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
        THEN RAISE_APPLICATION_ERROR(-20770, '���� �Ⱓ�Ͽ� ���Ե��� �ʽ��ϴ�~!!!');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20771, '�̹� �ߵ������� �л��Դϴ�~!!!');
        ROLLBACK;
    COMMIT;
END;

-------------------------------------------------------------------------------------------------
--�θ����̺� ������
---------------------------------------------------------------------------------------------------------
--������  ���̺� ������ �Է�
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('janghs','java006$','������');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('usy1234','java007$','���ҿ�');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('kbk987','java008$','�躸��');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('jhh3579','java009$','������');

--==>>1 �� ��(��) ���ԵǾ����ϴ�.*4
SELECT *
FROM ADMIN;
---------------------------------------------------------------------------------------------------
--������ ���̺� ������ �Է�

SELECT *
FROM PROFESSOR;


EXEC  PRC_PROFESSOR_INSERT('1045987','ȣ����',TO_DATE('2000-01-01','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('2024123','�ڼ���',TO_DATE('2005-02-03','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('1011325','������',TO_DATE('1997-02-04','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('1021728','��',TO_DATE('2013-05-07','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('2051421','������',TO_DATE('2015-12-25','YYYY-MM-DD'));
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.*5

/*
20220011	1045987	ȣ����	2000-01-01
20220012	2024123	�ڼ���	2005-02-03
20220013	1011325	������	1997-02-04
20220014	1021728	��	2013-05-07
20220015	2051421	������	2015-12-25
*/


---------------------------------------------------------------------------------------------
--�л� ���̺� ������
SELECT *
FROM STUDENT;
EXEC PRC_STUDENT_INSERT('2234567','���α�' ,TO_DATE('2022-01-01', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1234567','������' ,TO_DATE('2021-02-02', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1035798','������' ,TO_DATE('2020-05-07', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1032599','���¹�' ,TO_DATE('2021-12-05', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1057239','������' ,TO_DATE('2020-11-28', 'YYYY-MM-DD'));
--==>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.*5
/*
20220002	2234567	���α�	2022-01-01
20220003	1234567	������	2021-02-02
20220004	1035798	������	2020-05-07
20220005	1032599	���¹�	2021-12-05
20220006	1057239	������	2020-11-28
*/

---------------------------------------------------------------------------------------------
SELECT *
FROM SUBJECT_NAME;
--���� ���̺� ������
EXEC PRC_SUBJECT_INSERT('J001','JAVA');
EXEC PRC_SUBJECT_INSERT('S001','SPRING');
EXEC PRC_SUBJECT_INSERT('JS001','JavaScript');
EXEC PRC_SUBJECT_INSERT('O001','ORACLE');
EXEC PRC_SUBJECT_INSERT('H001','HTML');
/*
J001	JAVA
S001	SPRING
JS001	JavaScript
O001	ORACLE
H001	HTML
*/

SELECT *
FROM TEXTBOOK;
--���� ���̺� ������
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA001','�ڹ�������','��������');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING001','������ �����ӿ�ũ ù����','��Ű�Ͻ�');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JS001','DO it! �ڹٽ�ũ��Ʈ','�л�̵��');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('ORACLE001','����Ŭ SQL','��Ű�Ͻ�');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('HTML001','HTML���̵��','��Ű�Ͻ�');

SELECT *
FROM QUIT_REASON;
--�ߵ�Ż������ ���̺� ������
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A001', '���� ����');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A002', '���� ���');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A003', '���� ����');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A004', '���� ����');

COMMIT;
------------------------------------------------------------------------------------------------------------------------


SELECT *
FROM CLASSROOM;
--���� ���̺� ������
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C001','������ ������ �缺����(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C002','������ ������ �缺����(B)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('F001','Full-Stack ������ �缺 ����(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S001','SW ������ �缺����(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S002','SW ������ �缺����(B)');

--���ǽ� ���̺� ������
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL001','AŬ����',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL002','BŬ����',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL003','CŬ����',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL004','DŬ����',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL005','EŬ����',20);


--���� ���̺� INSERT 
EXEC PRC_COURSE_INSERT('C001','������ ������ �缺����(A)');
EXEC PRC_COURSE_INSERT('C002','������ ������ �缺����(B)');
EXEC PRC_COURSE_INSERT('F001','Full-Stack ������ �缺 ����(A)');
EXEC PRC_COURSE_INSERT('S001','SW ������ �缺����(A)');
EXEC PRC_COURSE_INSERT('S002','SW ������ �缺����(B)');

-- ���� ���̺� ��ȸ
SELECT *
FROM COURSE;
--==>>
/*
C001   ������ ������ �缺����(A)
C002   ������ ������ �缺����(B)
F001   Full-Stack ������ �缺 ����(A)
S001   SW ������ �缺����(A)
S002   SW ������ �缺����(B)
*/
--=========================================================================================================
--�ڽ����̺� ������
-----------------------------------------------------------------------------------------------------------
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL003' ,'F001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL004' ,'S001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-01-25', 'YYYY-MM-DD'),'CL005' ,'S001');

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC2	2022-05-27	2022-12-15	CL001	C002   ������ ������ �缺����(B) 
OCF3	2022-09-29	2023-03-25	CL003	F001   Full-Stack ������ �缺 ����(A)
OCS4	2022-09-14	2023-03-25	CL004	S001   SW ������ �缺����(A)
OCS5	2022-09-14	2023-01-25	CL005	S002   SW ������ �缺����(B)
*/

-- ���ν��� ȣ���� ���� ���� ���̺� INSERT
EXEC PRC_COURSE_INSERT('C001','������ ������ �缺����(A)');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- �ߺ� ������ INSERT 
EXEC PRC_COURSE_INSERT('C001','������ ������ �缺����(A)');
--==>> ORA-20500: �̹� ��ϵ� ����

-- ���ν��� ���� �� ���� ���̺� ��ȸ
SELECT *
FROM COURSE;
--==>> C001   ������ ������ �缺����(A)

-- ���ν��� ȣ���� ���� ���� ���̺� UPDATE
EXEC PRC_COURSE_UPDATE('C001', 'Full-Stack ������ �缺 ����(A)');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- �����ڵ� ���� ������ UPDATE
EXEC PRC_COURSE_UPDATE('C003', 'Full-Stack ������ �缺 ����(A)');
--==>> ORA-20501: �������� �ʴ� �����̹Ƿ� ���� �Ұ���

-- ���ν��� ���� �� ���� ���̺� ��ȸ
SELECT *
FROM COURSE;
--==> C001   Full-Stack ������ �缺 ����(A)

-- ���ν��� ȣ���� ���� ���� ���̺� DELETE
EXEC PRC_COURSE_DELETE('C001');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- �����ڵ� ���� ������ DELETE
EXEC PRC_COURSE_DELETE('C003');
--==>> ORA-20502: �������� �ʴ� �����̹Ƿ� ���� �Ұ���

-- ���ν��� ���� �� ���� ���̺� ��ȸ
SELECT *
FROM COURSE;
--==> ��ȸ ��� ����

-- �׽�Ʈ�� ���� ���� ���̺� INSERT 
EXEC PRC_COURSE_INSERT('C001','������ ������ �缺����(A)');
EXEC PRC_COURSE_INSERT('C002','������ ������ �缺����(B)');
EXEC PRC_COURSE_INSERT('F001','Full-Stack ������ �缺 ����(A)');
EXEC PRC_COURSE_INSERT('S001','SW ������ �缺����(A)');
EXEC PRC_COURSE_INSERT('S002','SW ������ �缺����(B)');

-- ���� ���̺� ��ȸ
SELECT *
FROM COURSE;
--==>>
/*
C001   ������ ������ �缺����(A)
C002   ������ ������ �缺����(B)
F001   Full-Stack ������ �缺 ����(A)
S001   SW ������ �缺����(A)
S002   SW ������ �缺����(B)
*/

-- ���� ��� ��
SELECT *
FROM VIEW_COURSE;

-- ���ν��� ȣ���� ���� �������� ���̺� INSERT
-- ���� ���� INSERT
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C001');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- ���� ���� INSERT �������� �ʴ� ���ǽ�
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'C0002' ,'C001');
--==>> ORA-20505: ���ǽ��� �������� ����

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- ���� ���� INSERT �������� �ʴ� �����ڵ�
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C003');
--==>> ORA-20503: ������ �������� ����

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- ���� ���� INSERT �������� ������ ���� ������ ���
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C001');
--==>> ORA-20504: ���������� �� ������ ����

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- �׽�Ʈ�� ���� ���� ���� ���̺� INSERT 
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL003' ,'F001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL004' ,'S001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-01-25', 'YYYY-MM-DD'),'CL003' ,'S001');

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/08/15   2023/02/17   CL002   C001
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ���ν��� ȣ���� ���� �������� ���̺� UPDATE
-- ���� ���� UPDATE (������ ����)
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-16', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/05/27   2022/12/16   CL001   C002

-- �������� �ڵ尡 �������� ���� �� UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC3', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> ORA-20506: �������� �ʴ� ���������̹Ƿ� ���� �Ұ���

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/05/27   2022/12/15   CL001   C002
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ���� �ڵ尡 �������� ���� �� UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C015');
--==>> ORA-20507: ������ �������� �ʾ� ���� �Ұ���

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/05/27   2022/12/15   CL001   C002
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ������������ ���������� ���� ������ �� UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2021-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> ORA-20508: ���������� �� ������ ������ ���� �Ұ���

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/05/27   2022/12/15   CL001   C002
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ���ǽ� ��尡 �������� ���� �� UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CR001' ,'C002');
EXEC PRC_OPENED_COURSE_UPDATE('OCS5',TO_DATE('2022-09-14','YYYY-MM-DD'),TO_DATE('2023-01-25','YYYY-MM-DD'),'CL005','S002')

--==>> ORA-20509: ���ǽ��� �������� �ʾ� ���� �Ұ���

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/05/27   2022/12/15   CL001   C002
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ���ν��� ȣ���� ���� �������� ���̺� DELETE
-- �����ϴ� ���������� ���� ��
EXEC PRC_OPENED_COURSE_DELETE('OCC3');
--==>> ORA-20510: �������� �ʴ� �����̹Ƿ� ���� �Ұ���

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC1   2022/05/27   2022/12/15   CL001   C002
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/

-- ���� ���� DELETE
EXEC PRC_OPENED_COURSE_DELETE('OCC1');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� ���� ���̺� ��ȸ
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC2   2022/05/27   2022/12/15   CL001   C002
OCF3   2022/09/29   2023/03/25   CL003   F001
OCS4   2022/09/14   2023/03/25   CL004   S001
OCS5   2022/09/14   2023/01/25   CL003   S001
*/


--=========================================================================================================
--�������� ������ �־�� ���� �ֵ�
------------------------------------------------------------------------------------------------------------
--�������� ������
--EXEC PRC_OPSUB_INSERT
--(���������,����������,������¥,�Ǳ����,�ʱ����,������,�����ڵ�,����ID,�����ڵ�,���������ڵ�)

/*
JAVA001	    �ڹ�������	��������
SPRING001	������ �����ӿ�ũ ù����	��Ű�Ͻ�
JS001	    DO it! �ڹٽ�ũ��Ʈ	�л�̵��
ORACLE001	����Ŭ SQL	��Ű�Ͻ�
HTML001	    HTML���̵��	��Ű�Ͻ�
*/
/*
����ID
20220011	1045987	ȣ����	2000-01-01
20220012	2024123	�ڼ���	2005-02-03
20220013	1011325	������	1997-02-04
20220014	1021728	��	2013-05-07
20220015	2051421	������	2015-12-25
*/
/*
�����ڵ�
J001	JAVA
S001	SPRING
JS001	JavaScript
O001	ORACLE
H001	HTML
*/
/*
���������ڵ�
OCC2	2022-05-27	2022-12-15	CL001	C002   ������ ������ �缺����(B) 
OCF3	2022-09-29	2023-03-25	CL003	F001   Full-Stack ������ �缺 ����(A)
OCS4	2022-09-14	2023-03-25	CL004	S001   SW ������ �缺����(A)
OCS5	2022-09-14	2023-01-25	CL005	S002   SW ������ �缺����(B)
*/
SELECT *
FROM OPENED_COURSE;
SELECT *
FROM OPENED_SUBJECT;

EXEC PRC_OPSUB_INSERT(TO_DATE('2022-05-27', 'YYYY-MM-DD'),TO_DATE('2022-06-28', 'YYYY-MM-DD'),TO_DATE('2022-05-25', 'YYYY-MM-DD'),50,40,10,'JAVA001','20220011','J001','OCC2');
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-06-29', 'YYYY-MM-DD'),TO_DATE('2022-07-30', 'YYYY-MM-DD'),TO_DATE('2022-05-25', 'YYYY-MM-DD'),40,40,20,'SPRING001','20220011','S001','OCC2');
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-08-01', 'YYYY-MM-DD'),TO_DATE('2022-10-01', 'YYYY-MM-DD'),TO_DATE('2022-05-25', 'YYYY-MM-DD'),30,50,20,'ORACLE001','20220011','O001','OCC2');
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-10-02', 'YYYY-MM-DD'),TO_DATE('2022-11-01', 'YYYY-MM-DD'),TO_DATE('2022-05-25', 'YYYY-MM-DD'),40,40,20,'JS001','20220011','JS001','OCC2');
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-11-02', 'YYYY-MM-DD'),TO_DATE('2022-12-14', 'YYYY-MM-DD'),TO_DATE('2022-05-25', 'YYYY-MM-DD'),40,40,20,'HTML001','20220011','H001','OCC2');
/*
OSJ12	2022-05-27	2022-06-28	2022-05-25	50	40	10	JAVA001	    20220011	J001	OCC2
OSS13	2022-06-29	2022-07-30	2022-05-25	40	40	20	SPRING001	20220011	S001	OCC2
OSO14	2022-08-01	2022-10-01	2022-05-25	30	50	20	ORACLE001	20220011	O001	OCC2
OSJ15	2022-10-02	2022-11-01	2022-05-25	40	40	20	JS001	    20220011	JS001	OCC2
OSH16	2022-11-02	2022-12-14	2022-05-25	40	40	20	HTML001	    20220011	H001	OCC2
*/
COMMIT;

--OPENED_SUBJECT 
INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE,PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS001',TO_DATE('2022-08-15','YYYY-MM-DD'),TO_DATE('2022-09-25','YYYY-MM-DD')
,TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');

SELECT *
FROM OPENED_SUBJECT;

SELECT *
FROM APP;

INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G301', SYSDATE, '20171305', 'H1');

-------------------------------------------------------------------------------------------------------
SELECT *
FROM APP;
EXEC PRC_APP_INSERT(TO_DATE('2022-05-01','YYYY-MM-DD'),'20220007','OCC2');
EXEC PRC_APP_INSERT(TO_DATE('2022-05-02','YYYY-MM-DD'),'20220008','OCC2');
EXEC PRC_APP_INSERT(TO_DATE('2022-05-15','YYYY-MM-DD'),'20220009','OCC2');
EXEC PRC_APP_INSERT(TO_DATE('2022-04-28','YYYY-MM-DD'),'20220010','OCC2');
--===>>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.*4

EXEC PRC_APP_INSERT(TO_DATE('2022-05-31','YYYY-MM-DD'),'20220011','OCC2');
--==>>ORA-20203: ������û���� �ƴմϴ�.






INSERT INTO GRADE(GRADE_CODE,GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE) VALUES('A00001',DEFAULT,90,80,75,'OSJ1','G301');

EXEC PRC_STUDENT_INSERT('�л��̸�,PW(�ֹι�ȣ ���ڸ�)'); 

--(���������,����������,������¥,�Ǳ����,�ʱ����,������,�����ڵ�,����ID,�����ڵ�,���������ڵ�)
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-08-15','YYYY-MM-DD'),TO_DATE('2022-09-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');

EXEC PRC_OPSUB_UPDATE('OSJ1',TO_DATE('2022-09-26','YYYY-MM-DD'),TO_DATE('2022-10-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');
--���� �ذ�
EXEC PRC_OPSUB_DELETE('OSJ1');

-----------------------------------------------------------------------------------------------------------------------
--���� ������ �Է�
EXEC PRC_GRADE_INSERT(TO_DATE('2023-09-26','YYYY-MM-DD'),90,90,90,'OSJ12','AP0001');

-----------------------------------------------------------------------------------------------------------------------




--���� ��ȸ ��
--������ /���ǽ�/ �����/���� �Ⱓ /���� ��/ �����ڸ�
CREATE OR REPLACE VIEW VIEW_SUBJECT
AS
SELECT CO.COURSE_NAME "������"
    , CR.CR_NAME "���ǽ�"
    , SN.SUB_NAME "�����"
    , OS.OS_START || '~' || OS.OS_END "����Ⱓ"
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
SELECT *
FROM VIEW_STUDENTS;
SELECT *
FROM VIEW_STUDENT_GRADE;
--------------------------------------------------------------------------------------------------------------------------------
-- ������ �л� ���� ��� ����
-- �л� �̸�, ������, ��������, �������� ����, �ߵ�Ż������
CREATE OR REPLACE VIEW VIEW_STUDENTS
AS
SELECT ST.STU_NAME"�л���",CO.COURSE_NAME"������",SN.SUB_NAME"��������"
     , (NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100) + (NVL(GR.GRADE_WT,0)*OS.OS_WT/100) + (NVL(GR.GRADE_PT,0)*OS.OS_PT/100)"������������"
     , (CASE WHEN AP.APP_CODE =  QL.APP_CODE THEN '�ߵ�Ż��' ELSE' ' END)"�ߵ�Ż������"
FROM STUDENT ST JOIN APP AP --�л� ��
ON ST.STU_ID = AP.STU_ID    
    JOIN OPENED_COURSE OC
    ON AP.OC_CODE = OC.OC_CODE      -- �� ��������
        JOIN COURSE CO
        ON OC.COURSE_CODE = CO.COURSE_CODE
            JOIN OPENED_SUBJECT OS
            ON  OC.OC_CODE = OS.OC_CODE
                JOIN SUBJECT_NAME SN
                ON OS.SUB_CODE = SN.SUB_CODE
                    JOIN GRADE GR
                    ON OS.OS_CODE = GR.OS_CODE AND GR.APP_CODE = AP.APP_CODE
                        LEFT JOIN QUITLIST QL
                        ON AP.APP_CODE =QL.APP_CODE
ORDER BY 1,3;
----------------------------------------------------------------------------------------------------------------------
-- ����� �� �䱸�м�(�л�)
-- ��� ������ �л� �̸�, ������, �����, ���� �Ⱓ(���� ������, �� ������), ���� ��, 
-- ���, �Ǳ�, �ʱ�, ����, ����� ��µǾ�� �Ѵ�. 
CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE
AS
SELECT T.�л��̸�, T.������, T.�����, T.������, T.������, T.�����, T.���, T.�Ǳ�, T.�ʱ�, T.����
     , RANK()OVER(PARTITION BY T.���������ڵ� ORDER BY T.���� DESC)"���"
FROM
(
SELECT ST.STU_NAME"�л��̸�",CO.COURSE_NAME"������",SN.SUB_NAME"�����",OS.OS_START"������",OS.OS_END"������",TB.TB_NAME"�����"
,(NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100)"���"
,(NVL(GR.GRADE_PT,0)*OS.OS_PT/100)"�Ǳ�"
,(NVL(GR.GRADE_WT,0)*OS.OS_WT/100)"�ʱ�"
, (NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100) + (NVL(GR.GRADE_PT,0)*OS.OS_PT/100) + (NVL(GR.GRADE_WT,0)*OS.OS_WT/100) "����"
,OS.OS_CODE"���������ڵ�"
FROM STUDENT ST JOIN APP AP
ON ST.STU_ID = AP.STU_ID 
    JOIN OPENED_COURSE OC
    ON AP.OC_CODE = OC.OC_CODE
        JOIN COURSE CO
        ON OC.COURSE_CODE = CO.COURSE_CODE
            JOIN OPENED_SUBJECT OS
            ON OC.OC_CODE = OS.OC_CODE
                JOIN SUBJECT_NAME SN
                ON OS.SUB_CODE = SN.SUB_CODE
                    JOIN GRADE GR��
                    ON OS.OS_CODE = GR.OS_CODE AND GR.APP_CODE = AP.APP_CODE
                        JOIN TEXTBOOK TB
                        ON OS.TB_CODE = TB.TB_CODE
) T;

----------------------------------------------------------------------------------------
-- �������� ���� ��� -----------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_COURSE
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

--------------------------------------------------------------------------------
