package com.kh.insider.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/file")
public class AttachmentController {
	
	@GetMapping("/upload")
	public String upload() {
		return "/board/upload";
	}
	
	@PostMapping("/upload")
	public String upload(@RequestParam List<MultipartFile> attaches) {
		System.out.println("전송갯수 : " + attaches.size());
		return "redirect:/";
	}
}
