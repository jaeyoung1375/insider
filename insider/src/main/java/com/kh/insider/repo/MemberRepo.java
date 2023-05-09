package com.kh.insider.repo;

import com.kh.insider.dto.MemberDto;

public interface MemberRepo {
	
	public void join(MemberDto dto);
	public MemberDto findByEmail(String memberEmail);

}
