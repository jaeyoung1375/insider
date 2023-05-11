package com.kh.insider.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@GetMapping("/list")
	public String list() {
		return "board/list";
	}
	
	@GetMapping("/write")
	public String write() {
		return"board/write";
	}
}
