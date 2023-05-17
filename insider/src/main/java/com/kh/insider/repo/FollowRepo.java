package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.FollowDto;

public interface FollowRepo {
	void insert(FollowDto followDto);
	List<FollowDto> selectList(long memberNo);
	void changeAllow(FollowDto followDto);
	void delete(FollowDto followDto);
	
	//팔로워 수 반환(session의 memberNo 입력)
	int getFollowerNumber(long memberNo);
	//팔로우 한 수 반환(session의 memberNo 입력)
	int getFollowNumber(long memberNo);
}
