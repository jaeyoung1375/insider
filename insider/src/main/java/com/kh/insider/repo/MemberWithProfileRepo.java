package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.MemberWithSuspensionDto;
import com.kh.insider.vo.MemberWithProfileSearchVO;

public interface MemberWithProfileRepo {
	MemberWithProfileDto selectOne(long memberNo);
	
	//회원 검색 및 조회
	List<MemberWithSuspensionDto> selectList(MemberWithProfileSearchVO memberWithProfileSearchVO);
	int selectCount(MemberWithProfileSearchVO memberWithProfileSearchVO);
	MemberWithSuspensionDto suspensionSelectOne(long memberNo);
}
