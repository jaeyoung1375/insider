
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
board_attachment_no number primary key,
board_no REFERENCES board(board_no) on delete cascade,
attachment_no REFERENCES attachment(attachment_no) on delete cascade
);
create sequence board_attachment_seq;

drop table board_attachment;


create table attachment (
attachment_no number primary key,
attachment_name varchar2(256) not null,
attachment_type varchar2(60) not null,
attachment_size number not null
);
create sequence attachment_seq;

commit;

--회원설정 setting 테이블
CREATE TABLE setting (
member_no REFERENCES member(member_no) ON DELETE CASCADE PRIMARY KEY NOT NULL,
setting_hide NUMBER(1) DEFAULT 0 NOT NULL CHECK (setting_hide IN (0, 1, 2, 3)),
setting_distance NUMBER DEFAULT 5 NOT NULL,
setting_like_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_like_alert IN (0, 1, 2)),
setting_reply_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1, 2)),
setting_follow_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_follow_alert IN (0, 1, 2)),
setting_video_auto NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_video_auto IN (0, 1)),
setting_reply_like_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1, 2)),
setting_message NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1, 2)),
setting_allow_reply NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1, 2, 3)),
setting_watch_like NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1, 2))
);
--신고 report 테이블
create table report (
report_no number primary key,
member_no REFERENCES member(member_no) on delete cascade,
report_content varchar2(300) not null,
report_table_no number not null,
report_table varchar2(30) check(report_table IN ('member', 'reply', 'board', 'dm_message', 'etc')) not null,
report_time date default sysdate not null,
report_check number(1) DEFAULT 0 NOT NULL CHECK (report_check IN (0, 1, 2, 3))
);
create sequence report_seq;

--프로필 테이블
CREATE TABLE member_profile(
member_profile_no NUMBER PRIMARY KEY,
member_no REFERENCES member(member_no) ON DELETE CASCADE NOT NULL,
attachment_no REFERENCES attachment(attachment_no) NOT null
);
CREATE SEQUENCE member_profile_seq;
--멤버, 프로필 뷰
CREATE VIEW member_with_profile as
SELECT M.*, P.attachment_no FROM MEMBER M 
LEFT OUTER JOIN member_profile P ON M.member_no=P.member_no;

--태그 관련 테이블 생성
CREATE TABLE tag(
tag_name varchar2(60) PRIMARY KEY,
tag_follow NUMBER DEFAULT 0 NOT NULL check(tag_follow>=0)
);

CREATE TABLE board_tag(
board_tag_no NUMBER PRIMARY KEY,
tag_name references tag(tag_name),
board_no REFERENCES board(board_no)
);
CREATE SEQUENCE board_tag_seq;

CREATE TABLE tag_follow(
tag_name REFERENCES tag(tag_name),
member_no REFERENCES member(MEMBER_no),
PRIMARY key(tag_name, member_no)
);