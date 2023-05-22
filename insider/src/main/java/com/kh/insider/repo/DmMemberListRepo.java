package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMemberListDto;

public interface DmMemberListRepo {

	//팔로워 회원 목록
	List<DmMemberListDto> chooseDm(long memberNo);
	
}
