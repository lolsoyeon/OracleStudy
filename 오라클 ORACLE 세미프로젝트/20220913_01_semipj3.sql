SELECT USER
FROM DUAL;
--==>> SEMIPJ3

-- 성적 테이블
CREATE TABLE GRADE 
( GRADE_CODE       VARCHAR2(10)       NOT NULL                      -- 성적코드
, GRADE_DATE       DATE               DEFAULT SYSDATE               -- 평가날짜
, GRADE_ATT       NUMBER(3)                                         -- 출결
, GRADE_WT       NUMBER(3)                                          -- 필기
, GRADE_PT       NUMBER(3)                                          -- 실기
, OS_CODE       VARCHAR2(10)       NOT NULL                         -- 개설과목코드
, APP_CODE       VARCHAR2(10)       NOT NULL                        -- 수강신청코드
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);

ALTER TABLE GRADE
ADD CONSTRAINT GRADE_OS_CODE_FK FOREIGN KEY (OS_CODE)
    REFERENCES OPENED_SUBJECT(OS_CODE);


ALTER TABLE GRADE
ADD CONSTRAINT GRADE_APP_CODE_FK FOREIGN KEY (APP_CODE)
    REFERENCES APP(APP_CODE);





---수강과목 총점 함수 TOTAL_SCORE ---
CREATE OR REPLACE FUNCTION TOTAL_SCORE
(
    --성적 SCORE,  개설과목(배점) OPENED_SUBJECT 호출
    V_GRADE_CODE IN GRADE.GRADE_CODE%TYPE
   ,V_OS_CODE    IN OPENED_SUBJECT.OS_CODE%TYPE
)
    -- 숫자값을 리턴
    RETURN NUMBER
IS
    -- 주요 변수 선언
    RESULT NUMBER;
    
    V_P_POINT OPENED_SUBJECT.OS_PT%TYPE;
    V_W_POINT OPENED_SUBJECT.OS_WT%TYPE;
    V_A_POINT OPENED_SUBJECT.OS_ATT%TYPE;
    
    V_P_SCORE GRADE.GRADE_PT%TYPE;
    V_W_SCORE GRADE.GRADE_WT%TYPE;
    V_A_SCORE GRADE.GRADE_ATT%TYPE;
    
BEGIN
    -- 배점 받아오기 
    -- NULL일 경우 0으로 치환
    SELECT NVL(OS_PT,0), NVL(OS_WT,0), NVL(OS_ATT,0) INTO V_P_POINT, V_W_POINT, V_A_POINT
    FROM OPENED_SUBJECT
    WHERE OS_CODE = V_OS_CODE;
    
    -- 점수 받아오기
    -- NULL일 경우 0으로 치환    
    SELECT NVL(GRADE_PT,0), NVL(GRADE_WT,0), NVL(GRADE_ATT,0) INTO V_P_SCORE, V_W_SCORE, V_A_SCORE
    FROM GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    RESULT := (V_P_POINT*V_P_SCORE + V_W_POINT*V_W_SCORE + V_A_POINT*V_A_SCORE)/100;

    -- 최종 결과 반환
    RETURN RESULT;
END;
--==>> Function TOTAL_SCORE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
-- 배점 부여 PRC_SCORE_POINT --
CREATE OR REPLACE PROCEDURE PRC_SCORE_POINT
(
     V_OS_CODE        IN OPENED_SUBJECT.OS_CODE%TYPE
    ,V_OS_WT          IN OPENED_SUBJECT.OS_WT%TYPE     -- 필기배점
    ,V_OS_PT          IN OPENED_SUBJECT.OS_PT%TYPE      -- 실기배점
    ,V_OS_ATT         IN OPENED_SUBJECT.OS_ATT%TYPE    -- 출결배점
)
IS
BEGIN
    UPDATE OPENED_SUBJECT
    SET OS_WT = V_OS_WT, OS_PT = V_OS_PT, OS_ATT = V_OS_ATT
    WHERE OS_CODE = V_OS_CODE;
END;
--==>> Procedure PRC_SCORE_POINT이(가) 컴파일되었습니다.




/*
■■■ 사용자 측 요구분석(학생) - 성적 출력 기능 구현 ■■■
학생 이름, 과정명, 과목명, 교육 기간(시작 연월일, 끝 연월일), 교재 명, 출결, 실기, 필기, 총점, 등수 
아직 안끝난 과목은 출력 불가

*/

CREATE OR REPLACE VIEW VIEW_STUDENT_GRADE  
AS 
SELECT DISTINCT T1.학생이름
    , T1.과정명
    , T1.과목명
    , T1.과목시작일
    , T1.과목종료일
    , T1.교재명
    , T1.출결성적
    , T1.필기성적
    , T1.실기성적
    , T1.총점
    , T1.등수
FROM(    
    SELECT S.STU_NAME 학생이름
    , C.COURSE_NAME 과정명
    , SUB.SUB_NAME 과목명
    , OS.OS_START 과목시작일
    , OS.OS_END 과목종료일
    , B.TB_NAME 교재명
    , NVL(G.GRADE_ATT * OS.OS_ATT, 0) / 100 출결성적
    , NVL(G.GRADE_PT * OS.OS_PT, 0) / 100 실기성적
    , NVL(G.GRADE_WT * OS.OS_WT, 0) / 100 필기성적 
    , NVL(G.GRADE_ATT * OS.OS_ATT, 0) / 100 + NVL(SC.PRACTICE_SCORE * OS.PRACTICE_POINT, 0) / 100 
    + NVL(G.GRADE_WT * OS.OS_WT, 0) / 100 "총점"
    , S.STU_ID 학생코드
    ,SUB.SUB_CODE 과목코드
    , RANK() OVER(PARTITION BY OS.SUB_CODE||OC.OS_START||OC.PROF_ID ORDER BY SC.ATTEND_SCORE + SC.WRITE_SCORE + SC.PRACTICE_SCORE DESC) 등수
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
WHERE 학생이름 = '?넣은데이터입력';










