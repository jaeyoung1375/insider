package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMemberInfoDto;

public interface DmMemberInfoRepo {

	//특정 회원에 정보
	List<DmMemberInfoDto> dmMemberList(long memberNo);
	
}
