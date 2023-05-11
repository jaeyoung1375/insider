package com.kh.insider.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.insider.repo.DmRoomRepo;

@Controller
@RequestMapping("/dm")
public class DmController {
	
	@GetMapping("/channel")
	public String channel() {
		return "dm/channel";
	}
	
	@Autowired
	private DmRoomRepo dmRoomRepo;
	
	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("dmRoomList", dmRoomRepo.list());
		
		return "dm/home";
	}
	
	//테스트
	@GetMapping("/json")
	public String json() {
		return "dm/json";
	}
	
	//테스트
	@GetMapping("/channel6")
	public String channel6() {
		return "dm/channel6";
	}
	

}
