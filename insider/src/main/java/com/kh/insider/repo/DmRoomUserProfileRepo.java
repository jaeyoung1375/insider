package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmRoomUserProfileDto;

public interface DmRoomUserProfileRepo {

	//로그인 회원이 참여 중인 채팅방 조회
	List<DmRoomUserProfileDto> findRoomsById(long memberNo);
	
}
