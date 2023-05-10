package com.kh.insider.repo;

import com.kh.insider.dto.MemberDto;

public interface MemberRepo {
	
	// 회원가입 
	public void join(MemberDto dto);
	// 이메일 조회
	public MemberDto findByEmail(String memberEmail);
	public MemberDto login(String memberEmail, String memberPassword);

}
