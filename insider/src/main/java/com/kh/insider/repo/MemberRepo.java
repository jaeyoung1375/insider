package com.kh.insider.repo;

import com.kh.insider.dto.MemberDto;

public interface MemberRepo {
	
	// 회원가입 
	public void join(MemberDto dto);
	public void socialJoin(MemberDto dto);
	// 이메일 조회
	public MemberDto findByEmail(String memberEmail);
	// 이메일 중복확인
	public int isEmailDuplicated(String memberEmail) throws Exception;
	
	public void update(MemberDto memberDto);
	public MemberDto login(String memberEmail, String memberPassword);
	
	// 로그인 시각 갱신
	public void updateLoginTime(long memberNo);
	//단일 번호조회
	public MemberDto findByNo(long memberNo);
	public void changePassword(MemberDto memberDto);
	
	// 닉네임
	String nick(long memberNo);
}
