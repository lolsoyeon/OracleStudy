SELECT USER
FROM DUAL;
--==>>SEMIPJ3
SELECT *
FROM TAB;
SELECT *
FROM RECYCLEBIN;
--관리자 테이블 
--[관리자ID - PK]
CREATE TABLE ADMIN                                             
( AD_ID   VARCHAR2(20)                                           -- 관리자ID 
, AD_PW   VARCHAR2(20)      NOT NULL                            -- 비밀번호
, AD_NAME   VARCHAR2(30)                                        -- 관리자명
, CONSTRAINT ADMIN_AD_ID_PK PRIMARY KEY(AD_ID)                  -- PK 제약조건 추가
);

 -- 교수자 테이블(개설과목 테이블의 부모)
 --[교수ID - PK]
CREATE TABLE PROFESSOR                      -- 교수자 테이블
( PROF_ID       VARCHAR2(20)                -- 교수ID
, PROF_PW       CHAR(7)         NOT NULL    -- 비밀번호
, PROF_NAME     VARCHAR2(30)    NOT NULL    -- 교수명
, PROF_DATE     DATE            NOT NULL    -- 등록날짜
, CONSTRAINT PROFESSOR_PROF_ID_PK PRIMARY KEY(PROF_ID)
);

-- 학생 테이블 (수강신청 테이블의 부모)
-- ⒫학생ID, 비밀번호, 학생이름, 등록날짜
CREATE TABLE STUDENT
( STU_ID       VARCHAR2(20)                             -- 학생ID
, STU_PW       CHAR(7)                  NOT NULL             -- 비밀번호
, STU_NAME     VARCHAR2(30)             NOT NULL             -- 학생이름
, STU_DATE     DATE    DEFAULT SYSDATE                       -- DEFAULT ?
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);




--과정 테이블 (개설과정 테이블의 부모)
-- [과정코드-PK]
CREATE TABLE COURSE 
( COURSE_CODE   VARCHAR2(10)                    --과정코드
, COURSE_NAME   VARCHAR2(40)      NOT NULL     --과정이름
, CONSTRAINT COURSE_COURSE_CODE_PK PRIMARY KEY(COURSE_CODE)
);


--강의실 테이블 (개설과정 테이블의 부모)
-- [강의실코드-PK]
CREATE TABLE CLASSROOM
( CR_CODE       VARCHAR2(10)                     --강의실코드
, CR_NAME    VARCHAR2(10)         NOT NULL      --강의실명
, CR_CAPACTIY   NUMBER(4)         NOT NULL      --수용가능인원
, CONSTRAINT CLASSROOM_CR_CODE_PK PRIMARY KEY(CR_CODE)
);

COMMENT ON COLUMN CLASSROOM.CR_CODE IS 'ClassRoom_CODE';


--개설과정 테이블 (개설과목 테이블의 부모/ 수강신청 테이블의 부모)
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
--강의실테이블의 강의실코드(CR_CODE)를 부모로 삼는 FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_CR_CODE_FK FOREIGN KEY (CR_CODE)
                              REFERENCES CLASSROOM(CR_CODE);
--과정테이블의 과정코드(COURSE_CODE)를 부모로 삼는 FK
ALTER TABLE OPENED_COURSE
ADD CONSTRAINT OC_COURSE_CODEE_FK FOREIGN KEY (COURSE_CODE)
                                    REFERENCES COURSE(COURSE_CODE);


COMMENT ON COLUMN OPENED_COURSE.OC_CODE IS 'OPENEDCourse_CODE';
COMMENT ON COLUMN OPENED_COURSE.CR_CODE IS 'ClassRoom_CODE';


--과목 테이블 (개설과목 테이블의 부모)
CREATE TABLE SUBJECT_NAME                                       -- 과목  테이블     
( SUB_CODE   VARCHAR2(10)                                       -- 과목코드
, SUB_NAME   VARCHAR2(40)      NOT NULL                         -- 과목명
, CONSTRAINT SUBJECT_NAME_SUB_CODE_PK PRIMARY KEY(SUB_CODE)      -- PK 제약조건 추가
);

COMMENT ON COLUMN SUBJECT_NAME.SUB_CODE IS 'SUBject_CODE';




--교재 테이블(개설과목 테이블의 부모)
CREATE TABLE TEXTBOOK                                           -- 교재 
( TB_CODE   VARCHAR2(10)                                        -- 교재코드
, TB_NAME   VARCHAR2(40)      NOT NULL                          -- 교재명
, PUB   VARCHAR2(40)                                            -- 출판사
, CONSTRAINT TEXTBOOK_TB_CODE_PK PRIMARY KEY(TB_CODE)           -- PK 제약조건 추가
);

COMMENT ON COLUMN TEXTBOOK.TB_CODE IS 'TextBook_CODE';

COMMENT ON COLUMN TEXTBOOK.TB_NAME IS 'TextBook_NAME';

COMMENT ON COLUMN TEXTBOOK.PUB IS 'Publisher';



--개설과목 테이블(성적 테이블의 부모)
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
-- 수강신청 테이블(중도탈락 테이블의 부모)

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


-- 성적 테이블
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                        -- 성적코드
, GRADE_DATE       DATE               DEFAULT SYSDATE     -- 필기날짜
, GRADE_ATT       NUMBER(3)                                      -- 출결
, GRADE_WT       NUMBER(3)                                      -- 필기
, GRADE_PT       NUMBER(3)                                      -- 실기
, OS_CODE       VARCHAR2(10)       NOT NULL                       -- 개설과목코드
, APP_CODE       VARCHAR2(10)       NOT NULL                        -- 수강신청코드
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



-- 중도탈락 테이블 생성
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




-- 중도탈락 사유 테이블 (중도탈락 테이블의 부모)
-- ⒫탈락사유코드, 중도탈락사유
CREATE TABLE QUIT_REASON
( QR_CODE        VARCHAR2(10)   
, QUIT_REASON   VARCHAR2(40)                  NOT NULL         
, CONSTRAINT QUIT_REASON_PK PRIMARY KEY(QR_CODE)
);

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

--제약 조건 확인 
SELECT *
FROM VIEW_CONSTCHECK;
WHERE TABLE_NAME = 'QUITLIST';

---------------------------------------------------------------------------------

--시퀀스
--소연
-- 교재 시퀀스
CREATE SEQUENCE BOOK_SEQ
START WITH 101
INCREMENT BY 1 
MAXVALUE 99999
NOCYCLE
NOCACHE;

--현성

CREATE SEQUENCE SEQ_STU
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;

--시퀀스
--태민
CREATE SEQUENCE OPSUB_SEQ
START WITH 1
INCREMENT BY 1 
MAXVALUE 999999
NOCYCLE
NOCACHE;

SELECT *
FROM USER_SEQUENCES;



--시퀀스
--보경
CREATE SEQUENCE SEQ_PROF
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;
--==>> Sequence SEQ_PROF이(가) 생성되었습니다.

SELECT *
FROM USER_SEQUENCES;

--수강신청 코드
CREATE SEQUENCE SEQ_APP
START WITH 1
INCREMENT BY 1
MAXVALUE 9999   
NOCYCLE
NOCACHE;
--==>> Sequence SEQ_APP이(가) 생성되었습니다.
---------------------------------------------------------------------------------------
--로그인(관리자,교수자,학생)
--관리자 로그인
CREATE OR REPLACE PROCEDURE PRC_ADMIN_LOGIN
( V_AD_ID       IN      ADMIN.AD_ID%TYPE
, V_AD_PW       IN      ADMIN.AD_PW%TYPE
)
IS
    V_AD_ID_CHECK   ADMIN.AD_ID%TYPE;        --일치하는 ID가 대조할 변수 선언
    V_AD_PW_CHECK   ADMIN.AD_PW%TYPE;        --비밀번호 대조할 변수 선언
    
    USER_DEFINE_ERROR1 EXCEPTION;      --ID없을때 띄울 에러
    USER_DEFINE_ERROR2 EXCEPTION;      --비밀번호 일치하지 않을때 띄울 에러
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
    
    DBMS_OUTPUT.PUT_LINE('관리자가 로그인 하였습니다~!!!');
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1 THEN RAISE_APPLICATION_ERROR(-20760 , '일치하는 ID가 존재하지 않습니다~!!!');
    WHEN USER_DEFINE_ERROR2 THEN RAISE_APPLICATION_ERROR(-20761 , '비밀번호가 일치 하지 않습니다~!!!');
    WHEN OTHERS THEN ROLLBACK;
    --커밋
    COMMIT;
END;


--교수자 로그인
CREATE OR REPLACE PROCEDURE PRC_PROF_LOGIN
( V_PROF_ID     IN      PROFESSOR.PROF_ID%TYPE
, V_PROF_PW     IN      PROFESSOR.PROF_PW%TYPE
)
IS
    V_PROF_ID_CHECK     PROFESSOR.PROF_ID%TYPE;     --교수자ID 체크할 변수 선언
    V_PROF_PW_CHECK     PROFESSOR.PROF_PW%TYPE;     --교수자PW 체크할 변수 선언
    
    USER_DEFINE_ERROR1 EXCEPTION;                   --ID가 존재하지 않을시 띄울 에러
    USER_DEFINE_ERROR2 EXCEPTION;                   --PW가 일치하지 않을시 띄울 에러
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
    
    DBMS_OUTPUT.PUT_LINE('교수자가 로그인 하였습니다~!!!');
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR1 THEN RAISE_APPLICATION_ERROR(-20762 , '일치하는 ID가 존재하지 않습니다~!!!');
    WHEN USER_DEFINE_ERROR2 THEN RAISE_APPLICATION_ERROR(-20763 , '비밀번호가 일치 하지 않습니다~!!!');
    WHEN OTHERS THEN ROLLBACK;
    --커밋
    COMMIT;

END;


--학생 로그인
CREATE OR REPLACE PROCEDURE PRC_STU_LOGIN
( V_STU_ID      IN STUDENT.STU_ID%TYPE
, V_STU_PW      IN STUDENT.STU_PW%TYPE
)
IS
    --선언부
    V_IDCHECK   NUMBER;
    V_STU_NAME  STUDENT.STU_NAME%TYPE;  
    V_PWCHECK    STUDENT.STU_PW%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    -- ID가 있는지 확인
    SELECT COUNT(*) INTO V_IDCHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- 입력한 ID가 존재하지 않는 경우 예외 발생
    IF (V_IDCHECK = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 입력한 ID의 PW 확인
    SELECT STU_PW INTO V_PWCHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- 입력한 ID의 비밀번호가 틀렸을 시 예외 발생
    IF (V_STU_PW != V_PWCHECK)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --해당하는 학생의 이름을 V_STU_NAME 변수에 담기
    SELECT STU_NAME INTO V_STU_NAME 
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    -- 로그인 성공시 문구 출력
    DBMS_OUTPUT.PUT_LINE(V_STU_NAME || '님 어서오세요~!!!');
    
    --예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20211,'아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요');
    --커밋
    COMMIT;
END;


-----------------------------------------------------------------------------------
--보경
--교수자

--교수자 인서트 프로시저
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
    --중복 값 찾기
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
            THEN RAISE_APPLICATION_ERROR(-20400,'이미 등록된 교수자입니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_PROFESSOR_INSERT이(가) 컴파일되었습니다.



--교수자 업데이트 프로시저
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
( V_PROF_ID      IN PROFESSOR.PROF_ID%TYPE  
, V_PROF_NAME    IN PROFESSOR.PROF_NAME%TYPE
)
IS
    ID_CHECK    NUMBER(1);
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --해당 ID가 존재하지 않을경우
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
            THEN RAISE_APPLICATION_ERROR(-20400,'입력된 정보와 일치하는 교수자가 존재하지 않습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PROFESSOR_UPDATE이(가) 컴파일되었습니다.


--교수자 딜리트 프로시저
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
( V_PROF_ID          IN PROFESSOR.PROF_ID%TYPE
)
IS
    V_CHECK             NUMBER;

    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    --해당 교수자 정보가 있는지 확인
    SELECT COUNT(*)     INTO V_CHECK
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;
    
    --정보가 없을경우 에러 발생
    IF (V_CHECK = 0)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 삭제    
    DELETE
    FROM PROFESSOR
    WHERE PROF_ID = V_PROF_ID;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20400,'입력된 정보와 일치하는 교수자가 존재하지 않습니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PROFESSOR_DELETE이(가) 컴파일되었습니다.



CREATE OR REPLACE TRIGGER PRC_PROFESSOR_DELETE1
    BEFORE
    DELETE ON PROFESSOR
    FOR EACH ROW
BEGIN
    DELETE
    FROM OPENED_SUBJECT
    WHERE PROF_ID = :OLD.PROF_ID;
END;

--==>> Trigger PRC_PROFESSOR_DELETE1이(가) 컴파일되었습니다.

-------------------------------------------------------------------------------------
--소연
--교재 등록 PRC_TEXTBOOK_INSERT(교재명, 출판사)--
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_INSERT
( V_TB_NAME  IN TEXTBOOK.TB_NAME%TYPE
, V_PUB      IN TEXTBOOK.PUB%TYPE
)
IS
    -- 선언부
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


    -- INSERT 쿼리문 수행
    INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB)
    VALUES(V_TB_CODE, V_TB_NAME, V_PUB);
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20610, '이미 등록된 교재입니다.');
    ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;

--==>> Procedure PRC_TEXTBOOK_INSERT이(가) 컴파일되었습니다.


-----------------------------------------------------------------------------------

--■■■ 교재 수정 PRC_TEXTBOOK_UPDATE(교재코드, 교재명, 출판사) ■■■--
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_UPDATE
( V_TB_CODE       IN TEXTBOOK.TB_CODE%TYPE
, NEW_TB_NAME     IN TEXTBOOK.TB_NAME%TYPE
, NEW_PUB         IN TEXTBOOK.PUB%TYPE
)
IS
-- 선언부
    CHECK_BOOK_NAME   TEXTBOOK.TB_NAME%TYPE;
    CHECK_BOOK_CODE     TEXTBOOK.TB_CODE%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- 교재ID가 없으면 예외
    SELECT NVL((SELECT TB_CODE
               FROM TEXTBOOK
               WHERE TB_CODE = V_TB_CODE),'0') INTO CHECK_BOOK_CODE
    FROM DUAL;
    
    IF (CHECK_BOOK_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 이미 등록된 교재명이면 예외
    SELECT NVL((SELECT TB_NAME
               FROM TEXTBOOK
               WHERE TB_NAME = NEW_TB_NAME),'0') INTO CHECK_BOOK_NAME
    FROM DUAL;
    
    IF (CHECK_BOOK_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- UPDATE 쿼리문 수행
    UPDATE TEXTBOOK
    SET TB_NAME = NEW_TB_NAME, PUB = NEW_PUB
    WHERE TB_CODE = V_TB_CODE;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20611, '등록되지 않은 교재ID입니다.' );
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20612, '이미 등록된 교재입니다.' );
    ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_TEXTBOOK_UPDATE이(가) 컴파일되었습니다.


------------------------------------------------------------------------------------
-- 교재 삭제 PRC_TEXTBOOK_DELETE(교재코드) --
CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_DELETE
(V_TB_CODE  IN TEXTBOOK.TB_CODE%TYPE
)
IS
    -- 선언부
    CHECK_TB_CODE  TEXTBOOK.TB_CODE%TYPE;
    
    USER_DEFINE_ERROR    EXCEPTION;
    USER_DIFINE_ERROR2   EXCEPTION;

BEGIN
    -- 교재코드가 없으면 예외발생 ERROR
    SELECT NVL((SELECT TB_CODE
                FROM TEXTBOOK
                WHERE TB_CODE = V_TB_CODE), '0') INTO CHECK_TB_CODE
    FROM DUAL;
    
    IF (CHECK_TB_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 해당 교재를 이미 사용 중인 과목이 있습니다. ERROR2
    SELECT NVL((SELECT TB_CODE
                FROM OPENED_SUBJECT
                WHERE TB_CODE = V_TB_CODE), '0') INTO CHECK_TB_CODE
    FROM DUAL;
    
    IF (CHECK_TB_CODE = V_TB_CODE)
        THEN RAISE USER_DIFINE_ERROR2;
    END IF;


    -- DELETE 쿼리문 수행
    DELETE 
    FROM TEXTBOOK
    WHERE TB_CODE = V_TB_CODE;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20613, '등록되지 않은 교재입니다.');
    WHEN USER_DIFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20614, '해당교재를 이미 사용중인 과목이 있습니다.');
    ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;

--==>> Procedure PRC_TEXTBOOK_DELETE이(가) 컴파일되었습니다.



-----------------------------------------------------------------------------------
--현성
--1.학생 등록 프로시저
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(  V_STU_PW      IN STUDENT.STU_PW%TYPE  -- SSN 컬럼을 따로 생성하지 않았음
,  V_STU_NAME    IN STUDENT.STU_NAME%TYPE
,  V_STU_DATE    IN STUDENT.STU_DATE%TYPE
)
IS
    V_STU_ID    STUDENT.STU_ID%TYPE;
    V_CHECK     STUDENT.STU_PW%TYPE;
    PW_CHECK    NUMBER(1);

    
    USER_DEFINE_ERROR   EXCEPTION;  
BEGIN
    --중복 값 찾기
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
            THEN RAISE_APPLICATION_ERROR(-20200,'이미 등록된 학생입니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋
    COMMIT;
    
END;

--2.학생 수정 프로시저
--아이디 , 변경할 이름 해당 학생의 이름 변경
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_STU_ID      IN STUDENT.STU_ID%TYPE  
, V_STU_NAME    IN STUDENT.STU_NAME%TYPE
)
IS
    ID_CHECK    NUMBER(1);
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --해당 ID가 존재하지 않을경우
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
            THEN RAISE_APPLICATION_ERROR(-20201,'입력된 정보와 일치하는 학생이 존재하지 않습니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋
    COMMIT;

END;
--==>> Procedure PRC_STU_UPDATE이(가) 컴파일되었습니다.

--3학생 삭제 프로시저
--아이디 입력시 해당 학생의 수강정보 및 학생정보 삭제
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
( V_STU_ID          IN STUDENT.STU_ID%TYPE
)
IS
    V_CHECK             NUMBER;
--    V_APP_CODE          APP.APP_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    
    --해당 학생정보가 있는지 확인
    SELECT COUNT(*)     INTO V_CHECK
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
    
    --학생정보가 없을경우 에러 발생
    IF (V_CHECK = 0)
    THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
-- 학생정보 삭제    
    DELETE
    FROM STUDENT
    WHERE STU_ID = V_STU_ID;
-- 수강정보 삭제
--    DELETE
--    FROM APP
--    WHERE STU_ID = V_STU_ID;
-- 성적 삭제
--    DELETE
--    FROM GRADE
--    WHERE APP_CODE = V_APP_CODE;

--SELECT OC_CODE
--FROM APP
--WHERE STU_ID = V_STU_ID;
    --예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20201,'입력된 정보와 일치하는 학생이 존재하지 않습니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋
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
--현하
--과정
-- 과정 정보 입력 --------------------------------------------------------------
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
            THEN RAISE_APPLICATION_ERROR(-20500, '이미 등록된 과정');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


-- 과정 정보 수정 --------------------------------------------------------------
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
            THEN RAISE_APPLICATION_ERROR(-20501, '존재하지 않는 과정이므로 수정 불가능');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋       
    COMMIT;
    
END;

-- 과정 정보 삭제 ---------------------------------------------------------------
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
            THEN RAISE_APPLICATION_ERROR(-20502, '존재하지 않는 과정이므로 삭제 불가능');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;

--------------------------------------------------------------------------------
-- 과정 삭제 트리거 -------------------------------------------------------------
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
-- 개설과정 정보 입력 -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_INSERT
( V_OC_START    IN      OPENED_COURSE.OC_START%TYPE
, V_OC_END      IN      OPENED_COURSE.OC_END%TYPE
, V_CR_CODE     IN      CLASSROOM.CR_CODE%TYPE
, V_COURSE_CODE IN      COURSE.COURSE_CODE%TYPE

)
IS
    -- 개설과정 코드 
    V_OC_CODE                   OPENED_COURSE.OC_CODE%TYPE;
    -- 과정코드 존재 여부를 확인할 변수
    V_COURSE_CODE_CHECK          COURSE.COURSE_CODE%TYPE;
    -- 강의실코드 존재 여부를 확인할 변수
    V_CR_CODE_CHECK             CLASSROOM.CR_CODE%TYPE;
    

-- 에러 발생 경우
-- 1. 과정 코드가 존재하지 않을 때
    USER_DEFINE_ERROR1 EXCEPTION;
-- 2. 과정종료일이 과정시작일 보다 이전일 때
    USER_DEFINE_ERROR2 EXCEPTION;    
-- 3. 강의실 고드가 존재하지 않을 때
    USER_DEFINE_ERROR3 EXCEPTION;


BEGIN
    -- 1. 과정 코드가 존재하지 않을 때
    SELECT NVL(MAX(COURSE_CODE), '0') INTO V_COURSE_CODE_CHECK 
    FROM COURSE
    WHERE COURSE_CODE =V_COURSE_CODE;
    
    IF (V_COURSE_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;

    -- 2. 과정종료일이 과정시작일 보다 이전일 때
    
    IF(V_OC_START >= V_OC_END)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    -- 3. 강의실 고드가 존재하지 않을 때
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
    THEN RAISE_APPLICATION_ERROR(-20503, '과정이 존재하지 않음');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20504, '과정시작일 및 종료일 오류');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20505, '강의실이 존재하지 않음');
    
    WHEN OTHERS THEN ROLLBACK;
    
    --커밋
    COMMIT;
       
END;


--------------------------------------------------------------------------------
-- 개설과정 정보 수정 -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_UPDATE
( V_OC_CODE        IN OPENED_COURSE.OC_CODE%TYPE
, V_OC_START       IN OPENED_COURSE.OC_START%TYPE
, V_OC_END         IN OPENED_COURSE.OC_END%TYPE
, V_CR_CODE        IN CLASSROOM.CR_CODE%TYPE
, V_COURSE_CODE    IN COURSE.COURSE_CODE%TYPE
)
IS
    -- 개설과정 코드 존재 여부를 확인할 변수
    V_OC_CODE_CHECK             OPENED_COURSE.OC_CODE%TYPE;
    -- 과정코드 존재 여부를 확인할 변수
    V_COURSE_CODE_CHECK          COURSE.COURSE_CODE%TYPE;
    -- 강의실코드 존재 여부를 확인할 변수
    V_CR_CODE_CHECK             CLASSROOM.CR_CODE%TYPE;
    

-- 에러 발생 경우
-- 1. 개설과정 코드가 존재하지 않을 때
    USER_DEFINE_ERROR1 EXCEPTION;
-- 2. 과정 코드가 존재하지 않을 때
    USER_DEFINE_ERROR2 EXCEPTION;
-- 3. 과정종료일이 과정시작일 보다 이전일 때
    USER_DEFINE_ERROR3 EXCEPTION;    
-- 4. 강의실 고드가 존재하지 않을 때
    USER_DEFINE_ERROR4 EXCEPTION;
    
BEGIN
    -- 1. 개설과정 코드가 존재하지 않을 때
    SELECT NVL(MAX(OC_CODE), '0') INTO V_OC_CODE_CHECK 
    FROM OPENED_COURSE
    WHERE OC_CODE =V_OC_CODE;
    
    IF (V_OC_CODE_CHECK= '0')
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
     -- 2. 과정 코드가 존재하지 않을 때
    SELECT NVL(MAX(COURSE_CODE), '0') INTO V_COURSE_CODE_CHECK 
    FROM COURSE
    WHERE COURSE_CODE =V_COURSE_CODE;
    
    IF (V_COURSE_CODE_CHECK = '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    -- 3. 과정종료일이 과정시작일 보다 이전일 때
    
    IF(V_OC_START >= V_OC_END)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

    -- 4. 강의실 고드가 존재하지 않을 때
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
    THEN RAISE_APPLICATION_ERROR(-20506, '존재하지 않는 개설과정이므로 수정 불가능');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20507, '과정이 존재하지 않아 수정 불가능');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20508, '과정시작일 및 종료일 오류로 수정 불가능');
    
    WHEN USER_DEFINE_ERROR4
    THEN RAISE_APPLICATION_ERROR(-20509, '강의실이 존재하지 않아 수정 불가능');
    
    WHEN OTHERS THEN ROLLBACK;
    --커밋
    COMMIT;
    
END;

--------------------------------------------------------------------------------
-- 개설과정 정보 삭제 -----------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_OPENED_COURSE_DELETE
( V_OC_CODE     IN      OPENED_COURSE.OC_CODE%TYPE
)
IS
    -- 개설과정 코드 존재 여부를 확인할 변수
    OC_CODE_CHECK   OPENED_COURSE.OC_CODE%TYPE;
    
    -- 존재하는 개설과정이 없다면 에러 발생
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
        THEN RAISE_APPLICATION_ERROR(-20510, '존재하지 않는 과정이므로 삭제 불가능'); 
        --커밋
        COMMIT;
END;
--------------------------------------------------------------------------------
-- 개설과정 삭제 트리거 -------------------------------------------------------------
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
--태민
--1. 과목 등록 PRC_SUBJECT_INSERT(과목코드,과목명) 
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUB_CODE IN SUBJECT_NAME.SUB_CODE%TYPE
, V_SUB_NAME IN SUBJECT_NAME.SUB_NAME%TYPE
)
IS
-- 선언부
    CHECK_SUB_NAME   SUBJECT_NAME.SUB_NAME%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT NVL((SELECT SUB_NAME
               FROM SUBJECT_NAME
               WHERE SUB_NAME = V_SUB_NAME),'0') INTO CHECK_SUB_NAME
    FROM DUAL;
    
    --이미 중복된 과목이라면 예외 발생 시킬 것
    IF (CHECK_SUB_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --데이터 인서트 (받아온 매개변수들로 SUB_CODE와 SUB_NAME에 값을 INSERT)
    INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME)
    VALUES(V_SUB_CODE, V_SUB_NAME);
    
    --중복된 과목이라면 예외 발생 처리
    EXCEPTION
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20700, '이미 등록된 과목입니다~!!!' );
    
    -- 커밋
    COMMIT;
END;
--------------------------------------------------------------------------------
--2. 과목 수정 PRC_SUBJECT_UPDATE(과목코드, 과목명)
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
    
    --등록된 과목이 있는 지 확인하고 없다면 예외발생 시킬 것
    IF (CHECK_SUB_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 과목 이름 변경
    UPDATE SUBJECT_NAME
    SET SUB_NAME = V_SUB_NAME
    WHERE SUB_CODE = V_SUB_CODE;
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20701, '등록된 과목이 없습니다~!!!' );

    
    -- 커밋
    COMMIT;
    
END;
--------------------------------------------------------------------------------
--3. 과목 삭제 PRC_SUBJECT_DELETE(과목CODE) 
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
            THEN RAISE_APPLICATION_ERROR(-20702,'일치하는 데이터가 없습니다~!!!');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;            
END;
--------------------------------------------------------------------------------
-- 4. 과목 삭제2 PRC_SUBJECT_DELETE_1 (트리거)
--○ 과목 삭제 트리거 생성
-- 과목에서 DELETE가 실행됐을 때 
-- 개설과목 테이블에서도 과목을 삭제 해야함
-- 개설과목에서 과목 삭제
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
--5. 개설과목 추가 PRC_OPSUB_INSERT
--(개설과목코드,
--(과목시작일,과목종료일,개설날짜,실기배점,필기배점,출결배점,교재코드,교수ID,과목코드,개설과정코드)

--EXEC PRC_OPSUB_INSERT(과목시작일,과목종료일,개설날짜,실기배점,필기배점,출결배점,교재코드,교수ID,과목코드,개설과정코드)


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
--개설과목코드는 매개변수로 입력받는 것이 아니므로 변수 선언을 따로 해줌
--문자열 + TO_CHAR(시퀀스)로 값을 담아 줄 것
    V_OS_CODE  OPENED_SUBJECT.OS_CODE%TYPE; 
    
--개설과정코드 대조할 변수 선언
    OC_CODE_CHECK  OPENED_COURSE.OC_CODE%TYPE;

--개설과목코드 이름 붙여줄 변수 선언 (과목코드의 첫글자를 따올것)
--    V_NAMING    SUBJECT_NAME.SUB_CODE%TYPE := SUBSTR(V_SUB_CODE,1,1);
    
    
--에러 발생 변수

--①배점의 총합이 100점이 미치지 못할 경우
    USER_DEFINE_ERROR1 EXCEPTION;
--②개설날짜가 겹칠 경우(기존 있던 과목들과)
    USER_DEFINE_ERROR2 EXCEPTION;    
--③개설과목의 기간이 개설과정의 기간과 맞지 않을 경우
    USER_DEFINE_ERROR3 EXCEPTION;

    OC_START    DATE;   --개설 과정 시작일 담을 변수 
    OC_END      DATE;   --개설 과정 종료일 담을 변수
    
    EX_START    DATE;   --기존 과목 시작일
    EX_END      DATE;   --기존 과목 종료일
    
    CURSOR CUR_DATE_CHECK
    IS
    SELECT OS_START,OS_END
    FROM OPENED_SUBJECT
    WHERE OC_CODE = V_OC_CODE;
BEGIN
    --①배점의 총합이 100점이 아닐 경우 에러 발생
    IF(V_OS_PT+V_OS_WT+V_OS_ATT!=100)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    


    --②개설날짜가 겹칠 경우(기존 있던 과목들과) 
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

    --③개설과목의 기간이 개설과정의 기간과 맞지 않을 경우
    SELECT OC_START, OC_END INTO OC_START,OC_END
    FROM OPENED_COURSE
    WHERE OC_CODE = V_OC_CODE;
    
    --생성하는 개설과목의 시작일이 해당 개설과정일의 시작일 보다 앞서거나
    --생성하는 개설과목의 종료일이 해당 개설과정일의 종료일 보다 늦는다면 에러 발생
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
    THEN RAISE_APPLICATION_ERROR(-20703, '배점의 총합이 100점이 아닙니다~!!!');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20704, '기존의 과목들과 날짜가 겹쳐 개설할수 없습니다~!!!');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20705, '개설과목의 기간은 개설과정의 기간에 포함되어야 합니다~!!!');
    
    WHEN OTHERS THEN ROLLBACK;

    
    --커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--6.개설과목 수정 PRC_OPSUB_UPDATE
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

--교재코드와 대조할 변수 선언
    TB_CODE_CHECK TEXTBOOK.TB_CODE%TYPE;
--교수ID와 대조할 변수 선언
    PROF_ID_CHECK PROFESSOR.PROF_ID%TYPE;
--과목코드와 대조할 변수 선언
    SUB_CODE_CHECK SUBJECT_NAME.SUB_CODE%TYPE;
--개설과정코드 대조할 변수 선언
    OC_CODE_CHECK  OPENED_COURSE.OC_CODE%TYPE;
--개설과목코드 대조할 변수 선언
    OS_CODE_CHECK  OPENED_SUBJECT.OS_CODE%TYPE;
    
    
--에러 발생 변수
--○ 개설과목코드가 일치하지 않을 경우 발생시킬 에러(PL/SQL성공적으로 실행되었습니다. 잡아내기위한 처리)
    USER_DEFINE_ERROR EXCEPTION;

--①배점의 총합이 100점이 미치지 못할 경우
    USER_DEFINE_ERROR1 EXCEPTION;
--②개설날짜가 겹칠 경우(기존 있던 과목들과)
    USER_DEFINE_ERROR2 EXCEPTION;    
--③개설과목의 기간이 개설과정의 기간과 맞지 않을 경우
    USER_DEFINE_ERROR3 EXCEPTION;

--④ 교재코드가 존재하지 않을 경우 발생시킬 에러
     USER_DEFINE_ERROR4 EXCEPTION;
--⑤ 교수ID가 존재하지 않을 경우 발생시킬 에러
     USER_DEFINE_ERROR5 EXCEPTION;
--⑥ 과목코드가 존재하지 않을 경우 발생시킬 에러 
     USER_DEFINE_ERROR6 EXCEPTION;
--⑦ 개설과정코드 존재하지 않을 경우 발생시킬 에러
     USER_DEFINE_ERROR7 EXCEPTION;
     
    OC_START    DATE;   --개설 과정 시작일 담을 변수 
    OC_END      DATE;   --개설 과정 종료일 담을 변수
    
    EX_START    DATE;   --기존 과목 시작일
    EX_END      DATE;   --기존 과목 종료일
    
    CURSOR CUR_DATE_CHECK
    IS
    SELECT OS_START,OS_END
    FROM OPENED_SUBJECT
    WHERE OC_CODE = V_OC_CODE;
BEGIN

    --①배점의 총합이 100점이 아닐 경우 에러 발생
    IF(V_OS_PT+V_OS_WT+V_OS_ATT!=100)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    


    --②개설날짜가 겹칠 경우(기존 있던 과목들과) 
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

    --③개설과목의 기간이 개설과정의 기간과 맞지 않을 경우
    SELECT OC_START, OC_END INTO OC_START,OC_END
    FROM OPENED_COURSE
    WHERE OC_CODE = V_OC_CODE;
    
    --생성하는 개설과목의 시작일이 해당 개설과정일의 시작일 보다 앞서거나
    --생성하는 개설과목의 종료일이 해당 개설과정일의 종료일 보다 늦는다면 에러 발생
    IF(V_OS_START<OC_START OR OC_END<V_OS_END)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

--변수에 값 담아내기
--개설과목코드와 대조할 변수에 값 담아내기
   SELECT NVL(MAX(OS_CODE), '0') INTO OS_CODE_CHECK
    FROM OPENED_SUBJECT
    WHERE OS_CODE =V_OS_CODE;

--교재코드와 대조할 변수에 값 담아내기
   SELECT NVL(MAX(TB_CODE), '0') INTO TB_CODE_CHECK
    FROM TEXTBOOK
    WHERE TB_CODE =V_TB_CODE;
--교수ID와 대조할 변수에 값 담아내기
    SELECT NVL(MAX(PROF_ID), '0') INTO PROF_ID_CHECK 
    FROM PROFESSOR
    WHERE PROF_ID =V_PROF_ID;
    
--과목코드와  대조할 변수에 값 담아내기
    SELECT NVL(MAX(SUB_CODE), '0') INTO SUB_CODE_CHECK
    FROM SUBJECT_NAME
    WHERE SUB_CODE =V_SUB_CODE;
--개설과정코드 대조할 변수에 값 담아내기
    SELECT NVL(MAX(OC_CODE), '0') INTO OC_CODE_CHECK 
    FROM OPENED_COURSE
    WHERE OC_CODE =V_OC_CODE;
    
    
--④ 교재코드가 존재하지 않을 경우 발생시킬 에러
    IF (TB_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR4; 
    END IF;
--⑤ 교수ID가 존재하지 않을 경우 발생시킬 에러
    IF (PROF_ID_CHECK ='0')
        THEN RAISE USER_DEFINE_ERROR5; 
    END IF;
--⑥ 과목코드가 존재하지 않을 경우 발생시킬 에러 
    IF (SUB_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR6; 
    END IF;
--⑦ 개설과정코드 존재하지 않을 경우 발생시킬 에러
    IF (OC_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR7; 
    END IF;
--○ 개설과목코드가 존재하지 않을 경우 발생시킬 에러
    IF (OS_CODE_CHECK='0')
        THEN RAISE USER_DEFINE_ERROR; 
    END IF;  
--에러체크 끝났으므로, 업데이트 구문 실행
    UPDATE OPENED_SUBJECT
    SET OS_START = V_OS_START , OS_END= V_OS_END, OS_DATE=V_OS_DATE, OS_PT=V_OS_PT
    , OS_WT=V_OS_WT,OS_ATT=V_OS_ATT, TB_CODE=V_TB_CODE, PROF_ID=V_PROF_ID, SUB_CODE=V_SUB_CODE, OC_CODE =V_OC_CODE
    WHERE OS_CODE = V_OS_CODE;

   EXCEPTION
    WHEN USER_DEFINE_ERROR1
    THEN RAISE_APPLICATION_ERROR(-20709, '배점의 총합이 100점이 아닙니다~!!!');
    
    WHEN USER_DEFINE_ERROR2
    THEN RAISE_APPLICATION_ERROR(-20710, '기존의 과목들과 날짜가 겹쳐 개설할수 없습니다~!!!');
    
    WHEN USER_DEFINE_ERROR3
    THEN RAISE_APPLICATION_ERROR(-20711, '개설과목의 기간은 개설과정의 기간에 포함되어야 합니다~!!!');
    
     WHEN USER_DEFINE_ERROR4
    THEN RAISE_APPLICATION_ERROR(-20712, '해당 교재코드가 존재하지 않습니다~!!!');
    
    WHEN USER_DEFINE_ERROR5
    THEN RAISE_APPLICATION_ERROR(-20713, '해당 교수ID가 존재하지 않습니다~!!!');
    
    WHEN USER_DEFINE_ERROR6
    THEN RAISE_APPLICATION_ERROR(-20714, '해당 과목코드가 존재하지 않습니다~!!!');   
    
    WHEN USER_DEFINE_ERROR7
    THEN RAISE_APPLICATION_ERROR(-20715, '해당 개설과정코드가 존재하지 않습니다~!!!'); 
    
    WHEN USER_DEFINE_ERROR
    THEN RAISE_APPLICATION_ERROR(-20716, '해당 개설과목코드가 존재하지 않습니다~!!!'); 
    
    WHEN OTHERS THEN ROLLBACK;
    
    COMMIT;
END;


 

--------------------------------------------------------------------------------
--7.개설과목 삭제 PRC_OPSUB_DELETE  (트리거 활용)
-- 성적 기록이 남아있는 데이터 삭제 안되게 수정해야함.
-- 매개변수로 받아와야할것? 
CREATE OR REPLACE PROCEDURE PRC_OPSUB_DELETE
( V_OS_CODE     IN      OPENED_SUBJECT.OS_CODE%TYPE
)
IS
    --매개변수와 개설과목코드를 대조할 변수 
    OS_CODE_CHECK   OPENED_SUBJECT.OS_CODE%TYPE;
    --일치하지 않을시 에러 발생
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
        THEN RAISE_APPLICATION_ERROR(-20717, '해당 개설과목코드가 존재하지 않습니다~!!!'); 
END;

--8.개설과목 삭제를 위한 트리거 장착
--자식 테이블의 데이터를 지우고 와야 하기에 BEFORE ROW TRIGGER
--성적에 데이터가 있을시 개설과목 삭제하면 안되기에 DROP시킴.
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
--수강신청 등록
--PRC_APP_INSERT(과정코드,학생ID)
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
        -- 해당 학생이 있는지 확인
        SELECT COUNT(*)     INTO ID_CHECK
        FROM STUDENT
        WHERE STU_ID = V_STU_ID;
        -- 해당 학생이 존재하지 않다면 예외 발생
        IF(ID_CHECK = 0)
            THEN RAISE USER_DEFINE_ERROR1;
        END IF;
        
        -- 해당 과정이 있는지 확인
        SELECT COUNT(*)     INTO OC_CHECK
        FROM OPENED_COURSE
        WHERE OC_CODE = V_OC_CODE;
        -- 해당 과정이 존재하지 않다면 예외 발생
        IF(OC_CHECK = 0)
            THEN RAISE USER_DEFINE_ERROR1;
        END IF;
        
        -- 수강신청이 가능한 날짜인지 확인
        SELECT OC_START     INTO START_CHECK
        FROM OPENED_COURSE
        WHERE OC_CODE = V_OC_CODE;
        -- 이미 시작한 경우
        IF(V_APP_DATE > START_CHECK)
            THEN RAISE USER_DEFINE_ERROR2;
        END IF;
        
        --이미 수강신청한 경우
        SELECT COUNT(*)     INTO APP_CHECK
        FROM APP
        WHERE STU_ID = V_STU_ID;
        
        IF(APP_CHECK != 0)
            THEN RAISE USER_DEFINE_ERROR3;
        END IF;
            
        INSERT INTO APP(APP_CODE, APP_DATE, STU_ID,OC_CODE)VALUES(('AP'||LPAD(TO_CHAR(SEQ_APP.NEXTVAL),4,'0')),V_APP_DATE,V_STU_ID,V_OC_CODE);
              
        EXCEPTION
            WHEN USER_DEFINE_ERROR1
                THEN RAISE_APPLICATION_ERROR(-20202,'해당 학생이나 과정을 찾을 수 없습니다.');
                     ROLLBACK;
            WHEN USER_DEFINE_ERROR2
                THEN RAISE_APPLICATION_ERROR(-20203,'수강신청일이 아닙니다.');
                     ROLLBACK;
            WHEN USER_DEFINE_ERROR3
                THEN RAISE_APPLICATION_ERROR(-20204,'이미 수강신청된 수업입니다.');
                     ROLLBACK;
            WHEN OTHERS 
                THEN ROLLBACK;
        COMMIT;
END;
--==>> Procedure PRC_APP_INSERT이(가) 컴파일되었습니다.

-----------------------------------------------------------------------------------------------------------
-- 1. 성적 입력 PRC_GRADE_INSERT(출결, 필기, 실기, 개설과목코드, 수강신청코드) 작동확인
-- EXEC PRC_GRADE_INSERT(출결, 필기, 실기, 개설과목코드, 수강신청코드);
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
    

    V_OS_END            OPENED_SUBJECT.OS_END%TYPE;          -- 개설과목 종료일       
    V_FAPP_ID           GRADE.APP_CODE%TYPE;                -- 수강신청코드 중복검사   
    V_FOP_SUB           GRADE.OS_CODE%TYPE;                 -- 개설과목코드 중복검사
    V_MID_DROP          NUMBER;                            -- 중도포기 
    
    
    MID_DROP_STU_ERROR EXCEPTION;                   -- 중도포기에러  
    APP_OVERLAP_ERROR EXCEPTION;                    -- 수강신청코드 중복시 에러 
    GRADE_DATE_ERROR   EXCEPTION;                  -- 개설과목 진행중에 성적입력X 에러

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
    
    -- 과목 진행 중간에 성적 입력 불가 
    -- 끝나는 날짜보다 이르면 입력 불가
    SELECT OS_END INTO V_OS_END
    FROM OPENED_SUBJECT
    WHERE OS_CODE =  V_OS_CODE;

    IF (V_OS_END > SYSDATE)
        THEN RAISE GRADE_DATE_ERROR;
    END IF;

    INSERT INTO GRADE(GRADE_CODE, GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE)
    VALUES(V_GRADE_CODE, V_GRADE_DATE, V_GRADE_ATT, V_GRADE_WT, V_GRADE_PT, V_OS_CODE, V_APP_CODE);

    COMMIT;
    
    
    -- 예외처리
    EXCEPTION
        WHEN MID_DROP_STU_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20601, '중도포기한 수업입니다.');
                ROLLBACK;
        WHEN APP_OVERLAP_ERROR
            THEN RAISE_APPLICATION_ERROR(-20602, '이미 성적이 등록된 학생입니다');
                ROLLBACK;
        WHEN GRADE_DATE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20603, '성적입력기간이 아닙니다');
                ROLLBACK;

         WHEN OTHERS
            THEN ROLLBACK;
    
END;

--==>> Procedure PRC_GRADE_INSERT이(가) 컴파일되었습니다.





-- 2. 성적 수정 PRC_SCORE_UPDATE(성적코드, 출결, 필기, 실기)  작동확인
-- EXEC PRC_SCORE_UPDATE(성적코드, 출결, 필기, 실기); 
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
( V_GRADE_CODE      IN GRADE.GRADE_CODE%TYPE
, V_GRADE_ATT       IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT        IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT        IN GRADE.GRADE_PT%TYPE
)
IS
BEGIN
    -- 출결, 필기, 실기 업데이트
    UPDATE GRADE
    SET GRADE_ATT = V_GRADE_ATT, GRADE_WT = V_GRADE_WT, GRADE_PT = V_GRADE_PT
    WHERE GRADE_CODE = V_GRADE_CODE;
END;
--==>> Procedure PRC_GRADE_UPDATE이(가) 컴파일되었습니다.

---------------------------------------------------------------------------
-- 3. 성적 삭제 PRC_GRADE_DELETE(성적 코드) -- 작동확인
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
    
    -- 결과 집합의 결과 ROW 수가 0이면 TRUE, 아니면 FALSE를 반환
    -- 조회 결과 수가 0일 경우엔 에러 발생
    IF SQL%NOTFOUND
    THEN RAISE NOTEXIST_ERROR;
    END IF;
    
    COMMIT;
    
    EXCEPTION 
        WHEN NOTEXIST_ERROR
            THEN RAISE_APPLICATION_ERROR(-20605,'일치하는 데이터가 없습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_GRADE_DELETE이(가) 컴파일되었습니다.


-------------------------------------------------------------------------------------
--중도탈락 입력
CREATE OR REPLACE PROCEDURE PRC_QUITLIST_INSERT
( V_QUIT_DATE    IN QUITLIST.QUIT_DATE%TYPE
, V_APP_CODE     IN QUITLIST.APP_CODE%TYPE
, V_QR_CODE      IN QUIT_REASON.QR_CODE%TYPE

)
IS  
    V_QUIT_CODE   QUITLIST.QUIT_CODE%TYPE;   -- 중도포기 코드 
    
    V_START_DATE   OPENED_COURSE.OC_START%TYPE; -- 과정 시작일 담기
    V_END_DATE     OPENED_COURSE.OC_END%TYPE;   -- 과정 종료일 담기
    
    USER_DEFINE_ERROR1 EXCEPTION;              -- 중도포기일이 과정기간 안에 없으면 오류
    USER_DEFINE_ERROR2 EXCEPTION;              -- 이미 중도포기한 학생이면 오류 발생
    
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
        THEN RAISE_APPLICATION_ERROR(-20770, '과정 기간일에 포함되지 않습니다~!!!');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
        THEN RAISE_APPLICATION_ERROR(-20771, '이미 중도포기한 학생입니다~!!!');
        ROLLBACK;
    COMMIT;
END;

-------------------------------------------------------------------------------------------------
--부모테이블 데이터
---------------------------------------------------------------------------------------------------------
--관리자  테이블 데이터 입력
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('janghs','java006$','장현성');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('usy1234','java007$','엄소연');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('kbk987','java008$','김보경');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('jhh3579','java009$','조현하');

--==>>1 행 이(가) 삽입되었습니다.*4
SELECT *
FROM ADMIN;
---------------------------------------------------------------------------------------------------
--교수자 테이블 데이터 입력

SELECT *
FROM PROFESSOR;


EXEC  PRC_PROFESSOR_INSERT('1045987','호진샘',TO_DATE('2000-01-01','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('2024123','박세미',TO_DATE('2005-02-03','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('1011325','김프로',TO_DATE('1997-02-04','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('1021728','잭',TO_DATE('2013-05-07','YYYY-MM-DD'));
EXEC  PRC_PROFESSOR_INSERT('2051421','마무리',TO_DATE('2015-12-25','YYYY-MM-DD'));
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.*5

/*
20220011	1045987	호진샘	2000-01-01
20220012	2024123	박세미	2005-02-03
20220013	1011325	김프로	1997-02-04
20220014	1021728	잭	2013-05-07
20220015	2051421	마무리	2015-12-25
*/


---------------------------------------------------------------------------------------------
--학생 테이블 데이터
SELECT *
FROM STUDENT;
EXEC PRC_STUDENT_INSERT('2234567','김인교' ,TO_DATE('2022-01-01', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1234567','민찬우' ,TO_DATE('2021-02-02', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1035798','유동현' ,TO_DATE('2020-05-07', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1032599','김태민' ,TO_DATE('2021-12-05', 'YYYY-MM-DD'));
EXEC PRC_STUDENT_INSERT('1057239','정영준' ,TO_DATE('2020-11-28', 'YYYY-MM-DD'));
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.*5
/*
20220002	2234567	김인교	2022-01-01
20220003	1234567	민찬우	2021-02-02
20220004	1035798	유동현	2020-05-07
20220005	1032599	김태민	2021-12-05
20220006	1057239	정영준	2020-11-28
*/

---------------------------------------------------------------------------------------------
SELECT *
FROM SUBJECT_NAME;
--과목 테이블 데이터
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
--교재 테이블 데이터
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA001','자바의정석','도우출판');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING001','스프링 프레임워크 첫걸음','위키북스');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JS001','DO it! 자바스크립트','학산미디어');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('ORACLE001','오라클 SQL','위키북스');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('HTML001','HTML가이드북','위키북스');

SELECT *
FROM QUIT_REASON;
--중도탈락사유 테이블 데이터
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A001', '개인 사정');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A002', '조기 취업');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A003', '진로 변경');
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A004', '개인 사정');

COMMIT;
------------------------------------------------------------------------------------------------------------------------


SELECT *
FROM CLASSROOM;
--과정 테이블 데이터
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C001','빅데이터 개발자 양성과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C002','빅데이터 개발자 양성과정(B)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('F001','Full-Stack 개발자 양성 과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S001','SW 개발자 양성과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S002','SW 개발자 양성과정(B)');

--강의실 테이블 데이터
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL001','A클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL002','B클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL003','C클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL004','D클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL005','E클래스',20);


--과정 테이블에 INSERT 
EXEC PRC_COURSE_INSERT('C001','빅데이터 개발자 양성과정(A)');
EXEC PRC_COURSE_INSERT('C002','빅데이터 개발자 양성과정(B)');
EXEC PRC_COURSE_INSERT('F001','Full-Stack 개발자 양성 과정(A)');
EXEC PRC_COURSE_INSERT('S001','SW 개발자 양성과정(A)');
EXEC PRC_COURSE_INSERT('S002','SW 개발자 양성과정(B)');

-- 과정 테이블 조회
SELECT *
FROM COURSE;
--==>>
/*
C001   빅데이터 개발자 양성과정(A)
C002   빅데이터 개발자 양성과정(B)
F001   Full-Stack 개발자 양성 과정(A)
S001   SW 개발자 양성과정(A)
S002   SW 개발자 양성과정(B)
*/
--=========================================================================================================
--자식테이블 데이터
-----------------------------------------------------------------------------------------------------------
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL003' ,'F001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL004' ,'S001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-01-25', 'YYYY-MM-DD'),'CL005' ,'S001');

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>>
/*
OCC2	2022-05-27	2022-12-15	CL001	C002   빅데이터 개발자 양성과정(B) 
OCF3	2022-09-29	2023-03-25	CL003	F001   Full-Stack 개발자 양성 과정(A)
OCS4	2022-09-14	2023-03-25	CL004	S001   SW 개발자 양성과정(A)
OCS5	2022-09-14	2023-01-25	CL005	S002   SW 개발자 양성과정(B)
*/

-- 프로시저 호출을 통한 과정 테이블 INSERT
EXEC PRC_COURSE_INSERT('C001','빅데이터 개발자 양성과정(A)');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 중복 데이터 INSERT 
EXEC PRC_COURSE_INSERT('C001','빅데이터 개발자 양성과정(A)');
--==>> ORA-20500: 이미 등록된 과정

-- 프로시저 실행 후 과정 테이블 조회
SELECT *
FROM COURSE;
--==>> C001   빅데이터 개발자 양성과정(A)

-- 프로시저 호출을 통한 과정 테이블 UPDATE
EXEC PRC_COURSE_UPDATE('C001', 'Full-Stack 개발자 양성 과정(A)');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 과정코드 없는 데이터 UPDATE
EXEC PRC_COURSE_UPDATE('C003', 'Full-Stack 개발자 양성 과정(A)');
--==>> ORA-20501: 존재하지 않는 과정이므로 수정 불가능

-- 프로시저 실행 후 과정 테이블 조회
SELECT *
FROM COURSE;
--==> C001   Full-Stack 개발자 양성 과정(A)

-- 프로시저 호출을 통한 과정 테이블에 DELETE
EXEC PRC_COURSE_DELETE('C001');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 과정코드 없는 데이터 DELETE
EXEC PRC_COURSE_DELETE('C003');
--==>> ORA-20502: 존재하지 않는 과정이므로 삭제 불가능

-- 프로시저 실행 후 과정 테이블 조회
SELECT *
FROM COURSE;
--==> 조회 결과 없음

-- 테스트를 위한 과정 테이블에 INSERT 
EXEC PRC_COURSE_INSERT('C001','빅데이터 개발자 양성과정(A)');
EXEC PRC_COURSE_INSERT('C002','빅데이터 개발자 양성과정(B)');
EXEC PRC_COURSE_INSERT('F001','Full-Stack 개발자 양성 과정(A)');
EXEC PRC_COURSE_INSERT('S001','SW 개발자 양성과정(A)');
EXEC PRC_COURSE_INSERT('S002','SW 개발자 양성과정(B)');

-- 과정 테이블 조회
SELECT *
FROM COURSE;
--==>>
/*
C001   빅데이터 개발자 양성과정(A)
C002   빅데이터 개발자 양성과정(B)
F001   Full-Stack 개발자 양성 과정(A)
S001   SW 개발자 양성과정(A)
S002   SW 개발자 양성과정(B)
*/

-- 과정 출력 뷰
SELECT *
FROM VIEW_COURSE;

-- 프로시저 호출을 통한 개설과정 테이블 INSERT
-- 개설 과정 INSERT
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C001');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- 개설 과정 INSERT 존재하지 않는 강의실
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'C0002' ,'C001');
--==>> ORA-20505: 강의실이 존재하지 않음

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- 개설 과정 INSERT 존재하지 않는 과정코드
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C003');
--==>> ORA-20503: 과정이 존재하지 않음

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- 개설 과정 INSERT 종료일이 시작일 보다 이전인 경우
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C001');
--==>> ORA-20504: 과정시작일 및 종료일 오류

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/08/15   2023/02/17   CL002   C001

-- 테스트를 위한 개설 과정 테이블에 INSERT 
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
EXEC PRC_OPENED_COURSE_INSERT(TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL003' ,'F001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL004' ,'S001');
EXEC PRC_OPENED_COURSE_INSERT(SYSDATE, TO_DATE('2023-01-25', 'YYYY-MM-DD'),'CL003' ,'S001');

-- 개설 과정 테이블 조회
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

-- 프로시저 호출을 통한 개설과정 테이블 UPDATE
-- 개설 과정 UPDATE (종료일 변경)
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-16', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 개설 과정 테이블 조회
SELECT *
FROM OPENED_COURSE;
--==>> OCC1   2022/05/27   2022/12/16   CL001   C002

-- 개설과정 코드가 존재하지 않을 때 UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC3', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> ORA-20506: 존재하지 않는 개설과정이므로 수정 불가능

-- 개설 과정 테이블 조회
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

-- 과정 코드가 존재하지 않을 때 UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C015');
--==>> ORA-20507: 과정이 존재하지 않아 수정 불가능

-- 개설 과정 테이블 조회
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

-- 과정종료일이 과정시작일 보다 이전일 때 UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2021-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');
--==>> ORA-20508: 과정시작일 및 종료일 오류로 수정 불가능

-- 개설 과정 테이블 조회
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

-- 강의실 고드가 존재하지 않을 때 UPDATE
EXEC PRC_OPENED_COURSE_UPDATE('OCC1', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CR001' ,'C002');
EXEC PRC_OPENED_COURSE_UPDATE('OCS5',TO_DATE('2022-09-14','YYYY-MM-DD'),TO_DATE('2023-01-25','YYYY-MM-DD'),'CL005','S002')

--==>> ORA-20509: 강의실이 존재하지 않아 수정 불가능

-- 개설 과정 테이블 조회
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

-- 프로시저 호출을 통한 개설과정 테이블 DELETE
-- 존재하는 개설과정이 없을 때
EXEC PRC_OPENED_COURSE_DELETE('OCC3');
--==>> ORA-20510: 존재하지 않는 과정이므로 삭제 불가능

-- 개설 과정 테이블 조회
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

-- 개설 과정 DELETE
EXEC PRC_OPENED_COURSE_DELETE('OCC1');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 개설 과정 테이블 조회
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
--개설과정 데이터 있어야 들어가는 애들
------------------------------------------------------------------------------------------------------------
--개설과목 데이터
--EXEC PRC_OPSUB_INSERT
--(과목시작일,과목종료일,개설날짜,실기배점,필기배점,출결배점,교재코드,교수ID,과목코드,개설과정코드)

/*
JAVA001	    자바의정석	도우출판
SPRING001	스프링 프레임워크 첫걸음	위키북스
JS001	    DO it! 자바스크립트	학산미디어
ORACLE001	오라클 SQL	위키북스
HTML001	    HTML가이드북	위키북스
*/
/*
교수ID
20220011	1045987	호진샘	2000-01-01
20220012	2024123	박세미	2005-02-03
20220013	1011325	김프로	1997-02-04
20220014	1021728	잭	2013-05-07
20220015	2051421	마무리	2015-12-25
*/
/*
과목코드
J001	JAVA
S001	SPRING
JS001	JavaScript
O001	ORACLE
H001	HTML
*/
/*
개설과정코드
OCC2	2022-05-27	2022-12-15	CL001	C002   빅데이터 개발자 양성과정(B) 
OCF3	2022-09-29	2023-03-25	CL003	F001   Full-Stack 개발자 양성 과정(A)
OCS4	2022-09-14	2023-03-25	CL004	S001   SW 개발자 양성과정(A)
OCS5	2022-09-14	2023-01-25	CL005	S002   SW 개발자 양성과정(B)
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
--===>>PL/SQL 프로시저가 성공적으로 완료되었습니다.*4

EXEC PRC_APP_INSERT(TO_DATE('2022-05-31','YYYY-MM-DD'),'20220011','OCC2');
--==>>ORA-20203: 수강신청일이 아닙니다.






INSERT INTO GRADE(GRADE_CODE,GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE) VALUES('A00001',DEFAULT,90,80,75,'OSJ1','G301');

EXEC PRC_STUDENT_INSERT('학생이름,PW(주민번호 뒷자리)'); 

--(과목시작일,과목종료일,개설날짜,실기배점,필기배점,출결배점,교재코드,교수ID,과목코드,개설과정코드)
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-08-15','YYYY-MM-DD'),TO_DATE('2022-09-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');

EXEC PRC_OPSUB_UPDATE('OSJ1',TO_DATE('2022-09-26','YYYY-MM-DD'),TO_DATE('2022-10-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');
--오류 해결
EXEC PRC_OPSUB_DELETE('OSJ1');

-----------------------------------------------------------------------------------------------------------------------
--성적 데이터 입력
EXEC PRC_GRADE_INSERT(TO_DATE('2023-09-26','YYYY-MM-DD'),90,90,90,'OSJ12','AP0001');

-----------------------------------------------------------------------------------------------------------------------




--과목 조회 뷰
--과정명 /강의실/ 과목명/과목 기간 /교재 명/ 교수자명
CREATE OR REPLACE VIEW VIEW_SUBJECT
AS
SELECT CO.COURSE_NAME "과정명"
    , CR.CR_NAME "강의실"
    , SN.SUB_NAME "과목명"
    , OS.OS_START || '~' || OS.OS_END "과목기간"
    , TB.TB_NAME "교재명"
    , PF.PROF_NAME "교수자명"
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
-- 관리자 학생 관리 기능 구현
-- 학생 이름, 과정명, 수강과목, 수강과목 총점, 중도탈락여부
CREATE OR REPLACE VIEW VIEW_STUDENTS
AS
SELECT ST.STU_NAME"학생명",CO.COURSE_NAME"과정명",SN.SUB_NAME"수강과목"
     , (NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100) + (NVL(GR.GRADE_WT,0)*OS.OS_WT/100) + (NVL(GR.GRADE_PT,0)*OS.OS_PT/100)"수강과목총점"
     , (CASE WHEN AP.APP_CODE =  QL.APP_CODE THEN '중도탈락' ELSE' ' END)"중도탈락여부"
FROM STUDENT ST JOIN APP AP --학생 앱
ON ST.STU_ID = AP.STU_ID    
    JOIN OPENED_COURSE OC
    ON AP.OC_CODE = OC.OC_CODE      -- 앱 개설과정
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
-- 사용자 측 요구분석(학생)
-- 출력 정보는 학생 이름, 과정명, 과목명, 교육 기간(시작 연월일, 끝 연월일), 교재 명, 
-- 출결, 실기, 필기, 총점, 등수가 출력되어야 한다. 
CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE
AS
SELECT T.학생이름, T.과정명, T.과목명, T.시작일, T.종료일, T.교재명, T.출결, T.실기, T.필기, T.총점
     , RANK()OVER(PARTITION BY T.개설과목코드 ORDER BY T.총점 DESC)"등수"
FROM
(
SELECT ST.STU_NAME"학생이름",CO.COURSE_NAME"과정명",SN.SUB_NAME"과목명",OS.OS_START"시작일",OS.OS_END"종료일",TB.TB_NAME"교재명"
,(NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100)"출결"
,(NVL(GR.GRADE_PT,0)*OS.OS_PT/100)"실기"
,(NVL(GR.GRADE_WT,0)*OS.OS_WT/100)"필기"
, (NVL(GR.GRADE_ATT,0)*OS.OS_ATT/100) + (NVL(GR.GRADE_PT,0)*OS.OS_PT/100) + (NVL(GR.GRADE_WT,0)*OS.OS_WT/100) "총점"
,OS.OS_CODE"개설과목코드"
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
                    JOIN GRADE GRㅁ
                    ON OS.OS_CODE = GR.OS_CODE AND GR.APP_CODE = AP.APP_CODE
                        JOIN TEXTBOOK TB
                        ON OS.TB_CODE = TB.TB_CODE
) T;

----------------------------------------------------------------------------------------
-- 개설과정 정보 출력 -----------------------------------------------------------
CREATE OR REPLACE VIEW VIEW_COURSE
AS
SELECT CO.COURSE_NAME "과정명"
    , CR.CR_NAME "강의실"
    , SN.SUB_NAME "과목명"
    , OS.OS_START || '-' || OS.OS_END "과목기간"
    , TB.TB_NAME "교재명"
    , PF.PROF_NAME "교수자명"
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
