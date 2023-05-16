package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;


public interface BoardAttachmentRepo {
	
//	//등록
//	void insert(BoardAttachVO vo);
//	
//	//목록
//	List<BoardAttachVO> selectList(PaginationVO paginationVO);
//	
//	//상세
//	BoardAttachVO  selectOne(int boardNo);
//	
//	//삭제
//	void delete(int boardNo);
	
	void insert(BoardAttachmentDto boardAttachmentDto);
	void delete(int boardNo);
}
