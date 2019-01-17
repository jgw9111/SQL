-- *******************
-- [����021]
-- JOB_TITLE �� "Programmer" �Ǵ� "Sales Manager"�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- ������ �̸��� ������������ �����Ͻÿ�
-- *******************

-- �� :
select e.fname �̸�, e.hdate �Ի���, j.title ������
from  emp e
    inner join job j
    on j.JID like e.JID
where j.TITLE in ('Programmer', 'Sales Manager')
order by e.fname;
    
    
-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  

-- �� :
select d.DNAME �μ���, e.FNAME "�Ŵ��� �̸�"
from dep d
inner join emp e
on d.mid like e.eid
;

-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  

-- �� : 
select d.did
from dep d
where d.dname like 'Marketing';

select e.eid ��� ,j.title ��å, e.fname �̸�,
        h.edate - h.sdate �ټ��ϼ�
from hts h
    join job j
        on h.jid like j.jid
    join emp e
        on e.eid like h.eid
where e.did like 20;
-- *******************
select e.eid ��� ,j.title ��å, e.fname �̸�,
        h.edate - h.sdate �ټ��ϼ�
from hts h
    join job j
        on h.jid like j.jid
    join emp e
        on e.eid like h.eid
where e.did like (select d.did
from dep d
where d.dname like 'Marketing');


-- *******************
-- [����024]
-- ��å�� "Programmer" �� ����� ������ ���
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************  

-- �� : 
SELECT 
    DNAME �μ���, FNAME || ' ' || LNAME �̸�
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
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************
-- �� : �������� 
select
    d.dname �μ���, 
    e.fname || ' ' || e.lname"������ �̸�", 
    l.city "�μ���ġ ����"
from dep d
    join emp e 
        on d.mid like e.eID
    join loc l
        using(lid)
        -- lid �ݺ��Ǵ� ���: on d.lid like l.lid
order by dname;

-- *******************
-- [����026]
-- �μ��� ��� �޿��� ���Ͻÿ�
-- *******************

-- �� : 
select 
    d.dname �μ���,
    round(avg(e.SAL),2) "�μ��� ��� �޿�"
from emp e
    join dep d
        on e.did like d.did
group by e.did, d.dname;


-- *******************
-- group by ����
-- *******************
select 
    d.dname �μ���,
    round(avg(e.SAL),2) "�μ��� ��� �޿�"
from emp e
    join dep d
        on e.did like d.did
group by e.did, d.dname
having round(avg(e.SAL),2) >=  10000;