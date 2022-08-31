SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�..


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    -- �����
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



--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����  ������ �ۼ��ϴ� ����
/*
CASE ����
    WHEN ��1 THEN ���๮1;
    WHEN ��2 THEN ���๮2;
    ELSE ���๮N+1;
END CASE;
*/

-- ����1 ����2 �Է��ϼ���
-- 1
-- �����Դϴ�.

-- ����1 ����2 �Է��ϼ���
-- 2
-- �����Դϴ�.


ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- ����� �� �ֿ� ���� ����
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '����';
    
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('SEL : '|| SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    /*
    CASE SEL 
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    */
    
    CASE SEL 
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� '|| RESULT ||'�Դϴ�.');
END;




--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- ��&�ܺκ����� ���·� �����ϰ� �ȴ�.


--�� ���� �� ���� �ܺηκ���(����ڷκ���) �Է¹޾�
--  �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.


-- ��Ǯ��
ACCEPT NUM PROMPT '������ �Է� ���ּ���';

ACCEPT NUM1 PROMPT '������ �Է� ���ּ���';

DECLARE
    SEL     NUMBER := &NUM;
    SEL1    NUMBER := &NUM1;
    RESULT  NUMBER(10);
BEGIN
    --SEL + SEL2 := &RESULT
     RESULT := &NUM + &NUM1;
    
    DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
END;

--------------------- T ������ Ǯ��
ACCEPT N1 PROMPT 'ù ��° ������ �Է��ϼ���';
ACCEPT N2 PROMPT '�� ��° ������ �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ����
    NUM1  NUMBER := &N1;
    NUM2  NUMBER := &N2;
    TOTAL NUMBER := 0;
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1); 10
    --DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2); 20
    
    -- ���� �� ó��
    TOTAL := NUM1 + NUM2;
    
    -- ��� ���
    
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>> 23 + 47 = 70

--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
-- ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.

/*
 ���� ��)
 ���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990
 
 �Է¹��� �ݾ� �Ѿ� : 990��
 ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
 
--�� MOD(�Ķ����1, �Ķ����2)  �������� ��ȯ�ϴ� �Լ�         java �� %
--> �Ķ���� 1�� �Ķ���� 2�� ���� ������ ��� �� ��ȯ


*/
ACCEPT NUM PROMPT '�ݾ� �Է� : ';

DECLARE
    -- �ֿ� ���� ����
    TOTAL NUMBER := &NUM;
    N1 NUMBER;
    N2 NUMBER;
    N3 NUMBER;
    N4 NUMBER;
BEGIN
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('TOTAL : '|| TOTAL);
    
    -- ����
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
    
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ' || '����� ' || N1 ||','||' ��� '
                        || N2 ||','||' ���ʿ� ' || N3 || ','||' �ʿ� ' || N4 );
END;
--==>> ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4


ACCEPT INPUT PROMPT'�ݾ� �Է�';

DECLARE
    -- �ֿ� ���� ����
    MONEY  NUMBER := INPUT;      --  ������ ���� �Է°��� ��Ƶ� ����
    MONEY2 NUMBER := INPUT;      -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                --(MONEY ������ ���� �������� ���� ���ϱ� ������(�پ��ϱ�))
                        
    M500  NUMBER;            -- 500�� ¥�� ������ ��Ƶ� ����
    M100  NUMBER;            -- 100�� ¥�� ������ ��Ƶ� ����
    M50   NUMBER;            -- 50�� ¥�� ������ ��Ƶ� ����
    M10   NUMBER;            -- 10�� ¥�� ������ ��Ƶ� ����
BEGIN
    -- ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�. �� 500���� ������ Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���. �ں����� ����
    MONEY := MOD(MONEY, 500);
    
    --MONEY �� 100���� ������ ���� ���ϰ� �������� ������. �� 100���� ����
    
    M100 := TRUNC(MONEY / 100);
    
    --MONEY �� 100���� ������ ���� ������ �������� ���Ѵ�. �� 100���� ������ Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY�� ��Ƴ���.
    
    MONEY := MOD(MONEY, 100);
    
    --MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY / 50);
    
    --MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�. �� 50���� ������ Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY�� ��Ƴ���.
    MONEY := MOD(MONEY, 50);
    
    --MONEY �� 10���� ������ ���� ���ϰ� �������� ������. �� 10���� ����
    M10 := TRUNC(MONEY / 10);
    
    -- ��� ���
    -- ���յ� ���(ȭ�� ������ ����)�� ���Ŀ� �°� ���� ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : '|| MONEY2 || ' ��');   -- MONEY�� �پ����ִ�
    DBMS_OUTPUT.PUT_LINE('ȭ����� : �����' || M500 ||
                    ', ���' || M100 ||
                    ', ���ʿ�' || M50 ||
                    ', �ʿ�'|| M10);
END;








--�� �⺻ �ݺ���
-- LOOP ~ END LOOP; 

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    EXIT WHEN ����;       -- ������ ���� ��� �ݺ����� ����������.
END LOOP;
*/

--�� 1���� 10������ �� ��� (LOOP�� Ȱ��)

DECLARE
    -- �ֿ亯������
    N1  NUMBER := 0;
BEGIN
    LOOP
      N1 := +1;
        EXIT WHEN N1 = BETWEEN 1 AND 10;
    END LOOP;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(N1);
END;


---------- T ������ Ǯ��

DECLARE
    N  NUMBER;
BEGIN
    N := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >=10;           --����� 10�����ϰ� 10���� Ŀ���� ���� ��Ű���ʰ� ������.
        
        N := N +1;                  -- N++:   N+=1;
    END LOOP;
END;

--�� WHILE �ݺ���

-- WHILE LOOP ~ END LOOPO;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
-- WHILE LOOP ������ ����Ѵ�.
--   ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--   LOOP���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--   LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����


/*
WHILE ���� LOOP           -- ������ ���� ��� �ݺ� ����
        -- ���๮;
END LOOP;
*/
--�� 1���� 10������ �� ��� (WHILE LOOP�� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE  N<10 LOOP
        
         DBMS_OUTPUT.PUT_LINE(N);
        
         N := N + 1;
         
    END LOOP;
END;


-------- ������ Ǯ��

DECLARE
    N  NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


-- �� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �����ۼ������� 1�� ���� �Ͽ�
--    ������������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����

/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP;
*/
--�� 1���� 10������ �� ��� (FOR LOOP�� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
-- �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2 * 1 = 2
2 * 2 = 4
    :
2 * 9 = 18


*/
-- 1. LOOP��
ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';
DECLARE
    NLOOP  NUMBER;                  -- 1 2 3 4 5 Ŀ���鼭 ��������.
    S      NUMBER;                  -- ������ ������� ����.
BEGIN
    NLOOP := 1;
    --S := NLOOP * &NUM;               -- NLOOP�� 1 2 3 4 &NUM�� �Է¹��� �ܼ�
    LOOP
      --  S := NLOOP * &NUM           
        S := NLOOP * &NUM; 
        DBMS_OUTPUT.PUT_LINE(S);
        
        EXIT WHEN NLOOP>=9;
        
        NLOOP := NLOOP + 1;         -- NLOOP += 1;
    END LOOP;
    
END;



-- 2. WHILE LOOP��

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';
DECLARE
    NWH     NUMBER;     -- 1 2 3 4 Ŀ����� ��������.
    S       NUMBER;     -- ������ �����
BEGIN
    NHW := 1;
    S := NWH * &NUM;
    
    WHILE N<9 LOOP
        DBMS_OUTPUT.PUT_LINE(S);
        NWH := NWH + 1;
    END LOOP;
END;

-- 3. FOR LOOP��


ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';
DECLARE
BEGIN
END;






------------------------------------------- ������
-- 1. LOOP��

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';

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


-- 2. WHILE LOOP��

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';

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


-- 3. FOR LOOP��

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';

DECLARE
    DAN  NUMBER := &NUM;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
    END LOOP;
END;

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';
DECLARE
    DAN NUMBER := &NUM;
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * '|| N || ' = ' || ()
    END LOOP;
END;





--�� ������ ��ü (2�� ~ 9��).�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
-- ��, ���߹ݺ��� (�ݺ����� ��ø) ������ Ȱ���Ѵ�.

/*
���� ��)
===[ 2��]===
2 * 1 = 2
2 * 2 = 4
     : 
     
===[ 3��]===
    :
    
9 * 9 = 81

*/


DECLARE
    DAN NUMBER;         -- 2�� 3�� 4�� ....9�� ���� Ŀ����.
    N   NUMBER;         -- DAN * 1, DAN * 2   3 4 5 Ŀ����.
BEGIN
    DAN := 2;
    N   := 1;    
    LOOP                -- �ܺ� ���� ����
     EXIT WHEN N >= 9;
     
        LOOP            -- ���� ���� ����
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

---------------------- ������

DECLARE
    N   NUMBER;
    M   NUMBER;
BEGIN
    FOR N IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('=== ['|| N || '��]===');
        
        FOR M IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N || ' * ' || M || ' = ' || (N * M) );
        END LOOP;
        
    END LOOP;
END;


/*
=== [2��]===
2 * 1 = 2


=== [9��]===
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












