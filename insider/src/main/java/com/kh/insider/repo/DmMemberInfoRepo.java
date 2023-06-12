package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMemberInfoDto;

public interface DmMemberInfoRepo {

	//특정 회원에 정보
	List<DmMemberInfoDto> dmMemberList(long memberNo);

	//특정 채팅방에 참여한 모든 회원 조회
	List<DmMemberInfoDto> findUsersByRoomNo(long memberNo, int roomNo);
	
	//특정 회원이 특정 채팅방에서 읽지 않은 메세지 수 + 차단 포함 (본인이 전송한 메세지는 제외)
	Integer getUnreadMessages(Long memberNo);

}	

