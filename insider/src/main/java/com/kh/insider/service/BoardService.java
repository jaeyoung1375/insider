package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardDto;

public interface BoardService {
	
	void insert(BoardDto boardDto, List<MultipartFile> boardAttach) throws IllegalStateException, IOException;
	
	void delete(int boardNo);
}
