package com.kh.insider.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tag")
public class TagController {
	
	@GetMapping("/{tagName}")
	public String tagPage(@PathVariable String tagName) {
		return "tag/tagPage";
	}
}
