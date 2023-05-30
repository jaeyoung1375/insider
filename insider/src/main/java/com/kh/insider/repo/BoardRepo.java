package com.kh.insider.repo;

import java.util.List;


import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardWithNickDto;
import com.kh.insider.vo.BoardAttachmentVO;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;
import com.kh.insider.vo.BoardTagStatsResponseVO;
import com.kh.insider.vo.BoardTagStatsSearchVO;
import com.kh.insider.vo.BoardTimeStatsResponseVO;
import com.kh.insider.vo.BoardTimeStatsSearchVO;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);
	
	List<BoardDto> myPageSelectListPaging(int page, int memberNo);

	int sequence();
	
	BoardDto insert(BoardDto boardDto);

	void updateLikeCount(int boardNo, int count);
	
	//컨텐트까지 포함한 리스트 출력(팔로우, 차단 x)
	List<BoardListVO> selectListWithAttach(AdminBoardSearchVO vo);
	int selectAdminCount(AdminBoardSearchVO vo);
	//팔로우 차단 구현 리스트 출력
	List<BoardListVO> selectListWithFollow(BoardSearchVO vo);
	//차단 구현 리스트 출력
	List<BoardListVO> selectListWithoutFollow(BoardSearchVO vo);
	
	// 전체 게시물 개수
	int getTotalPostCount(Long MemberNo);
	// 마이페이지 전체 게시물 조회
	List<BoardDto> getTotalMyPost(long memberNo);
	
	//신고수 추가
	void addReport(int boardNo);
	
	//게시물 생성 통계
	List<BoardTimeStatsResponseVO> getBoardTimeStats(BoardTimeStatsSearchVO boardTimeStatsSearchVO);

	void delete(int boardNo);
	//태그 생성 통계
	List<BoardTagStatsResponseVO> getBoardTagStats(BoardTagStatsSearchVO boardTagStatsSearchVO);
	
	//계층형 단일조회
	BoardListVO selectOneBoard(int boardNo);
}
