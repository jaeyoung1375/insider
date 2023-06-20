package com.kh.insider.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;
import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.BoardTagRepo;
import com.kh.insider.repo.TagRepo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardAttachServiceImpl implements BoardAttachService{

	@Autowired
	private BoardAttachmentRepo boardAttachmentRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private AttachmentRepo attachmentRepo;
	@Autowired
	private TagRepo tagRepo;
	@Autowired
	private BoardTagRepo boardTagRepo;
	
	@Transactional
	@Override
	public void insert(BoardDto boardDto, List<MultipartFile> boardAttachment) throws IllegalStateException, IOException {
//		BoardDto newDto = boardRepo.insert(boardDto);
		boardRepo.insert(boardDto);
		if (boardAttachment != null) {
			for(MultipartFile file : boardAttachment) {
				if(file.getOriginalFilename()==null || file.getOriginalFilename().length()==0)continue;
				int attachmentNo = attachmentRepo.save(file);
				//동영상 파일 여부 입력을 위한 코드 추가
				AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
				boardAttachmentRepo.insert(BoardAttachmentDto.builder()
						.boardNo(boardDto.getBoardNo())
						.attachmentNo(attachmentNo)
						.attachmentType(attachmentDto.getAttachmentType())
						.build());
			}
		}
	}
	
//	@Transactional
//	@Override
//	public void insert(BoardDto boardDto, List<MultipartFile> boardAttachment) throws IllegalStateException, IOException {
//	    boardRepo.insert(boardDto);
//
//	    if (boardAttachment != null) {
//	        List<Integer> attachmentNumbers = attachmentRepo.save(boardAttachment);
//
//	        List<BoardAttachmentDto> boardAttachmentDtos = new ArrayList<>();
//	        for (Integer attachmentNo : attachmentNumbers) {
//	            boardAttachmentDtos.add(BoardAttachmentDto.builder()
//	                    .boardNo(boardDto.getBoardNo())
//	                    .attachmentNo(attachmentNo)
//	                    .build());
//	        }
//
//	        boardAttachmentRepo.insert(boardAttachmentDtos);
//	        
//	        log.debug("사진 갯수:{}", boardAttachment.size());
//	    }
//	}


	@Transactional
	@Override
	public void delete(int boardNo) {
		boardRepo.delete(boardNo);
		boardAttachmentRepo.delete(boardNo);
		boardTagRepo.delete(boardNo);
	}
	



}