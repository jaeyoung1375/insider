package com.kh.insider.repo;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;

@Repository
public class AttachmentRepoImpl implements AttachmentRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private FileUploadProperties fileUploadProperties;
	
	//저장 위치
	private File directory = new File("D:/upload");
	public AttachmentRepoImpl() {
		directory.mkdirs();
	}
	
	
	@Override
	public int save(MultipartFile attachment) throws IllegalStateException, IOException {
		int attachmentNo = sqlSession.selectOne("attachment.sequence");
		
		String fileName = String.valueOf(attachmentNo);
		File dir = new File(directory, fileName);
		attachment.transferTo(dir);
		
		sqlSession.insert("attachment.insert", AttachmentDto.builder()
				.attachmentNo(attachmentNo)
				.attachmentName(attachment.getOriginalFilename())
				.attachmentType(attachment.getContentType())
				.attachmentSize(attachment.getSize())
				.build());
		return attachmentNo;
	}


	@Override
	public void delete(int profileIsNull) {
		sqlSession.delete("attach.delete", profileIsNull);
	}

	}
