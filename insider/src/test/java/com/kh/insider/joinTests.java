package com.kh.insider;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.insider.repo.MemberRepo;

import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class joinTests {
	
	@Autowired
	private MemberRepo repo;
	
	
	@Test
	public void test() throws Exception {
		
		String memberEmail = "gjrk13752@naver.com";
		
		log.debug("result = {}",repo.isEmailDuplicated(memberEmail));
	}

}
