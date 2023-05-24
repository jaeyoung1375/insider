package com.kh.insider.service;


import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardTagDto;
import com.kh.insider.dto.TagDto;
import com.kh.insider.vo.PaginationVO;

public interface BoardAttachService {
	
void insert(BoardDto boardDto,List<MultipartFile> boardAttachment) throws IllegalStateException, IOException;
	
void delete(int boardNo);
}
