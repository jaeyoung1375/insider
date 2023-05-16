package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);

	int sequence();
	void insert(BoardDto boardDto);
	boolean update(BoardDto boardDto);

	void delete(int boardNo);

}
