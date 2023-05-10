package com.kh.insider.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.SettingRepo;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private SettingRepo settingRepo;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto dto) {
		memberRepo.join(dto);
		//기본 회원설정값 생성(추후 수정 필요)
		settingRepo.basicInsert(dto.getMemberNo());
		return "redirect:join";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
//	환경설정 페이지
	@GetMapping("/setting")
	public String setting() {
		return"member/setting";
	}

}
