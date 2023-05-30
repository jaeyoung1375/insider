package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.service.AlarmService;
import com.kh.insider.vo.AlarmVO;

@RestController
@RequestMapping("/rest/alarm")
public class AlarmRestController {

	@Autowired
	private AlarmService alarmService;
	
	
	// findByNo를 사용하여 memberNo에 관련된 나머지 데이터를 불러와야함
	@GetMapping("")
	public List<AlarmVO> selectList(
									HttpSession session){
		Long memberNo = (Long) session.getAttribute("login");
		return alarmService.selectAlarm(memberNo);
	}
	
	@PutMapping("/check")
	public void checkAlarm(
							HttpSession session) {
		Long memberNo = (Long)session.getAttribute("login");
		alarmService.check(memberNo);
	}
	
	@GetMapping("/is_insider")
	public Integer isInsider(
						HttpSession session) {
		Long memberNo = (Long)session.getAttribute("login");
		return alarmService.isInsider(memberNo);
	}
	
}