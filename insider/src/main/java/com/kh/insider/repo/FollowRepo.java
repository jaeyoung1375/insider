package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.FollowDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.dto.FollowerWithProfileDto;

public interface FollowRepo {
	void insert(FollowDto followDto);
	FollowDto selectOne(FollowDto followDto);
	
	List<FollowDto> selectList(long memberNo);
	//내가 팔로우 한 사람들의 리스트 반환
	List<FollowWithProfileDto> getFollowList(long memberNo);
	
	// 팔로우 리스트 무한스크롤
	List<FollowWithProfileDto> getFollowListPaging(int page, long memberNo);
	
	// 팔로워 리스트 무한스크롤
	List<FollowWithProfileDto> getFollowerListPaging(int page, long memberNo);
	
	//나를 팔로우 한 팔로워들의 리스트를 반환
	List<FollowerWithProfileDto> getFollowerList(long memberNo);
	void changeAllow(FollowDto followDto);
	void delete(FollowDto followDto);
	
	//팔로워 수 반환(session의 memberNo 입력)
	int getFollowerNumber(long memberNo);
	//팔로우 한 수 반환(session의 memberNo 입력)
	int getFollowNumber(long memberNo);
	
	//메인 홈에서 팔로우 전체 체크
	List<Long> check(long memberNo);
	

}
