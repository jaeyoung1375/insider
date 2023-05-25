package com.kh.insider.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmMemberListDto;
import com.kh.insider.dto.DmMessageNickDto;
import com.kh.insider.dto.DmRoomUserProfileDto;
import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.DmMemberListRepo;
import com.kh.insider.repo.DmMessageNickRepo;
import com.kh.insider.repo.DmRoomUserProfileRepo;
import com.kh.insider.repo.DmUserRepo;

@RestController
@RequestMapping("/rest")
public class DmRestController {

	@Autowired
	DmMessageNickRepo dmMessageNickRepo;
	
	@Autowired
	DmMemberListRepo dmMemberListRepo;
	
	@Autowired
	DmRoomUserProfileRepo dmRoomUserProfileRepo;
	
	@Autowired
	private DmUserRepo dmUserRepo;
	
	//메세지 리스트
	@GetMapping("/message/{roomNo}")
	public List<DmMessageNickDto> roomMessage (
			@PathVariable int roomNo,
			HttpSession session) {
		long memberNo = (Long) session.getAttribute("memberNo");
		long messageSender = (Long) session.getAttribute("memberNo");
		
		//채팅방 읽은 정보 수정
		DmUserDto dmUserDto = new DmUserDto();
		dmUserDto.setReadTime(System.currentTimeMillis());
		dmUserDto.setMemberNo(memberNo);
		dmUserDto.setRoomNo(roomNo);
		dmUserRepo.updateReadTime(dmUserDto);
		
		return dmMessageNickRepo.getUndeletedMessages(messageSender, roomNo, memberNo);
	}

	//팔로워 회원 목록
    @GetMapping("/dmMemberList")
    public List<DmMemberListDto> followMemberList(HttpSession session) {
    	long memberNo = (Long) session.getAttribute("memberNo");
        return dmMemberListRepo.chooseDm(memberNo);
    }
    
    //차단한 회원을 제외한 전체 회원 목록
	@GetMapping("/dmMemberSearch")
	public List<DmMemberListDto> dmMemberSearch(
				HttpSession session,
				@RequestParam String keyword){
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmMemberListRepo.dmMemberSearch(memberNo, keyword);
	}
	
	//로그인 회원이 참여중인 채팅방 목록
	@GetMapping("/dmRoomList")
	public List<DmRoomUserProfileDto> findRoomsById (HttpSession session){
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmRoomUserProfileRepo.findRoomsById(memberNo);
	}	
	
}
