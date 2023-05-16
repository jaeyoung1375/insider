package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.vo.BoardListVO;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);

	boolean update(BoardDto boardDto);
	void insert(BoardDto boardDto);
	void updateLikeCount(int boardNo, int count);

	//컨텐트까지 포함한 리스트 출력
	List<BoardListVO> selectListWithAttach(int page);
}
