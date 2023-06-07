
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
report_member_no NUMBER NOT NULL,
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
member_no REFERENCES member(MEMBER_no) on delete cascade,
PRIMARY key(tag_name, member_no)
);

--보드에 멤버닉, 어태치먼트 넘버 추가
CREATE OR REPLACE VIEW board_with_nick as
SELECT b.*, m.attachment_no, m.member_nick, s.setting_hide, s.setting_allow_reply FROM board b
inner JOIN MEMBER_WITH_PROFILE m ON b.member_no=m.member_no
LEFT outer JOIN setting s ON b.member_no=s.member_no;

--신고 현황관리 view 생성
CREATE OR REPLACE VIEW REPORT_MANAGEMENT AS
select
rs.*,
m.member_name, m.member_nick, m.attachment_no,
rr.report_result,
ms.member_suspension_days, ms.member_suspension_lift_date, ms.member_suspension_status, ms.member_suspension_times, ms.member_suspension_content from
(
SELECT r.report_member_no, r.report_table_no, r.report_table,
  COUNT(*) AS count,
  MIN(report_time) AS report_time,
  SUM(CASE WHEN report_check = 0 or report_check=2 THEN 1 ELSE 0 END) AS managed_count
FROM report r
GROUP BY r.report_member_no, r.report_table_no, r.report_table
) rs
INNER JOIN member_with_profile m ON rs.report_member_no=m.member_no
LEFT OUTER JOIN report_result rr ON rs.report_table_no=rr.report_table_no AND rs.report_table=rr.report_table
LEFT OUTER JOIN MEMBER_SUSPENSION ms ON rs.report_member_no=ms.member_no;


--차단 테이블
CREATE TABLE block(
member_no REFERENCES member(member_no) ON delete CASCADE,
block_no REFERENCES member(member_no) ON delete CASCADE,
PRIMARY KEY(member_no, block_no)
);

--팔로우 테이블
CREATE TABLE follow(
member_no REFERENCES member(member_no) ON DELETE CASCADE,
follow_follower REFERENCES member(member_no) ON DELETE CASCADE,
follow_time DATE DEFAULT sysdate NOT NULL,
follow_allow number(1) DEFAULT 1 NOT NULL,
PRIMARY key(member_no, follow_follower)
);

--멤버 member_join 칼럼 추가
alter TABLE MEMBER ADD member_join DATE DEFAULT sysdate;
UPDATE MEMBER SET member_join=sysdate;
ALTER TABLE MEMBER MODIFY member_join NOT NULL;

--차단자, 팔로우, 팔로워 뷰 추가
CREATE OR REPLACE VIEW follow_With_Profile as
SELECT f.*, m.member_name, m.member_nick, m.attachment_no FROM follow f
inner JOIN member_with_profile m ON f.FOLLOW_FOLLOWER = m.MEMBER_NO;

CREATE OR REPLACE VIEW follower_With_Profile as
SELECT f.*, m.member_name, m.member_nick, m.attachment_no FROM follow f
inner JOIN member_with_profile m ON f.member_no = m.MEMBER_NO;

CREATE OR REPLACE VIEW Block_With_Profile as
SELECT b.*, m.member_name, m.member_nick, m.attachment_no FROM block b
inner JOIN member_with_profile m ON b.BLOCK_NO = m.MEMBER_NO;

--검색 테이블 및 뷰 생성
CREATE TABLE search(
search_no NUMBER PRIMARY KEY,
member_no REFERENCES member(member_no) ON DELETE CASCADE NOT NULL,
search_tag_name varchar2(90),
search_member_no NUMBER,
search_time DATE DEFAULT sysdate NOT NULL,
search_delete number(1) DEFAULT 0 NOT NULL
);
CREATE SEQUENCE search_base_seq;

--검색 테이블에 필요한 데이터 추가해서 반환
CREATE OR REPLACE VIEW search_with_profile AS
SELECT s.*, m.member_nick, m.member_name, m.attachment_no, 
CASE WHEN t.tag_follow IS NOT NULL THEN t.tag_follow ELSE m.member_follow END AS follow 
FROM SEARCH s LEFT OUTER JOIN MEMBER_WITH_PROFILE m ON s.search_MEMBER_NO =m.MEMBER_NO
LEFT OUTER JOIN tag t ON s.search_tag_name=t.tag_name;

--추천 검색어 리스트 반환
CREATE OR REPLACE VIEW search_complex as
SELECT member_name AS name, member_nick AS nick, member_follow AS follow, member_no AS member_no, attachment_no AS ATTACHMENT_NO
FROM MEMBER_with_profile UNION ALL SELECT tag_name AS name, NULL AS nick, tag_follow AS follow, NULL AS member_no, NULL AS attachment_no
FROM tag;

--리포트 결과 테이블 생성
CREATE TABLE report_result(
report_table_no NUMBER NOT NULL,
report_table  varchar2(30) NOT NULL,
report_result NUMBER(1) DEFAULT 0,
unique(report_table_no, report_table)
);

--게시물 좋아요 테이블 생성
create table board_like (
member_no  number references member(member_no) on delete cascade,
board_no number references board(board_no) on delete cascade,
board_like_time date default sysdate,
like_check char(1) default 0 not null
);

--like에 멤버닉, 어태치먼트 넘버 추가
CREATE OR REPLACE VIEW like_with_nick as
SELECT l.*, m.attachment_no, m.member_nick FROM board_like l
inner JOIN MEMBER_WITH_PROFILE m ON l.member_no=m.member_no;


-- reply에 멤버닉, 어태치먼트 넘버 추가
CREATE OR REPLACE VIEW reply_with_nick as
SELECT r.*, m.attachment_no, m.member_nick FROM reply r
inner JOIN MEMBER_WITH_PROFILE m ON r.reply_member_no=m.member_no;

--댓글 좋아요 테이블 생성
create table reply_like (
member_no  number references member(member_no) on delete cascade,
reply_no number references reply(reply_no) on delete cascade,
reply_like_time date default sysdate not null,
reply_like_check NUMBER default 0 not null
);

-- 북마크 테이블 생성
create table bookmark(
board_no references board(board_no) on delete cascade,
member_no references member(member_no) on delete cascade
);
