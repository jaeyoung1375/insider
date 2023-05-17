package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmRoomDto;

public interface DmRoomRepo {

	int sequence();
	
    void create(DmRoomDto dmRoomDto);
    
    DmRoomDto find(int roomNo);
    
    List<DmRoomDto> list();
    
    void updateRoomName(DmRoomDto dmRoomDto);
    
    //유저가 없을 경우 채팅방 삭제
    void deleteIfEmpty(int roomNo);
    
}
