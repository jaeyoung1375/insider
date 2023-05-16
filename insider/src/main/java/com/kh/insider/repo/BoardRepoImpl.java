package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.vo.BoardListVO;

@Repository
public class BoardRepoImpl implements BoardRepo {
	
	@Autowired
	private SqlSession sqlSession;


	@Override
	public List<BoardDto> selectListPaging(int page) {
		int end = page*10;
		int begin = end-9;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("board.selectListPaging",param);
	}


	@Override
	public Long sequence() {
		 return sqlSession.selectOne("board.sequence");
	}
	
	@Override
	public void insert(BoardDto boardDto) {
		 sqlSession.insert("board.insert", boardDto);		
	}


	public List<BoardListVO> selectListWithAttach(int page) {
		int end = page*10;
		int begin = end-9;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("board.boardListTreeSelect",param);
	}


	@Override
	public void updateLikeCount(int boardNo, int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("count", count);
		sqlSession.update("board.updateLikeCount",param);
	}

}
