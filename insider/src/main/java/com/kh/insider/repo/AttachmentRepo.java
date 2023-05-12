package com.kh.insider.repo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

    int sequence();
    void insert(AttachmentDto attachmentDto);
    AttachmentDto selectOne(int attachmentNo);
}
