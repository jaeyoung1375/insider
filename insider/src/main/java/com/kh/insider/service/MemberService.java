package com.kh.insider.service;

import com.kh.insider.dto.MemberDto;

public interface MemberService {
	public void join(MemberDto memberDto);
	public MemberDto login(String memberEmail, String memberPassword); 
	public boolean checkPassword(String enteredPassword, String encodedPassword);
	public int RandomCode();
	public String generatTempPassword(); // 임시비밀번호 생성
	public int sendEmail(String email);
	public void changePassword(MemberDto memberDto);
	
}
