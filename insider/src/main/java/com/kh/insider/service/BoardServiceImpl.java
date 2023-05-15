package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;

public class BoardServiceImpl implements BoardService{

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private AttachmentRepo attachmentRepo;
	@Autowired
	private BoardAttachmentRepo boardAttachmentRepo; 
	
	
	@Override
	public void insert(BoardDto boardDto, List<MultipartFile> boardAttach) throws IllegalStateException, IOException {
//		boardRepo.insert(boardDto);
//				
//				for(MultipartFile file : boardAttach) {
//					int attachmentNo = attachmentRepo.insert(file);
//					
//					boardAttachmentRepo.insert(BoardAttachmentDto.builder()
//																		.boardNo(boardDto.getBoardNo())
//																		.attachmentNo(attachmentNo)
//																	.build());
//				}
		
	}

	@Override
	public void delete(int boardNo) {
////		boardRepo.delete(boardNo);
//		boardAttachmentRepo.delete(boardNo);
		
	}

}
