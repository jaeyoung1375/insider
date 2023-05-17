package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.dto.BoardLikeDto;
import com.kh.insider.repo.BoardLikeRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.service.BoardSearchService;
import com.kh.insider.vo.BoardLikeVO;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private BoardRepo boardRepo;
	
	@Autowired
	private BoardLikeRepo boardLikeRepo;
	@Autowired
	private BoardSearchService boardSearchService;
	
	//게시물 등록
	@PostMapping("/")
	public int insert(BoardDto boardDto, HttpSession session) {
		//시퀀스
		int boardNo = boardRepo.sequence();
		System.out.println("boardNo = " +"boardNo");
		//번호
		boardDto.setBoardNo(boardNo);
		//작성자
		boardDto.setMemberNo(boardNo);
		//콘텐트
		boardDto.setBoardContent(boardDto.getBoardContent());
		
		//등록
		return boardDto.getBoardNo();
	}
	
	
	//무한스크롤
	@GetMapping("/page/{page}")
	public List<BoardDto> paging(@PathVariable int page) {
		return boardRepo.selectListPaging(page);
	}
	//검색 페이지 리스트 출력을 위한 계층형 조회
	@GetMapping("/list/{page}")
	public List<BoardListVO> boardList(@PathVariable int page, HttpSession session){
		long memberNo=(Long)session.getAttribute("memberNo");
		
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
		return boardRepo.selectListWithoutFollow(boardSearchVO);
	}
	//좋아요
	@PostMapping("/like")
	public BoardLikeVO like(
			HttpSession session,
			@RequestBody BoardLikeDto boardLikeDto
			) {
		long memberNo = (Long)session.getAttribute("memberNo");
		boardLikeDto.setMemberNo(memberNo);
		
		boolean current = boardLikeRepo.check(boardLikeDto);
		if(current) {
			boardLikeRepo.delete(boardLikeDto);
		}
		else {
			boardLikeRepo.insert(boardLikeDto);
		}
		
		int count = boardLikeRepo.count(boardLikeDto.getBoardNo());
		
		boardRepo.updateLikeCount(boardLikeDto.getBoardNo(), count);
		
		return BoardLikeVO.builder()
					.result(!current)
					.count(count)
					.build();
	}
	//좋아요 여부 확인
	@PostMapping("/check")
	public boolean check(
			HttpSession session,
			@RequestBody BoardLikeDto boardLikeDto) {
		long memberNo = (Long)session.getAttribute("memberNo");
		boardLikeDto.setMemberNo(memberNo);
		
		return boardLikeRepo.check(boardLikeDto);
	}
	
}
