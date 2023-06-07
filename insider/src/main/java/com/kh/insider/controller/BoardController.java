package com.kh.insider.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.insider.configuration.FileUploadProperties;
import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardTagDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.ReportDto;
import com.kh.insider.dto.ReportResultDto;
import com.kh.insider.dto.TagDto;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.BoardTagRepo;
import com.kh.insider.repo.MemberProfileRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.ReportRepo;
import com.kh.insider.repo.ReportResultRepo;
import com.kh.insider.repo.TagRepo;
import com.kh.insider.service.BoardAttachService;
import com.kh.insider.service.ReportService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	
	// 파일 경로 받아오기 
	@Autowired
	private FileUploadProperties fileuploadProperties;

	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(fileuploadProperties.getPath());
	}
	
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private MemberProfileRepo memberProfileRepo;
	@Autowired
	private TagRepo tagRepo;
	@Autowired
	private BoardTagRepo boardTagRepo;
	@Autowired
	private BoardAttachService boardAttachService;
	
	@Autowired
	private BoardRepo boardRepo;
	
	@Autowired
	private BoardAttachmentRepo boardAttachmentRepo;
	@Autowired
	private ReportResultRepo reportResultRepo;
	@Autowired
	private ReportRepo reportRepo;
	@Autowired
	private ReportService reportService;

	
	@GetMapping("/list")
	public String list() {
		return "board/list";
	}

// 	// 파일업로드 글 쓸때 사용, 
// 	@PostMapping("/upload")
// 	public String upload(@RequestParam List<MultipartFile> attaches) throws IllegalStateException, IOException, InterruptedException {
//// 	public String upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException, InterruptedException {
// 		
// 		for(MultipartFile file : attaches) {
// 		System.out.println(file.isEmpty());
// 		// getName은 <input name="attach"> 여기서 name에 해당한다.
// 		System.out.println("name = " + file.getName());
// 		System.out.println("original file name = " + file.getOriginalFilename());
// 		System.out.println("content type = " + file.getContentType());
// 		System.out.println("size = " + file.getSize());
// 		
// 		if(!file.isEmpty()) {//파일이 있을 경우
// 			
// 			// 파일 및 파일 형식 판별 --------------------------------
// 			String contentType = file.getContentType(); 
// 			String fileType = null; 
// 			System.out.println("dir는 다음과 같습니다 "+dir);
// 			
// 			// 번호 생성 - DB에 저장하기 위함 번호대로 저장
// 			int attachmentNo = attachmentRepo.sequence();
// 			
// 			// 비디오인지 판별
// 			if(contentType.contains("video"))
// 			{
// 				// 비디오파일형식 판별 ex) mp4, wav
// 				fileType = contentType.replaceAll("video/","");
// 				System.out.println("비디오입니다. 파일확장자는 "+fileType+" 입니다.");
// 				// 빈 파일 생성 파일명=시퀀스.파일형식 ex) 1.png, 2.jpeg, 3.mp4  
// 				File target = new File(dir, String.valueOf(attachmentNo)+"."+fileType);
// 				file.transferTo(target);
// 			}
// 			// 사진인지 판별
// 			else if(contentType.contains("image"))
// 			{
// 				// 사진파일형식 판별 ex) jpeg, png
// 				fileType = contentType.replaceAll("image/","");
// 				System.out.println("사진입니다. 파일확장자는 "+fileType+" 입니다.");
// 				File target = new File(dir, String.valueOf(attachmentNo));
// 				file.transferTo(target);
// 			}			
// 			// 파일 저장(저장 위치는 임시로 생성)---------------------------	
// 			
// 			// 생성한 빈 파일에 사진 혹은 동영상 데이터 저장
// 			
// 			
// 			// 동영상의 경우 이후 압축률이 높은 코덱으로 변경하여
// 			// 용량을 줄여주고 채널 또한 모노로 바꾸어 동영상 파일을 압축한다.
// 			// 파일명 또한 video번호.mp4 ex) video1.mp4 의 형태로 바꾸어준다. 
// 						
// 			
// 			// 비디오 파일 압축 및 이름 변경-----------------------------
// 			if(contentType.contains("video")) { // 콘텐츠타입이 video일 경우에, 
// 				
// 				// 필독@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// 				// 비디오 압축을 진행하기 위해서는 ffmpeg를 다운 받아서 resources에 넣고 진행해야함
// 				// 다운 받고 압축을 풀고나면 ffmpeg/bin 폴더에 있는 실행파일이 있음
// 				// 이것들을 모두 src/main/resources에 넣고 진행할것 용량이 커서 커밋 불가능 200mb임... 
// 				FFmpeg ffmpeg = new FFmpeg("src/main/resources/ffmpeg/bin/ffmpeg");
// 				FFprobe ffprobe = new FFprobe("‪src/main/resources/ffmpeg/bin/ffprobe");
// 				
// 				// 원본 파일
// 				String originFile = dir+"\\"+String.valueOf(attachmentNo)+"."+fileType;
//
// 				// 원볼 파일의 위치를 받아와 Path 인스턴스 생성 
// 				Path filePath = Paths.get(originFile);
// 				
// 				// 변환 파일 선언
// 				String videoFile = dir+"\\"+String.valueOf(attachmentNo);
// 				
// 				// 비디오 파일 빌드 
// 				FFmpegBuilder builder = new FFmpegBuilder().setInput(originFile)
// 						.overrideOutputFiles(true) // 오버라이드
// 						.addOutput(videoFile) // 코덱 압축 후 비디오 저장 파일
// 						.setFormat(fileType) // 포맷 (확장자)
// 						.setVideoCodec("libx264") // 비디오 코덱 H.264 와 같은 이름(facebook, instargram과 동일한 코덱)
// 						.disableSubtitle() // 서브 타이틀 제거 
// 						.setAudioChannels(1) // 모노 : 1, 스테레오 : 2 스테레오가 용량차지가 큼 (facebook은 스테레오)
// 						// .setVideoResolution(1280,720) // 크기 미 지정 시 원본 파일 크기 그대로  
// 						// .setVideoBitRate(1464800) // 비트 레이트 미 지정 시 원본 비트레이트 그대로 
// 						.setStrict(FFmpegBuilder.Strict.EXPERIMENTAL) // ffmpeg 빌더 실행 허용
// 						.done();
// 				
// 				// 비디오 처리 도구 선언
// 				FFmpegExecutor executor = new FFmpegExecutor(ffmpeg,ffprobe);
// 				
// 				// 비디오 처리 시작
// 				executor.createJob(builder).run();
// 				
// 				// 원본 파일 삭제
// 				Files.deleteIfExists(filePath);
// 				
// 				// 변환 파일 사이즈 조회
// 				Path path = Paths.get(videoFile);
// 				long videoSize = Files.size(path);
// 				
// 				// 비디오 DB 저장----------------------------
// 				attachmentRepo.insert(AttachmentDto.builder()
// 								.attachmentNo(attachmentNo)
// 								.attachmentName(file.getOriginalFilename())
// 								.attachmentType(contentType)
// 								.attachmentSize(videoSize)
// 							.build());
// 			}
// 			
// 			else if(contentType.contains("image")) {
// 				
// 				// 이미지 DB 저장----------------------------
// 				attachmentRepo.insert(AttachmentDto.builder()
// 								.attachmentNo(attachmentNo)
// 								.attachmentName(file.getOriginalFilename())
// 								.attachmentType(contentType)
// 								.attachmentSize(file.getSize())
// 							.build());
// 				}
// 			
// 			}
// 		}
// 		return "redirect:/";
// 	}
    

    
 // 통합게시물 등록
//    @PostMapping("/insert")
//    public String insert(HttpSession session, Model model, @ModelAttribute BoardDto boardDto, RedirectAttributes attr){
//
//        // 1. 통합게시물 시퀀스 발행
//        int boardNo = boardRepo.sequence();
//       boardDto.setBoardNo(boardNo);
//
//        // 2. 통합게시물 작성자
//        long memberNo = (long)session.getAttribute("memberNo");
//        boardDto.setMemberNo(memberNo);
//
//        // 4. 통합게시물 등록
//        boardRepo.insert(boardDto);
//
//        // 리디렉트어트리뷰트 추가
//        attr.addAttribute("boardNo", boardNo);
//
//        return "redirect:/";
//    }
    
    
    
    @GetMapping("/insert")
	public String insert(HttpSession session, Model model) {
		
		Long memberNo = (Long)session.getAttribute("memberNo");

		String memberNick = memberRepo.nick(memberNo);
		Integer attachmentNo = memberProfileRepo.selectAttachNo(memberNo);
		
		model.addAttribute("memberNick", memberNick);
		model.addAttribute("attachNo", attachmentNo);
		 
		return "/board/insert";
	}
    
    @PostMapping("/insert")
    public String insert(@ModelAttribute BoardDto boardDto, 
							HttpSession session, 
							RedirectAttributes attr,
							@RequestParam(value="boardAttachment", required=false) List<MultipartFile> boardAttachment,
							Model model,
							@ModelAttribute TagDto tagDto,
							@ModelAttribute MemberDto memberDto,
							@ModelAttribute BoardTagDto boardTagDto
    		) throws IllegalStateException, IOException {
    	Long memberNo = (Long)session.getAttribute("memberNo");
    	
		boardDto.setMemberNo(memberNo);
		log.debug("boardAttachment:{}", boardAttachment);
		boardAttachService.insert(boardDto,boardAttachment);
		
		 // 해시태그 저장
		if(tagDto.getTagName() != null) {
			String inputTagName = tagDto.getTagName();
			String[] array = inputTagName.split("#");
			List<String> tagList = new ArrayList<>();
			for(String s : array) {
				if(s!=null && s.length()>0) {
					s=s.trim();
					s=s.replace("#","");
					if(s.length()>0) {
						tagList.add(s);
					}
				}
			}
			
			for(int i = 0; i < tagList.size(); i++) {
				String tagName = tagList.get(i);
				TagDto tagDtoFind = tagRepo.selectOne(tagName);
				if(tagDtoFind == null) {
					tagRepo.insert(tagName);
				}
					
				BoardTagDto newBoardTagDto = new BoardTagDto();
				newBoardTagDto.setBoardTagNo(boardTagDto.getBoardTagNo());
				newBoardTagDto.setBoardNo(boardDto.getBoardNo());
				newBoardTagDto.setTagName(tagName);
				boardTagRepo.insert(newBoardTagDto);
			}
		}
		attr.addAttribute("memberNo",memberNo);
		return "redirect:/";
    }
    
	//게시글 삭제하기
	@GetMapping("/delete")
	public String delete(@RequestParam int boardNo) {		
		boardTagRepo.delete(boardNo);
		boardRepo.delete(boardNo);
		
		//리포트가 있으면 찾아서 상태 변경해줌
		reportService.manageDeleted("board", boardNo);
		return "redirect:/";
	}
	
	//게시물 수정
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		model.addAttribute("board", boardRepo.selectOne(boardNo));
		//model.addAttribute("boardAttach", boardAttachmentRepo.selectList(boardNo));
		
		List<BoardTagDto> find = boardTagRepo.selectList(boardNo);
		List<String> tagList = new ArrayList<>();
		
		if(find != null) {
			for (BoardTagDto tagDto : find) {
			    String tagName = "#" + tagDto.getTagName();
			    tagList.add(tagName);
			}
			String tagData = String.join(" ", tagList);
			model.addAttribute("tag", tagData);			
		}
		else {
			String empty = "";
			tagList.add(empty);
			model.addAttribute("tag", tagList);			
		}
		
		List<BoardAttachmentDto> findImage = boardAttachmentRepo.selectList(boardNo);
		List<Integer> imageList = new ArrayList<>();
		for(BoardAttachmentDto attDto : findImage) {
			imageList.add(attDto.getAttachmentNo());
		}
		model.addAttribute("image",imageList);
		
		return "/board/edit";
	}
	
	@PostMapping("/edit")
	public String edit(
			@ModelAttribute BoardDto boardDto,
			@ModelAttribute TagDto tagDto,
			@ModelAttribute BoardTagDto boardTagDto) {
		boardTagRepo.delete(boardDto.getBoardNo());
		boardRepo.update(boardDto);
		
		// 해시태그 저장
				if(tagDto.getTagName() != null) {
					String inputTagName = tagDto.getTagName();
					String[] array = inputTagName.split("#");
					List<String> tagList = new ArrayList<>();
					for(String s : array) {
						if(s!=null && s.length()>0) {
							s=s.trim();
							s=s.replace("#","");
							if(s.length()>0) {
								tagList.add(s);
							}
						}
					}
					
					for(int i = 0; i < tagList.size(); i++) {
						String tagName = tagList.get(i);
						TagDto tagDtoFind = tagRepo.selectOne(tagName);
						log.debug("태그디티오:{}",tagDtoFind);
						if(tagDtoFind == null) {
							tagRepo.insert(tagName);
						}
							
						BoardTagDto newBoardTagDto = new BoardTagDto();
						newBoardTagDto.setBoardTagNo(boardTagDto.getBoardTagNo());
						newBoardTagDto.setBoardNo(boardDto.getBoardNo());
						newBoardTagDto.setTagName(tagName);
						boardTagRepo.insert(newBoardTagDto);
					}
				}
		
		return "redirect:/";
	}
    
    
    //비동기
    @GetMapping("/rest")
    public String rest() {
    	return "/board/rest";
    }
    
// 	// 파일업로드 글 쓸때 사용, 
// 	@PostMapping("/insert")
// 	public String insert(@RequestParam List<MultipartFile> boardAttachment) throws IllegalStateException, IOException, InterruptedException {
//// 	public String upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException, InterruptedException {
// 		
// 		for(MultipartFile file : boardAttachment) {
// 		System.out.println(file.isEmpty());
// 		// getName은 <input name="attach"> 여기서 name에 해당한다.
// 		System.out.println("name = " + file.getName());
// 		System.out.println("original file name = " + file.getOriginalFilename());
// 		System.out.println("content type = " + file.getContentType());
// 		System.out.println("size = " + file.getSize());
// 		
// 		if(!file.isEmpty()) {//파일이 있을 경우
// 			
// 			// 파일 및 파일 형식 판별 --------------------------------
// 			String contentType = file.getContentType(); 
// 			String fileType = null; 
// 			System.out.println("dir는 다음과 같습니다 "+dir);
// 			
// 			// 번호 생성 - DB에 저장하기 위함 번호대로 저장
// 			int attachmentNo = attachmentRepo.sequence();
// 			
// 			// 비디오인지 판별
// 			if(contentType.contains("video"))
// 			{
// 				// 비디오파일형식 판별 ex) mp4, wav
// 				fileType = contentType.replaceAll("video/","");
// 				System.out.println("비디오입니다. 파일확장자는 "+fileType+" 입니다.");
// 				// 빈 파일 생성 파일명=시퀀스.파일형식 ex) 1.png, 2.jpeg, 3.mp4  
// 				File target = new File(dir, String.valueOf(attachmentNo)+"."+fileType);
// 				file.transferTo(target);
// 			}
// 			// 사진인지 판별
// 			else if(contentType.contains("image"))
// 			{
// 				// 사진파일형식 판별 ex) jpeg, png
// 				fileType = contentType.replaceAll("image/","");
// 				System.out.println("사진입니다. 파일확장자는 "+fileType+" 입니다.");
// 				File target = new File(dir, String.valueOf(attachmentNo));
// 				file.transferTo(target);
// 			}			
// 			// 파일 저장(저장 위치는 임시로 생성)---------------------------	
// 			
// 			// 생성한 빈 파일에 사진 혹은 동영상 데이터 저장
// 			
// 			
// 			// 동영상의 경우 이후 압축률이 높은 코덱으로 변경하여
// 			// 용량을 줄여주고 채널 또한 모노로 바꾸어 동영상 파일을 압축한다.
// 			// 파일명 또한 video번호.mp4 ex) video1.mp4 의 형태로 바꾸어준다. 
// 						
// 			
// 			// 비디오 파일 압축 및 이름 변경-----------------------------
// 			if(contentType.contains("video")) { // 콘텐츠타입이 video일 경우에, 
// 				
// 				// 필독@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// 				// 비디오 압축을 진행하기 위해서는 ffmpeg를 다운 받아서 resources에 넣고 진행해야함
// 				// 다운 받고 압축을 풀고나면 ffmpeg/bin 폴더에 있는 실행파일이 있음
// 				// 이것들을 모두 src/main/resources에 넣고 진행할것 용량이 커서 커밋 불가능 200mb임... 
// 				FFmpeg ffmpeg = new FFmpeg("src/main/resources/ffmpeg/bin/ffmpeg");
// 				FFprobe ffprobe = new FFprobe("‪src/main/resources/ffmpeg/bin/ffprobe");
// 				
// 				// 원본 파일
// 				String originFile = dir+"\\"+String.valueOf(attachmentNo)+"."+fileType;
//
// 				// 원볼 파일의 위치를 받아와 Path 인스턴스 생성 
// 				Path filePath = Paths.get(originFile);
// 				
// 				// 변환 파일 선언
// 				String videoFile = dir+"\\"+String.valueOf(attachmentNo);
// 				
// 				// 비디오 파일 빌드 
// 				FFmpegBuilder builder = new FFmpegBuilder().setInput(originFile)
// 						.overrideOutputFiles(true) // 오버라이드
// 						.addOutput(videoFile) // 코덱 압축 후 비디오 저장 파일
// 						.setFormat(fileType) // 포맷 (확장자)
// 						.setVideoCodec("libx264") // 비디오 코덱 H.264 와 같은 이름(facebook, instargram과 동일한 코덱)
// 						.disableSubtitle() // 서브 타이틀 제거 
// 						.setAudioChannels(1) // 모노 : 1, 스테레오 : 2 스테레오가 용량차지가 큼 (facebook은 스테레오)
// 						// .setVideoResolution(1280,720) // 크기 미 지정 시 원본 파일 크기 그대로  
// 						// .setVideoBitRate(1464800) // 비트 레이트 미 지정 시 원본 비트레이트 그대로 
// 						.setStrict(FFmpegBuilder.Strict.EXPERIMENTAL) // ffmpeg 빌더 실행 허용
// 						.done();
// 				
// 				// 비디오 처리 도구 선언
// 				FFmpegExecutor executor = new FFmpegExecutor(ffmpeg,ffprobe);
// 				
// 				// 비디오 처리 시작
// 				executor.createJob(builder).run();
// 				
// 				// 원본 파일 삭제
// 				Files.deleteIfExists(filePath);
// 				
// 				// 변환 파일 사이즈 조회
// 				Path path = Paths.get(videoFile);
// 				long videoSize = Files.size(path);
// 				
// 				// 비디오 DB 저장----------------------------
// 				attachmentRepo.insert(AttachmentDto.builder()
// 								.attachmentNo(attachmentNo)
// 								.attachmentName(file.getOriginalFilename())
// 								.attachmentType(contentType)
// 								.attachmentSize(videoSize)
// 							.build());
// 			}
// 			
// 			else if(contentType.contains("image")) {
// 				
// 				// 이미지 DB 저장----------------------------
// 				attachmentRepo.insert(AttachmentDto.builder()
// 								.attachmentNo(attachmentNo)
// 								.attachmentName(file.getOriginalFilename())
// 								.attachmentType(contentType)
// 								.attachmentSize(file.getSize())
// 							.build());
// 				}
// 			
// 			}
// 		}
// 		return "redirect:/";
// 	}


}