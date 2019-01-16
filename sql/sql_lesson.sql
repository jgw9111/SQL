
select * from article;

create table admin(
admin_num varchar2(10) primary key,
name varchar2(10) not null,
pass varchar2(10) not null,
auth varchar2(10) default '���'
);

create sequence art_seq
start with 1000
increment by 1;

create table article(
art_seq number primary key,
title varchar2(20) default '���� ����',
content varchar2(50),
regdate date default sysdate,
id varchar2(10) not null,
constraint article_fk_member foreign key(id) references member(id)
);



-- PK
alter table member
add primary key(id);

 
select count(*) from tab;

drop table customers;

select * from tab;

-- �÷� �߰�
alter table Test
add test2 varchar2(10); 

-- �÷� ����
alter table test
drop column test2;


select * from Test;

