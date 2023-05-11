package com.kh.insider.repo;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

	int sequence();
	void insert(AttachmentDto attachmentDto);
	AttachmentDto selectOne(int attachmentNo);
}
