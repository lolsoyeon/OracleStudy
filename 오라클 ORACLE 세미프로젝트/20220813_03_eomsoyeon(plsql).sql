-- 데이터 입력 프로시저 

/*
-- 성적코드, 출결, 필기, 실기
-- EXEC PRC_GRADE_UPDATE (성적코드, 출결, 필기, 실기)
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
( V_GRADE_CODE      IN GRADE.GRADE_CODE%TYPE
, V_GRADE_ATT       IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT        IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT        IN GRADE.GRADE_PT%TYPE
)
IS
    -- 개설과목코드 , 과목종료일, 평가날짜
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
    
    -- 종료일 20221003 > 현재 20220913
    IF(V_OS_END < SYSDATE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE GRADE
    SET GRADE_ATT =V_GRADE_ATT , GRADE_WT =V_GRADE_WT , GRADE_PT = V_GRADE_PT
    WHERE GRADE_CODE = V_GRADE_CODE; 
    
    COMMIT;
    
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-206001,'성적입력은 과목이 종료된 후에 가능합니다.');
             ROLLBACK;
    WHEN OTHERS THEN ROLLBACK;
    
END;
--==>> Procedure PRC_GRADE_UPDATE이(가) 컴파일되었습니다.
*/

-- 성적 수정 PRC_SCORE_UPDATE(점수ID, 출결, 필기, 실기) --
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


--  성적 코드 시퀀스 생성
CREATE SEQUENCE SEQ_GRADE_CODE
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;
--==>> Sequence SEQ_GRADE_CODE이(가) 생성되었습니다.




-- 성적 입력 PRC_GRADE_INSERT(개설과정코드,수강신청코드,출결,필기,실기) -- 
CREATE OR REPLACE PROCEDURE PRC_SCORE_INSERT
( V_OS_CODE             IN GRADE.OS_CODE%TYPE      
, V_APP_CODE            IN GRADE.APP_CODE%TYPE            
, V_GRADE_ATT           IN GRADE.GRADE_ATT%TYPE
, V_GRADE_WT            IN GRADE.GRADE_WT%TYPE
, V_GRADE_PT            IN GRADE.GRADE_PT%TYPE
)
IS

    V_OS_END            OPENED_SUBJECT.OS_END%TYPE;          -- 개설과목 종료일    
    V_GRADE_DATE        GRADE.GRADE_DATE%TYPE;               -- 평가날짜   
    V_GRADE_CODE          GRADE.GRADE_CODE%TYPE;             -- 점수 코드
    V_FAPP_ID           GRADE.APP_CODE%TYPE;                -- 수강신청코드 중복검사   
    V_FOP_SUB           GRADE.OS_CODE%TYPE;                 -- 개설과목코드 중복검사
    V_MID_DROP          NUMBER;                            -- 중도포기 


    MID_DROP_STU_ERROR EXCEPTION;                   -- 중도포기에러  
    APP_OVERLAP_ERROR EXCEPTION;                    -- 수강신청코드시 중복시 에러 
    GRADE_DATE_ERROR   EXCEPTION;                  -- 개설과목 진행중에 성적입력X 에러

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
    
    -- 과목 진행 중간에 성적 입력 불가 
    -- 끝나는 날짜보다 이르면 입력 불가
    SELECT OS_END INTO V_OS_END
    FROM OPENED_SUBJECT
    WHERE OS_CODE =  V_OS_CODE;

    IF (V_OS_END > SYSDATE)
        THEN RAISE GRADE_DATE_ERROR;
    END IF;
    --GRADE_CODE + 시퀀스 번호 표기 
    V_GRADE_CODE := 'G'||TO_CHAR(SYSDATE,'YY');
    
    -- 성적테이블에 INSERT
    INSERT INTO GRADE(GRADE_CODE, OS_CODE, GRADE_ATT, GRADE_WT, GRADE_PT, APP_CODE)
    VALUES(V_GRADE_CODE||LPAD(TO_CHAR(SEQ_GRADE_CODE.NEXTVAL),5,'0'), V_OS_CODE, V_APP_CODE, 
          V_GRADE_ATT, V_GRADE_WT, V_GRADE_PT);

    -- 커밋
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
            THEN RAISE_APPLICATION_ERROR(-20602, '성적입력기간이 아닙니다');
                ROLLBACK;

         WHEN OTHERS
            THEN ROLLBACK;
END;

--==>> Procedure PRC_SCORE_INSERT이(가) 컴파일되었습니다.





-- 성적 삭제 PRC_GRADE_DELETE(성적 코드) --
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






--과정명 /강의실/ 과목명/과목 기간 /교재 명/ 교수자명
CREATE OR REPLACE VIEW VIEW_SUBJECT
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

SELECT *
FROM VIEW_SUBJECT;




--■■■ 배점 부여 PRC_SCORE_POINT ■■■--
CREATE OR REPLACE PROCEDURE PRC_SCORE_POINT
(
     V_OS_CODE   IN OPENED_SUBJECT.OS_CODE%TYPE
    ,V_OS_WT            IN OPENED_SUBJECT.OS_WT%TYPE     -- 필기배점
    ,V_OS_PT            IN OPENED_SUBJECT.OS_PT%TYPE    -- 실기배점
    ,V_OS_ATT           IN OPENED_SUBJECT.OS_ATT%TYPE    -- 출결배점
)
IS
BEGIN
    UPDATE OPENED_SUBJECT
    SET OS_WT = V_OS_WT, OS_PT = V_OS_PT, OS_ATT = V_OS_ATT
    WHERE OS_CODE = V_OS_CODE;
END;
--==>> Procedure PRC_SCORE_POINT이(가) 컴파일되었습니다.


--■■■ 수강과목 총점 함수 TOTAL_SCORE ■■■--

CREATE OR REPLACE FUNCTION TOTAL_SCORE
(
    --성적 GRADE,  개설과목(배점) OPENED_SUBJECT 호출
    V_GRADE_CODE   IN GRADE.GRADE_CODE%TYPE
   ,V_OS_CODE       IN OPENED_SUBJECT.OS_CODE%TYPE
)
    -- 숫자값을 리턴
    RETURN NUMBER
IS
    -- 주요 변수 선언
    RESULT NUMBER;
    
    V_P_POINT OS.PT%TYPE;
    V_W_POINT OS.WT%TYPE;
    V_A_POINT OS.ATT%TYPE;
    
    V_P_GRADE GRADE.GRADE.PT%TYPE;
    V_W_GRADE GRADE.GRADE.WT%TYPE;
    V_A_GRADE GRADE.GRADE.ATT%TYPE;
    
BEGIN
    -- 배점 받아오기 30
    -- NULL일 경우 0으로 치환
    SELECT NVL(OS.PT,0), NVL(OS.WT,0), NVL(OS.ATT,0) INTO V_P_POINT, V_W_POINT, V_A_POINT
    FROM OPENED_SUBJECT
    WHERE OS_CODE = V_OS_CODE;
    
    -- 점수 받아오기 100
    -- NULL일 경우 0으로 치환    
    SELECT NVL(GRADE.PT,0), NVL(GRADE.WT,0), NVL(GRADE.ATT,0) INTO V_P_GRADE, V_W_GRADE, V_A_GRADE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    -- (30 * 100 + 20 * 90 + 50 * 80)/100  3000 + 1800 + 4000 = 8800/100
    -- 30 * 0.01 = 0.3 /* 98 => 29.4  / 40 * 0.01 = 0.4/ * 56 = 22.4  / 30 * 0.01 = 0.3 /* 44 = 13.2 
    -- 29.4 + 22.4 + 13.2 = 65
    -- (V_P_POINT * 0.01 * V_P_SCORE) +(V_W_POINT* 0.01 * V_W_SCORE) + (V_A_POINT* 0.01 *V_A_SCORE);
    RESULT := (V_P_POINT*V_P_SCORE + V_W_POINT*V_W_SCORE + V_A_POINT*V_A_SCORE)/100;

    -- 최종 결과 반환
    RETURN RESULT;
END;
