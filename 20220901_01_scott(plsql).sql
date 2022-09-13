SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
-- �޿��� ��(�⺻�� *12) + ���硻 ������� ������ �����Ѵ�.
-- �Լ��� : FN_PAY(�⺻��, ����)

SELECT *
FROM TBL_INSA;

CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER ,V_SUDANG NUMBER)
RETURN NUMBER
IS 
BEGIN
END;


CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER ,V_SUDANG NUMBER)
RETURN NUMBER
IS 
    -- ����
    V_RESULT NUMBER;
    
BEGIN
    -- ���� �� ó��
    V_RESULT := V_BASICPAY * 12 + V_SUDANG;
    
    RETURN V_RESULT;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.





CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER, V_SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := (NVL(V_BASICPAY, 0 *12)) + NVL(V_SUDANG, 0);  --������� NULL�� ����
    
    RETURN V_RESULT;
END;

SELECT *
FROM TBL_INSA;
DESC TBL_INSA;
--�� TBL_INSA ���̺��� �Ի����� �������� 
-- ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
-- ��, �ټ������ �Ҽ������� ���ڸ����� ����Ѵ�.
-- �Լ��� : FN_WORKYEAR(�Ի���)  
-- EXTRACT(YEAR FROM SYSDATE)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(V_IBSADATE DATE)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    -- V_RESULT := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM V_IBSDATE)
        -- 2022 - 1998 = 24��
    V_RESULT := ROUND((MONTHS_BETWEEN(SYSDATE, V_IBSADATE)/12), 1);
        -- 288.234234234/12 => 24.01936666666
        
    RETURN V_RESULT;
    
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

------------------------------ T ������
--1
SELECT MONTHS_BETWEEN(SYSDATE , '2022-02-11')/12
FROM DUAL;

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE , '2022-02-11')/12) ||'��'||
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE , '2022-02-11')/12)) ||'����'
FROM DUAL;

--3
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)"�ٹ��Ⱓ"
FROM TBL_INSA;

------------------�� ������ �̷� ���·� ���� ����.
CREATE OR REPLACE FUNCTION FN_WORKYEAR(V_IBSADATE DATE)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR(20);
BEGIN

    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE , V_IBSADATE)/12) ||'��'||
                TRUNC(MOD(MONTHS_BETWEEN(SYSDATE , V_IBSADATE)/12)) ||'����';
    RETURN V_RESULT;
END;

---------------- ������ Ǯ��
CREATE OR REPLACE FUNCTION FN_WORKYEAR(V_IBSADATE DATE)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN

    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE , V_IBSADATE)/12, 1);
    
    RETURN V_RESULT;

END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MARGE)
--==>> DML(Date Manipulation Language)      -- ������ ����
--  COMMIT/ ROLLBACK �� �ʿ��ϴ�. TCL ����


-- 2. CREATE, DROP, ALTER, (TRUNCATE)       -- ���������� ����
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.(����Ŀ��)

-- 3. GRANT , REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.(����Ŀ��)

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

--------------------------------------------------------------------------------

-- ���� PROCEDURE(���ν���) ���� -- PL�� �� ����������


-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������ Ÿ��
 , �Ű����� OUT ������ Ÿ��
 , �Ű����� INOUT ������ Ÿ��
)]
IS
    [--�ֿ� ���� ����]
BEGIN
    -- ���౸��;
    ...
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

-- �� FUNCTION �� ��������
--   ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--   ��RETURN���� ��ü�� �������� ������,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű�������
--   IN, OUT, INOUT ���� ���еȴ�.

-- 3. ����(ȣ��) 
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

-- ���ν��� ���� �ǽ� ������ ����
-- 20220901_02_scott.sql ���Ͽ� 
-- ���̺� ���� �� ������ �Է� ����


--�� ���ν��� ���� ���� �Է� �Ű������� �ѱ�� ���·� �ۼ��� ���̴�.
-- ���ν��� �� : PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ, �ּ�) 
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID          IN TBL_IDPW.ID%TYPE 
, V_PW          IN TBL_IDPW.PW%TYPE
, V_NAME        IN TBL_STUDENTS.NAME%TYPE
, V_TEL         IN TBL_STUDENTS.TEL%TYPE
, V_ADDR        IN TBL_STUDENTS.ADDR%TYPE
) 
IS
BEGIN
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID, V_PW);
    
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.

--�� TBL_SUNGSUK ���̺� ������ �Է� ��
--  Ư�� �׸��� �����͸� �Է��ϸ�
--  -----------------
--( �й�, �̸�, ��������, ��������, ��������)
-- ���������� ����, ���, ��޿� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ� 
-- ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
-- ���ν��� �� : PRC_SUNGSUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGSUK_INSERT(1, '���ҿ�', 90, 80, 70);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�   �������� ��������  ��������   ����  ���  ���
 1   ���ҿ�    90      80        70        240   80   B
 */
CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_INSERT
( V_HAKBUN  TBL_SUNGSUK.HAKBUN%TYPE
, V_NAME    TBL_SUNGSUK.NAME%TYPE
, V_KOR     TBL_SUNGSUK.KOR%TYPE
, V_ENG     TBL_SUNGSUK.ENG%TYPE
, V_MAT     TBL_SUNGSUK.MAT%TYPE
, V_TOT     TBL_SUNGSUK.TOT%TYPE
, V_AVG     TBL_SUNGSUK.AVG%TYPE
, V_GRADE   TBL_SUNGSUK.GRADE%TYPE
)
IS
    -- �����
     V_TOT1     TBL_SUNGSUK.TOT%TYPE;
     V_AVG1     TBL_SUNGSUK.AVG%TYPE;
     
BEGIN
    -- ���� �� ó��
    V_TOT1 := V_KOR + V_ENG + V_MAT;
    V_AVG1 := (V_KOR + V_ENG + V_MAT)/3;
    /*
    V_GRADE := CASE V_AVG WHEN >=90 THEN 'A';
                          WHEN >=80 THEN 'B';
                          WHEN >=70 THEN 'C';
                          WHEN >=60 THEN 'D';
                          ELSE 'F';
               END CASE;
     */
     V_GRADE := IF V_AVG1 >=90 THEN DBMS_OUTPUT.PUT_LINE('A');
                ELSIF V_AVG1 >=80 THEN DBMS_OUTPUT.PUT_LINE('B');
                ELSIF V_AVG1 >=70 THEN DBMS_OUTPUT.PUT_LINE('C');
                ELSIF V_AVG1 >=60 THEN DBMS_OUTPUT.PUT_LINE('D');
                ELSE DBMS_OUTPUT.PUT_LINE('F');
                END IF;

    INSERT INTO TBL_SUNGSUK(HAKBNUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT , V_AVG , V_GRADE);
END;


-------------------------T ������ Ǯ�� ����

CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_INSERT
( V_HAKBUN  IN TBL_SUNGSUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGSUK.NAME%TYPE
, V_KOR     IN TBL_SUNGSUK.KOR%TYPE
, V_ENG     IN TBL_SUNGSUK.ENG%TYPE
, V_MAT     IN TBL_SUNGSUK.MAT%TYPE
)
IS 
BEGIN
END;
---------------------- �̱��� �ϸ� �Ķ���� ���� ��


CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_INSERT
( V_HAKBUN  IN TBL_SUNGSUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGSUK.NAME%TYPE
, V_KOR     IN TBL_SUNGSUK.KOR%TYPE
, V_ENG     IN TBL_SUNGSUK.ENG%TYPE
, V_MAT     IN TBL_SUNGSUK.MAT%TYPE
)
IS 
BEGIN
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGSUK(HAKBUN, NAME, KOR, ENG, MAT, TOT,AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, ????,???,???);
    
END;


--------------------------- �ʿ��Ѱ��� �����ؾ� �� ��


CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_INSERT
( V_HAKBUN  IN TBL_SUNGSUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGSUK.NAME%TYPE
, V_KOR     IN TBL_SUNGSUK.KOR%TYPE
, V_ENG     IN TBL_SUNGSUK.ENG%TYPE
, V_MAT     IN TBL_SUNGSUK.MAT%TYPE
)
IS 
        --  �����
        --  INSERT ������ ������ �ϱ� ���� �ʿ��� ����
        V_TOT   TBL_SUNGSUK.TOT%TYPE;
        V_AVG   TBL_SUNGSUK.AVG%TYPE;
        V_GRADE TBL_SUNGSUK.GRADE%TYPE;
BEGIN
    -- �����
    -- INSERT ������ �����ϱ�����
    -- ����ο��� ������ �ֿ� �����鿡 ���� ��Ƴ����Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    -- � ��Ȳ�̳Ŀ� ���� �б��ؼ� ��ƾ��Ѵ�.(��Ȳ�� ���� �б� �ʿ�)
    -- V_GRADE := 
    IF(V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGSUK(HAKBUN, NAME, KOR, ENG, MAT, TOT,AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- �μ�Ʈ �������� �Ѿư����� Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGSUK_INSERT��(��) �����ϵǾ����ϴ�.



--�� TBL_SUNGSUK ���̺� Ư�� �л��� ���� ������ ���� ��
--  Ư�� �׸��� �����͸� �Է��ϸ�
--  -----------------
--( �й�, ��������, ��������, ��������)
-- ���������� ����, ���, ��޿� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ� 
-- ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
-- ���ν��� �� : PRC_SUNGSUK_UPDATE()


/*
���� ��)
EXEC PRC_SUNGSUK_UPDATE(1, 50, 50, 50);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�   �������� ��������  ��������   ����  ���  ���
 1   ���ҿ�    50      50        50       150    50    F
 */
 
 ---------------- ���� �� �� UPDATE�������ε� INSERT �ۼ�......
CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_UPDATE
( V_HAKBUN IN TBL_SUNGSUK.HAKBUN%TYPE
, V_KOR IN TBL_SUNGSUK.KOR%TYPE
, V_ENG IN TBL_SUNGSUK.ENG%TYPE
, V_MAT IN TBL_SUNGSUK.MAT%TYPE
)
IS
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� ����
    V_NAME TBL_SUNGSUK.NAME%TYPE;
    V_TOT   TBL_SUNGSUK.TOT%TYPE;
    V_AVG   TBL_SUNGSUK.AVG%TYPE;
    V_GRADE TBL_SUNGSUK.GRADE%TYPE;
    
BEGIN
    -- INSERT ������ �����ϱ� ����
    -- ����ο��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    -- V_GRADE ��Ȳ�� ���� �б� �ʿ�
    IF(V_AVG >=90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';   
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    -- �μ�Ʈ ������ ����
    INSERT INTO TBL_SUNGSUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, NAME, V_KOR, V_ENG, V_MAT, TOT,AVG, GRADE);
    
    --�μ�Ʈ �������� ���ư����� Ŀ��
    COMMIT;
END;



-------------------------T ������ Ǯ�� ����

CREATE OR REPLACE PROCEDURE PRC_SUNGSUK_UPDATE
( V_HAKBUN IN TBL_SUNGSUK.HAKBUN%TYPE
, V_KOR IN TBL_SUNGSUK.KOR%TYPE
, V_ENG IN TBL_SUNGSUK.ENG%TYPE
, V_MAT IN TBL_SUNGSUK.MAT%TYPE
-- , �� ���еǴ� �Ű�����
)
IS
    -- �����
    -- UPDATE  ������ ������ ���� �ʿ��� ���� ����
    V_TOT   TBL_SUNGSUK.TOT%TYPE;
    V_AVG   TBL_SUNGSUK.AVG%TYPE;
    V_GRADE TBL_SUNGSUK.GRADE%TYPE;
BEGIN
    -- �����  (������ �߿��ϴ�)
    -- UPDATE ������ ���࿡ �ռ� �߰��� ������ �ֿ� �����鿡 �� ��Ƴ���

    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    IF(V_AVG >=90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';   
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    
    -- UPDATE ������ ����
    UPDATE TBL_SUNGSUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
         , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGSUK_UPDATE��(��) �����ϵǾ����ϴ�.

SELECT *
FROM TBL_STUDENTS; -- ID, NAME, TEL, ADDR

-- �� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� ����(�����ϴ�)
-- ���ν����� �ۼ��Ѵ�. 
-- ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� �����Ѵ�.
-- ���ν����� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman','java002','010-9876-5432','������ Ⱦ��');
--> �н����� ��ġ���� ���� --==>> ������ ���� X
EXEC PRC_STUDENTS_UPDATE('superman','java002$','010-9876-5432','������ Ⱦ��');
--> �н����� ��ġ�� --==>> ������ ���� ��
*/
SELECT *
FROM TBL_IDPW;  -- ID, PW

SELECT I.ID, S.NAME,S.TEL, S.ADDR, I.PW
FROM TBL_STUDENTS S JOIN TBL_IDPW I
ON S.ID = I.ID 
WHERE I.PW = V_PW
 AND I.ID = V_ID;




SELECT *
FROM
(
    SELECT I.ID, S.NAME,S.TEL, S.ADDR, I.PW
    FROM TBL_STUDENTS S JOIN TBL_IDPW I
    ON S.ID = I.ID
)T;




CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID TBL_STUDENTS%ROWTYPE
, V_PW TBL_IDPW%ROWTYPE

)
IS
    --�����
    V_TEL TBL_STUDENTS.TEL%TYPE;
    V_ADDR TBL_STUDENTS.ADDR%TYPE;
    
BEGIN
    --�����
    UPDATE TBL_STUDENTS
    SET ID = V_ID, PW = V_PW, TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND PW = V_PW;
END;






CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID IN TBL_STUDENTS.ID%TYPE
, V_PW IN SELECT I.ID, S.NAME,S.TEL, S.ADDR, I.PW
           FROM TBL_STUDENTS S JOIN TBL_IDPW I
           ON S.ID = I.ID.I.PW%TYPE
)
IS
    --�����
    --UPDATE ������ ������ ���� �ʿ��� ���� ����
    V_TEL   TBL_STUDENTS.TEL%TYPE;
    V_ADDR  TBL_STUDENTS.ADDR%TYPE;
    
BEGIN
    --�����
    UPDATE TBL_STUDENTS
    SET ID = V_ID, PW = V_PW, TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND PW = V_PW;
END;
--==>>  "SELECT" when expecting one of the following:   




CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID IN TBL_STUDENTS.ID%TYPE
, V_PW IN TBL_IDPW.PW%TYPE
, V_TEL IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS
    
BEGIN
    --�����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = (SELECT I.ID 
                FROM TBL_STUDENTS S JOIN TBL_IDPW I
                ON S.ID = I.ID
                WHERE I.PW = V_PW
                 AND I.ID = V_ID);
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.



SELECT SA.ID 
FROM TBL_STUDENTS S JOIN TBL_IDPW SA
ON S.ID = SA.ID
WHERE SA.PW = V_PW
 AND SA.ID = V_ID;
----------------------------T ������ Ǯ��
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID   IN TBL_IDPW.ID%TYPE
, V_PW  IN TBL_IDPW.PW%TYPE
, V_TEL  IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
END;

-----��

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID   IN TBL_IDPW.ID%TYPE
, V_PW   IN TBL_IDPW.PW%TYPE
, V_TEL  IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE(SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID)T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR      
    WHERE T.ID = V_ID 
      AND T.PW = V_PW;
      
      COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.




-----��
----------------------------T ������ Ǯ��
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID   IN TBL_IDPW.ID%TYPE
, V_PW   IN TBL_IDPW.PW%TYPE
, V_TEL  IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- �ʿ��� ���� ����
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0;
    
BEGIN
    -- �н����尡 �´��� Ȯ��
    --(����ڰ� �Է��� V_PW �� ���� �е����� �������� Ȯ��)
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    -- �н����� ��ġ ���ο� ���� �б�
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG := 2;
    END IF;

    -- UPDATE ������ ���� �� TBL_STUDENTS (�б� ��� �ݿ�)
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
    -- Ŀ��;
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- ���� ������ �÷� ��
-- NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
-- �� ������ �Է� ��
-- NUM �÷�(�����ȣ) �� ����
-- ���� �ο��� �����ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó�� �� �� �ִ�
-- ���ν����� �����Ѵ�.
-- ���ν��� �� : PRC_INSA_INSERT()

/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970124-2234567', SYSDATE, '����','010-7202-6306'
                    ,'���ߺ�','�븮','20000000, 20000000);
                    
���ν��� ȣ��� ó���� ���
 1061 ������ 970124-2234567 2022-09-01 ���� 010-7202-6306 ���ߺ� �븮 20000000  20000000
 �� �����Ͱ� �ű� �Էµ� ��Ȳ
*/


INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
VALUES (1061, 


CREATE SEQUENCE TBL_INSA_SEQ      -- �⺻���� ������ ���� ����
START WITH 1061                         -- ���۰�
INCREMENT BY 1                       -- ������
--MINVALUE 1                            -- �ּҰ�
--MAXVALUE 9900                         -- �ִ밪
NOCACHE;                              -- ĳ�� ��� ����(����)
--==>> Sequence TBL_INSA_SEQ��(��) �����Ǿ����ϴ�.
DROP SEQUENCE TBL_INSA_SEQ;
--==>> Sequence TBL_INSA_SEQ��(��) �����Ǿ����ϴ�.



CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    -- V_NUM TBL_INSA.NUM%TYPE;
BEGIN
    --NUM := TBL_INSA_SQE.NEXTVAL;
    -- ������ �Է�
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(TBL_INSA_SQE.NEXTVAL, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG); 
END;


--------------------------T ������ Ǯ��

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
)
IS
BEGIN
END;


CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM TBL_INSA.NUM%TYPE;
    
BEGIN

--�� INTO �� ��´ٴ� �� 
--NVL NULL ó�� �ǰ� �߿��ѱ���
    SELECT MAX(NVL(NUM,0)) + 1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG); 
    
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.













