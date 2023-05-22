package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardTagDto;

@Repository
public class BoardTagRepoImpl implements BoardTagRepo{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void insert(BoardTagDto boardTagDto) {
		sqlSession.insert("boardTag.insert", boardTagDto);
	}

	@Override
	public void delete(int boardNo) {
		sqlSession.delete("boardTag.delete", boardNo);
	}

	@Override
	public List<BoardTagDto> selectList(int boardNo) {
		return sqlSession.selectList("boardTag.selectList", boardNo);
	}

}
