package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.vo.BoardAttachmentVO;
import com.kh.insider.vo.BoardListVO;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);

	int sequence();
	
	void insert(BoardDto boardDto);

	void updateLikeCount(int boardNo, int count);

	void connect(int boardNo, int attachmentNo);
	
	//컨텐트까지 포함한 리스트 출력
	List<BoardListVO> selectListWithAttach(int page);
	
	//신고수 추가
	void addReport(int boardNo);

	void delete(int boardNo);
}
