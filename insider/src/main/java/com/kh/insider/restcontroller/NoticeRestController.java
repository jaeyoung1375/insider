package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.service.NoticeService;
import com.kh.insider.service.NoticeServiceImpl;
import com.kh.insider.vo.NoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rest/notice")
public class NoticeRestController {

	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private NoticeServiceImpl noticeServiceImpl;
	
	
	@GetMapping("/")
	public List<NoticeVO> selectList(
									HttpSession session){
		Long memberNo = (Long) session.getAttribute("memberNo");
	    List<NoticeVO> noticeList = noticeService.selectNotice(memberNo);
	    //log.debug("notice목록: {}", noticeList);
	    
		return noticeService.selectNotice(memberNo);
	}

	@PutMapping("/check")
	public void checkAlarm(
							HttpSession session) {
		Long memberNo = (Long)session.getAttribute("memberNo");
		noticeService.check(memberNo);
	}
	
	@GetMapping("/is_insider")
	public Integer isInsider(
						HttpSession session) {
		Long memberNo = (Long)session.getAttribute("memberNo");
		return noticeService.isInsider(memberNo);
	}
	
	//dm 알림
	@GetMapping("/isChat")
	public int isDm(HttpSession session) {
		long memberNo = (Long)session.getAttribute("memberNo");
		return noticeServiceImpl.isDm(memberNo);
	}
	
}