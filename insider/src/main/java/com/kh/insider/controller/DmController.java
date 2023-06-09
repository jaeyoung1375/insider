package com.kh.insider.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.insider.repo.DmRoomRepo;
import com.kh.insider.repo.MemberProfileRepo;

@Controller
@RequestMapping("/dm")
public class DmController {
	
	@Autowired
	private MemberProfileRepo memberProfileRepo;
	
	@GetMapping("/channel")
	public String channel(HttpSession session, Model model) {
		long memberNo = (Long)session.getAttribute("memberNo");
		int attach = memberProfileRepo.selectAttachNo(memberNo);
		model.addAttribute("attach",attach);
		return "dm/channel";
	}
	
	@Autowired
	private DmRoomRepo dmRoomRepo;
	
	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("dmRoomList", dmRoomRepo.list());
		
		return "dm/home";
	}
	
	
}