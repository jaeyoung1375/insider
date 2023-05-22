package com.kh.insider.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmMemberListDto;
import com.kh.insider.dto.DmMessageNickDto;
import com.kh.insider.repo.DmMemberListRepo;
import com.kh.insider.repo.DmMessageNickRepo;
import com.kh.insider.repo.DmRoomRepo;
import com.kh.insider.repo.DmRoomUserRepo;
import com.kh.insider.repo.DmUnreadUserRepo;
import com.kh.insider.repo.MemberRepo;

@RestController
@RequestMapping("/rest")
public class DmRestController {

	@Autowired
	DmMessageNickRepo dmMessageNickRepo;
	
	@Autowired
	DmMemberListRepo dmMemberListRepo;
	
	//메세지 리스트
	@GetMapping("/message/{roomNo}")
	public List<DmMessageNickDto> roomMessage (
			@PathVariable int roomNo,
			HttpSession session) {
		long memberNo = (Long) session.getAttribute("memberNo");
		long messageSender = (Long) session.getAttribute("memberNo");
		return dmMessageNickRepo.getUndeletedMessages(messageSender, roomNo, memberNo);
	}

	//팔로워 회원 목록
    @GetMapping("/dmMemberList")
    public List<DmMemberListDto> chooseDm(HttpSession session) {
    	long memberNo = (Long) session.getAttribute("memberNo");
        return dmMemberListRepo.chooseDm(memberNo);
    }
	
}
