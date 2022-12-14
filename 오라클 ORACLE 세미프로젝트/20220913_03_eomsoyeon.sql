SELECT USER
FROM DUAL;
--==>>EOMSOYEON

SELECT USER
FROM DUAL;
--==>>SEMIPJ3
--=========================================================================================================
--부모테이블 데이터
---------------------------------------------------------------------------------------------------------
--관리자  테이블 데이터
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('kimtaemin','java002$','김태민');
INSERT INTO ADMIN (AD_ID, AD_PW , AD_NAME ) VALUES ('janghs','java006$','장현성');
--==>>1 행 이(가) 삽입되었습니다.*2

---------------------------------------------------------------------------------------------------
-- 1. 교수자 테이블 데이터

SELECT *
FROM PROFESSOR;
ROLLBACK;
INSERT INTO PROFESSOR(PROF_ID, PROF_PW, PROF_NAME, PROF_DATE) VALUES ('hjteacher22','1045987','김호진',SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.

INSERT INTO PROFESSOR(PROF_ID, PROF_PW, PROF_NAME, PROF_DATE) 
VALUES ('javagosu','2024123','고수영',TO_DATE('2000-01-01','YYYY-MM-DD'));

INSERT INTO PROFESSOR(PROF_ID, PROF_PW, PROF_NAME, PROF_DATE) 
VALUES ('hangeul97','1011325','김세종',TO_DATE('1997-02-04','YYYY-MM-DD'));

INSERT INTO PROFESSOR(PROF_ID, PROF_PW, PROF_NAME, PROF_DATE) 
VALUES ('hungryman','1021728','장시장',TO_DATE('2013-05-07','YYYY-MM-DD'));

INSERT INTO PROFESSOR(PROF_ID, PROF_PW, PROF_NAME, PROF_DATE) 
VALUES ('mmm1234','2051421','박세연',TO_DATE('2015-12-25','YYYY-MM-DD'));

alter session set nls_date_format='YYYY-MM-DD'
---------------------------------------------------------------------------------------------
--2. 학생 테이블 데이터

COMMIT;

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES ('20171305', '2234567', '김보경', TO_DATE('2022-09-08', 'YYYY-MM-DD'));

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES ('20153075', '1234567', '김태민', TO_DATE('2022-09-08', 'YYYY-MM-DD'));

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES ('20143054', '2133567', '조현하', TO_DATE('2022-09-08', 'YYYY-MM-DD'));

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES ('20131001', '2234317', '엄소연', TO_DATE('2022-09-08', 'YYYY-MM-DD'));

INSERT INTO STUDENT(STU_ID, STU_PW, STU_NAME, STU_DATE )
VALUES ('20161062', '1246867', '장현성', TO_DATE('2022-09-08', 'YYYY-MM-DD'));



SELECT *
FROM STUDENT;
---------------------------------------------------------------------------------------------
SELECT *
FROM SUBJECT_NAME;



ROLLBACK;

--3. 과목 테이블 데이터
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('J001','JAVA');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('S001','SPRING');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('JS001','JavaScript');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('O001','ORACLE');
INSERT INTO SUBJECT_NAME(SUB_CODE, SUB_NAME) VALUES('H001','HTML');

-- 4. 교재 테이블 데이터
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA001','자바의정석','도우출판');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA002','코딩은 처음이라 with 자바','영진닷컴');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('PYTHON001','DO it! 파이썬 프로그래밍','학산미디어');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING001','스프링 프레임워크 첫걸음','위키북스');
INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('SPRING002','스프링 부트핵심가이드','위키북스');

SELECT *
FROM TEXTBOOK;

---------------------------------------------------------------------------------------------

-- 5. 중도탈락사유 테이블 데이터
INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A001', '개인 사정');

INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A002', '개인 사정');

INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('A003', '조기 취업');

INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('B001', '진로 변경');

INSERT INTO QUIT_REASON(QR_CODE, QUIT_REASON) VALUES('B002', '개인 사정');

SELECT *
FROM QUIT_REASON;

------------------------------------------------------------------------------------------------------------------------


SELECT *
FROM COURSE;
-- 6. 과정 테이블 데이터
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C001','빅데이터 개발자 양성과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('C002','빅데이터 개발자 양성과정(B)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('F001','Full-Stack 개발자 양성 과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S001','SW 개발자 양성과정(A)');
INSERT INTO COURSE(COURSE_CODE,COURSE_NAME) VALUES ('S002','SW 개발자 양성과정(B)');

-- 7. 강의실 테이블 데이터
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL001','A클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL002','B클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL003','C클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL004','D클래스',20);
INSERT INTO CLASSROOM(CR_CODE,CR_NAME,CR_CAPACTIY) VALUES('CL005','E클래스',20);


SELECT *
FROM CLASSROOM;
--=========================================================================================================
--자식테이블 데이터
-----------------------------------------------------------------------------------------------------------
--8. 개설 과정 데이터
INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
VALUES( 'H1', TO_DATE('2022-08-15', 'YYYY-MM-DD'), TO_DATE('2023-02-17', 'YYYY-MM-DD'),'CL002' ,'C001');

INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
VALUES( 'H2', TO_DATE('2022-05-27', 'YYYY-MM-DD'), TO_DATE('2022-12-15', 'YYYY-MM-DD'),'CL001' ,'C002');

INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
VALUES( 'H3', TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL003' ,'F001');


INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
VALUES( 'H4', SYSDATE, TO_DATE('2023-03-25', 'YYYY-MM-DD'),'CL004' ,'S001');

INSERT INTO OPENED_COURSE(OC_CODE, OC_START, OC_END, CR_CODE, COURSE_CODE)
VALUES( 'H5', SYSDATE, TO_DATE('2023-01-25', 'YYYY-MM-DD'),'CL003' ,'S001');


SELECT *
FROM OPENED_COURSE;


--=========================================================================================================
--개설과정 데이터 있어야 들어가는 애들
------------------------------------------------------------------------------------------------------------
-- 9.개설과목 데이터
-- OPENED_SUBJECT 
INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS001',TO_DATE('2022-08-15','YYYY-MM-DD'), TO_DATE('2022-09-25','YYYY-MM-DD')
, TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1' );


SELECT *
FROM OPENED_COURSE;


SELECT *
FROM OPENED_SUBJECT;


INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G311', SYSDATE, '20131001', 'H1');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G305', SYSDATE, '20161062', 'H1');

--테스트용 성적 INSERT

SELECT *
FROM STUDENT;

COMMIT;



INSERT INTO GRADE(GRADE_CODE, GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE) VALUES('A00001',DEFAULT, 90, 80, 75,'OS005','G301');

SELECT *
FROM GRADE;

SELECT *
FROM OPENED_SUBJECT;


-- 10. 개설과목 데이터 
INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE,PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS003',TO_DATE('2022-08-21','YYYY-MM-DD'),TO_DATE('2023-02-03','YYYY-MM-DD',TO_DATE('2022-08-17','YYYY-MM-DD'), 30, 30, 40, 'SPRING001','hangeul97','SUBJECT_NAME','H3');

INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS002',TO_DATE('2021-08-07','YYYY-MM-DD'),TO_DATE('2021-12-17','YYYY-MM-DD'),TO_DATE('2020-12-17','YYYY-MM-DD'),40,30,30,'JAVA001','hangeul97','H001','H1');

INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS001',TO_DATE('2021-06-07','YYYY-MM-DD'),TO_DATE('2021-09-07','YYYY-MM-DD'),TO_DATE('2021-04-17','YYYY-MM-DD'),30,40,30,'PYTHON001','hungryman','O001','H2');

INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS004',TO_DATE('2022-01-07','YYYY-MM-DD'),TO_DATE('2022-08-25','YYYY-MM-DD'),TO_DATE('2021-12-17','YYYY-MM-DD'),50,30,20,'SPRING001','mmm1234','JS001','H3');

INSERT INTO OPENED_SUBJECT(OS_CODE, OS_START, OS_END, OS_DATE, OS_PT, OS_WT, OS_ATT, TB_CODE, PROF_ID, SUB_CODE, OC_CODE)
VALUES('OS005',TO_DATE('2022-09-07','YYYY-MM-DD'),TO_DATE('2022-10-30','YYYY-MM-DD'),TO_DATE('2022-03-18','YYYY-MM-DD'),NULL,NULL,NULL,'SPRING001','javagosu','JS001','H3');


-- 11. 수강신청 
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G301', SYSDATE, '20171305', 'H1');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G302', SYSDATE, '20153075', 'H2');
INSERT INTO APP (APP_CODE, APP_DATE, STU_ID, OC_CODE) VALUES ('G303', SYSDATE, '20143054', 'H3');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A101','20153075','H1');
INSERT INTO APP(APP_CODE, STU_ID, OC_CODE) VALUES ('A102','20161062','H2');
*/



EXEC PRC_STUDENT_INSERT('학생이름,PW(주민번호 뒷자리)'); 

--(과목시작일,과목종료일,개설날짜,실기배점,필기배점,출결배점,교재코드,교수ID,과목코드,개설과정코드)
EXEC PRC_OPSUB_INSERT(TO_DATE('2022-08-15','YYYY-MM-DD'),TO_DATE('2022-09-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');

EXEC PRC_OPSUB_UPDATE('OSJ1',TO_DATE('2022-09-26','YYYY-MM-DD'),TO_DATE('2022-10-25','YYYY-MM-DD'),TO_DATE('2022-08-13','YYYY-MM-DD'), 30, 30, 40, 'JAVA001','hangeul97','J001','H1');
--오류 해결
EXEC PRC_OPSUB_DELETE('OSJ1');

SELECT *
FROM GRADE;

DELETE
FROM GRADE
WHERE GRADE_CODE = 'GR10011';

SELECT *
FROM APP;

EXEC PRC_GRADE_INSERT('OS005', 'G301', 30, 40, 30);


-- 성적 입력 PRC_GRADE_INSERT(입력날짜,  출결, 필기, 실기, 개설과목코드, 수강신청코드) 

EXEC PRC_GRADE_INSERT(SYSDATE, 90, 80, 75,'OS004','G302');

--프로시저 작동함
EXEC PRC_GRADE_INSERT(80,70,60,'OS004','G302');
EXEC PRC_GRADE_INSERT(100,80,70,'OS004','G302');
EXEC PRC_GRADE_INSERT(20,10,90,'OS005','G301');
EXEC PRC_GRADE_INSERT(80,80,80,'OS005','G301');
EXEC PRC_GRADE_INSERT(100,90,80,'OS005','G301');




EXEC PRC_GRADE_INSERT(70,80,80,'OS004','G303');

EXEC PRC_GRADE_INSERT(70,80,80,'OS002','G301');



INSERT INTO GRADE(GRADE_CODE, GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE) VALUES('A00001',DEFAULT, 90, 80, 75,'OS005','G301');
INSERT INTO GRADE(GRADE_CODE, GRADE_DATE, GRADE_ATT, GRADE_WT, GRADE_PT, OS_CODE, APP_CODE) VALUES('A00002',SYSDATE, 90, 80, 75,'OS004','G302');


ROLLBACK;


COMMIT;




EXEC PRC_SCORE_UPDATE(성적코드, 출결, 필기, 실기) --

--딜리트 작동
EXEC PRC_GRADE_DELETE('GR10004');



EXEC PRC_GRADE_UPDATE('GR10005',100,100,100);






EXEC PRC_SCORE_POINT('GR10005',30,30,40);



-- EXEC PRE_SCORE_POINT(개설과목코드, 필기배점, 실기배점, 출결배점)


EXEC PRE_SCORE_POINT('OS005', 40, 20, 40);




SELECT TOTAL_SCORE('GR10005','OS005') "총점"
FROM GRADE;

SELECT *
FROM VIEW_STUDENT_GRADE;



SELECT *
FROM VIEW_PROFESSOR_GRADE;




SELECT *
FROM GRADE;


EXEC PRE_SCORE_POINT('OS005', 30, 20, 50);


SELECT *
FROM VIEW_STUDENT_GRADE;




EXEC PRC_TEXTBOOK_INSERT('자바는 재미있어 테스트', '민음사');



INSERT INTO TEXTBOOK(TB_CODE, TB_NAME, PUB) VALUES('JAVA006','자바의정석','도우출판');



SELECT *
FROM TEXTBOOK;



EXEC PRC_TEXTBOOK_DELETE('JAVA001');


EXEC PRC_TEXTBOOK_UPDATE('JAVA001','테스트','테스트');






ROLLBACK;

-- 프로시저 내용 조회 쿼리문
SELECT *
FROM USER_SOURCE 
WHERE TYPE = 'PROCEDURE'
AND NAME = 'PRC_TEXTBOOK_INSERT';



SELECT *
FROM USER_SEQUENCES;

EXEC PRC_CLASS_INSERT('G클래스', 30);


SELECT *
FROM CLASSROOM;




