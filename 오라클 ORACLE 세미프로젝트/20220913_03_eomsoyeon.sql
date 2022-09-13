SELECT USER
FROM DUAL;
--==>>EOMSOYEON

SELECT *
FROM TAB;

--1. ������ ���̺� 
--[������ID - PK]
CREATE TABLE ADMIN                                             
( AD_ID   VARCHAR2(20)                                           -- ������ID 
, AD_PW   VARCHAR2(20)      NOT NULL                            -- ��й�ȣ
, AD_NAME   VARCHAR2(30)                                        -- �����ڸ�
, CONSTRAINT ADMIN_AD_ID_PK PRIMARY KEY(AD_ID)                  -- PK �������� �߰�
);

 -- 2. ������ ���̺�(�������� ���̺��� �θ�)
 --[����ID - PK]
CREATE TABLE PROFESSOR                      -- ������ ���̺�
( PROF_ID       VARCHAR2(20)                -- ����ID
, PROF_PW       CHAR(7)         NOT NULL    -- ��й�ȣ
, PROF_NAME     VARCHAR2(30)    NOT NULL    -- ������
, PROF_DATE     DATE            NOT NULL    -- ��ϳ�¥
, CONSTRAINT PROFESSOR_PROF_ID_PK PRIMARY KEY(PROF_ID)
);

-- 3. �л� ���̺� (������û ���̺��� �θ�)
-- ���л�ID, ��й�ȣ, �л��̸�, ��ϳ�¥
CREATE TABLE STUDENT
( STU_ID       VARCHAR2(20)                             -- �л�ID
, STU_PW       CHAR(7)                  NOT NULL             -- ��й�ȣ
, STU_NAME     VARCHAR2(30)             NOT NULL             -- �л��̸�
, STU_DATE     DATE    DEFAULT SYSDATE                       -- DEFAULT ?
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);


-- 4. ���� ���̺� (�������� ���̺��� �θ�)
-- [�����ڵ�-PK]
CREATE TABLE COURSE 
( COURSE_CODE   VARCHAR2(10)                    --�����ڵ�
, COURSE_NAME   VARCHAR2(40)      NOT NULL     --�����̸�
, CONSTRAINT COURSE_COURSE_CODE_PK PRIMARY KEY(COURSE_CODE)
);


-- 5. ���ǽ� ���̺� (�������� ���̺��� �θ�)
-- [���ǽ��ڵ�-PK]
CREATE TABLE CLASSROOM
( CR_CODE       VARCHAR2(10)                     --���ǽ��ڵ�
, CR_NAME    VARCHAR2(10)         NOT NULL      --���ǽǸ�
, CR_CAPACTIY   NUMBER(4)         NOT NULL      --���밡���ο�
, CONSTRAINT CLASSROOM_CR_CODE_PK PRIMARY KEY(CR_CODE)
);

COMMENT ON COLUMN CLASSROOM.CR_CODE IS 'ClassRoom_CODE';


--6. �������� ���̺� (�������� ���̺��� �θ�/ ������û ���̺��� �θ�)
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
-- ���ǽ����̺��� ���ǽ��ڵ�(CR_CODE)�� �θ�� ��� FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_CR_CODE_FK FOREIGN KEY (CR_CODE)
                              REFERENCES CLASSROOM(CR_CODE);
-- �������̺��� �����ڵ�(COURSE_CODE)�� �θ�� ��� FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_COURSE_CODEE_FK FOREIGN KEY (COURSE_CODE)
                                    REFERENCES COURSE(COURSE_CODE);


COMMENT ON COLUMN OPENED_COURSE.OC_CODE IS 'OPENEDCourse_CODE';
COMMENT ON COLUMN OPENED_COURSE.CR_CODE IS 'ClassRoom_CODE';




-- 7. ���� ���̺� (�������� ���̺��� �θ�)
CREATE TABLE SUBJECT_NAME                                       -- ����  ���̺�     
( SUB_CODE   VARCHAR2(10)                                       -- �����ڵ�
, SUB_NAME   VARCHAR2(40)      NOT NULL                         -- �����
, CONSTRAINT SUBJECT_NAME_SUB_CODE_PK PRIMARY KEY(SUB_CODE)      -- PK �������� �߰�
);

COMMENT ON COLUMN SUBJECT_NAME.SUB_CODE IS 'SUBject_CODE';




-- 8.���� ���̺�(�������� ���̺��� �θ�)
CREATE TABLE TEXTBOOK                                           -- ���� 
( TB_CODE   VARCHAR2(10)                                        -- �����ڵ�
, TB_NAME   VARCHAR2(40)      NOT NULL                          -- �����
, PUB   VARCHAR2(40)                                            -- ���ǻ�
, CONSTRAINT TEXTBOOK_TB_CODE_PK PRIMARY KEY(TB_CODE)           -- PK �������� �߰�
);

COMMENT ON COLUMN TEXTBOOK.TB_CODE IS 'TextBook_CODE';

COMMENT ON COLUMN TEXTBOOK.TB_NAME IS 'TextBook_NAME';

COMMENT ON COLUMN TEXTBOOK.PUB IS 'Publisher';



-- 9. �������� ���̺�(���� ���̺��� �θ�)
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
-- 10. ������û ���̺�(�ߵ�Ż�� ���̺��� �θ�)

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


-- 11. ���� ���̺�
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                  -- �����ڵ�
, GRADE_DATE       DATE               DEFAULT SYSDATE           -- �ʱ⳯¥
, GRADE_ATT       NUMBER(3)                                     -- ���
, GRADE_WT       NUMBER(3)                                      -- �ʱ�
, GRADE_PT       NUMBER(3)                                      -- �Ǳ�
, OS_CODE       VARCHAR2(10)       NOT NULL                     -- ���������ڵ�
, APP_CODE       VARCHAR2(10)       NOT NULL                    -- ������û�ڵ�
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



-- 12. �ߵ�Ż�� ���̺� ����
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





-- 13. �ߵ�Ż�� ���� ���̺� (�ߵ�Ż�� ���̺��� �θ�)
-- ��Ż�������ڵ�, �ߵ�Ż������
CREATE TABLE QUIT_REASON
( QR_CODE        VARCHAR2(10)   
, QUIT_REASON   VARCHAR2(40)                  NOT NULL         
, CONSTRAINT QUIT_REASON_PK PRIMARY KEY(QR_CODE)
);

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'QUITLIST';

-- ���Ѻο� �� ����� 

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

-- ���� ������ �Է�
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J001','Ŭ���� Ȱ�� �ڹ�(A)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J002','Ŭ���� Ȱ�� �ڹ�(B)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J003','Ŭ���� Ȱ�� �ڹ�(C)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('P001','���̽� ���α׷��� ����(A)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('P002','���̽� ���α׷��� ����(B)');


-- ���� ������ �Է�
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA001','�ڹ�������','��������');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA002','�ڵ��� ó���̶� with �ڹ�','��������');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('PYTHON001',' ���̽� ���α׷���','�л�̵��');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING001','������ �����ӿ�ũ ù����','��Ű�Ͻ�');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING002','������ ��Ʈ�ٽɰ��̵�','��Ű�Ͻ�');


SELECT *
FROM TEXTBOOK;

DELETE
FROM TEXTBOOK;

ROLLBACK;

COMMIT;




INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20171305, 2234567, '�躸��', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20153075, 1234567, '���¹�', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20143054, 2133567, '������', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20131001, 2234317, '���ҿ�', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20161062, 1246867, '������', TO_DATE('2022-09-08', 'YYYY-MM-DD');



INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G301', SYSDATE, '20171305', 'H1');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G302', SYSDATE, '20153075', 'H2');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G303', SYSDATE, '20143054', 'H3');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A101','20153075','H1');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A102','20161062','H2');

SELECT *
FROM APP;

DELETE
FROM APP;



-- �������ڵ�,������û�ڵ� OS_CODE, APP_CODE
EXEC PRC_GRADE_INSERT('OS002','H2',80,40,30);

EXEC PRC_GRADE_INSERT(���������ڵ�,������û�ڵ�,���,�ʱ�,�Ǳ�)





