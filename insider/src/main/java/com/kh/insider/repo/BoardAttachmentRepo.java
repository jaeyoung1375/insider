package com.kh.insider.repo;

import com.kh.insider.dto.BoardAttachmentDto;

public interface BoardAttachmentRepo {

	void insert(BoardAttachmentDto boardAttachmentDto);
	void delete(int boardNo);
}
