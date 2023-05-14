package com.kh.insider.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.PaginationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private BoardRepo boardRepo;
	
	//무한스크롤
	@GetMapping("/page/{page}")
	public List<BoardDto> paging(@PathVariable int page) {
		return boardRepo.selectListPaging(page);
	}
	//리스트 출력을 위한 계층형 조회
	@GetMapping("/list/{page}")
	public List<BoardListVO> boardList(@PathVariable int page){
		return boardRepo.selectListWithAttach(page);
	}
}
