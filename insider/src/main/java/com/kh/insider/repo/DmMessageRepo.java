package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMessageDto;

public interface DmMessageRepo {

	long sequence();
    
    long create(DmMessageDto dmMessageDto);
    
    //특정 메시지의 상세 정보 조회
    DmMessageDto detail(long messageNo);
    
    //특정 채팅방의 모든 메시지 조회
    List<DmMessageDto> roomMessageList(int roomNo);
    
    void delete(DmMessageDto dmMessageDto);

}
