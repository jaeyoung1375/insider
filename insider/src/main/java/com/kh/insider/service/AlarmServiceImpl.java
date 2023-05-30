package com.kh.insider.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.insider.vo.AlarmVO;

@Repository
public class AlarmServiceImpl implements AlarmService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AlarmVO> selectAlarm(Long memberNo) {
		return sqlSession.selectList("alarm.selectList",memberNo);
	}

	@Transactional
	@Override
	public void check(Long memberNo) {
		sqlSession.update("alarm.checkBL", memberNo);
		sqlSession.update("alarm.checkAL", memberNo);
		sqlSession.update("alarm.checkFollow", memberNo);
		sqlSession.update("alarm.checkBR", memberNo);
		sqlSession.update("alarm.checkAR", memberNo);
	}

	@Override
	public int isInsider(Long memberNo) {
		if(sqlSession.selectOne("alarm.isAlarm", memberNo)==null) {
			return 0;
		}
		return sqlSession.selectOne("alarm.isAlarm",memberNo);
	}


}
