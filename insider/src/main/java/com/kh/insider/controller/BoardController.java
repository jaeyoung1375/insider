package com.kh.insider.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@GetMapping("/list")
	public String list() {
		return "board/list";
	}
	
	  // 임시 파일 업로드 주소
    @GetMapping("/file")
    public String file(){
        return "temp_file";
    }

    // 임시 서머노트 & 파일 업로드 연계
    @GetMapping("/write")
    public String write(){
        return "temp_write";
    }

}
