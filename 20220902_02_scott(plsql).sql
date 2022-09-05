SELECT USER
FROM DUAL;
--==>> SCOTT


--※ TBL_입고 테이블에 『입고』 이벤트 발생시...
-- 관련 테이블에 수행되어야 하는 내용

--① INSERT → TBL_입고

--② UPDATE → TBL_상품

--○ TBL_상품, TBL_입고 테이블을 대상으로
--      TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--      TBL_입고 테이블의 데이터 입력 뿐 아니라
--      TBL_상품 테이블에 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--      단, 이 과정에서 입고번호는 자동 증가 처리한다.(시퀀스 사용 X)
--      TBL_입고 테이블 구성 컬럼 - 구조
--      : 입고번호, -상품코드, 입고일자, -입고수량, -입고단가
--      프로시저명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

--------- 내가 한 것
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_입고.상품코드%TYPE
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)
IS 
    --V_FLAG NUMBER := 1;
    V_입고번호   TBL_입고.입고번호%TYPE; 
    V_입고일자   TBL_입고.입고일자%TYPE; 
    V_상품명     TBL_상품.상품명%TYPE;
    V_소비자가격 TBL_상품.소비자가격%TYPE;
    V_재고수량   TBL_상품.재고수량%TYPE;
    
BEGIN

    SELECT MAX(NVL(입고번호,0)) + 1 INTO V_입고번호
    FROM TBL_입고;
    
    --UPDATE 문 입고테이블
    UPDATE TBL_입고
    SET 입고번호= V_입고번호, 상품코드 = V_상품코드, 입고일자 = V_입고일자, 입고수량 = V_입고수량, 입고단가 = V_입고단가
    WHERE 상품코드 = V_상품코드 AND 입고수량 = V_입고수량 AND 입고단가 = V_입고단가;

    --INSERT 문 상품테이블 (UPDATE와 순서는 상관없다 EHY?? 동시에 일어나기 때문에
    INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격, 재고수량)
    VALUES(V_상품코드, V_상품명, V_소비자가격, V_재고수량);
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


---------------------------------------------선생님 풀이
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드 IN TBL_입고.상품코드%TYPE            -- TBL_상품.상품코드&TYPE
, V_입고수량 IN TBL_입고.입고수량%TYPE
, V_입고단가 IN TBL_입고.입고단가%TYPE
)
IS
    --아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호 TBL_입고.입고번호%TYPE;
BEGIN
    --아래의 쿼리문을 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호
    FROM TBL_입고;
    
    --INSERT 문 입고테이블
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES((V_입고번호+1) ,V_상품코드, V_입고수량, V_입고단가);

    --UPDATE 문 상품테이블
    UPDATE TBL_상품
    --SET 재고수량 = V_입고수량 (덮어씌워진다)
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리 (정상적으로 처리되지못하는 다른 상황이면 롤백해라)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------

--■■■ 프로시저 내에서의 예외 처리 ■■■--
--○ TBL_MEMBER 테이블에 데이터 입력하는 프로시저를 작성
-- 단, 이 프로시저를 통헤 데이터를 입력 할 경우
-- CITY(지역) 항목 '서울','경기','대전' 만 입력 가능하도록  구성한다.
-- 이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
-- (즉, 입력을 시도하는경우)
-- 예외에 대한 처리를 하려고 한다.
-- 프로시저명 : PRC_MEMBER_INSERT()
/*
실행 예)
EXEC PRC_MEMBER_INSERT('임시연','010-1111-1111','서울');
--==>> 데이터 입력 ○
 
EXEC PRC_MEMBER_INSERT('김보경','010-2222-2222','부산');
--==>> 데이터 입력 X

*/

----------------------- IF문 공부할 부분
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    TBL_MEMBER.NAME%TYPE
, V_TEL     TBL_MEMBER.TEL%TYPE
, V_CITY    TBL_MEMBER.CITY%TYPE  -- 인서트보다 조건검사가 성행되야한다
)
IS
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 추가 선언
    V_NUM TBL_MEMBER.NUM%TYPE;
BEGIN

    -- 프로시저를 통해 입력처리를 정상적으로 진행해야할 데이터인지
    -- 아닌지의 여부를 가장 먼저 확인할 수 있도록 코드 구성
    IF(지역이 서울 경기 인천이 아니라면)
        THEN 예외를 발생시키겠다.
    END IF;
    

    -- 쿼리문 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;

    -- 쿼리문 구성 → INSERT 
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES ((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
    
    --예외 처리구문 (TRY CHACH 처럼 )
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;       
    
END;



-------------------------------------- 예외 처리 선생님 설명
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    TBL_MEMBER.NAME%TYPE
, V_TEL     TBL_MEMBER.TEL%TYPE
, V_CITY    TBL_MEMBER.CITY%TYPE  -- 인서트보다 조건검사가 선행되야한다
)
IS
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 추가 선언
    V_NUM TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언~!~! CHECK 예외도 변수다
    USER_DEFINE_ERROR EXCEPTION;
    -- 변수명 데이터타입;
BEGIN

    -- 프로시저를 통해 입력처리를 정상적으로 진행해야할 데이터인지
    -- 아닌지의 여부를 가장 먼저 확인할 수 있도록 코드 구성
    IF(V_CITY NOT IN('서울','경기','대전'))                 -- 들어있지 않다면
        -- THEN 예외를 발생시키겠다. RAISE  띄우다
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT 쿼리문 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;

    --쿼리문 구성 → INSERT 
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES ((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
        --예외 처리구문 (TRY ~ CHACH 처럼 )
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'서울, 경기, 대전만 입력이 가능합니다.');    -- 예외 띄우는 함수
        WHEN OTHERS 
            THEN ROLLBACK;   
            
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.


------------------------------------------------------------------------------------

-- 
--○TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생시)
-- TBL_상품 테이블의 재고 수량이 변동되는 프로시저를 작성한다.
-- 단, 출고번호는 입고번호와 마찬가지로 자동 증가 처리한다.
-- 출고 액션 처리 자체를 취소 할 수 있도록 처리한다. (출고가 이루어지지 않도록...)
-- 프로시저명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT('H001', 50, 1000); 상품코드 수량 가격
*/
---------------- 내가 한 것 첫 번째
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드      IN TBL_출고.상품코드%TYPE
, V_출고수량      IN TBL_출고.출고수량%TYPE
, V_출고단가      IN TBL_출고.출고단가%TYPE
)
IS
    V_출고번호 TBL_출고.출고번호%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
     V_상품수량 TBL_상품.상품수량%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언~!~!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --프로시저를 통해 입력처리를 정상적으로 진행해야 할 데이터 인지
        -- 아닌지 여부를 가장먼저 확인 할 수 있도록 코드 구성
        IF(V_재고수량 < V_출고수량)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        --쿼리문 수행전 출고번호에 관한 값 담기
        SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
        FROM TBL_출고;
        
        --UPDATE 쿼리문 상품테이블
        UPDATE TBL_상품
        SET 재고수량  = 재고수량 -V_출고수량
        WHERE 상품코드 = V_상품코드;
        --WHERE 재고수량 = V_재고수량;
        
        
        --INSERT  쿼리문 출고테이블
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES (V_출고번호 +1 , V_상품코드, V_출고수량, V_출고단가);
        
        
        -- 예외 처리 
        EXCEPTION 
            WHEN USER_DEFINE_ERROR 
                THEN RAISE_APPLICATION_ERROR(-20101, '재고수량보다 출고수량이 더 많습니다.');
            WHEN OTHERS
                THEN ROLLBACK;
END;
---------------- 내가 한 것 문제점
/*
선행 되지 못 한 코드~!~! 잘 숙지하기 
SELECT 재고수량 INTO V_재고수량
FROM TBL_상품
WHERE 상품코드 = V_상품코드;

AND

필요없는(안쓰이는) 변수 선언
    -- V_상품수량 TBL_상품.상품수량%TYPE;
    
--UPDATE 쿼리문 상품테이블
    UPDATE TBL_상품
    SET 재고수량  = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    --WHERE 재고수량 = V_재고수량;  조건절의 조건이 맞지 않았다.......
*/


---------------- 내가 한 것  재구성 
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드      IN TBL_출고.상품코드%TYPE
, V_출고수량      IN TBL_출고.출고수량%TYPE
, V_출고단가      IN TBL_출고.출고단가%TYPE
)
IS
    V_출고번호 TBL_출고.출고번호%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
    -- V_상품수량 TBL_상품.상품수량%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언~!~!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
        --쿼리문 수행이전에 수행 여부를 확인하는 과정에서
        -- 재고파악 , 기존의 재고를 확인하는 과정이 선행되어야한다.
        -- 그래야...출고 수량과 비교가 가능하기 때문에
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = V_상품코드;


        --프로시저를 통해 입력처리를 정상적으로 진행해야 할 데이터 인지
        -- 아닌지 여부를 가장먼저 확인 할 수 있도록 코드 구성
        IF(V_재고수량 < V_출고수량)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        --쿼리문 수행전 출고번호에 관한 값 담기
        SELECT NVL(MAX(출고번호), 0) INTO V_출고번호
        FROM TBL_출고;
        
        --UPDATE 쿼리문 상품테이블
        UPDATE TBL_상품
        SET 재고수량  = 재고수량 -V_출고수량
        WHERE 상품코드 = V_상품코드;
        --WHERE 재고수량 = V_재고수량;
        
        
        --INSERT  쿼리문 출고테이블
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES (V_출고번호 +1 , V_상품코드, V_출고수량, V_출고단가);
        
        
        -- 예외 처리 
        EXCEPTION 
            WHEN USER_DEFINE_ERROR 
                THEN RAISE_APPLICATION_ERROR(-20101, '재고수량보다 출고수량이 더 많습니다.');
            WHEN OTHERS
                THEN ROLLBACK;
                
        -- 커밋
        COMMIT;
END;






---------------------- 선생님 T 풀이 내가 한 것과 비교해보기~~!~!~!~!~!~!~!

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드 IN TBL_상품.상품코드%TYPE
, V_출고수량 IN TBL_출고.출고수량%TYPE
, V_출고단가 IN TBL_출고.출고단가%TYPE
)
IS
    -- 쿼리문 수행을 위한 추가 변수 선언
    v_출고번호 TBL_출고.출고번호%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    -- 사용자 정의 예외 선언
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- 쿼리문 수행이전에 수행 여부를 확인하는 과정에서
    -- 재고파악 기존의 재고를 확인하는 과정이 선행되어야한다.
    -- 그래야,,, 출고 수량괴 비교가 가능하기 때문에
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 출고를 정상적으로 진행해 줄 것인지에 대한 여부 확인
    -- 파악한 재고수량보다 출고 수량이 많으면 예외 발생
    
    IF(V_출고수량 >V_재고수량)
        --예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호),0) INTO V_출고번호
    FROM TBL_출고;
    -- 쿼리문 구성 → INSERT(TBL_출고)
    
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES ((V_출고번호 +1) , V_상품코드, V_출고수량, V_출고단가);
    
    -- 쿼리문 구성 → UPDATE(TBL_상품)
        UPDATE TBL_상품
        SET 재고수량  = 재고수량 - V_출고수량
        WHERE 상품코드 = V_상품코드;
        
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002, '재고부족!~!!');
                    ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
        
        -- 커밋
        COMMIT;
     
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.


--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저를 작성한다.
--  프로시저 명: PRC_출고_UPDATE()

/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할 수량);

*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호 IN TBL_출고.출고번호%TYPE
, V_출고수량 IN TBL_출고.출고수량%TYPE
)
IS
    V_상품코드 TBL_출고.상품코드%TYPE;
    V_출고단가 TBL_출고.출고단가%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    -- 사용자정의 예외 선언
    USER_DEFINE_ERROR  EXCEPTION;
BEGIN
    -- 쿼리문 수행이전에 수행야부를 확인하는 과정에서
    -- 재고 보다 출고수량이 더 큰지 비교하는 과정이 필요하다.
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 출고를 정상적으로 진행시켜줄 것인지 확인
    -- 파악한 재고수량보다 출고수량이 많으면 예외 발생
    IF(V_출고수량 > V_재고수량)
        -- 예외발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 선언한 변수에 값 담아내기 ??
 

    -- 쿼리문 구성 → UPDATE (TLB_출고)
    UPDATE TBL_출고
    SET 출고수량 = V_재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 쿼리문 구성 → INSERT (TBL_상품)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES (V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '출고 수량보다 재고 부족~!');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.


-----------------------------------T 선생님 풀이 시작 
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    -- ①매개변수 구성
  V_출고번호 IN TBL_출고.출고번호%TYPE
, V_출고수량 IN TBL_출고.출고수량%TYPE
)
IS
    -- ③ 필요한 변수 추가 선언
    -- 출고 정상 수행여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인 해야한다.
    V_상품코드     TBL_상품.상품코드%TYPE;
    V_이전출고수량 TBL_출고.출고수량%TYPE;
    V_재고수량     TBL_상품.재고수량%TYPE;
    
BEGIN
    -- ④ 선언한 변수에 값 담아내기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    -- 
    SELECT 출고수량 INTO V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;



    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET TBL_출고 = V_출고수량;
    WHERE 출고번호 = V_출고번호;

END;





CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    -- ① 매개변수 구성
  V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    -- ③ 필요한 변수 추가 선언
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_이전출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량     TBL_상품.재고수량%TYPE;
    
    -- ⑦ 예외발생
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    --  선언한 변수에 값 담아내기
    -- ④ 상품코드와 이전 출고수량 파악
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- ⑤ 위에서 얻어낸 상품코드를 활용하여 재고 수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

 
    --⑥ 출고 정상 수행여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인 해야한다.
    --IF(파악한 재고수량과 이전의 재고수량을 합친값이 현재의 출고수량보다 작으면 )
    --    예외를 발생시키도록 한다.
    --END IF;
    
    IF((V_재고수량 + V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;


    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET TBL_출고 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- ⑧ 30 + 20 - 50
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑩ 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고부족~!~!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --⑨ 커밋
    COMMIT;
END;




CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_이전출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량     TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF((V_재고수량 + V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE TBL_출고
    -- 여기네~ ㅠㅠSET TBL_출고 = V_출고수량
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고부족~!~!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
 
    COMMIT;
END;



--------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_이전출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량      TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN

    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF ((V_재고수량 + V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
            
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;
------------------------------------------------------------------------------------------

-- 과제 
/*
1. PRC_입고_UPDATE(입고번호, 입고수량) -- 수량을 바꾸는것 과거에 발생했던(INSERT) 입고를 바꾸는것이다. 
    출고 쌓이고 입고도 쌓인 상태 입고 100 현재재고 100 출고 100 현재재고 0 현재재고 20   출고 UPDATE 참조
2. PRC_입고_DELETE(입고번호)  

3. PRC_출고_DELETE(출고번호)  입고INSERT 출고수량만큼 없앤다     트렌젝션

*/

------------------------------------------------------------------------------------------

--■■■ CURSOR (커서) ■■■-- 깜짝상자

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된(다중 레코드)
--    작업 영역에서  SQL 문을 실행하고 그 과정에서 발생한 데이터를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다.
                            -- 여러 레코드 시


-- 2. 암시적 커서는 모든 SQL 문에 존재하며
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러행(ROW)으로 구성된 경우
--    커서(CORSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.

SET SERVEROUTPUT ON;

--○ 커서 이용 전 상황(단일 행 접근시)
DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
END;
--==>> 홍길동 - 011-2356-4528

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
END;
--==>> 에러 발생 다중행 
-- (ORA-01422: exact fetch returns more than requested number of rows)


--○ 커서 이용 전 상황(단일 행 접근시)

DECLARE
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;
    V_NUM  TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
            DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
            V_NUM := V_NUM + 1;
            EXIT WHEN V_NUM>= 1062;

    END LOOP;
    
END;
--==>> 
/*
홍길동 - 011-2356-4528
이순신 - 010-4758-6532
이순애 - 010-4231-1236
김정훈 - 019-5236-4221
한석봉 - 018-5211-3542
이기자 - 010-3214-5357
장인철 - 011-2345-2525
김영년 - 016-2222-4444
나윤균 - 019-1111-2222
김종서 - 011-3214-5555
유관순 - 010-8888-4422
정한국 - 018-2222-4242
조미숙 - 019-6666-4444
황진이 - 010-3214-5467
이현숙 - 016-2548-3365
이상헌 - 010-4526-1234
엄용수 - 010-3254-2542
이성길 - 018-1333-3333
박문수 - 017-4747-4848
유영희 - 011-9595-8585
홍길남 - 011-9999-7575
이영숙 - 017-5214-5282
김인수 - 
김말자 - 011-5248-7789
우재옥 - 010-4563-2587
김숙남 - 010-2112-5225
김영길 - 019-8523-1478
이남신 - 016-1818-4848
김말숙 - 016-3535-3636
정정해 - 019-6564-6752
지재환 - 019-5552-7511
심심해 - 016-8888-7474
김미나 - 011-2444-4444
이정석 - 011-3697-7412
정영희 - 
이재영 - 011-9999-9999
최석규 - 011-7777-7777
손인수 - 010-6542-7412
고순정 - 010-2587-7895
박세열 - 016-4444-7777
문길수 - 016-4444-5555
채정희 - 011-5125-5511
양미옥 - 016-8548-6547
지수환 - 011-5555-7548
홍원신 - 011-7777-7777
허경운 - 017-3333-3333
산마루 - 018-0505-0505
이기상 - 
이미성 - 010-6654-8854
이미인 - 011-8585-5252
권영미 - 011-5555-7548
권옥경 - 010-3644-5577
김싱식 - 011-7585-7474
정상호 - 016-1919-4242
정한나 - 016-2424-4242
전용재 - 010-7549-8654
이미경 - 016-6542-7546
김신제 - 010-2415-5444
임수봉 - 011-4151-4154
김신애 - 011-4151-4444
조현하 - 010-7202-6306
*/

/*
오라클에서 중요한 패턴★(선언)
변수명 데이터타입
V_REAULT NUMBER;
USER_DEFINE_ERROR EXCEPTION;
*/


/* 오라클에서 중요한 패턴★
테이블 생성(정의)
사용자 생성(정의)
함수 정의
프로시저 정의
CREATE TABLE 테이블명
        INDEX 인덱스명
        FUNCTION 함수명
        PROCEDURE 프로시저명
        CURSOR 커서명 

*/


--○ 커서 이용 후 상황
DECLARE
    -- 선언부
    -- 주요 변수 선언
    V_NAME TBL_INSA.NAME%TYPE;
    V_TEL TBL_INSA.TEL%TYPE;

    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의) 깜짝 상자
     CURSOR CUR_INSA_SELECT
     IS
     SELECT NAME, TEL
     FROM TBL_INSA;
     
BEGIN
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    --커서 오픈시 쏟아져 나오는 데이터들 처리
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
         FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
         -- 커서에서 쏟아져나오는걸 INTO로 받는다.
         
        
        -- 커서에서 더이상 데이터가 쏟아져 나오지 않는 상태
        -- 즉, 커서 내부에서 더 이상의 데이터를 찾을수 없는상태
        -- → 그만~! 반복문 빠져나가기
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' - ' || V_TEL);
        
    END LOOP;
            
    -- 커서 클로즈   자바랑 연결시엔 클로즈 안함 스트림처리 때문에 
    CLOSE CUR_INSA_SELECT;
    
END;
--==>> 같은 결과 







------------------------------------------------------------------------------------------





















