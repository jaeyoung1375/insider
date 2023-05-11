package com.kh.insider.repo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

	int save(MultipartFile attachment) throws IllegalStateException, IOException;

	void delete(int profileIsNull);
	
	//단일정보조회
	AttachmentDto selectOne(int attachmentNo);

}
