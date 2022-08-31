SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다..


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    GRADE CHAR;
BEGIN
    -- 실행부
    GRADE := 'A';
    
    IF GRADE ='A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCLLENT');
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
    
END;

--==>> EXCLLENT



DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
        
    END IF;
    
END;
--==>> GOOD



--○ CASE 문(조건문)
-- CASE ~ WHEN ~THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조  구문을 작성하는 순서
/*
CASE 변수
    WHEN 값1 THEN 실행문1;
    WHEN 값2 THEN 실행문2;
    ELSE 실행문N+1;
END CASE;
*/

-- 남자1 여자2 입력하세요
-- 1
-- 남자입니다.

-- 남자1 여자2 입력하세요
-- 2
-- 여자입니다.


ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    -- 선언부 → 주요 변수 선언
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '남자';
    
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : '|| SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    /*
    CASE SEL 
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    
    CASE SEL 
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 '|| RESULT ||'입니다.');
END;




--○ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- 『&외부변수명』 형태로 접근하게 된다.


--○ 정수 두 개를 외부로부터(사용자로부터) 입력받아
--  이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.


-- 내풀이
ACCEPT NUM PROMPT '정수를 입력 해주세요';

ACCEPT NUM1 PROMPT '정수를 입력 해주세요';

DECLARE
    SEL     NUMBER := &NUM;
    SEL1    NUMBER := &NUM1;
    RESULT  NUMBER(10);
BEGIN
    --SEL + SEL2 := &RESULT
     RESULT := &NUM + &NUM1;
    
    DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
END;

--------------------- T 선생님 풀이
ACCEPT N1 PROMPT '첫 번째 정수를 입력하세요';
ACCEPT N2 PROMPT '두 번째 정수를 입력하세요';

DECLARE
    -- 주요 변수 선언
    NUM1  NUMBER := &N1;
    NUM2  NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1); 10
    --DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2); 20
    
    -- 연산 및 처리
    TOTAL := NUM1 + NUM2;
    
    -- 결과 출력
    
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>> 23 + 47 = 70

--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
-- 단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.

/*
 실행 예)
 바인딩 변수 입력 대화창 → 금액 입력 : 990
 
 입력받은 금액 총액 : 990원
 화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
 
--○ MOD(파라미터1, 파라미터2)  나머지를 반환하는 함수         java → %
--> 파라미터 1을 파라미터 2로 나눈 나머지 결과 값 반환


*/
ACCEPT NUM PROMPT '금액 입력 : ';

DECLARE
    -- 주요 변수 선언
    TOTAL NUMBER := &NUM;
    N1 NUMBER;
    N2 NUMBER;
    N3 NUMBER;
    N4 NUMBER;
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('TOTAL : '|| TOTAL);
    
    -- 연산
    /*
    N1 := MOD(990, 500); --> 1
    N2 := MOD(490, 100);
    N3 := MOD(90, 50);
    N4 := MOD(40,10);
    */
    
    N1 := TRUNC(990/500); --> 1
    N2 := TRUNC(490/100);
    N3 := TRUNC(90/50);
    N4 := TRUNC(40/10);
    
    DBMS_OUTPUT.PUT_LINE('화폐단위 : ' || '오백원 ' || N1 ||','||' 백원 '
                        || N2 ||','||' 오십원 ' || N3 || ','||' 십원 ' || N4 );
END;
--==>> 화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4


ACCEPT INPUT PROMPT'금액 입력';

DECLARE
    -- 주요 변수 선언
    MONEY  NUMBER := INPUT;      --  연산을 위해 입력값을 담아둘 변수
    MONEY2 NUMBER := INPUT;      -- 결과 출력을 위해 입력값을 담아둘 변수
                                --(MONEY 변수가 연산 과정에서 값이 변하기 때문에(줄어드니까))
                        
    M500  NUMBER;            -- 500원 짜리 갯수를 담아둘 변수
    M100  NUMBER;            -- 100원 짜리 갯수를 담아둘 변수
    M50   NUMBER;            -- 50원 짜리 갯수를 담아둘 변수
    M10   NUMBER;            -- 10원 짜리 갯수를 담아둘 변수
BEGIN
    -- 연산 및 처리
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 갯수
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY 를 500으로 나워서 몫은 버리고 나머지를 취한다. → 500원의 갯수를 확인하고 남은 금액
    -- 이 결과를 다시 MONEY 에 담아낸다. ★복습시 주의
    MONEY := MOD(MONEY, 500);
    
    --MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. → 100원의 갯수
    
    M100 := TRUNC(MONEY / 100);
    
    --MONEY 를 100으로 나눠서 목은 버리고 나머지를 취한다. → 100원의 갯수를 확인하고 남은 금액
    -- 이 결과를 다시 MONEY에 담아낸다.
    
    MONEY := MOD(MONEY, 100);
    
    --MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 갯수
    M50 := TRUNC(MONEY / 50);
    
    --MONEY 를 500으로 나눠서 목은 버리고 나머지를 취한다. → 50원의 갯수를 확인하고 남은 금액
    -- 이 결과를 다시 MONEY에 담아낸다.
    MONEY := MOD(MONEY, 50);
    
    --MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. → 10원의 갯수
    M10 := TRUNC(MONEY / 10);
    
    -- 결과 출력
    -- 취합된 결과(화폐 단위별 갯수)를 형식에 맞게 최종 출력한다.
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : '|| MONEY2 || ' 원');   -- MONEY는 줄어들어있다
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원' || M500 ||
                    ', 백원' || M100 ||
                    ', 오십원' || M50 ||
                    ', 십원'|| M10);
END;








--○ 기본 반복문
-- LOOP ~ END LOOP; 

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    EXIT WHEN 조건;       -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;
*/

--○ 1부터 10까지의 수 출력 (LOOP문 활용)

DECLARE
    -- 주요변수선언
    N1  NUMBER := 0;
BEGIN
    LOOP
      N1 := +1;
        EXIT WHEN N1 = BETWEEN 1 AND 10;
    END LOOP;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(N1);
END;


---------- T 선생님 풀이

DECLARE
    N  NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >=10;           --출력은 10까지하고 10보다 커지면 증가 시키지않고 끝낸다.
        
        N := N +1;                  -- N++:   N+=1;
    END LOOP;
END;

--○ WHILE 반복문

-- WHILE LOOP ~ END LOOPO;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
-- WHILE LOOP 구문을 사용한다.
--   조건은 반복이 시작되는 시점에 체크하게 되어
--   LOOP내의 문장이 한 번도 수행되지 않을 경우도 있다.
--   LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조


/*
WHILE 조건 LOOP           -- 조건이 참인 경우 반복 수행
        -- 실행문;
END LOOP;
*/
--○ 1부터 10까지의 수 출력 (WHILE LOOP문 활용)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE  N<10 LOOP
        
         DBMS_OUTPUT.PUT_LINE(N);
        
         N := N + 1;
         
    END LOOP;
END;


-------- 선생님 풀이

DECLARE
    N  NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


-- ○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작수』에서 1씩 증가 하여
--    『끝냄수』가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조

/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
    -- 실행문;
END LOOP;
*/
--○ 1부터 10까지의 수 출력 (FOR LOOP문 활용)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


--○ 사용자로부터 임의의 단(구구단)을 입력받아
-- 해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.

/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2 * 1 = 2
2 * 2 = 4
    :
2 * 9 = 18


*/
-- 1. LOOP문
ACCEPT NUM PROMPT '단을 입력하세요 : ';
DECLARE
    NLOOP  NUMBER;                  -- 1 2 3 4 5 커지면서 곱해진다.
    S      NUMBER;                  -- 곱해진 결과값이 담긴다.
BEGIN
    NLOOP := 1;
    --S := NLOOP * &NUM;               -- NLOOP가 1 2 3 4 &NUM이 입력받은 단수
    LOOP
      --  S := NLOOP * &NUM           
        S := NLOOP * &NUM; 
        DBMS_OUTPUT.PUT_LINE(S);
        
        EXIT WHEN NLOOP>=9;
        
        NLOOP := NLOOP + 1;         -- NLOOP += 1;
    END LOOP;
    
END;



-- 2. WHILE LOOP문

ACCEPT NUM PROMPT '단을 입력하세요 : ';
DECLARE
    NWH     NUMBER;     -- 1 2 3 4 커지면거 곱해진다.
    S       NUMBER;     -- 구구단 결과값
BEGIN
    NHW := 1;
    S := NWH * &NUM;
    
    WHILE N<9 LOOP
        DBMS_OUTPUT.PUT_LINE(S);
        NWH := NWH + 1;
    END LOOP;
END;

-- 3. FOR LOOP문


ACCEPT NUM PROMPT '단을 입력하세요 : ';
DECLARE
BEGIN
END;






------------------------------------------- 선생님
-- 1. LOOP문

ACCEPT NUM PROMPT '단을 입력하세요 : ';

DECLARE
    DAN NUMBER;
    N  NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || '=' || (DAN * N) );
        EXIT WHEN N >= 9;
        N := N + 1;
    END LOOP;
END;


-- 2. WHILE LOOP문

ACCEPT NUM PROMPT '단을 입력하세요 : ';

DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
    
BEGIN

    N:= 0;
    WHILE N<9 LOOP
        N := N +1;
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N) );
    END LOOP;    
END;


-- 3. FOR LOOP문

ACCEPT NUM PROMPT '단을 입력하세요 : ';

DECLARE
    DAN  NUMBER := &NUM;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
    END LOOP;
END;

ACCEPT NUM PROMPT '단을 입력하세요 : ';
DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * '|| N || ' = ' || ()
    END LOOP;
END;





--○ 구구단 전체 (2단 ~ 9단).를 출력하는 PL/SQL 구문을 작성한다.
-- 단, 이중반복문 (반복문의 중첩) 구문을 활용한다.

/*
실행 예)
===[ 2단]===
2 * 1 = 2
2 * 2 = 4
     : 
     
===[ 3단]===
    :
    
9 * 9 = 81

*/


DECLARE
    DAN NUMBER;         -- 2단 3단 4단 ....9단 까지 커진다.
    N   NUMBER;         -- DAN * 1, DAN * 2   3 4 5 커진다.
BEGIN
    DAN := 2;
    N   := 1;    
    LOOP                -- 외부 루프 시작
     EXIT WHEN N >= 9;
     
        LOOP            -- 내부 루프 시작
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || '=' || (DAN * N) );
            
            N := N + 1;
        END LOOP;
        
        DAN := DAN + 1;
        
    END LOOP;
END;




DECLARE
    DAN NUMBER := 2;
    N   NUMBER:= 1;
BEGIN
    FOR DAN IN 2 .. 9 LOOP
        FOR N IN 1 .. 9 LOOP
            DBMS_OUTPUT
        END LOOP;
        
        DAN = DAN + 1;
        N = N + 1;
        
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || '=' || (DAN * N) );
    END LOOP;
    
END;

---------------------- 선생님

DECLARE
    N   NUMBER;
    M   NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('=== ['|| N || '단]===');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' || (N * M) );
        END LOOP;
        
    END LOOP;
END;


/*
=== [2단]===
2 * 1 = 2


=== [9단]===
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81

*/












