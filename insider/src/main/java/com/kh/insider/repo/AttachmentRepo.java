package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

	public int sequence();
	public void insert(AttachmentDto attachmentDto);
	public AttachmentDto selectOne(int attachmentNo);
	public List<AttachmentDto> selecList();
	public boolean delete(int attachmentNo);

}
