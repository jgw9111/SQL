-- ******
-- EMPLOYEES ���̺�
-- [ employee_id = ��� ] [ first_name = �̸� ] 
-- [ last_name = �� ] [ email = �̸��� ] 
-- [ phone_number = ��ȭ��ȣ ] [ hire_date = ������ ]
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
order by department_id asc,salary desc,first_name ;

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