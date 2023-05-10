create table board (
board_no number primary key,
member_no REFERENCES dm_member(member_no) on delete set null,
board_content varchar2(600) not null,
board_like number,
board_lat number,
board_lon number,
board_time date default sysdate not null,
board_reply number,
board_reply_vaild number CHECK (TYPE IN (0, 1)),
board_like_vaild number CHECK (TYPE IN (0, 1)),
board_report number,
board_hide number CHECK (TYPE IN (0, 1)),
board_kid number CHECK (TYPE IN (0, 1)),
board_size number
);
create sequence board_seq;

drop sequence board_seq;


create table reply (
reply_no number primary key,
board_no REFERENCES board(board_no) on delete cascade,
member_no REFERENCES dm_member(member_no) on delete cascade,
reply_content varchar2(300) not null,
reply_parent number,
reply_like number,
reply_time date default sysdate not null,
reply_report number
);
create sequence reply_seq;


create table board_attachment (
board_no REFERENCES board(board_no) on delete cascade,
attachment_no REFERENCES attachment(attachment_no) on delete cascade
);


create table attachment (
attachment_no number primary key,
attachment_name varchar2(256) not null,
attachment_type varchar2(60) not null,
attachment_size number not null
);
create sequence attachment_seq;

commit;