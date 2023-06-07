package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BookmarkDto;
import com.kh.insider.repo.BookmarkRepo;

@RestController
@RequestMapping("/rest/bookmark")
public class BookmarkRestController {
	
	@Autowired
	private BookmarkRepo bookmarkRepo;
	
	// 북마크 등록
	@PostMapping("/{boardNo}")
	public boolean insert(@PathVariable int boardNo, HttpSession session) {
		long memberNo = (long) session.getAttribute("memberNo");
		BookmarkDto dto = new BookmarkDto();
		dto.setMemberNo(memberNo);
		dto.setBoardNo(boardNo);
		
		BookmarkDto checkDto = bookmarkRepo.selectOne(dto);
		
		if(checkDto == null) {
			bookmarkRepo.insert(dto);
			return true;
		}else {
			bookmarkRepo.delete(dto);
			return false;
		}
	}
	
	// 특정회원 북마크 목록
	@GetMapping("/selectOne")
	public List<BookmarkDto> selectOne(HttpSession session){
		long memberNo = (long) session.getAttribute("memberNo");
		return bookmarkRepo.findByNo(memberNo);
	}
	
	

}
