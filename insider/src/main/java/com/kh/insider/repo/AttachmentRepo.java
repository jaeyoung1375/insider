package com.kh.insider.repo;

import java.io.IOException;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

	void insert(MultipartFile attachment) throws IllegalStateException, IOException;

}
