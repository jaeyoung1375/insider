package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.TagFollowDto;

public interface TagFollowRepo {
	//상용자가 태그를 팔로우
	void insert(TagFollowDto tagFollowDto);
	//사용자가 팔로우한 태그 반환
	List<TagFollowDto> selectList(long memberNo);
	//사용자가 팔로우한 태그 반환
	int countFromMember(long memberNo);
	//태그를 팔로우한 사람 수 반환
	int countFromTag(String tagName);
	//사용자가 태그를 언팔
	void delete(TagFollowDto tagFollowDto);
	
}
