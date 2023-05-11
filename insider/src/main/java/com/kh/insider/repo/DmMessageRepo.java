package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMessageDto;

public interface DmMessageRepo {

	int sequence();
    
    void create(DmMessageDto dmMessageDto);
    
    DmMessageDto detail(int messageNo);
    
    List<DmMessageDto> roomMessageList(int roomNo);
    
    void delete(DmMessageDto dmMessageDto);
    
}
