----Join + Aliases
select e.LAST_NAME 이름, d.DEPARTMENT_name 부서명 
from employees e
inner join departments d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;


select department_id
from employees
where last_name like 'Fay';
-- +
select department_name
from departments
where department_id like '20';

-- 서브쿼리 사용
select department_name
from departments
where department_id like 
(select department_id
from employees
where last_name like 'Fay');

desc employees;

-- create view
create view emp as
select employee_id eid,
first_name fname,
last_name lname,
email email,
phone_number phone,
hire_date hdate,
job_id jid,
salary sal,
commission_pct comm,
manager_id mid,
department_id did from employees;

desc jobs;
create view job as
select 
    JOB_ID jid, 
    JOB_TITLE title,
    MIN_SALARY minsal,
    MAX_SALARY maxsal
from jobs;

desc departments;
create view dep as
select 
    DEPARTMENT_ID did,
    DEPARTMENT_NAME dname,
    MANAGER_ID mid,
    LOCATION_ID lid
from departments;

desc locations;
create view loc as
select 
    LOCATION_ID lid,
    STREET_ADDRESS addr,
    POSTAL_CODE zip,
    CITY,
    STATE_PROVINCE prov,
    COUNTRY_ID cid
from locations;

desc job_history;
create view hts as
select  
    EMPLOYEE_ID eid,
    START_DATE sdate,
    END_DATE edate,
    JOB_ID jid,
    DEPARTMENT_ID did
from job_history;


select * from tab;