package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.DmMemberInfoDto;

import lombok.Data;

@Data
public class DmMemberInfoVO {
	//방 목록
	private List<DmMemberInfoDto> dmRoomList;
	//채팅방 총 인원 수
	private List<Integer> count;
	//읽지 않은 메세지 수
	private List<Long> unreadCount;
}
