package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardLikeDto;

public interface BoardLikeRepo {
	void insert(BoardLikeDto boardLikeDto);
	void delete(BoardLikeDto boardLikeDto);
	boolean check(BoardLikeDto boardLikeDto);
	int count(int boardNo);
	List<BoardLikeDto> list(int boardNo);
}
