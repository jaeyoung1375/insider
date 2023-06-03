package com.kh.insider;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.insider.dto.MemberWithProfileDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class joinTests {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberRepo repo;
	
	@Autowired
	private MemberService memberService;
	
	
//	@Test
//	public void test() throws Exception {
//		
//		String memberEmail = "gjrk13752@naver.com";
//		
//		log.debug("result = {}",repo.isEmailDuplicated(memberEmail));
//	}
	
//	@Test
//	public void test() {
//		String chPw = memberService.generatTempPassword();
//		MemberDto dto = new MemberDto();
//		dto.setMemberEmail("jaeyoung1375@naver.com");
//		dto.setMemberPassword(chPw);
//		
//		repo.updateTempPassword(dto);
//		
//	}
	
	@Test
	public void test1() {
		int memberNo = 0;
		
		List<MemberWithProfileDto> result = sqlSession.selectList("member.recommendFriends", memberNo);
		for (MemberWithProfileDto dto : result) {
		    log.debug("Result = {}", dto);
		}
		
		
	}

}
