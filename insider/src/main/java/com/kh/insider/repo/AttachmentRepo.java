package com.kh.insider.repo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public interface AttachmentRepo {

	int save(MultipartFile attachment) throws IllegalStateException, IOException;

	void delete(int profileIsNull);

}
