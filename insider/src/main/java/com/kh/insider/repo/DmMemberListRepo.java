package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmMemberListDto;

public interface DmMemberListRepo {

	//팔로우 회원 목록
	List<DmMemberListDto> chooseDm(long memberNo);
	
	//차단한 회원을 제외한 전체 회원 목록
	List<DmMemberListDto>  dmMemberSearch(long memberNo,int roomNo, String keyword);
	
	//초대 팔로우 회원 목록
	List<DmMemberListDto> InvitechooseDm(long memberNo);
	//초대 차단한 회원을 제외한 전체 회원 목록
	List<DmMemberListDto>  dmInviteMemberSearch(long memberNo,int roomNo, String keyword);
	
}