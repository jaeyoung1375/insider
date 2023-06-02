package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMemberInfoDto;

public interface DmMemberInfoRepo {

	//특정 회원에 정보
	List<DmMemberInfoDto> dmMemberList(long memberNo);

	//특정 채팅방에 참여한 모든 회원 조회
	List<DmMemberInfoDto> findUsersByRoomNo(long memberNo, int roomNo);
	