-- ******
-- EMPLOYEES ���̺�
-- [ employee_id = ��� ] [ first_name = �̸� ] 
-- [ last_name = �� ] [ email = �̸��� ] 
-- [ phone_number = ��ȭ��ȣ ] [ hire_date = ����� ]
-- [ job_id = ����ID ] [ salary = �޿�]
-- [ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = ���ID]
-- [ department_id = �μ�ID]

-- *******
-- ����011. 
-- Ŀ�̼��� ���� ���ϴ� ������ �̸�,�����ڵ�,�޿�,Ŀ�̼Ǻ����� ��ȸ
-- *******

-- �� :
select first_name,job_id,salary,commission_pct
from EMPLOYEES
where commission_pct is null ;

-- *******
-- ����012. 
-- ����� 110,120,130�� ����� ���, ��, �̸� ��ȸ
-- *******

-- �� :
select employee_id,last_name,first_name
from EMPLOYEES
where employee_id in(110,120,130) ;

-- *******
-- ����013. 
-- �μ��ڵ�� ��������, �޿��� ������������ 
-- �μ��ڵ�, �޿�, ���, �̸�, �� ����
-- �������� 0,1,2 ... �������� 9,8,7...
-- ******

-- �� :
select department_id,salary,employee_id,first_name,last_name 
from EMPLOYEES 
order by department_id ,salary desc,first_name;

-- *******
-- ����014. 
-- �̸��� am �̶� ���ڰ� ���Ե� ������ ���,�̸�, ��
-- *******

-- �� :
select first_name from EMPLOYEES where first_name like '%am%';

-- *******
-- ����015. 
-- �̸��Ͽ� 'GG' �� 'KK'�δܾ� �� �ϳ��� ���ԵǾ ��ȸ
-- ��, ��ҹ��� ������
-- *******

-- �� :
select email from EMPLOYEES where email like '%GG%' or email like '%KK%';

-- *******
-- ����016. 
-- �̸����ּҰ� A �� �������� �ʴ� �̸��� ����
-- *******

-- �� :
select count(*) email from EMPLOYEES where not(email like 'A%');

-- *******
-- ����017.
-- ���� �ι�°,����° ���ڰ� ���ÿ� e �� ������ �̸�, ��
-- *******

-- �� : 
select first_name,last_name from EMPLOYEES where last_name like '_e%' and last_name like '__e%';

-- *******
-- ����018
 -- �����ӱ��� 10000�� �̻��� ���� �� �� ������ ǥ���Ѵ�
-- *******

-- �� :
select job_id,job_title,min_salary,max_salary
from jobs
where 10000 <= min_salary;

-- *******************
-- [����19]
-- 2002����� 2005����� 
-- ������ ������ �̸��� ���� ���ڸ� ǥ���Ѵ�.
-- *******************

-- �� :
select first_name,hire_date
from employees
where '2002/01/01' < hire_date and hire_date < '2005/12/31' 
order by hire_date asc ;

-- *******************
-- [����020]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, �����ڵ� ǥ��.
-- *******************

-- �� :

select first_name AS "�̸�" ,hire_date AS "�Ի���" ,job_id AS "�����ڵ�"
from employees 
where job_id like 'IT_PROG' or job_id like 'SA_MAN';


