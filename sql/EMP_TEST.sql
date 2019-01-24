SELECT * FROM EMP;
-- EMPNO 사원
-- ENAME 사원명
-- JOB 업무
-- MGR 매니저 
-- HIREDATE 입사일
-- SAL 월급 
-- COMM 커미션
-- DEPTNO 부서코드

SELECT * FROM DEPT;
-- DEPTNO 부서코드
-- DNAME 부서이름
-- LOC 회사위치

-- EMP TEST 01
-- CASE 표현 

-- 답 : 
SELECT ENAME, 
    CASE WHEN SAL > 2000
        THEN SAL
        ELSE 2000
    END REVISED_SALARY
FROM EMP;

-- 문법 
-- CASE WHEN 조건식
--    THEN 참일경우
--    ELSE 거짓일 경우
-- END 컬럼명으로 처리

-- EMP TEST 02
-- 부서정보에서 부서위치를 미국의 동부, 중부, 서부로 구분하라
-- 뉴욕 - EAST , 보스턴 - EAST , 시카고 - CENTER , 달라스 - CENTER
-- 컬럼명 - AREA

-- 답 : 
SELECT DNAME,
    CASE WHEN LOC IN('NEW YORK' ,'BOSTON') THEN 'EAST'
        WHEN LOC IN('DALLAS','CHICAGO') THEN 'CENTER'
        ELSE 'WEST'
    END AREA 
FROM DEPT
;



-- EMP_TEST_03
-- 급여가 3000 이상이면 HIGH, 1000 이상이면 MID, 미만이면 LOW 

-- 답 :
SELECT ENAME,SAL ,
    CASE WHEN SAL >= 3000
        THEN 'HIGH'
        WHEN SAL >= 1000
        THEN 'MID'
        ELSE 'LOW'
    END 급여수준  
FROM EMP
ORDER BY SAL
;


-- EMP_TEST_04
-- 급여가 2000 이상이면 보너스 1000, 
-- 1000 이상이면 500,
-- 1000 미만이면 0으로 계산하시오
-- 컬럼명은 BONUS

-- 답 :

SELECT ENAME,SAL,
    CASE WHEN SAL >= 2000
        THEN '1000'
        WHEN SAL >= 1000
        THEN '500'
        ELSE '0'
    END BONUS
FROM EMP
ORDER BY BONUS;
;


-- EMP_TEST_05
-- 매니저가 "BLAKE" 이면 NULL 표시, 같지 않으면 MGR 표시

-- 답 :
SELECT ENAME, EMPNO, MGR,
    CASE WHEN MGR LIKE (SELECT EMPNO
                    FROM EMP 
                    WHERE ENAME LIKE 'BLAKE')
         THEN NULL
         ELSE MGR
    END NUIF
FROM EMP; 

SELECT *
from EMP;

-- EMP TEST 06
-- 개별입사정보에서 월별 데이터를 추출하기
--  EXTRACT()

-- 답 :
SELECT ENAME, DEPTNO, EXTRACT(MONTH FROM HIREDATE) 입사월, SAL
FROM EMP;


-- EMP TEST 07
-- 추출된 MONTH 데이터를 12개의 월별 칼럼으로 구분하기
-- 답 :
SELECT ENAME, DEPTNO, 
    CASE MONTH WHEN 1 THEN SAL END "1월",
    CASE MONTH WHEN 2 THEN SAL END "2월",
    CASE MONTH WHEN 3 THEN SAL END "3월",
    CASE MONTH WHEN 4 THEN SAL END "4월",
    CASE MONTH WHEN 5 THEN SAL END "5월",
    CASE MONTH WHEN 6 THEN SAL END "6월",
    CASE MONTH WHEN 7 THEN SAL END "7월",
    CASE MONTH WHEN 8 THEN SAL END "8월",
    CASE MONTH WHEN 9 THEN SAL END "9월",
    CASE MONTH WHEN 10 THEN SAL END "10월",
    CASE MONTH WHEN 11 THEN SAL END "11월",
    CASE MONTH WHEN 12 THEN SAL END "12월"
FROM (SELECT ENAME, DEPTNO, 
    EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
    FROM EMP)    
;

-- 오라클함수 DECODE . 기능은 같다
SELECT ENAME, DEPTNO, 
        DECODE(MONTH,1,SAL) "1월"
FROM (SELECT ENAME, DEPTNO, 
    EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
    FROM EMP)    
;    

-- EMP TEST 08
-- 추출된 MONTH 데이터를 12개의 월별칼럼으로 구분한 후
-- 부서별로 구별하기

-- 답 : 
SELECT (SELECT DNAME
        FROM DEPT D
        WHERE D.DEPTNO LIKE T.DEPTNO) DNAME,DEPTNO, 
    AVG(CASE MONTH WHEN 1 THEN SAL END) "1월",
    AVG(CASE MONTH WHEN 2 THEN SAL END) "2월",
    AVG(CASE MONTH WHEN 3 THEN SAL END) "3월",
    AVG(CASE MONTH WHEN 4 THEN SAL END) "4월",
    AVG(CASE MONTH WHEN 5 THEN SAL END) "5월",
    AVG(CASE MONTH WHEN 6 THEN SAL END) "6월",
    AVG(CASE MONTH WHEN 7 THEN SAL END) "7월",
    AVG(CASE MONTH WHEN 8 THEN SAL END) "8월",
    AVG(CASE MONTH WHEN 9 THEN SAL END) "9월",
    AVG(CASE MONTH WHEN 10 THEN SAL END) "10월",
    AVG(CASE MONTH WHEN 11 THEN SAL END) "11월",
    AVG(CASE MONTH WHEN 12 THEN SAL END) "12월"
FROM (SELECT ENAME, E.DEPTNO, 
    EXTRACT(MONTH FROM HIREDATE) MONTH, SAL
    FROM EMP E) T   
GROUP BY T.DEPTNO
;


-- EMP TEST 09
-- 계층형 쿼리
-- LEVEL : 루트 데이터이면 1, 그 하위 데이터이면 2이다.
-- 리프(LEAF) 데이터까지 1씩 증가한다
-- CONNECT_BY_ISLEAF 전개 과정에서 해당데이터가 리프데이터아면 
-- 1, 그렇지 않으면 0 이다.
-- LPAD 는 결과 데이터를 들여쓰기 하기 위해 사용함

-- 답 :
SELECT LEVEL, 
       LPAD(' ',4*(LEVEL-1)) || EMPNO 사원,
       MGR 관리자,
       CONNECT_BY_ISLEAF ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO LIKE MGR;

-- EMP TEST 009 
-- 셀프조인 

-- 자신과 자신의 직속관리자는 동일한 행에서 구할 수 있으나,
-- 상위 관리자는 바로 구할 수 없기 때문에 
-- 자신의 직속 관리자를 기준으로 셀프조인을 수행해야한다.
-- 그러나, INNER JOIN 을 사용함으로써 
-- 자신의 관리자가 존재하지 않는 경우에는
-- E2 테이블에서 조인할 대상이 존재하지 않기 때문에
-- 해당 데이터는 결과에서 누락된다
-- 이를 방지하기 위해서는 아우터 조인을 써야한다. 
------> SELF JOIN 을 하면 OUTER JOIN 을 써야함 

SELECT E1.EMPNO 사번, E1.MGR 관리자, E2.MGR "상위 관리자"
FROM EMP E1
    JOIN EMP E2
        ON E1.MGR LIKE E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO
;


----> OUTER JOIN(생략 가능) LEFT ( OUTER )
SELECT E1.EMPNO 사번, E1.MGR 관리자, E2.MGR "상위 관리자"
FROM EMP E1
    LEFT OUTER JOIN EMP E2
        ON E1.MGR LIKE E2.EMPNO
ORDER BY E2.MGR DESC, E1.MGR, E1.EMPNO
;

-- EMP TEST 011
-- GROUP FUNTION 그룹함수
-- 일반적인 GROUP BY 함수

-- ANSI 에서 정의한 함수 세가지
-- AGGREGATE FUNCTION 집계  SUM(), MIN(), MAX(), AVG(), COUNT()
-- GROUP FUNCTION 그룹함수 

-- 특정 항목에 대한 소계를 하는 함수
-- ROLLUP() : 소그룹간의 소계를 계산하는 함수
-- CUBE() : 다차원적인 소계를 계산하는 함수
-- WINDOW FUNCTION 윈도우 함수
-- RANK() , ROW_NUMBER()

--
SELECT DNAME 부서명, JOB 업무, COUNT(*) "전체 사원",
       SUM(SAL) "전체 급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY DNAME,JOB
;

-- ROLLUP 
SELECT DNAME 부서명, JOB 업무, COUNT(*) "전체 사원",
       SUM(SAL) "전체 급여"
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY ROLLUP(DNAME,JOB)
;

-- CUBE 
SELECT CASE GROUPING(DNAME)
            WHEN 1 THEN '부서'
            ELSE DNAME 
            END "부서명",
        CASE GROUPING(JOB)
            WHEN 1 THEN 'ALL DEPTS'
            ELSE JOB 
            END AS "업무",
        COUNT(*) "전체 사원",
        SUM(SAL) "전체 급여"
            
FROM EMP E, DEPT D
WHERE E.DEPTNO LIKE D.DEPTNO
GROUP BY CUBE(DNAME,JOB)
;



