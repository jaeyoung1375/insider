package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmRoomDto;

public interface DmRoomRepo {

	int sequence();
	
    void create(DmRoomDto dmRoomDto);
    
    //채팅방 존재 여부 조회
    DmRoomDto find(int roomNo);
    
    //채팅방 목록
    List<DmRoomDto> list();
    
    //유저가 없을 경우 채팅방 삭제
    void deleteRoom(DmRoomDto dmRoomDto);


    //////////////////////////////////////////
    //채팅방 이름 변경
    void updateRoomName(DmRoomDto dmRoomDto);
    
    
}
