package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardTagDto;

public interface BoardTagRepo {
	//태그 입력
	void insert(BoardTagDto boardTagDto);
	//boardNo 태그 전체 삭제
	void delete(int boardNo);
	//boardNo로 태그 리스트 반환
	List<BoardTagDto> selectList(int boardNo);
}
