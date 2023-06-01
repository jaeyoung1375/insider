package com.kh.insider.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.insider.vo.NoticeVO;

@Repository
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeVO> selectNotice(Long memberNo) {
		return sqlSession.selectList("notice.selectList",memberNo);
	}
}
