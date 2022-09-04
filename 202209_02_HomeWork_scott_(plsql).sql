
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

 -- 기본틀
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

-- 1. PRC_입고_UPDATE(입고번호, 입고수량)
-- ○ UPDATE : 기존에 입력되어 있던 값을 변경 할 때 ULDATE문 을 사용한다.
-- TBL_입고 테이블에서 UPDATE 가 일어나면 TBL_상품 테이블에서도 UPDATE 동.시.에(트렌젝션) 수행

-- EXEC PRC_입고_ULDATE(1, 10);

CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V_입고번호   IN TBL_입고.입고번호%TYPE
, V_입고수량   IN TBL_입고.입고수량%TYPE
)
IS
    --  필요한 변수 추가 선언
    V_상품코드        TBL_입고.상품코드%TYPE;
    V_이전입고수량    TBL_입고.입고수량%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    
    -- 예외 변수 선언
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    -- 쿼리문 작성 전 추가한 변수에 값 담기
    -- 상품코드와 이전입고수량 파악
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_이전입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --  추가한 변수에 값담기 (재고수량)
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    
    --  쿼리문 실행전 실행 여부 결정
    --  변경 이전의 입고수량 및 현재의 재고수량 확인
    IF (V_재고수량 - V_이전입고수량+ V_입고수량 < 0) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    --  쿼리문 구성 → UPDATE(TBL_입고)
    UPDATE TBL_입고
    SET 입고수량 = V_입고수량
    WHERE 입고번호 = V_입고번호;
    
    
    --  쿼리문 구성 → UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = (V_재고수량 - V_이전입고수량) + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    
    --  예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
            
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.







-- 2. PRC_입고_DELETE(입고번호)  
--  ○ DELETE : 데이터를 삭제할 때엔 DELETE 구문을 사용한다.
-- TBL_입고 에서 DELETE가 일어나면 TBL_상품 테이블에선 UPDATE 동.시.에(트렌젝션) 수행

-- EXEC PRC_입고_DELETE(1);

CREATE OR REPLACE PROCEDURE  PRC_입고_DELETE
( V_입고번호    IN TBL_입고.입고번호%TYPE
)
IS
    -- ③ 필요한 변수 추가 선언
    V_상품코드  TBL_입고.상품코드%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_입고수량  TBL_입고.입고수량%TYPE;
    
    
    -- ⑥⑦ 예외 변수 선언
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- ④ 쿼리문 작성 전 추가한 변수에 값 담기
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑤ 쿼리문 작성 전 추가한 변수에 값 담기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;

    SELECT 입고수량 INTO V_입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    
    
    -- ⑥ TLB_상품 테이블에서 재고수량이 입고수량보다 작을 경우 예외발생
    
    IF(V_재고수량 < V_입고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ① 쿼리문 구성 → DELETE(TBL_입고)
    DELETE        
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;

    -- ② 쿼리문 구성 → UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 -  V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    
    -- ⑧ 예외처리 (예외 발생 시 롤백)
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!~!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    -- ⑨ 커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.




--  3. PRC_출고_DELETE(출고번호)  입고INSERT 처럼 수행 
-- 즉, TBL_출고 테이블에서 DELETE 가 일어나면  TBL_상품에서는 UPDATE 동.시.에(트렌젝션) 수행
-- EXEC PRC_출고_DELETE(1);

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(V_출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    -- 필요한 변수 추가 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_출고수량  TBL_출고.출고수량%TYPE;
    
BEGIN
    -- 쿼리문 실행 전  얻어내야할 변수 값 담아내기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    SELECT 출고수량 INTO V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;


    --DELETE 문 출고 테이블
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    --UPDATE 문 상품테이블
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리 (정상적으로 처리되지못하는 다른 상황이면 롤백해라)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
        
    -- 다 확인되면 커밋
    COMMIT;

END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.


------------------------------------------------------------------------------














