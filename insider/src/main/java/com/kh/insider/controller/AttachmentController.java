package com.kh.insider.controller;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.repo.AttachmentRepo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/attachment")
public class AttachmentController {
	
	@Autowired
	private FileUploadProperties fileUploadProperties;
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	private File dir;
	@PostConstruct
		public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	@GetMapping("/upload")
	public String upload() {
		return "attachment/upload";
	}
	
	@PostMapping("/upload")
	public String upload(@RequestParam List<MultipartFile> attaches) {
		log.debug("전송갯수 = " + attaches.size());
		return "redirect:attachment/list";
	}
	
	@GetMapping("/list")
	public String list(Model model){
		model.addAttribute("list", attachmentRepo.selectList());
		return "attachment/list";
	}
	
}
