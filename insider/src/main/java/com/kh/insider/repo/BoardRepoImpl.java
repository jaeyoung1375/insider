package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.vo.BoardAttachmentVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;

@Repository
public class BoardRepoImpl implements BoardRepo {
	
	@Autowired
	private SqlSession sqlSession;


	@Override
	public List<BoardDto> selectListPaging(int page) {
		int end = page*2;
		int begin = end-1;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("board.selectListPaging",param);
	}


	@Override
	public int sequence() {
		 return sqlSession.selectOne("board.sequence");
	}
	
	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("board.insert", boardDto);
	}

	@Override
	public List<BoardListVO> selectListWithAttach(int page) {
		int end = page*2;
		int begin = end-1;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("board.boardListTreeSelect",param);
	}
	@Override
	public List<BoardListVO> selectListWithFollow(BoardSearchVO vo) {
		return sqlSession.selectList("board.boardListWithFollow", vo);
	}
	@Override
	public List<BoardListVO> selectListWithoutFollow(BoardSearchVO vo) {
		return sqlSession.selectList("board.boardListWithoutFollow", vo);
	}


	@Override
	public void updateLikeCount(int boardNo, int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("boardNo", boardNo);
		param.put("count", count);
		sqlSession.update("board.updateLikeCount",param);
	}


	@Override
	public void addReport(int boardNo) {
		sqlSession.update("board.addReport", boardNo);
	}



//	@Override
//	public void connect(int boardNo, int attachmentNo) {
//	    Map<String, Integer> params = new HashMap<>();
//	    params.put("boardNo", boardNo);
//	    params.put("attachmentNo", attachmentNo);
//	    sqlSession.insert("boardAttachment.connect", params);
//	}


	@Override
	public void delete(int boardNo) {
		sqlSession.delete("board.delete", boardNo);		
	}

}
