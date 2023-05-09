create table insider_attachment (
insider_attachment_no number primary key,
insider_attachment_name varchar2(256) not null,
insider_attachment_type varchar2(60) not null,
insider_attachment_size number not null
);

create sequence attachment_seq;
drop table insider_attachment;
select*from insider_attachment;
