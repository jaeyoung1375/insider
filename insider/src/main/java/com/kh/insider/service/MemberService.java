package com.kh.insider.service;

public interface MemberService {
	public int RandomCode();
	public int sendEmail(String email);
	
	/*
	 * 1. 사용자가 이메일을 입력하고 이메일 전송 버튼을 누른다.
	 * 2. 사용자가 전송된 인증번호를 입력한다.
	 * 3. 인증번호가 일치하면 임시비밀번호를 해당 계정의 비밀번호를 임시비밀번호로 변경한다.
	 * 4. 사용자에게 임시비밀번호를 보여준다.
	 * 
	 */
}
