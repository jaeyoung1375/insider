package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;


public interface BoardAttachmentRepo {
	
	//시퀀스
//	int boardAttachSeq();
	//등록
	void insert(BoardAttachmentDto boardAttachmentDto);
//	void insert(List<BoardAttachmentDto> boardAttachmentDtos);
	//목록
	List<BoardAttachmentDto> selectList(int boardNo);
	//삭제
	void delete(int boardNo);
	
	

}