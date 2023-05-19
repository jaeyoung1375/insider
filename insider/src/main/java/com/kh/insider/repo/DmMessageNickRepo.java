package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMessageNickDto;

public interface DmMessageNickRepo {
	
	//특정 채팅방에서 회원이 삭제하지 않은 모든 메시지 조회
	List<DmMessageNickDto> getUndeletedMessages(long messageSender, int roomNo, long memberNo);

}
