package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;


public interface BoardAttachmentRepo {
	

	//목록
	List<BoardAttachmentDto> selectList(int boardNo);
	//등록
	void insert(BoardAttachmentDto boardAttachmentDto);

}
