package com.kh.insider.restcontroller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;
import com.kh.insider.dto.MemberProfileDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.MemberProfileRepo;

@RestController
@RequestMapping("/rest/attachment")
public class AttachmentRestController {
	@Autowired
	private AttachmentRepo attachmentRepo;
	@Autowired
	private FileUploadProperties fileUploadProperties;
	@Autowired
	private MemberProfileRepo memberProfileRepo;
	
	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	//업로드
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int attachmentNo=0;
		if(!attach.isEmpty()) {	//파일이 있을 경우
			attachmentNo = attachmentRepo.save(attach);
		}
		return attachmentNo;
	}
	//다운로드
	
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(	//byte 배열을 포장한 클래스(이거 쓰라고 정해져있음)
			@PathVariable int attachmentNo) throws IOException {
		//DB 조회
		AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
		if(attachmentDto==null) return ResponseEntity.notFound().build();
		
		//파일찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);	//ByteArrayResource 형태로 포장해줘야됨
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachmentDto.getAttachmentSize())	//제공되는 메소드로 헤더를 설정
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())	//제공되는 메소드 없음. 상수로 쓰는 방법
				.header(
					HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment().
						filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
						.build().toString()
				)
				.body(resource);
	}
	
	//프로필 업로드
	@PostMapping("/upload/profile")
	public int uploadProfile(@RequestParam MultipartFile attach,
			HttpSession session) throws IllegalStateException, IOException {
		int attachmentNo=0;
		long memberNo = (Long)session.getAttribute("memberNo");
		if(!attach.isEmpty()) {	//파일이 있을 경우
			attachmentNo = attachmentRepo.save(attach);
			
			//기존 프로필 정보 삭제
			memberProfileRepo.delete(memberNo);
			
			//프로필 사진 DB 입력
			MemberProfileDto memberProfileDto = new MemberProfileDto();
			memberProfileDto.setMemberNo(memberNo);
			memberProfileDto.setAttachmentNo(attachmentNo);
			
			memberProfileRepo.insert(memberProfileDto);
		}
		return attachmentNo;
	}
}
