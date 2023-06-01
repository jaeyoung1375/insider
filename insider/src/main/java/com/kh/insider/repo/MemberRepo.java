package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberProfileDto;

public interface MemberRepo {
	
	// 회원가입 
	public void join(MemberDto dto);
	public void socialJoin(MemberDto dto);
	// 이메일 조회
	public MemberDto findByEmail(String memberEmail);
	// 닉네임 조회
	public MemberDto findByNickName(String memberNick);
	// 이메일 중복확인
	public int isEmailDuplicated(String memberEmail) throws Exception;
	// 닉네임 중복확인
	public int isNickDuplicated(String memberNick) throws Exception;
	
	// 친구 추천목록 조회
	public List<MemberProfileDto> recommendFriends(long memberNo);
	
	
	
	public void update(MemberDto memberDto);
	public MemberDto login(String memberEmail, String memberPassword);
	
	// 로그인 시각 갱신
	public void updateLoginTime(Long memberNo);
	//단일 번호조회
	public MemberDto findByNo(long memberNo);
	
	
	public void changePassword(MemberDto memberDto);
	
	// 닉네임
	String nick(long memberNo);
}
