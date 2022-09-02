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


CREATE OR REPLACE PROCEDURE

IS
BEGIN
END;

SELECT *
FROM TBL_출고;


SELECT *
FROM TBL_상품;

SELECT *
FROM TBL_입고;
-- 과제 
/*
1. PRC_입고_UPDATE(입고번호, 입고수량) -- 수량을 바꾸는것 과거에 발생했던(INSERT) 입고를 바꾸는것이다. 
    출고 쌓이고 입고도 쌓인 상태 입고 100 현재재고 100 출고 100 현재재고 0 현재재고 20   출고 UPDATE 참조
2. PRC_입고_DELETE(입고번호)  

3. PRC_출고_DELETE(출고번호)  입고INSERT 출고수량만큼 없앤다     트렌젝션


물건 입고(ⓐINSERT) → 상품 에서 입고처리(ⓐUPDATE)  → 출고 에서 물건 (ⓑINSERT)
                                       (ⓑUPDATE)
        (ⓒUPDATE)                      (ⓒUPDATE)
                                        (ⓓUPDATE)                   (ⓓDELETE)
*/



-- 2. PRC_입고_DELETE(입고번호)  
-- TBL_입고 에서 DELETE가 일어나면 상품 테이블에선 UPDATE
CREATE OR REPLACE PROCEDURE  PRC_입고_DELETE
( V_입고번호    IN TBL_입고.입고번호%TYPE
, V_입고수량    IN TBL_입고.입고수량%TYPE
)
IS
    -- 필요한 변수 추가 선언
    V_상품코드  TBL_입고.상품코드%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- 쿼리문 작성 전 추가한 변수에 값 담기
    SELECT 재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;


    
    -- 쿼리문 구성 → DELETE(TBL_입고)
    DELETE        
    FROM TBL_입고
    WHERE 상품코드 = V_상품코드

    -- 쿼리문 구성 → UPDATE(TBL_상품)

    UPDATE TBL_상품
    SET 
    WHERE 재고수량 = V_재고수량
    
    
    -- 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR();
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    -- 커밋
    COMMIT;
END;









--  3. PRC_출고_DELETE(출고번호)  입고INSERT 처럼 수행 
-- 즉, TBL_출고 에서 DELETE 되면 TBL_상품에서는 UPDATE 동.시.에(트렌젝션) 수행

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(V_출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    -- 필요한 변수 추가 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_출고수량  TBL_출고.출고수량%TYPE;
BEGIN
    -- 쿼리문 실행 전  얻어내야할 변수 값 담아내기
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    SELECT 출고수량 INTO V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;


    --DELETE 문 출고 테이블
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    --UPDATE 문 상품테이블
    UPDATE TBL_상품
    SET 재고수량 = V_재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리 (정상적으로 처리되지못하는 다른 상황이면 롤백해라)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
        
    -- 다 확인되면 커밋
    COMMIT;

END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.


------------------------------------------------------------------------------














