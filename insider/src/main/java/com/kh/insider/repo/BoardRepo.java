package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.vo.BoardAttachmentVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);

	int sequence();
	
	BoardDto insert(BoardDto boardDto);

	void updateLikeCount(int boardNo, int count);
	
	//컨텐트까지 포함한 리스트 출력(팔로우, 차단 x)
	List<BoardListVO> selectListWithAttach(int page);
	//팔로우 차단 구현 리스트 출력
	List<BoardListVO> selectListWithFollow(BoardSearchVO vo);
	//차단 구현 리스트 출력
	List<BoardListVO> selectListWithoutFollow(BoardSearchVO vo);
	
	//신고수 추가
	void addReport(int boardNo);

	void delete(int boardNo);
}
