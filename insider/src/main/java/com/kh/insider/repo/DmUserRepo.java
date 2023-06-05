package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmUserDto;

public interface DmUserRepo {

	void enter(DmUserDto dmUserDto);
	
	//특정 회원이 참여 중인 채팅방 조회
	List<DmUserDto> find(long memberNo);
	
	//채팅방에서 유저 중복 확인
	boolean check(DmUserDto dmUserDto);
	
	//읽은 시간 수정
	void updateReadTime(DmUserDto dmUserDto);
	
	//읽은 시간 리스트 반환
	List<Long> selectReadTime(int roomNo);
	
	//채팅방에서 사용자 퇴장
	void leaveRoom(DmUserDto dmUserDto);
	
	//채팅방에서 남아 있는 회원
	List<DmUserDto> findMembersByRoom(int roomNo);
	
	//특정 채팅방에 참여한 총 회원수
	int countUsersInRoom(int roomNo);
	
	//특정 회원이 특정 채팅방에서 읽지 않은 메세지 수(본인이 전송한 메세지는 제외)
	List<DmUserDto> getUnreadMessageNum(long memberNo, int roomNo);
	
	//읽지 않은 메세지 수 수정
	void updateUnReadDm(DmUserDto dmUserDto);
	
}
