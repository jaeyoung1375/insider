package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReplyLikeDto;

@Repository
public class ReplyLikeRepoImpl implements ReplyLikeRepo {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReplyLikeDto replyLikeDto) {
		sqlSession.insert("replyLike.insert", replyLikeDto);
	}

	@Override
	public void delete(ReplyLikeDto replyLikeDto) {
		sqlSession.delete("replyLike.delete", replyLikeDto);
	}

	@Override
	public boolean check(ReplyLikeDto replyLikeDto) {
		int count = sqlSession.selectOne("replyLike.check", replyLikeDto);
		return count == 1;
	}

	@Override
	public int count(int replyNo) {
		return sqlSession.selectOne("replyLike.count", replyNo);
	}

}
