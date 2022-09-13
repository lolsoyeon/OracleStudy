SELECT USER
FROM DUAL;
--==>>EOMSOYEON

SELECT *
FROM TAB;

--1. 관리자 테이블 
--[관리자ID - PK]
CREATE TABLE ADMIN                                             
( AD_ID   VARCHAR2(20)                                           -- 관리자ID 
, AD_PW   VARCHAR2(20)      NOT NULL                            -- 비밀번호
, AD_NAME   VARCHAR2(30)                                        -- 관리자명
, CONSTRAINT ADMIN_AD_ID_PK PRIMARY KEY(AD_ID)                  -- PK 제약조건 추가
);

 -- 2. 교수자 테이블(개설과목 테이블의 부모)
 --[교수ID - PK]
CREATE TABLE PROFESSOR                      -- 교수자 테이블
( PROF_ID       VARCHAR2(20)                -- 교수ID
, PROF_PW       CHAR(7)         NOT NULL    -- 비밀번호
, PROF_NAME     VARCHAR2(30)    NOT NULL    -- 교수명
, PROF_DATE     DATE            NOT NULL    -- 등록날짜
, CONSTRAINT PROFESSOR_PROF_ID_PK PRIMARY KEY(PROF_ID)
);

-- 3. 학생 테이블 (수강신청 테이블의 부모)
-- ⒫학생ID, 비밀번호, 학생이름, 등록날짜
CREATE TABLE STUDENT
( STU_ID       VARCHAR2(20)                             -- 학생ID
, STU_PW       CHAR(7)                  NOT NULL             -- 비밀번호
, STU_NAME     VARCHAR2(30)             NOT NULL             -- 학생이름
, STU_DATE     DATE    DEFAULT SYSDATE                       -- DEFAULT ?
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);


-- 4. 과정 테이블 (개설과정 테이블의 부모)
-- [과정코드-PK]
CREATE TABLE COURSE 
( COURSE_CODE   VARCHAR2(10)                    --과정코드
, COURSE_NAME   VARCHAR2(40)      NOT NULL     --과정이름
, CONSTRAINT COURSE_COURSE_CODE_PK PRIMARY KEY(COURSE_CODE)
);


-- 5. 강의실 테이블 (개설과정 테이블의 부모)
-- [강의실코드-PK]
CREATE TABLE CLASSROOM
( CR_CODE       VARCHAR2(10)                     --강의실코드
, CR_NAME    VARCHAR2(10)         NOT NULL      --강의실명
, CR_CAPACTIY   NUMBER(4)         NOT NULL      --수용가능인원
, CONSTRAINT CLASSROOM_CR_CODE_PK PRIMARY KEY(CR_CODE)
);

COMMENT ON COLUMN CLASSROOM.CR_CODE IS 'ClassRoom_CODE';


--6. 개설과정 테이블 (개설과목 테이블의 부모/ 수강신청 테이블의 부모)
--(개설과정코드/ 과정시작일/ 과정종료일/ 강의실코드/ 과정코드)
-- [개설과정코드-PK] / [강의실코드-FK && 과정코드-FK]
CREATE TABLE OPENED_COURSE   
( OC_CODE       VARCHAR2(10)    
, OC_START      DATE              NOT NULL
, OC_END        DATE              NOT NULL
, CR_CODE       VARCHAR2(10)      NOT NULL
, COURSE_CODE   VARCHAR2(10)      NOT NULL
, CONSTRAINT OC_OC_CODE_PK PRIMARY KEY(OC_CODE)
);

--※FK 제약조건 추가
-- 강의실테이블의 강의실코드(CR_CODE)를 부모로 삼는 FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_CR_CODE_FK FOREIGN KEY (CR_CODE)
                              REFERENCES CLASSROOM(CR_CODE);
-- 과정테이블의 과정코드(COURSE_CODE)를 부모로 삼는 FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_COURSE_CODEE_FK FOREIGN KEY (COURSE_CODE)
                                    REFERENCES COURSE(COURSE_CODE);


COMMENT ON COLUMN OPENED_COURSE.OC_CODE IS 'OPENEDCourse_CODE';
COMMENT ON COLUMN OPENED_COURSE.CR_CODE IS 'ClassRoom_CODE';




-- 7. 과목 테이블 (개설과목 테이블의 부모)
CREATE TABLE SUBJECT_NAME                                       -- 과목  테이블     
( SUB_CODE   VARCHAR2(10)                                       -- 과목코드
, SUB_NAME   VARCHAR2(40)      NOT NULL                         -- 과목명
, CONSTRAINT SUBJECT_NAME_SUB_CODE_PK PRIMARY KEY(SUB_CODE)      -- PK 제약조건 추가
);

COMMENT ON COLUMN SUBJECT_NAME.SUB_CODE IS 'SUBject_CODE';




-- 8.교재 테이블(개설과목 테이블의 부모)
CREATE TABLE TEXTBOOK                                           -- 교재 
( TB_CODE   VARCHAR2(10)                                        -- 교재코드
, TB_NAME   VARCHAR2(40)      NOT NULL                          -- 교재명
, PUB   VARCHAR2(40)                                            -- 출판사
, CONSTRAINT TEXTBOOK_TB_CODE_PK PRIMARY KEY(TB_CODE)           -- PK 제약조건 추가
);

COMMENT ON COLUMN TEXTBOOK.TB_CODE IS 'TextBook_CODE';

COMMENT ON COLUMN TEXTBOOK.TB_NAME IS 'TextBook_NAME';

COMMENT ON COLUMN TEXTBOOK.PUB IS 'Publisher';



-- 9. 개설과목 테이블(성적 테이블의 부모)
CREATE TABLE OPENED_SUBJECT                                                  --개설과목 테이블
( OS_CODE   VARCHAR2(10)                                                    --개설과목코드
, OS_START  DATE            CONSTRAINT OP_SUBJECT_OS_START_NN  NOT NULL    --과목시작일
, OS_END    DATE            CONSTRAINT OP_SUBJECT_OS_END_NN    NOT NULL    --과목종료일
, OS_DATE   DATE            CONSTRAINT OP_SUBJECT_OS_DATE_NN   NOT NULL    --개설날짜
, OS_PT     NUMBER(3)                                                       --실기배점
, OS_WT     NUMBER(3)                                                       --필기배점
, OS_ATT    NUMBER(3)                                                       --출결배점
, TB_CODE   VARCHAR2(10)    CONSTRAINT OP_SUBJECT_TB_CODE_NN   NOT NULL   --교재코드
, PROF_ID   VARCHAR2(20)    CONSTRAINT OP_SUBJECT_PROF_ID_NN   NOT NULL   --교수ID
, SUB_CODE  VARCHAR2(10)    CONSTRAINT OP_SUBJECT_SUB_CODE_NN  NOT NULL   --과목코드
, OC_CODE   VARCHAR2(10)    CONSTRAINT OP_SUBJECT_OC_CODE_NN   NOT NULL   --개설과정코드
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

COMMENT ON TABLE OPENED_SUBJECT IS '개설과목 테이블';

COMMENT ON COLUMN OPENED_SUBJECT.OS_CODE IS '개설과목코드';
COMMENT ON COLUMN OPENED_SUBJECT.OS_START IS '과목시작일';
COMMENT ON COLUMN OPENED_SUBJECT.OS_END IS '과목종료일';
COMMENT ON COLUMN OPENED_SUBJECT.OS_DATE IS '개설날짜';
COMMENT ON COLUMN OPENED_SUBJECT.OS_PT IS '실기배점';
COMMENT ON COLUMN OPENED_SUBJECT.OS_WT IS '필기배점';
COMMENT ON COLUMN OPENED_SUBJECT.OS_ATT IS '출결배점';
COMMENT ON COLUMN OPENED_SUBJECT.TB_CODE IS '교재테이블 교재코드 참조키';
COMMENT ON COLUMN OPENED_SUBJECT.PROF_ID IS '교수자테이블 교수코드 참조키';
COMMENT ON COLUMN OPENED_SUBJECT.SUB_CODE IS '과목테이블 과목코드 참조키';
COMMENT ON COLUMN OPENED_SUBJECT.OC_CODE IS '개설과정테이블 개설과정코드 참조키';

--------------------------------------------------------
-- 10. 수강신청 테이블(중도탈락 테이블의 부모)

CREATE TABLE APP 
( APP_CODE   VARCHAR2(10)                                      -- 수강신청코드
, APP_DATE   DATE                DEFAULT SYSDATE              -- 수강신청일
, STU_ID     VARCHAR2(20)       NOT NULL                       -- 학생ID
, OC_CODE    VARCHAR2(10)       NOT NULL                        -- 개설과정코드
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


-- 11. 성적 테이블
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                  -- 성적코드
, GRADE_DATE       DATE               DEFAULT SYSDATE           -- 필기날짜
, GRADE_ATT       NUMBER(3)                                     -- 출결
, GRADE_WT       NUMBER(3)                                      -- 필기
, GRADE_PT       NUMBER(3)                                      -- 실기
, OS_CODE       VARCHAR2(10)       NOT NULL                     -- 개설과목코드
, APP_CODE       VARCHAR2(10)       NOT NULL                    -- 수강신청코드
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



-- 12. 중도탈락 테이블 생성
-- ⒫중도탈락코드, 중도탈락일자, 수강신청코드, 탈락사유코드
CREATE TABLE QUITLIST
( QUIT_CODE    VARCHAR2(10)                                     -- ⒫중도탈락코드
, QUIT_DATE    DATE    DEFAULT SYSDATE                         --중도탈락일자
, APP_CODE     VARCHAR2(10)                   NOT NULL          --수강신청코드
, QR_CODE      VARCHAR2(10)                   NOT NULL          --탈락사유코드
, CONSTRAINT QUITLIST_QUIT_CODE_PK PRIMARY KEY(QUIT_CODE)
);

ALTER TABLE QUITLIST 
ADD CONSTRAINT QUITLIST_APP_CODE_FK FOREIGN KEY (APP_CODE)       
                REFERENCES APP(APP_CODE);

ALTER TABLE QUITLIST 
ADD CONSTRAINT QUITLIST_QR_CODE_FK FOREIGN KEY (QR_CODE)       
                REFERENCES QUIT_REASON(QR_CODE);





-- 13. 중도탈락 사유 테이블 (중도탈락 테이블의 부모)
-- ⒫탈락사유코드, 중도탈락사유
CREATE TABLE QUIT_REASON
( QR_CODE        VARCHAR2(10)   
, QUIT_REASON   VARCHAR2(40)                  NOT NULL         
, CONSTRAINT QUIT_REASON_PK PRIMARY KEY(QR_CODE)
);

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'QUITLIST';

-- 권한부여 후 뷰생성 

--CONSTCHECK 뷰 생성
--※ 제약조건 확인 전용 뷰(VIEW) 생성
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
--==>> View VIEW_CONSTCHECK이(가) 생성되었습니다.

-- 과목 데이터 입력
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J001','클라우드 활용 자바(A)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J002','클라우드 활용 자바(B)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J003','클라우드 활용 자바(C)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('P001','파이썬 프로그래밍 기초(A)');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('P002','파이썬 프로그래밍 기초(B)');


-- 교재 데이터 입력
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA001','자바의정석','도우출판');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA002','코딩은 처음이라 with 자바','영진닷컴');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('PYTHON001',' 파이썬 프로그래밍','학산미디어');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING001','스프링 프레임워크 첫걸음','위키북스');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING002','스프링 부트핵심가이드','위키북스');


SELECT *
FROM TEXTBOOK;

DELETE
FROM TEXTBOOK;

ROLLBACK;

COMMIT;




INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20171305, 2234567, '김보경', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20153075, 1234567, '김태민', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20143054, 2133567, '조현하', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20131001, 2234317, '엄소연', TO_DATE('2022-09-08', 'YYYY-MM-DD');

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES (20161062, 1246867, '장현성', TO_DATE('2022-09-08', 'YYYY-MM-DD');



INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G301', SYSDATE, '20171305', 'H1');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G302', SYSDATE, '20153075', 'H2');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G303', SYSDATE, '20143054', 'H3');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A101','20153075','H1');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A102','20161062','H2');

SELECT *
FROM APP;

DELETE
FROM APP;



-- 개설목코드,수강신청코드 OS_CODE, APP_CODE
EXEC PRC_GRADE_INSERT('OS002','H2',80,40,30);

EXEC PRC_GRADE_INSERT(개설과정코드,수강신청코드,출결,필기,실기)





