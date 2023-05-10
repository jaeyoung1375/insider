package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReplyDto;

@Repository
public class ReplyRepoImpl implements ReplyRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReplyDto replydto) {
		sqlSession.insert("reply.insert",replydto);
	}

	@Override
	public boolean delete(int replyNo) {
		return sqlSession.delete("reply.delete", replyNo) > 0;
	}
	
}
