package com.kh.insider.repo;

import com.kh.insider.dto.AttachmentDto;

public interface AttachmentRepo {

    int sequence();
    void insert(AttachmentDto attachmentDto);
//    int save(MultipartFile attach) throws IllegalStateException, IOException;
    AttachmentDto selectOne(int attachmentNo);
}
