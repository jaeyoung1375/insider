package com.kh.insider.repo;

import com.kh.insider.dto.MemberSuspensionDto;

public interface MemberSuspensionRepo {
	void insert(MemberSuspensionDto memberSuspensionDto);
	MemberSuspensionDto selectOne(long memberNo);
	void removeSuspension(long memberNo);
	void addSuspension(MemberSuspensionDto memberSuspensionDto);
}
