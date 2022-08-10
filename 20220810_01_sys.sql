
-- 1줄 주석문 처리(단일행 주석문 처리)

/*
여러줄 
(다중행)
주석문
처리
자바랑 동일*/ 

-- ○현재 오라클 서버에 접속한 자신의 계정 조회
show user;
--==>> USER이(가) "SYS"입니다.
-- sqlplus 상태 일때 사용하는 명령어

select user
from dual;
--==>> SYS

-- 대소문자를 안가린다.
SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1+2
FROM DUAL;
-- SELECT은 FRM 오라클에서 제공하는 더미테이블
--==>> 3


SELECT           1+  2
FROM DUAL;
--==>> 3

S    ELECT 1 + 2
F   ROM DUAL;
--==>> 에러 발생





