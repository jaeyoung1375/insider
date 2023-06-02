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

import com.kh.insider.dto.BoardLikeDto;
import com.kh.insider.repo.BoardLikeRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.service.BoardSearchService;
import com.kh.insider.service.ForbiddenService;
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
	@Autowired
	private ForbiddenService forbiddenService;
	
	//무한스크롤
		@GetMapping("/page/{page}")
		public List<BoardListVO> paging(@PathVariable int page, HttpSession session) {
			long memberNo=(Long)session.getAttribute("memberNo");
			
			BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
			boardSearchVO.setBoardCount(2);
			return boardRepo.selectListWithoutFollow(boardSearchVO);
			//return boardRepo.selectListWithFollow(boardSearchVO);
	}
	
	//무한스크롤 팔로우(3일 이내)
	@GetMapping("/new/{page}")
	public List<BoardListVO> pagingNew(@PathVariable int page, HttpSession session) {
		long memberNo=(Long)session.getAttribute("memberNo");
		
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
		boardSearchVO.setLoginMemberNo(memberNo);
		boardSearchVO.setBoardCount(2);
		
		//금지어 정규표현식 검사 후 반환
		List<BoardListVO> boardList = boardRepo.selectListWithFollowNew(boardSearchVO);
		return forbiddenService.changeForbiddenWords(boardList);
		//return boardRepo.selectListWithFollow(boardSearchVO);
	}
	
	@GetMapping("/old/{page}")
	public List<BoardListVO> pagingOld(@PathVariable int page, HttpSession session) {
		long memberNo=(Long)session.getAttribute("memberNo");
		
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
		boardSearchVO.setLoginMemberNo(memberNo);
		boardSearchVO.setBoardCount(2);
		
		//금지어 정규표현식 검사 후 반환
		List<BoardListVO> boardList =boardRepo.selectListWithFollowOld(boardSearchVO);
		return forbiddenService.changeForbiddenWords(boardList);
		//return boardRepo.selectListWithFollow(boardSearchVO);
	}
	
	//검색 페이지 리스트 출력을 위한 계층형 조회
	@GetMapping("/list/{page}")
	public List<BoardListVO> boardList(@PathVariable int page, HttpSession session){
		long memberNo=(Long)session.getAttribute("memberNo");
		
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
		boardSearchVO.setBoardCount(15);
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
	
	//좋아요 목록 불러오기
	@GetMapping("/like/list/{boardNo}")
	public List<BoardLikeDto> likeList(@PathVariable int boardNo){
		return boardLikeRepo.list(boardNo);
	}
}
