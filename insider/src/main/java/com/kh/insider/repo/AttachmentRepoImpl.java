package com.kh.insider.repo;


import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

@Repository
public class AttachmentRepoImpl implements AttachmentRepo{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
	    return sqlSession.selectOne("attachment.sequence");
	}

	@Override
	public void insert(AttachmentDto attachmentDto) {
	    sqlSession.insert("attachment.insert", attachmentDto);
	}


	@Override
	public AttachmentDto selectOne(int attachmentNo) {
		return sqlSession.selectOne("attachment.selectOne", attachmentNo);
	}
	
	//저장 위치
		private File directory = new File("D:/upload");
		public AttachmentRepoImpl() {
			directory.mkdirs();
		}

	@Override
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		
		int attachmentNo = sqlSession.selectOne("attachment.sequence");
		
		String fileName = String.valueOf(attachmentNo);
		File target = new File(directory, fileName);
		attach.transferTo(target);
		
		sqlSession.insert("attachment.insert", AttachmentDto.builder()
				.attachmentNo(attachmentNo)
				.attachmentName(attach.getOriginalFilename())
				.attachmentType(attach.getContentType())
				.attachmentSize(attach.getSize())
				.build());
		
		return attachmentNo;
	}
	
//	@Override
//	public List<Integer> save(List<MultipartFile> attachments) throws IllegalStateException, IOException {
//	    List<Integer> attachmentNumbers = new ArrayList<>();
//
//	    for (MultipartFile attach : attachments) {
//	        int attachmentNo = sqlSession.selectOne("attachment.sequence");
//
//	        String fileName = String.valueOf(attachmentNo);
//	        File target = new File(directory, fileName);
//	        attach.transferTo(target);
//
//	        sqlSession.insert("attachment.insert", AttachmentDto.builder()
//	                .attachmentNo(attachmentNo)
//	                .attachmentName(attach.getOriginalFilename())
//	                .attachmentType(attach.getContentType())
//	                .attachmentSize(attach.getSize())
//	                .build());
//
//	        attachmentNumbers.add(attachmentNo);
//	    }
//
//	    return attachmentNumbers;
//	}

}
