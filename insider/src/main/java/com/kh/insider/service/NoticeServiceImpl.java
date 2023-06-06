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

	@Transactional
	@Override
	public void check(Long memberNo) {
		sqlSession.update("notice.checkBL", memberNo);
		sqlSession.update("notice.checkBR", memberNo);
		sqlSession.update("notice.checkBR2", memberNo);
		sqlSession.update("notice.checkRL", memberNo);
		sqlSession.update("notice.checkFollow", memberNo);
	}

	@Override
	public int isInsider(Long memberNo) {
		if(sqlSession.selectOne("notice.isNotice", memberNo)==null) {
			return 0;
		}
		return sqlSession.selectOne("notice.isNotice",memberNo);
	}


}
