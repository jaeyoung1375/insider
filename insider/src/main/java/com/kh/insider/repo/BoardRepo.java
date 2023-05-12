package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardDto;

public interface BoardRepo {
	List<BoardDto> selectListPaging(int page);

	boolean update(BoardDto boardDto);
	void insert(BoardDto boardDto);

}
