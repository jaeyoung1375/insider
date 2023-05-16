package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;


public interface BoardAttachmentRepo {
	

//	//목록
//	List<BoardAttachVO> selectList(PaginationVO paginationVO);
	//등록
	void insert(BoardAttachmentDto boardAttachmentDto);

}
