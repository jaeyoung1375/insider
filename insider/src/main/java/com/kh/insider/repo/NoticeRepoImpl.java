package com.kh.insider.repo;

import java.sql.Date;

import com.kh.insider.vo.NoticeVO;

public class NoticeRepoImpl implements NoticeRepo {

	private final NoticeVO noticeVO;

    public NoticeRepoImpl(NoticeVO noticeVO) {
        this.noticeVO = noticeVO;
    }

//    @Override
//    public int getBoardNo() {
//        return noticeVO.getBoardNo();
//    }
//
//    @Override
//    public Date getBoardTime() {
//        return noticeVO.getBoardTime();
//    }
//
//    @Override
//    public Date getBoardLikeTime() {
//        return noticeVO.getBoardLikeTime();
//    }
//
//    @Override
//    public Long getMemberNo() {
//        return noticeVO.getMemberNo();
//    }
//
//    @Override
//    public String getMemberNick() {
//        return noticeVO.getMemberNick();
//    }
//
//    @Override
//    public int getReplyNo() {
//        return noticeVO.getReplyNo();
//    }
//
//    @Override
//    public Date getReplyTime() {
//        return noticeVO.getReplyTime();
//    }
//
//    @Override
//    public long getFollowFollower() {
//        return noticeVO.getFollowFollower();
//    }
//
//    @Override
//    public Date getFollowTime() {
//        return noticeVO.getFollowTime();
//    }

}
