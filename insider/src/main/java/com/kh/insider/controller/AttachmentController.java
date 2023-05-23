package com.kh.insider.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;
import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;

import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;

@Controller
@RequestMapping("/attachment")
public class AttachmentController {
    
	// 파일 경로 받아오기 
	@Autowired
	private FileUploadProperties fileuploadProperties;
	
	@Autowired
	private AttachmentRepo attachmentRepo;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	} 
    
	// 첨부파일 조회
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> download(
			@PathVariable int fileName) throws IOException {
		
		//DB 조회
//		AttachmentDto attachmentDto = attachmentRepo.selectOne(fileName);

		//파일 찾기
		File dir = new File("D:/upload");
		File target = new File(dir, String.valueOf(fileName));
		if(!target.exists()) return ResponseEntity.notFound().build();
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
			.contentType(MediaType.APPLICATION_OCTET_STREAM)
			.contentLength(target.length())
//			.contentLength(attachmentDto.getAttachmentSize())
			.header(HttpHeaders.CONTENT_ENCODING, 
										StandardCharsets.UTF_8.name())
			.header(HttpHeaders.CONTENT_DISPOSITION,
				ContentDisposition.attachment()
							.filename(
									"reply.png", StandardCharsets.UTF_8
//									attachmentDto.getAttachmentName(),
//									StandardCharsets.UTF_8
							).build().toString()
			)
			.body(resource);
	}
	
}