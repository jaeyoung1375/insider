package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardLikeDto;

@Repository
public class BoardLikeRepoImpl implements BoardLikeRepo {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insert(BoardLikeDto boardLikeDto) {
		sqlSession.insert("boardLike.insert", boardLikeDto);
	}

	@Override
	public void delete(BoardLikeDto boardLikeDto) {
		sqlSession.delete("boardLike.delete", boardLikeDto);
	}

	@Override
	public boolean check(BoardLikeDto boardLikeDto) {
		int count = sqlSession.selectOne("boardLike.check",boardLikeDto);
		return count == 1;
	}

	@Override
	public int count(int boardNo) {
		return sqlSession.selectOne("boardLike.count", boardNo);
	}

	@Override
	public List<BoardLikeDto> list(int boardNo) {
		return sqlSession.selectList("boardLike.likeList", boardNo);
	}

}
