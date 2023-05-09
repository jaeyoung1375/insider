package com.kh.insider.repo;

import java.io.IOException;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

	void upload(@RequestParam MultipartFile attachment) throws IllegalStateException, IOException;
	List<AttachmentDto>selectList();

}
