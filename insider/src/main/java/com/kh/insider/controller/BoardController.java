package com.kh.insider.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@GetMapping("/list")
	public String list() {
		return "board/list";
	}
	
	@GetMapping("/insert")
	public String write(@RequestParam(required = false)Integer boardNo,
			Model model, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
//		throw new RequirePermissionException("로그인을 해주세요.");
		}
		model.addAttribute("boardNo",boardNo);
		
		return "board/insert";
	}
}
