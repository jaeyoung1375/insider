package com.kh.insider.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;
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
	

	
	@GetMapping("/download/{fileName}")
	@ResponseBody//여기서 반환되는 데이터는 뷰가 아닙니다
	public ResponseEntity<ByteArrayResource> download(
														@PathVariable int fileName) throws IOException	{
	
		File dir = new File("D:/upload");
		File target = new File(dir, String.valueOf(fileName));
		if(!target.exists()) return ResponseEntity.notFound().build();
		
		// 2. 응답 객체를 만들어서 반환
		byte[] data = FileUtils.readFileToByteArray(dir);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(dir.length())
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				//.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=reply.png")
				.header(HttpHeaders.CONTENT_DISPOSITION, 
						ContentDisposition.attachment()
						.filename("reply.png", StandardCharsets.UTF_8)
						.build()
						.toString()
				)
				.body(resource);
	}
	
//	@GetMapping("/upload")
//	public String upload() {
//		return "attachment/upload";
//	}
//	
//	@PostMapping("/upload")
//	public String upload(@RequestParam List<MultipartFile> attaches) {
//		log.debug("전송갯수 = " + attaches.size());
//		return "redirect:/list";
//	}
//
//	
//	@GetMapping("/list")
//	public String list(){
//		return "attachment/list";
//	}
	
//	private File dir;
//	@PostConstruct
//	public void init() {
//		// 파일경로 - D:/upload 폴더
//		dir = new File(fileUploadProperties.getPath()); 
//	}
	

	
}
