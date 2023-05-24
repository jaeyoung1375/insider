package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmUserDto;
import com.kh.insider.vo.DmReadTimeVO;

public interface DmUserRepo {

	void enter(DmUserDto dmUserDto);
	
	List<DmUserDto> find(long memberNo);
	
	boolean check(DmUserDto dmUserDto);
	
	//채팅방에서 사용자 퇴장
	void leaveRoom(DmUserDto dmUserDto);
	
	//읽은 시간 수정
	void updateReadTime(DmUserDto dmUserDto);
	//읽은 시간 리스트 반환
	List<Long> selectReadTime(int roomNo);
}
