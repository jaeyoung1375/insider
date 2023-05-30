package com.kh.insider.repo;

import java.sql.Date;

import com.kh.insider.vo.AlarmVO;

public class AlarmRepoImpl implements AlarmRepo {

	private final AlarmVO alarmVO;

    public AlarmRepoImpl(AlarmVO alarmVO) {
        this.alarmVO = alarmVO;
    }

    @Override
    public int getBoardNo() {
        return alarmVO.getBoardNo();
    }

    @Override
    public Date getBoardTime() {
        return alarmVO.getBoardTime();
    }

    @Override
    public Date getBoardLikeTime() {
        return alarmVO.getBoardLikeTime();
    }

    @Override
    public Long getMemberNo() {
        return alarmVO.getMemberNo();
    }

    @Override
    public String getMemberNick() {
        return alarmVO.getMemberNick();
    }

    @Override
    public int getReplyNo() {
        return alarmVO.getReplyNo();
    }

    @Override
    public Date getReplyTime() {
        return alarmVO.getReplyTime();
    }

    @Override
    public long getFollowFollower() {
        return alarmVO.getFollowFollower();
    }

    @Override
    public Date getFollowTime() {
        return alarmVO.getFollowTime();
    }

}
