package com.kh.insider.repo;

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

	@Override
	public int sequence() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insert(AttachmentDto attachmentDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public AttachmentDto selectOne(int attachmentNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttachmentDto> selecList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(int attachmentNo) {
		// TODO Auto-generated method stub
		return false;
	}

	

//	//저장 위치
//	private File directory = new File("D:/upload");
//	public AttachmentRepoImpl() {
//		directory.mkdirs();
//	}
	
	
//	@Override
//	public int save(MultipartFile attachment) throws IllegalStateException, IOException {
//		int attachmentNo = sqlSession.selectOne("attachment.sequence");
//		
//		String fileName = String.valueOf(attachmentNo);
//		File dir = new File(directory, fileName);
//		attachment.transferTo(dir);
//		
//		sqlSession.insert("attachment.insert", AttachmentDto.builder()
//				.attachmentNo(attachmentNo)
//				.attachmentName(attachment.getOriginalFilename())
//				.attachmentType(attachment.getContentType())
//				.attachmentSize(attachment.getSize())
//				.build());
//		return attachmentNo;
//	}



}
