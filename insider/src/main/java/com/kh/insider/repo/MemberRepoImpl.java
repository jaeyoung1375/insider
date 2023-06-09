package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.MemberProfileDto;
import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.dto.TagFollowDto;

@Repository
public class MemberRepoImpl implements MemberRepo{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;

	@Override
	public void join(MemberDto dto) {
		
		encoder = new BCryptPasswordEncoder();
		String encrypt = encoder.encode(dto.getMemberPassword());
		dto.setMemberPassword(encrypt);
	
		sqlSession.insert("member.join",dto);
	}
	
	@Override
	// 추후 수정 - 05/10 재영
	public void socialJoin(MemberDto dto) {
		
		sqlSession.insert("member.socialJoin",dto);
	}
	

	@Override
	public MemberDto findByEmail(String memberEmail) {
		return sqlSession.selectOne("member.findByEmail",memberEmail);
	}
	
	@Override
	public MemberWithProfileDto findByNickName(String memberNick) {
		return sqlSession.selectOne("member.findByNickName",memberNick);
	}
	
	@Override
	public int isEmailDuplicated(String memberEmail) throws Exception{		
		return sqlSession.selectOne("member.isEmailDuplicated",memberEmail);
	}
	
	@Override
	public int isNickDuplicated(String memberNick) throws Exception {
		return sqlSession.selectOne("member.isNickDuplicated",memberNick);
	}

	@Override
	public void update(MemberDto memberDto) {
		sqlSession.update("member.update", memberDto);
	}
	
	@Override
	public MemberDto login(String memberEmail, String memberPassword) {
	
		
//		MemberDto findMember = sqlSession.selectOne("member.findByEmail",memberEmail);
//		Map<String, Object> param = new HashMap<>();
//		param.put("memberEmail",memberEmail);
//		param.put("memberPassword",findMember.getMemberPassword());
//		
//		System.out.println("findMember : "+findMember);
//		System.out.println("memberPassword : "+memberPassword);
//		System.out.println("findMember.getPAssword : "+findMember.getMemberPassword());
//		if(encoder.matches(memberPassword, findMember.getMemberPassword())) {	
//			return sqlSession.selectOne("member.login",param);
//		}else {
//			return null;
//		}	
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberEmail",memberEmail);
		param.put("memberPassword",memberPassword);
		
		return sqlSession.selectOne("member.login",param);
		
	}

	@Override
	public void updateLoginTime(Long memberNo) {
		sqlSession.update("member.updateLoginTime",memberNo);
	}
	//memberNo 단일조회
	@Override
	public MemberDto findByNo(long memberNo) {
		return sqlSession.selectOne("member.findByNo", memberNo);
	}
	//비밀번호 변경
	@Override
	public void changePassword(MemberDto memberDto) {
		sqlSession.update("member.changePassword", memberDto);
	}

	//닉네임(boardController에서 닉네임 받아오기)
	@Override
	public String nick(long memberNo) {
		return sqlSession.selectOne("member.nick",memberNo);
	}
	

	// 친구 추천목록 조회
	@Override
	public List<MemberProfileDto> recommendFriends(long memberNo) {
		return sqlSession.selectList("member.recommendFriends",memberNo);
	}

	@Override
	public List<TagFollowDto> hashtagList(long memberNo) {

		return sqlSession.selectList("member.hashtagList",memberNo);
		
	}

	@Override
	public void updateFollow(long memberNo) {
		sqlSession.update("member.updateFollow", memberNo);
	}

	@Override
	public void addReport(long memberNo) {
		sqlSession.update("member.addReport", memberNo);
	}

	@Override
	public void deleteMember(long memberNo) {
		sqlSession.delete("member.deleteMember",memberNo);
	}

	
	
}
