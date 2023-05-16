package com.kh.insider.repo;

import com.kh.insider.dto.BoardLikeDto;

public interface BoardLikeRepo {
	void insert(BoardLikeDto boardLikeDto);
	void delete(BoardLikeDto boardLikeDto);
	boolean check(BoardLikeDto boardLikeDto);
	int count(int boardNo);
}
