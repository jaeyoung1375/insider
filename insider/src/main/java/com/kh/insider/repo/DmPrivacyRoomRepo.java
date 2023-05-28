package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmPrivacyRoomDto;

public interface DmPrivacyRoomRepo {

	void createPrivacy(DmPrivacyRoomDto dmPrivacyRoomDto);
	
	//채팅방에 동일한 초대 유저 중복 확인
	boolean checkDuplication(DmPrivacyRoomDto dmPrivacyRoomDto);
	
	//채팅방 퇴장
	void leaveRoom(DmPrivacyRoomDto dmPrivacyRoomDto);
	
	
////////////////////////삭제 예정 /////////////////

	//초대자 목록 조회 -- 필요 없으면 삭제
	List<DmPrivacyRoomDto> inviteeList(long inviteeNo);

	//특정 채팅방 검색 (중복 확인)
	DmPrivacyRoomDto selectOneRoom(DmPrivacyRoomDto dmPrivacyRoomDto);
	
}