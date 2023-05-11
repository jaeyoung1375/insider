package com.kh.insider.repo;

import com.kh.insider.dto.MemberWithProfileDto;

public interface MemberWithProfileRepo {
	MemberWithProfileDto selectOne(int memberNo);
}
