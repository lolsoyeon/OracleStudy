SELECT USER 
FROM DUAL;
--==>> HR


--■■■ 정규화(Normalization) ■■■--

--○ 정규화란?
--  한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해 (나누고 분리 쪼개기)
--  어떤 하나의 테이블을... 식별자를 가지는 여러 개의 테이블로(다시 합치는것을 고려) 
--  나누는 과정을 말한다.


SELECT *
FROM EMPLOYEES;


-- ex) 현성이가....옥장판을 판매한다.
--     고객리스트 → 거래처 직원 명단이 적혀있는 수첩의 정보를
--                  데이터베이스화 하려고 한다.

-- 테이블명 : 거래처직원

/*
 10Byte     10Byte      10Byte      10Byte      10Byte  10Byte  10Byte
--------------------------------------------------------------------------------
거래처회사명 회사주소  회사전화     거래처직원명 직급  이메일  휴대폰
--------------------------------------------------------------------------------
     LG     서울여의도 02-345-6789  정미경       부장  jmk@na..  010-1.....
     LG     서울여의도 02-345-6789  정영준       과장  jyj@na..  010-7.....
     LG     서울여의도 02-345-6789  조영관       대리  cyk@na..  010-3.....
     LG     서울여의도 02-345-6789  고연수       부장  kys@na..  010-1.....
     SK     서울소공동 02-987-6543  최나윤       부장  cny@na..  010-9.....
     LG     부산동래구 051-221-2211 민찬우       대리  mcw@na..  010-1.....
     SK     서울소공동 02-987-6543  유동현       과장  ydh@na..  010-8.....
     
     
                                    :
--------------------------------------------------------------------------------
가정) 서울 여의도 LG(본사) 라는 회사에 근무하는 거래처 직원 명단이
     총 100만 명이라고 가정한다.
     (한 행 (레코드)은 70 Byte)

     어느날 『서울 여의도』에 위치한 LG 본사가 『경기분당』으로
     사옥을 이전하게 되었다.
     회사주소는 『경기분당』으로 바뀌고, 회사 전화는 『031-111-2222』로 바뀌게 되었다.
     
     그러면...100만 명의 회사주소와 회사전화를 변경해야 한다.
     
     -- 이 때 수행되어야할 쿼리문 → UPDATE
     
     UPDATE 거래처직원
     SET 회사주소 = '경기분당' , 회사전화= '031-111-2222'
     WHERE 거래처회사원 = 'LG'
       AND 회사주소 = '서울여의도';
     
     
     -- 100만 개 행을 하드디스크상에서 읽어다가
        메모리에 로드시켜 주어야 한다.
        즉, 100만 *70Byte 를 모두
        하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다.
       
            → 이는 디스크설계가 잘못되었으므로
               DB 서버는 조만간 메모리 고갈로 인해 DOWN 될 것 이다.
            
                → 그러므로 정규화 과정을 수행해야 한다.
         

*/
-- 제 1 정규화
--> 어떤 하나의 테이블에 반복되는 컬럼값들이 존재한다면
--  값들이 반복되어 나오는 컬럼을 분리하여
--  새로운 테이블을 만들어준다.

/*

--테이블명 : 회사  → 부모 테이블

 10Byte   10Byte     10Byte      10Byte   
------------------------------------------
회사ID 거래처회사명 회사주소   회사전화    
------
참조받는 컬럼
------------------------------------------
  10         LG     서울여의도 02-345-6789  
  20         SK     서울소공동 02-987-6543 
  30         LG     부산동래구 051-221-2211 
------------------------------------------


-- 테이블명 : 직원  → 자식 테이블

10Byte       10Byte  10Byte   10Byte     10Byte
-----------------------------------------------
거래처직원명 직급  이메일    휴대폰     회사ID
                                      -------
                                    참조하는 컬럼
-----------------------------------------------
  정미경      부장  jmk@na..  010-1.....  10
  정영준      과장  jyj@na..  010-7.....  10
  조영관      대리  cyk@na..  010-3.....  10
  고연수      부장  kys@na..  010-1.....  10
  최나윤      부장  cny@na..  010-9.....  20
  민찬우      대리  mcw@na..  010-1.....  30
  유동현      과장  ydh@na..  010-8.....  20
     :
------------------------------------------------

*/

-- > 제 1 정규화를 수행하는 과정에서 분리된 테이블은 
-- 반드시 부모테이블과 자식 테이블의 관계를 갖게된다.

--> 부모테이블 → 참조받는 컬럼 → PRIMARY KEY
--  자식테이블 → 참조하는 컬럼 → FOREIGN KEY

-- ※ 참조받는 컬럼이 갖는 특징
-- 반드시 고유한(데이터)만 들어와야 한다.
-- 즉, 중복된 값(데이터)이 있어서는 안된다.
-- 비어있으면(NULL이 있어서는) 안된다. 
-- 즉, NOT NULL 이어야 한다.


--> 제 1정규화를 수행하는 과정에서
-- 부모테이블의 PRIMARY KEY 는 항상 자식 테이블의 FOREIGN KEY 로 전이된다.



-- 테이블이 분리(분할)되기 이전 상태로 조회


/*

SELECT A.거래처회사명, A.회사주소, A.회사전화
     , B.거래처직원명, B.직급, B.이메일, B.휴대폰
FROM 회사 A, 직원 B
WHERE A.회사ID = B.회사ID;






가정) 서울 여의도 LG(본사) 라는 회사에 근무하는 거래처 직원 명단이
     총 100만 명이라고 가정한다.
     나머지직원 까지 200만 명

     어느날 『서울 여의도』에 위치한 LG 본사가 『경기분당』으로
     사옥을 이전하게 되었다.
     회사주소는 『경기분당』으로 바뀌고, 회사 전화는 『031-111-2222』로 바뀌게 되었다.
     
     그러면...회사 테이블에서 1건의 회사주소와 회사전화를 변경해야 한다.
     
     -- 이 때 수행되어야할 쿼리문 → UPDATE
     
     UPDATE 거래처직원
     SET 회사주소 = '경기분당' , 회사전화= '031-111-2222'
     WHERE 거래처회사원 = 'LG'
       AND 회사주소 = '서울여의도';
       
       
    UPDATE 회사
    SET 회사주소 = '경기분당' , 회사전화= '031-111-2222' 
    WHERE 회사ID = 10;
     
     
     
     
     -- 1 개 행을 하드디스크상에서 읽어다가
        메모리에 로드시켜 주어야 한다.
        즉, 1 * 40Byte 를
        하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다.
       
            → 정규화 이전에는 100만 건을 처리해야 할 업무에서
                1건만 처리하면 되는 업무로 바뀐 상황이기 때문에
                DB 서버는 메모리 고갈이 일어나지않고 아주 빠르게 처리될 것이다.


--거래처 회사명, 회사전화
SELECT 거래처회사명, 회사전화     |SELECT 거래처회사명, 회사전화
FROM 회사;                        | FROM 거래처직원
--> 3 * 40 Byte 메모리            | --> 200만 * 70 Byte




-- 거래처직원명, 직급           |
SELECT 거래처직원명, 직급       |SELECT 거래처직원명, 직급
FROM 직원;                      |FROM 거래처직원;    
--> 200만 * 50 Byte 메모리        | --> 200만 * 70 Byte    



-- 거래처회사명, 거래처직원명
SELECT A.거래처회사명, B.거래처직원명
FROM 회사 A , 직원 B
WHERE A.회사ID = B.회사ID;
--> 200만 * 3 * 90 




SELECT A.거래처회사명, B.거래처직원명  |SELECT 거래처회사명, 거래처직원명
FROM 회사 A JOIN 직원 B                | FROM 거래처직원;
ON A.회사ID = B.회사ID;                |
--> (3 * 40 Byte) + (200만 * 50 Byte)    | --> 200만 * 70 Byte 



*/

-- 테이블명 : 주문
/*
------------------------------------------------------------------------
 고객 ID            제품코드           주문일자               주문수량
++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        P.K
------------------------------------------------------------------------
 KIK1174(김인교)   P-KKBK(꿀꽈배기)  2022-04-30 13:50:23        10
 KYL8335(김유림)   P-KKBC(꼬북칩)    2022-04-30 14:23:11        20
 MCW3235(민찬우)   P-KKDS(쿠크다스)  2022-05-11 16:14:37        12
 CHH5834(조현하)   P-SWKK(새우깡)    2022-05-12 10:32:48        12
                            :
                            :
                            
------------------------------------------------------------------------
*/
--※ 하나의 테이블에 존재하는 PRIMARY KEY 최대 갯수는 1개이다.
-- 하지만, PRIMARY KEY 를 이루는 (구성하는) 컬럼의 갯수는 복수(여러개)인 것이 가능하다.
-- 컬럼 1 개로만 구성된 PRIMARY KEY를 SINGLE PRIMARY KEY 라고 부른다.
-- (단일 프라이머리키)
-- 두 개 이상의 컬럼으로 구성된 PRIMARY KEY 를 COMPOSITE PRIMARY KEY 라고 부른다,
-- (복합 프라이머리키)


-- 제 2 정규화
--> 제 1 정규화를 마친 결과물에서 PRIMARY KEY 가 SINGLE COLUMN 이라면
--  제 2 정규화는 수행하지 않는다.
--  하지만, PRIMARY KEY가 COMPOSITE COLUMN 이라면
--  반.드.시. 제 2 정규화를 수행해야한다.

--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야하는데
-- 식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
-- 이를 분리하여 새로운 테이블을 생성해준다.
-- 이 과정을 제 2 정규화라 한다.

/*
-- 테이블명 : 과목 → 부모 테이블
-------------------------------------------------------------------------
과목번호  과목명     교수번호 교수자명  강의실코드  강의실설명
+++++++              ++++++++
    P           .       K
-------------------------------------------------------------------------
 J0101  자바기초      21     슈바이처    A301      전산실습관 3층 40석 규모
 J0102  자바중급      22      테슬라     T502      전자공학관 5층 60석 규모
 O3090  오라클중급    22     테슬라      A201      전산실습관 2층 30석 규모
 O3010  오라클심화    10     장영실      T502      전자공학관 5층 60석 규모
 J3342  JSP응용       20     맥스웰      K101      인문과학관 1층 90석 규모
                           :
 -------------------------------------------------------------------------



-- 테이블명 : 점수 → 자식 테이블
-----------------------------------------------
과목번호 교수번호    학번          점수
=================
      F.K
      
++++++++           ++++++++
    P      .          K
-----------------------------------------------
 O3090     22      2209130(김태민)     92
 O3090     22      2209142(정영준)     80
 O3090     22      2209151(최나윤)     96
                :
-----------------------------------------------

                
*/


-- 제 3 정규화
--> 식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 의존적인 상황이라면
-- 이를 분리하여 새로운 테이블을 생성해 주어야 한다.
-- 이 과정을 제 3 정규형이라 한다.

-- ※ 관계(Relation)의 종류

-- 1 : many(다) 관계 
--> 제 1 정규화를 적용하여 수행을 마친 결과물에서 나타나는 바람직한 관계.
--  관계형 데이터베이스를 활용하는 과정에서 추구해야 하는 관계.

-- 1 : 1 관계 
--> 논리적, 물리적으로 존재할 수 있는 관계이긴 하지만 
-- 관계형 데이터베이스 설계과정에서 가급적이면 피해야 할 관계.

-- many : many 관계 
--> 논리적인 모델링에서는 존재할 수 있지만, 
-- 실제 물리적인 모델링에서는 존재할 수 없는 관계

/*
-- 테이블명 : 고객                        - 테이블명 : 제품
-----------------------------------     ---------------------------------------
고객번호 고객명 이메일 전화번호            제품번호 제품명  제품단가 제품설명
+++++++                                  ++++++++
  p.k                                       p.k
-----------------------------------     ---------------------------------------
 1001   고연수  abc@tes  010-1...           pswk   새우깡    500   새우가 들어있는...
 1002   김인교  bcd@tes  010-2...           pkjk   감자깡    600   감자가 들어있는...
 1003   김태민  cde@tes  010-3...           pkkm   고구마깡  700   고구마가 들어있는...
 1004   정영준  def@tes  010-1...           pjkc   자갈치    400   자갈이 들어있는...
         :                                          :
-----------------------------------     ---------------------------------------


                    - 테이블명 : 주문접수(판매)
                    ------------------------------------------------
                    고객번호  고객번호 제품번호   주문일자  주문수량
                    ------------------------------------------------
                      27        1001   pswk     2022-06...  10
                      28        1001   pkjk     2022-06...  30
                      29        1001   pjkc     2022-06...  20
                      30        1002   pswk     2022-06...  20
                      31        1002   pswk     2022-06...  50
                                        :
                                        
                    ------------------------------------------------

*/

-- 제 4 정규화 (고객   제품 ▶ 주문접수 , 학생   과목 ▶ 수강신청)
--> 위에서 확인한 내용과 같이 『many(다) : many(다)』 관계를
-- 『1(일) : many(다)』 관계로 깨뜨리는 과정이 바로 제 4 정규화 수행 과정이다.
-- → 파생테이블 생성 → 『다 : 다』 관계를 『1 : 다』 관계로 깨뜨리는 역할 수행
-- 테이블 7개 vs 테이블 20개 


-- 역정규화(비정규화) 업무파악이 잘 돼 있어야 가능하다.
-- → 정규화를 거꾸로한다.  분리 → 분리했던것을 합치는것 

-- A 경우 → 역정규화를 수행하지 않는 것이 바람직한 경우~!!!

-- 테이블명 : 부서            -- 테이블명 : 사원
--  10      10      10          10     10    10   10    10     10          10
---------------------------  -------------------------------------- + --------
-- 부서번호 부서명  주소      사원번호 사원명 직급 급여 입사일 부서번호    부서명
---------------------------  -------------------------------------- + --------
--    10개 레코드(행)                 1,000,000 개 레코드(행)
---------------------------  -------------------------------------- + --------
-- 테이블간의 데이터의 차이가 크면 바람직하지 않을 경우가 많다.



--> 조회 결과물 ( 업무시 이 형태로 빈번하게 조회한다면...)
-------------------------
-- 부서명 사원명 직급 급여
-------------------------


--> 『부서』테이블과 『사원』테이블을 JOIN 했을 때의 크기
--  (10*30 Byte) +(1000000*60 Byte) = 300 + 6000000 = 60000300 Byte


--> 『사원』 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
-- (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
-- (1000000*70 Byte) =70000000 Byte 



-- B 경우 → 역정규화를 수행하는 것이 바람직한 경우~~!!!

-- 테이블명 : 부서            -- 테이블명 : 사원
--  10      10      10          10     10    10   10    10     10          10
---------------------------  -------------------------------------- + --------
-- 부서번호 부서명  주소      사원번호 사원명 직급 급여 입사일 부서번호    부서명
---------------------------  -------------------------------------- + --------
--  500,000개 레코드(행)                 1,000,000 개 레코드(행)
---------------------------  -------------------------------------- + --------
-- 테이블 간의 레코드의 차이가 크지않으면 역정규화하는 것이 나을 수 도있다.


--> 조회 결과물 ( 이런 형태로 빈번하게 조회한다면...)
-------------------------
-- 부서명 사원명 직급 급여
-------------------------


--> 『부서』테이블과 『사원』테이블을 JOIN 했을 때의 크기
--  (5000000*30 Byte) +(1000000*60 Byte) = 15000000 + 6000000 = 75000000 Byte


--> 『사원』 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
-- (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
-- (1000000*70 Byte) =70000000 Byte 


---------------------------------------------------------------------------------
-- ※ 참고 용어
/*
1. 관계(relatrionship, relation)
 - 모든 엔트리(entry)는 단일값을 가진다.
 - 각 열(column)은 유일한 이름을 가지며 순서는 무의미하다.
 - 테이블의 모든 행(row==튜플==tuple)은 동일하지 않으며 순서는 무의미하다.
 
 2. 속성(attribute)
 - 테이블의 열(column) 을 나타낸다.
 - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
 - 일반 파일(file)의 항목(아이템==item==필드==field)에 해당한다.
 - 엔티티(entity)의 특성과 상태를 기술
 - 속성(attribute)의 이름은 모두 달라야 한다.
 
 3. 튜플(tuple)
  - 테이블의 행(row==엔티티==entity)
  - 연관된 몇 개의 속성으로 구성
  - 개념 정보 단위
  - 일반 파일(file) 의 레코드(recode)에 해당한다.
  - 튜플 변수(tuple variable)
   : 튜플(tuple)을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수
   
4. 도메인(domain)
 - 각 속성(attribute)이 가질 수 있도록 허용된 값들의 집합
 - 속성 명과 도메인 명이 반드시 동일할 필요는 없음
 - 모든 릴레이션에서 모든 속성들의 도메인은 원자적(atomic)이어야 함.
 - 원자적 도메인
  : 도메인의 원소가 더이상 나누어질 수 없는 단일체일 때를 나타냄.
  
5. 릴레이션(relation)
 - 파일 시스템에서 파일과 같은 개념
 - 중복된 튜플(entity==엔티티)을 포함하지 않는다. → 모두 상이함(튜플의 유일성)
 - 릴레이션 = 튜플(엔티티==entity) 의 집합. 따라서 튜플의 순서는 무의미하다.
 - 속성(attribute)간에는 순서가 없다.

*/

--------------------------------------------------------------------------------
/*
--■■■ 무결성(Integrity) ■■■--

1. 무결성에는 개체 무결성(Entity Integrity)
              참조 무결성(Relation Integrity)
              도메인 무결성(Domain Integrity)이 있다.
              
-- 무결성이 유지되려면 제약조건이 있어야한다.
-- 자유롭게 입력하지 못하도록 제약사항 명시, 오라클이 막는다.

2. 개체 무결성(Entity Integrity)
   개체 무결성은 릴레이션에서 저장되는 튜플(tuple)의
   유일성을 보장하기 위한 제약조건이다.
   
   
3. 참조 무결성(Relation Integrity)
   참조 무결성은 릴레이션 간의 데이터 일관성을
   보장하기위한 제약조건이다.
    
4. 도메인 무결성(Domain Integrity)이 있다.
   도메인 무결성은 허용가능한 값의 범위를
   지정하기 위한 제약조건이다.

5. 제약조건의 종류

 - PRIMARY KEY(PK : P) → 기본키, 고유키, 식별키, 식별자
   해당 컬럼의 값은 반드시 존재해야 하며, 유일해야한다.
   (NOT NULL 과 UNIQUE 가 결합된 형태)

 - FOREIGN KEY(FK : F : R) → 외래키, 외부키, 참조키
   해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와
   일치하거나 NULL을 가진다.
   -- EMP테이블 의 DEPTNO   DEPT 테이블중 DEPTNO 하나 이거나 인턴(NULL)이거나  
 
 - UNIQUE(UK : U) 
   테이블 내에서 해당 컬럼의 값은 항상 유일해야 한다.

 - NOT NULL(NN : CK : C) 체크
   해당 컬럼은 NULL 을 포함할 수 없다.
   
 - CHECK(CK : C)
   해당 컬럼에 저장 가능한 데이터의 범위나 조건을 저장한다.

*/

--■■■ PRIMARY KEY ■■■--

--1. 테이블에 대한 기본 키를 생성한다.

                                        -- 싱글 ,  복합  
--2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
--  기본키는 테이블 당 최대 하나만 존재한다.
--  그러나 반드시 하나의 컬럼으로만 구성되는 것은 아니다.
--  NULL일 수 없고, 이미 테이블에 존재하고 있는 데이터를
--  다시 입력할 수 없도록 처리한다. (유일성)
--  UNIQUE INDEX 가 오라클 내부적으로 자동으로 생성된다.

--3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입[CONSTRAINT CONSTRAINT명] PRIMARY KEY[(컬럼명,..)]

-- ② 테이블 레벨의 형식     ★★★★추천
-- 컬럼명 데이터 타입,
-- 컬럼명 데이터 타입,
-- CONSTRAINT CONSTRAINT명 PRIMARY KEY[(컬럼명,..)

-- 4. CONSTRAINT 추가 시 CONSTRAINT명을 생략하면
--    오라클 서버가 자동적으로 CONSTRAINT명을 부여한다.
--    일반적으로 CONSTRAINT명은 『테이블명_컬럼명_CONSTRAINT약자』
--    형식으로 기술한다.               


--○ PK지정 실습 (① 컬럼 레벨의 형식)
--테이블생성

CREATE TABLE TBL_TEST1
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.
SELECT *
FROM TBL_TEST1;

DESC TBL_TEST1;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 

*/
-- 데이터 입력
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');  
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');  --> 에러발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'ABCD');  --> 에러발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2,'ABCD');  
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3,NULL);    
INSERT INTO TBL_TEST1(COL1) VALUES(4);              --> 행 삽입 완료, 502랑 같은 구문
INSERT INTO TBL_TEST1(COL1) VALUES(4);              --> 에러발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5,'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL,NULL); --> 에러발생


COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/

DESC TBL_TEST1;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)         → PK 제약조건 확인 불가    
COL2          VARCHAR2(30) 

*/


--※ 제약조건 확인
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	LOC_CITY_NN	C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	DEPT_LOC_FK	R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	LOC_C_ID_FK	R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE
HR	DEPT_ID_PK	P	DEPARTMENTS					ENABLED	NOT DEFERRABLE
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE
HR	JOB_ID_PK	P	JOBS					ENABLED	NOT DEFERRABLE
HR	LOC_ID_PK	P	LOCATIONS					ENABLED	NOT DEFERRABLE
HR	REG_ID_PK	P	REGIONS					ENABLED	NOT DEFERRABLE
HR	SYS_C007063	P	TBL_TEST1					ENABLED	NOT DEFERRABLE
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007063	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME

--※ 제약조건이 지정된 컬럼을 확인(조회)
SELECT *
FROM USER_CONS_COLUMNS;
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007063	TBL_TEST1	COL1	1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007063	TBL_TEST1	COL1	1


--○ USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
-- 제약조건이 설정된 소유주, 제약 조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회한다.
-- 내가한것
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';



SELECT *
FROM USER_CONSTRAINTS C1 , USER_CONS_COLUMS C2
WHERE C1.TABLE_NAME = C2.TABLE_NAME;



SELECT *
FROM USER_CONSTRAINTS C1 , USER_CONS_COLUMS C2
WHERE C1.TABLE_NAME = C2.TABLE_NAME;



SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'P';



SELECT *
FROM USER_CONSTRAINTS C1 JOIN USER_CONS_COLUMS C2
ON C1.TABLE_NAME = C2.TABLE_NAME
AND CONSTRAINT_TYPE = 'P';



SELECT *
FROM USER_CONSTRAINTS C1 JOIN USER_CONS_COLUMS C2
ON CONSTRAINT_TYPE = 'P'
WHERE C1.TABLE_NAME = C2.TABLE_NAME;


------------------ T 선생님
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
 

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST1';


--○ PK지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'TEST');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'TEST');  --> 에러발생
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (1,'ABCD');  --> 에러발생
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (2,'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (3,NULL);
INSERT INTO TBL_TEST2(COL1) VALUES (4);
INSERT INTO TBL_TEST2(COL1) VALUES (4);             --> 에러발생

INSERT INTO TBL_TEST2(COL1,COL2) VALUES (5,'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES (NULL,NULL); --> 에러발생
INSERT INTO TBL_TEST2(COL2) VALUES ('KKKK');         --> 에러발생


COMMIT;

SELECT *
FROM TBL_TEST2;
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

--○ USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
-- 제약조건이 설정된 소유주, 제약 조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회한다.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST2';
--==>> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1




--○ PK지정 실습(③다중 컬럼 PK 지정)
-- 테이블 생성
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
               --------------   ----------------------
               -- 이름            실제 제약조건이 걸리는 문법
--==>> Table TBL_TEST3이(가) 생성되었습니다.


-- 데이터 입력
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');    --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');                       -->★ 에러 안남 ★
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'TEST'); --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL);   --> 에러발생


COMMIT;

SELECT *
FROM TBL_TEST3;


/*
1	ABCD
1	TEST
2	ABCD
2	TEST
3	NULL
*/


--○ USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
-- 제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회한다.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST3';
 
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2

제약조건의 이름이 같으면 제약조건은 하나다
*/


--○ PK 지정 실습(④ 테이블 생성 이후 제약조건 추가 설정)
-- 테이블생성

CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST4이(가) 생성되었습니다.

--※ 이미 생성된(만들어져 있는)테이블에
--   부여하려는 제약조건을 위반한 데이터가 (단 하나라도)포함되어 있을 경우
--   해당 테이블에 제액조건을 추가하는 것은 불가능하다.

-- 제약조건 추가  -- 구조적인 변경
ALTER TABLE TBL_TEST4
ADD 컬럼명 데이터타입;

ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4이(가) 변경되었습니다.

--○ USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
-- 제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회한다.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE
     , UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC ,USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
 AND UC.TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1


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


--
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		


--■■■ UNIQUE ■■■--

--1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고 유일 할 수 있도록 설정하는 제약조건
--   PRIMARY KEY 와 유사한 제약조건이지만, ★① NULL을 허용한다는 차이점이 있다.
--   내부적으로 PRIMARY KEY 와 마찬가지로 UNIQUE INDEX 가 자동생성된다.
--   하나의 테이블 내에서 ★② UNIQUE 제약조건은 여러 번 설정하는 것이 가능하다.
--   즉,  하나의 테이블에 UNIQUE 제약조건의 컬럼을 여러 개 만드는 것은 가능하는 것이다.
-- 고유하기만 하면된다.

--2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터 타입[CONSTRAUNT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터 타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 UNIQUE(컬럼명,....)

--○ UK 지정 실습( ① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)     UNIQUE
);
--==>> Table TBL_TEST5이(가) 생성되었습니다.

-- 제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
/*
HR	SYS_C007067	TBL_TEST5	P	COL1		
HR	SYS_C007068	TBL_TEST5	U	COL2		
*/



-- 데이터 입력
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1,'TEST');          --> 에러 발생
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3,'ABCD');          --> 에러 발생
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3,NULL);   
-- NULL 은 데이터가 아니다
INSERT INTO TBL_TEST5(COL1) VALUES(4);  
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5,'ABCD');          --> 에러 발생

-- 확인
SELECT *
FROM TBL_TEST5;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/



--○ UK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6이(가) 생성되었습니다.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2			
*/


--○ UK 지정 실습(③ 테이블 생성 이후 제약조건 추가)

--테이블 생성

CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST7';
--==>> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
--  +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);
----↓

ALTER TABLE TBL_TEST7
ADD(CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
  , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>>Table TBL_TEST7이(가) 변경되었습니다.


-- 제약조건 추가 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/




--------------------------------------------------------------------------------

-- ■■■ CHECK(CK:C) ■■■--


--1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
             -------------------------------
--          데이터타입과 길이로 1차 필터링 가능 하지만
-- NUMBER(3) = -999 ~ 999  

--   컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 한다.
--   또한, 컬럼에서 수정되는 데이터를 검사하여 조건에 맞는 데이터로 수정되는 것만
--   허용하는 기능을 수행하게 된다.
 
--2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입[CONSTRAINT CONSTRAINT명] CHECK(컬럼명 조건)

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)


--○ CK 지정 실습(① 컬럼 레벨의 형식)

CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)    
, COL3 NUMBER(3)        CHECK (COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8이(가) 생성되었습니다.

--데이터 입력

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '조영관', 100);
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '민찬우', 100);  --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '민찬우', 101);  --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '민찬우', -1);   --> 에러 발생
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '민찬우', 80);


-- 확인
SELECT *
FROM TBL_TEST8;
/*
1	조영관	100
2	민찬우	80
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 제약 조건확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
/*
HR	SYS_C007073	TBL_TEST8	C	COL3	    COL3 BETWEEN 0 AND 100	
HR	SYS_C007074	TBL_TEST8	P	COL1		(null)
*/

--○  CK 지정 실습 (② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.
--==> 다시해야함 ........

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '조영관', 100);
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '민찬우', 100);  --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '민찬우', 101);  --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '민찬우', -1);   --> 에러 발생
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '민찬우', 80);



-- 제약 조건확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';


--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)

CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==>> Table TBL_TEST10이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
   , CONSTRAINT TEST10_COL3_CK CHECK (COL3 BETWEEN 0 AND 100));
--==>> Table TBL_TEST10이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	    COL3 BETWEEN 0 AND 100	
*/


-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID NUMBER
, NAME VARCHAR2(30)
, SSN CHAR(14)          -- 입력형태 → 'YYMMDD-NNNNNNN'
, TEL VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER이(가) 생성되었습니다.

--○ TBL_TESTMEMBER 테이블의 SSN 컬럼(주민등록번호 컬럼) 에서
-- 데이터 입력이나 수정시 성별이 유효한 데이터만 입력 될 수 있도록
-- 체크 제약조건을 추가 할 수 있도록 한다.
-- (→  주민등록 특정자리에 입력 가능한 데이터를 1,2,3,4, 만 가능하도록 처리)
-- 또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록한다. DO


SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';


-- 내가 한 것 틀림.......
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT TESTMEMBER_SSN_CK CHECK (SSN BETWEEN '_______1______' AND '_______4______'));
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.


-- 친구가 한 것
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
   , CONSTRAINT TESTMEMBER_SSN_CK CHECK(TO_NUMBER(SUBSTR(SSN,8,1)BETWEEN 1 AND 4)) );



ALTER TABLE TBL_TESTMEMBER
DROP CHECK;


-- DROP 방법
ALTER TABLE TBL_TESTMEMBER
DROP CONSTRAINT TESTMEMBER_SSN_CK;

ROLLBACK;

DESC TBL_TESTMEMBER;

-- 제약 조건 추가
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(주민번호 8번째자리 1개가 '1' 또는 '2' 또는 '3' 또는'4'));

ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN 8,1)가 '1' 또는 '2' 또는 '3' 또는'4'));

ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN 8,1) IN ('1','2','3','4')) );
--==>> 
ALTER TABLE TBL_TESTMEMBER
ADD( CONSTRAINT TESTMEMBER_SSD_CK CHECK(SUBSTR(SSN, 8,1) IN ('1','2','3','4')) );





-- 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';



-- 데이터
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '엄소연', '941124-2234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(2, '최동현', '950222-1234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(3, '유동현', '040601-3234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(4, '김유림', '050215-4234567','010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)           
VALUES(5, '김유림', '050215-5234567','010-5555-5555');     --> 에러 발생
INSERT INTO TBL_TESTMEMBER(SID, NAME,SSN,TEL)
VALUES(6, '김유림', '050215-6234567','010-6666-6666');     --> 에러 발생


SELECT *
FROM TBL_TESTMEMBER;
/*
엄소연	941124-2234567	010-1111-1111
최동현	950222-1234567	010-2222-2222
유동현	040601-3234567	010-3333-3333
김유림	050215-4234567	010-3333-3333
*/

COMMIT;
--==>> 커밋 완료.


--------------------------------------------------------------------------------

--■■■ FOREIGN KEY(FK:F:R) ■■■--

--1. 참조 키(R) 또는 외래 키(FK:F)는 두 테이블의 데이터 간 연결을 설정하고
--   강제 적용시키는데 사용되는 열이다.
--   한 테이블의 기본 키 값이 있는 열을
--   다음 테이블에 추가하면 테이블 간 연결을 설정 할 수 있다.
--   이 때, 두 번째 테이블에 추가되는 열이 외래키가 된다.


--2. ① 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--   ② 자식 테이블(참조하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--   이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

--3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                  REFERENCES 참조테이블명(참조컬럼명)
--                  [ON DELETE CASCADE | ON DELETE SET NULL] → 추가옵션(있을수도 없을수도있음)


-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
--CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--           REFERENCES 참조테이블명(참조컬럼명)
--           [ON DELETE CASCADE | ON DELETE SET NULL] → 추가옵션


-- ※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--   부모 테이블의 생성 작업을 먼저 수행해야한다.
--   그리고 이때, 부모 테이블에서는 반드시 PK 또는 UK 제약조건이
--   설정된 컬럼이 존재해야한다.


/*
★ 꼭 기억해두기 ★
-- 길이를 지정하지 않으면
컬럼명 CHAR        -- 한 글자
컬럼명 NUMBER      -- 표현범위를 다 갖는것 10의 38승(모든 숫자가 가능)
*/


-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS이(가) 생성되었습니다.

-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1,'사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2,'대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3,'과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4,'부장');
--==>> 1 행 이(가) 삽입되었습니다. * 4


-- 확인
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
4	부장
*/


-- 의도한 대로 잘 들어갔으면 커밋
COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습 (① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER      PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER      REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';

/*
HR	SYS_C007082	TBL_EMP1    	P	SID		
HR	SYS_C007083	TBL_EMP1	    R	JIKWI_ID		NO ACTION
                                           추가옵션유무
*/

-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1,'정미경', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2,'최나윤', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3,'민찬우', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4,'조영관', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'고연수', 5);   --> 에러 발생
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5,'고연수', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(6,'김태민');


-- 확인
SELECT *
FROM TBL_EMP1;
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	4
5	고연수	1
6	김태민	(null)
*/

COMMIT;
--==>> 커밋 완료.



--○ FK 지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);


--○ FK 지정 실습(② 테이블 생성후 제약조건 추가)
CREATE TABLE TBL_EMP3
( SID   NUMBER
, NAME  VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.


-- 제약조건추가
ALTER TABLE TBL_EMP3
ADD( CONSTRAINT EMP3_SID_PK  PRIMARY KEY(SID)
   , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3이(가) 변경되었습니다.


-- 제약조건 제거
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		


-- 다시 제약조건 추가

ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3이(가) 변경되었습니다.               
                
-- 다시 제약조건확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';

/*
HR	EMP3_SID_PK	    TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY 생성 시 주의사항
--      참조하고자하는 부모 테이블을 먼저 생성해야한다.
--      참조하고자 하는 컬럼이 PRIMARY KEY 또는 UNIQUE 제약조건이 설정되어 있어야한다.
--      테이블 사이에 PRIMARY KEY 와 FOREIGN KEY 가 정의되어 있으면
--      PRIMARY KEY 제약조건이 설정된 데이터 삭제 시
--      FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--      (즉, 자식테이블에 참조하는 레코드가 존재할 경우
--      부모 테이블의 참조받는 해당 레코드는 삭제 할 수 었다는 것이다.)
--      단, FK 설정 과정에서 『ON DELETE CASCADE』『ON DELETE SET NULL』옵션을
--      사용하여 설정한 경우에는 삭제가 가능하다.
--      또한, 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야한다.


-- 부모테이블
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
4	부장
*/
-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	4
5	고연수	1
6	김태민	(null)      
*/

-- 부모 테이블 제거 시도
DROP TABLE TBL_JOBS;
--==>> 에러 발생

-- 부모 테이블의 부장 직원 삭제 시도
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 4	부장

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 에러 발생


-- 조영관 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID  = 4;
--==>> 1 행 이(가) 업데이트되었습니다.



-- 확인
SELECT *
FROM TBL_EMP1;
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	1
5	고연수	1
6	김태민	(null)
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 부장(4) 데이터를 참조하고 있는 
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황

-- 이와 같은 상황에서 부모테이블(TBL_JOBS)DML
-- 부장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

-- 확인
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 사원 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1	사원


DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 에러 발생


-- ※ 부모 테이블의 데이터를 자유롭게(?) 삭제하기 위해서는
-- ON DELETE CASCADE 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(자식 테이블) 에서 FK 제약조건을 제거한 후
-- CASECADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.



-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';    
/*
HR	SYS_C007082	TBL_EMP1	P	SID		
HR	SYS_C007083	TBL_EMP1	R	JIKWI_ID		NO ACTION  ◀◀◀
*/



-- 제약 조건제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007083;        -- ◀◀◀ FK FOREIGN KEY, 참조키, 외래키만 제거 
--==>> Table TBL_EMP1이(가) 변경되었습니다.




-- 제약조건 제거 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1'; 
--==>> HR	SYS_C007082	TBL_EMP1	P	SID		




--『ON DELETE CASCADE』옵션이 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID)
                ON DELETE CASCADE; 
--==>> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약조건 생성이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';  
/*
HR	SYS_C007082	    TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

-- ※ CASECADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다.
--   단, ....부모 테이블의 데이터가 삭제될 경우...
--   이를 참조하는 자식 테이블의 데이터도 모~~~~두 함께 삭제된다.



-- 부모테이블
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
*/
-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	1
5	고연수	1
6	김태민	(null)    
*/

-- 부모 테이블(TBL_JOBS)에서 과장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.


SELECT *
FROM TBL_EMP1;
/*
1	정미경	1
2	최나윤	2
4	조영관	1
5	고연수	1
6	김태민	(null)    
*/




-- 부모 테이블(TBL_JOBS)에서 사원(1) 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.




-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
2	최나윤	2
6	김태민	(null)
*/
--==>> 사원(1)에 속하는 자식데이터 다 사라짐




DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2이(가) 삭제되었습니다.
-- 생성 시에는 부모 → 자식 생성
-- 삭제 시에는 자식 → 부모 삭제 즉, 반대로

DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3이(가) 삭제되었습니다.

DROP TABLE TBL_JOBS;
--==>> 에러 발생

DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1이(가) 삭제되었습니다.


DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS이(가) 삭제되었습니다.



