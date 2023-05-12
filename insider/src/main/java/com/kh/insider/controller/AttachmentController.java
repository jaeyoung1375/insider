package com.kh.insider.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.AttachmentDto;
import com.kh.insider.repo.AttachmentRepo;

import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;

@Controller
public class AttachmentController {
    
	// 파일 경로 받아오기 
	@Autowired
	private FileUploadProperties fileuploadProperties;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	}
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	// 파일업로드 글 쓸때 사용, 
	@PostMapping("/upload")
	public String upload3(@RequestParam MultipartFile attach) throws IllegalStateException, IOException, InterruptedException {
		System.out.println(attach.isEmpty());
		// getName은 <input name="attach"> 여기서 name에 해당한다.
		System.out.println("name = " + attach.getName());
		System.out.println("original file name = " + attach.getOriginalFilename());
		System.out.println("content type = " + attach.getContentType());
		System.out.println("size = " + attach.getSize());
		
		if(!attach.isEmpty()) {//파일이 있을 경우
			
			// 파일 및 파일 형식 판별 --------------------------------
			String contentType = attach.getContentType(); 
			String fileType = null; 
			System.out.println("dir는 다음과 같습니다 "+dir);
			
			// 번호 생성 - DB에 저장하기 위함 번호대로 저장
			int attachmentNo = attachmentRepo.sequence();
			
			// 비디오인지 판별
			if(contentType.contains("video"))
			{
				// 비디오파일형식 판별 ex) mp4, wav
				fileType = contentType.replaceAll("video/","");
				System.out.println("비디오입니다. 파일확장자는 "+fileType+" 입니다.");
				// 빈 파일 생성 파일명=시퀀스.파일형식 ex) 1.png, 2.jpeg, 3.mp4  
				File target = new File(dir, String.valueOf(attachmentNo)+"."+fileType);
				attach.transferTo(target);
			}
			// 사진인지 판별
			else if(contentType.contains("image"))
			{
				// 사진파일형식 판별 ex) jpeg, png
				fileType = contentType.replaceAll("image/","");
				System.out.println("사진입니다. 파일확장자는 "+fileType+" 입니다.");
				File target = new File(dir, String.valueOf(attachmentNo));
				attach.transferTo(target);
			}			
			// 파일 저장(저장 위치는 임시로 생성)---------------------------	
			
			// 생성한 빈 파일에 사진 혹은 동영상 데이터 저장
			
			
			// 동영상의 경우 이후 압축률이 높은 코덱으로 변경하여
			// 용량을 줄여주고 채널 또한 모노로 바꾸어 동영상 파일을 압축한다.
			// 파일명 또한 video번호.mp4 ex) video1.mp4 의 형태로 바꾸어준다. 
						
			
			// 비디오 파일 압축 및 이름 변경-----------------------------
			if(contentType.contains("video")) { // 콘텐츠타입이 video일 경우에, 
				
				// 필독@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				// 비디오 압축을 진행하기 위해서는 ffmpeg를 다운 받아서 resources에 넣고 진행해야함
				// 다운 받고 압축을 풀고나면 ffmpeg/bin 폴더에 있는 실행파일이 있음
				// 이것들을 모두 src/main/resources에 넣고 진행할것 용량이 커서 커밋 불가능 200mb임... 
				FFmpeg ffmpeg = new FFmpeg("src/main/resources/ffmpeg/bin/ffmpeg");
				FFprobe ffprobe = new FFprobe("‪src/main/resources/ffmpeg/bin/ffprobe");
				
				// 원본 파일
				String originFile = dir+"\\"+String.valueOf(attachmentNo)+"."+fileType;

				// 원볼 파일의 위치를 받아와 Path 인스턴스 생성 
				Path filePath = Paths.get(originFile);
				
				// 변환 파일 선언
				String videoFile = dir+"\\"+String.valueOf(attachmentNo);
				
				// 비디오 파일 빌드 
				FFmpegBuilder builder = new FFmpegBuilder().setInput(originFile)
						.overrideOutputFiles(true) // 오버라이드
						.addOutput(videoFile) // 코덱 압축 후 비디오 저장 파일
						.setFormat(fileType) // 포맷 (확장자)
						.setVideoCodec("libx264") // 비디오 코덱 H.264 와 같은 이름(facebook, instargram과 동일한 코덱)
						.disableSubtitle() // 서브 타이틀 제거 
						.setAudioChannels(1) // 모노 : 1, 스테레오 : 2 스테레오가 용량차지가 큼 (facebook은 스테레오)
						// .setVideoResolution(1280,720) // 크기 미 지정 시 원본 파일 크기 그대로  
						// .setVideoBitRate(1464800) // 비트 레이트 미 지정 시 원본 비트레이트 그대로 
						.setStrict(FFmpegBuilder.Strict.EXPERIMENTAL) // ffmpeg 빌더 실행 허용
						.done();
				
				// 비디오 처리 도구 선언
				FFmpegExecutor executor = new FFmpegExecutor(ffmpeg,ffprobe);
				
				// 비디오 처리 시작
				executor.createJob(builder).run();
				
				// 원본 파일 삭제
				Files.deleteIfExists(filePath);
				
				// 변환 파일 사이즈 조회
				Path path = Paths.get(videoFile);
				long videoSize = Files.size(path);
				
				// 비디오 DB 저장----------------------------
				attachmentRepo.insert(AttachmentDto.builder()
								.attachmentNo(attachmentNo)
								.attachmentName(attach.getOriginalFilename())
								.attachmentType(contentType)
								.attachmentSize(videoSize)
							.build());
			}
			
			else if(contentType.contains("image")) {
				
				// 이미지 DB 저장----------------------------
				attachmentRepo.insert(AttachmentDto.builder()
								.attachmentNo(attachmentNo)
								.attachmentName(attach.getOriginalFilename())
								.attachmentType(contentType)
								.attachmentSize(attach.getSize())
							.build());
			}
			
			
		}
		return "redirect:/";
	}

	
	@GetMapping("/show")
	public String show(
			@RequestParam int attachmentNo, 
			Model model) {
		
		// 보여줄 파일의 contentType 조회
		String contentType = attachmentRepo.selectOne(attachmentNo).getAttachmentType();
		if(contentType.contains("video")) {
			model.addAttribute("isVideo","Y");
		}
		
		else if(contentType.contains("image")) {
			model.addAttribute("isVideo","N");
		}
		
		// Restful하게 비디오를 조회하기 위한 model.addAttribute
		model.addAttribute("attachmentNo",attachmentNo);
		// ContentType에 따라 비디오를 재생하기 위한 model.addAttribute
		model.addAttribute("contentType",contentType); 
		return "attachment/show";
	}
	

	// 파일 업로드 & 다른 테이블 연계
	// @PostMapping("/upload4")
	// public String upload4(
	// 		@ModelAttribute PocketmonDto pocketmonDto,
	// 		@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
	// 	//1.포켓몬 등록
	// 	pocketmonDao.insert(pocketmonDto);
		
	// 	if(!attach.isEmpty()) {
	// 		//2.첨부파일 저장 및 등록(첨부파일이 있으면)
	// 		int attachmentNo = attachmentDao.sequence();
			
	// 		File target = new File(dir, String.valueOf(attachmentNo));
	// 		attach.transferTo(target);//저장
			
	// 		attachmentDao.insert(AttachmentDto.builder()
	// 					.attachmentNo(attachmentNo)
	// 					.attachmentName(attach.getOriginalFilename())
	// 					.attachmentType(attach.getContentType())
	// 					.attachmentSize(attach.getSize())
	// 				.build());
			
	// 		//3.포켓몬과 첨부파일 정보를 연결(첨부파일이 있으면)
	// 		pocketmonImageDao.insert(PocketmonImageDto.builder()
	// 					.pocketmonNo(pocketmonDto.getNo())
	// 					.attachmentNo(attachmentNo)
	// 				.build());
	// 	}
		
	// 	return "redirect:/";
	// }

	// 첨부파일 조회
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
			@RequestParam int attachmentNo) throws IOException {
		
		//DB 조회
		AttachmentDto attachmentDto = attachmentRepo.selectOne(attachmentNo);
		if(attachmentDto == null) {//없으면 404
			return ResponseEntity.notFound().build();
		}	
		
		
		
		//파일 찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
			.contentType(MediaType.APPLICATION_OCTET_STREAM)
			.contentLength(attachmentDto.getAttachmentSize())
			.header(HttpHeaders.CONTENT_ENCODING, 
										StandardCharsets.UTF_8.name())
			.header(HttpHeaders.CONTENT_DISPOSITION,
				ContentDisposition.attachment()
							.filename(
									attachmentDto.getAttachmentName(), 
									StandardCharsets.UTF_8
							).build().toString()
			)
			.body(resource);
	}
	
	@GetMapping("/test")
	public String test() {
		return "test";
	}
}