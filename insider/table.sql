--회원설정 setting 테이블
CREATE TABLE setting (
member_no REFERENCES member(member_no) ON DELETE CASCADE PRIMARY KEY NOT NULL,
setting_hide NUMBER(1) DEFAULT 0 NOT NULL CHECK (setting_hide IN (0, 1, 2, 3)),
setting_distance NUMBER DEFAULT 5 NOT NULL,
setting_like_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_like_alert IN (0, 1)),
setting_reply_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_reply_alert IN (0, 1)),
setting_follow_alert NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_follow_alert IN (0, 1)),
setting_video_auto NUMBER(1) DEFAULT 1 NOT NULL CHECK (setting_video_auto IN (0, 1))
);
--신고 report 테이블
create table report (
report_no number primary key,
member_no REFERENCES member(member_no) on delete cascade,
report_content varchar2(300) not null,
report_table_no number not null,
report_table varchar2(30) check(report_table IN ('member', 'reply', 'board', 'dm_message', 'etc')) not null,
report_time date default sysdate not null,
report_check number DEFAULT 0 NOT NULL CHECK (report_check IN (0, 1, 2))
);
create sequence report_seq;