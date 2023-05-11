package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmRoomDto;

public interface DmRoomRepo {

	int sequence();
	
    void create(DmRoomDto dmRoomDto);
    
    DmRoomDto find(int roomNo);
    
    List<DmRoomDto> list();
    
}
