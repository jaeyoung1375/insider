package com.kh.insider.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmMemberListDto;
import com.kh.insider.dto.DmMessageNickDto;
import com.kh.insider.dto.DmRoomUserProfileDto;
import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.DmMemberListRepo;
import com.kh.insider.repo.DmMessageNickRepo;
import com.kh.insider.repo.DmRoomRepo;
import com.kh.insider.repo.DmRoomUserProfileRepo;
import com.kh.insider.repo.DmUserRepo;
import com.kh.insider.service.DmServiceImpl;
import com.kh.insider.vo.DmRoomVO;
import com.kh.insider.vo.DmUserVO;

@RestController
@RequestMapping("/rest")
public class DmRestController {

	@Autowired
	private DmMessageNickRepo dmMessageNickRepo;
	
	@Autowired
	private DmMemberListRepo dmMemberListRepo;
	
	@Autowired
	private DmRoomUserProfileRepo dmRoomUserProfileRepo;
	
	@Autowired
	private DmUserRepo dmUserRepo;
	
	@Autowired
	private DmRoomRepo dmRoomRepo;
	
	@Autowired
	private DmServiceImpl dmServiceImpl;
	
	
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
	
	//채팅방 생성
	@PostMapping("/createChatRoom")
	public DmRoomVO createRoom(HttpSession session) {
	    int roomNo = dmRoomRepo.sequence();
	    String memberNick = (String) session.getAttribute("memberNick");

        dmServiceImpl.createRoom(roomNo, memberNick);
	    
	    DmRoomVO dmRoomVO = new DmRoomVO();
	    dmRoomVO.setRoomNo(roomNo);
	    dmRoomVO.setRoomName(memberNick);
		return dmRoomVO;
	}
    
	//채팅 유저 입장
	@PostMapping("/joinDmRoom")
	public void joinRoom(@RequestBody DmUserVO user, HttpSession session) {
	    int roomNo = user.getRoomNo();
	    String memberNick = (String) session.getAttribute("memberNick");
	    
	    user.setMemberNick(memberNick); 
	    dmServiceImpl.join(user, roomNo);
	}
	
	//유저 초대
	@PostMapping("/inviteUser")
	public void inviteUserToRoom(@RequestBody DmUserVO inviter, HttpSession session) {
		long inviterNo = (Long) session.getAttribute("memberNo");
		int roomNo = inviter.getRoomNo();
		long inviteeNo = inviter.getInviteeNo();

		inviter.setMemberNo(inviterNo);
		inviter.setRoomNo(roomNo);
		dmServiceImpl.inviteUserToRoom(inviter, roomNo, inviteeNo);
	}


}
