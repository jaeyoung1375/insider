package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardTagDto;
import com.kh.insider.dto.TagDto;
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
	public void insert(BoardDto boardDto,TagDto tagDto, BoardTagDto boardTagDto, List<MultipartFile> boardAttachment) throws IllegalStateException, IOException {
//		BoardDto newDto = boardRepo.insert(boardDto);
		boardRepo.insert(boardDto);
		if (boardAttachment != null) {
		for(MultipartFile file : boardAttachment) {
			int attachmentNo = attachmentRepo.save(file);
			boardAttachmentRepo.insert(BoardAttachmentDto.builder()
					.boardNo(boardDto.getBoardNo())
					.attachmentNo(attachmentNo)
					.build());
			}
		log.debug("사진 갯수:{}", boardAttachment.size());
		}
		
		 // 해시태그 저장
		if(tagDto.getTagName() != null) {
			
			String inputTagName = tagDto.getTagName();
			String[] array = inputTagName.split("#");
			
			for(int i = 0; i < array.length; i++) {
				String tagName = array[i];
				
				TagDto tagDtoFind = tagRepo.selectOne(tagName);
				if(tagDtoFind == null) {
					
					tagDto.setTagName(tagName);
					tagRepo.insert(tagDto);
					
					//문제 포인트 (tag생성 우선순위)
					tagDto.setTagName(tagDto.getTagName());
					boardTagDto.setBoardTagNo(boardTagDto.getBoardTagNo());
					boardTagRepo.insert(boardTagDto);
				}
				else {
					boardTagDto.setBoardTagNo(boardTagDto.getBoardTagNo());
					boardTagDto.setTagName(tagDtoFind.getTagName());
					boardTagRepo.insert(boardTagDto);
				}
			}
		}
	}

	@Transactional
	@Override
	public void delete(int boardNo) {
		boardRepo.delete(boardNo);
		boardAttachmentRepo.delete(boardNo);
	}
	



}
