package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.TagDto;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.TagCountVO;

public interface TagRepo {
	//신규 태그 입력
	void insert(String tagName);
	//태그를 팔로우 하는 유저 수 업데이트
	void updateFollow(TagDto tagDto);
	//tag List 및 단일조회
	List<TagDto> selectList();
	TagDto selectOne(String tagName);
	
	List<TagCountVO> tagCountList(AdminBoardSearchVO vo);
	int tagCountListCount(AdminBoardSearchVO vo);
	
	//태그 사용가능 여부 변경
	int updateAvailable(TagDto tagDto);
	
	
}
