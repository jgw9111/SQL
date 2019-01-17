-- *******************
-- [문제021]
-- JOB_TITLE 가 "Programmer" 또는 "Sales Manager"인 
-- 직원의 이름, 입사일, 업무명 표시.
-- 직원의 이름을 오름차순으로 정렬하시오
-- *******************

-- 답 :
select e.fname 이름, e.hdate 입사일, j.title 업무명
from  emp e
    inner join job j
    on j.JID like e.JID
where j.TITLE in ('Programmer', 'Sales Manager')
order by e.fname;
    
    
-- *******************
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  

-- 답 :
select d.DNAME 부서명, e.FNAME "매니저 이름"
from dep d
inner join emp e
on d.mid like e.eid
;

-- *******************
-- [문제023]
-- 마케팅(Marketing) 부서에서 근무하는 사원의 
-- 사번, 직책, 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  

-- 답 : 
select d.did
from dep d
where d.dname like 'Marketing';

select e.eid 사번 ,j.title 직책, e.fname 이름,
        h.edate - h.sdate 근속일수
from hts h
    join job j
        on h.jid like j.jid
    join emp e
        on e.eid like h.eid
where e.did like 20;
-- *******************
select e.eid 사번 ,j.title 직책, e.fname 이름,
        h.edate - h.sdate 근속일수
from hts h
    join job j
        on h.jid like j.jid
    join emp e
        on e.eid like h.eid
where e.did like (select d.did
from dep d
where d.dname like 'Marketing');


-- *******************
-- [문제024]
-- 직책이 "Programmer" 인 사원의 정보를 출력
-- DEPARTMENT_NAME 부서명, 이름(FIRST_NAME + [공백] + LAST_NAME)까지 출력
-- 이름은 중복되어서 출력됨. 즉 한명이 여러부서에서 업무를 수행함
-- *******************  

-- 답 : 
SELECT 
    DNAME 부서명, FNAME || ' ' || LNAME 이름
FROM EMP E 
    JOIN JOB J
        ON E.JID LIKE J.JID
    JOIN DEP D
        ON E.DID LIKE D.DID
WHERE J.JID LIKE (SELECT JID 
                  FROM JOB 
                  WHERE TITLE LIKE 'Programmer')
;
    


-- *******************
-- [문제025]
-- 부서명, 관리자 이름, 부서위치 도시 표시
-- 부서명 오름차순
-- *******************
-- 답 : 삼중조인 
select
    d.dname 부서명, 
    e.fname || ' ' || e.lname"관리자 이름", 
    l.city "부서위치 도시"
from dep d
    join emp e 
        on d.mid like e.eID
    join loc l
        using(lid)
        -- lid 반복되는 경우: on d.lid like l.lid
order by dname;

-- *******************
-- [문제026]
-- 부서별 평균 급여를 구하시오
-- *******************

-- 답 : 
select 
    d.dname 부서명,
    round(avg(e.SAL),2) "부서별 평균 급여"
from emp e
    join dep d
        on e.did like d.did
group by e.did, d.dname;


-- *******************
-- group by 조건
-- *******************
select 
    d.dname 부서명,
    round(avg(e.SAL),2) "부서별 평균 급여"
from emp e
    join dep d
        on e.did like d.did
group by e.did, d.dname
having round(avg(e.SAL),2) >=  10000;