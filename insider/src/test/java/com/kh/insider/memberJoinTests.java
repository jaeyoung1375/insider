package com.kh.insider;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class memberJoinTests {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
	
	@Test
	public void test() {
		
		MemberDto dto = new MemberDto();
//		dto.setMemberNo(1235);
		dto.setMemberName("testName");
		dto.setMemberNick("testNickName");
		dto.setMemberPassword("testPassword");
		dto.setMemberBirth("1997-01-28");
		dto.setMemberEmail("testEmail");
		dto.setMemberGender("0");
		dto.setMemberPost("12345");
		dto.setMemberBasicAddr("12345");
		dto.setMemberDetailAddr("12345");
		dto.setMemberTel("010-12345-67");
		
		Map<String,Object> param = new HashMap<>();
		param.put("dto", dto);
		
		
		sqlSession.insert("member.join",dto);
	}

}
