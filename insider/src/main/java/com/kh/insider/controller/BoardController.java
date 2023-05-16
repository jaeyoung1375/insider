package com.kh.insider.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardRepo boardRepo;
	
	@GetMapping("/list")
	public String list() {
		return "board/list";
	}
	
	 // 통합게시물 등록페이지
    @GetMapping("/insert")
    public String insert(){
        return "/board/insert";
    }
    
    // 통합게시물 등록
    @PostMapping("/insert")
    public String insert(HttpSession session, Model model, @ModelAttribute BoardDto boardDto, RedirectAttributes attr){

    	Long boardNo =boardRepo.sequence();
        boardDto.setBoardNo(boardNo);

        // 게시물 작성자
        Long memberNo = (Long)session.getAttribute("memberNo");
        boardDto.setMemberNo(memberNo);

        // 게시물 등록
        boardRepo.insert(boardDto);

        // 개별테이블 추가(Fix!!)

        // 리다이렉트어트리뷰트 추가
        attr.addAttribute("boardNo", boardNo);

        return "redirect:/";
    }
    
    //비동기
    @GetMapping("/rest")
    public String rest() {
    	return "/board/rest";
    }


}
