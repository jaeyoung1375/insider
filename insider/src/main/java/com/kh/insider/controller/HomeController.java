package com.kh.insider.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;

@Controller
@RequestMapping("/")
public class HomeController {
	
	@Autowired
	private MemberRepo memberRepo;
	
	@GetMapping("")
	public String home(Model model,
			HttpSession session) {
		//long memberNo = (long) session.getAttribute("memberNo"); 
		//MemberDto memberDto = memberRepo.find(memberNo);
		
		//model.addAttribute("memberDto",memberDto);
		
		return "home";
	}
}
