package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmUserDto;

public interface DmUserRepo {

	void enter(DmUserDto dmUserDto);
	
	List<DmUserDto> find(long memberNo);
	
	boolean check(DmUserDto dmUserDto);
	
	//채팅방에서 사용자 퇴장
	void leaveRoom(DmUserDto dmUserDto);
	
}
