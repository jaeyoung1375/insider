package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardWithNickDto;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;
import com.kh.insider.vo.BoardTagStatsResponseVO;
import com.kh.insider.vo.BoardTagStatsSearchVO;
import com.kh.insider.vo.BoardTimeStatsResponseVO;
import com.kh.insider.vo.BoardTimeStatsSearchVO;

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
	public BoardDto insert(BoardDto boardDto) {
		int boardNo = sqlSession.selectOne("board.sequence");
		boardDto.setBoardNo(boardNo);
		sqlSession.insert("board.insert", boardDto);
		return sqlSession.selectOne("board.selectOne", boardNo);
	}

	@Override
	public List<BoardListVO> selectListWithAttach(AdminBoardSearchVO vo) {
		return sqlSession.selectList("board.boardListTreeSelect",vo);
	}
	
	@Override
	public List<BoardListVO> selectListWithFollowNew(BoardSearchVO vo) {
		return sqlSession.selectList("board.boardListWithFollowNew", vo);
	}


	@Override
	public List<BoardListVO> selectListWithFollowOld(BoardSearchVO vo) {
		return sqlSession.selectList("board.boardListWithFollowOld", vo);
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


	@Override
	public int getTotalPostCount(Long MemberNo) {
		return sqlSession.selectOne("board.getTotalPostCount",MemberNo);
	}


	@Override
	public List<BoardDto> getTotalMyPost(long memberNo) {
		return sqlSession.selectList("board.getTotalMyPost2",memberNo);
	}
	
	public List<BoardTimeStatsResponseVO> getBoardTimeStats(BoardTimeStatsSearchVO boardTimeStatsSearchVO) {
		return sqlSession.selectList("board.timeStats", boardTimeStatsSearchVO);
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


	@Override
	public List<BoardTagStatsResponseVO> getBoardTagStats(BoardTagStatsSearchVO boardTagStatsSearchVO) {
		return sqlSession.selectList("board.boardTagStats", boardTagStatsSearchVO);
	}


	@Override
	public List<BoardDto> myPageSelectListPaging(int page, int memberNo) {
		int end = page * 6;
		int begin = end -9;
		Map param = Map.of("begin",begin, "end",end, "memberNo",memberNo);
		return sqlSession.selectList("board.getTotalMyPost",param);
	}
	
	@Override
	public int selectAdminCount(AdminBoardSearchVO vo) {
		return sqlSession.selectOne("board.selectAdminCount", vo);
	}

	@Override
	public BoardListVO selectOneBoard(int boardNo) {
		return sqlSession.selectOne("board.selectOneBoard", boardNo);
	}
	
	@Override
	public BoardWithNickDto selectOne(int boardNo) {
		return sqlSession.selectOne("board.selectOneNick", boardNo);
	}

	@Override
	public boolean update(BoardDto boardDto) {
		int result = sqlSession.update("board.edit", boardDto);
		return result > 0;
	}


	
}
