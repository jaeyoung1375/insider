package com.kh.insider.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.DmMemberListDto;
import com.kh.insider.dto.DmMessageNickDto;
import com.kh.insider.dto.DmRoomDto;
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
	
	//회원 입장
	@PostMapping("/enterUsers")
	public void enterUsersInRoom(@RequestBody DmRoomVO dmRoomVO) {
		dmServiceImpl. enterUsersInRoom(dmRoomVO);
	}
	
	//회원 초대
	@PostMapping("/inviteUser")
	public void inviteUserToRoom(@RequestBody DmRoomVO dmRoomVO) {
		dmServiceImpl.inviteUsersToRoom(dmRoomVO);
	}
	
	//채팅방에서 회원 퇴장
	@PostMapping("/exitDmRoom")
	public void exitInRoom(@RequestBody DmUserVO user, HttpSession session) {
		long memberNo = (Long) session.getAttribute("memberNo");
		int roomNo = user.getRoomNo();
		user.setMemberNo(memberNo);
		dmServiceImpl.leaveDmRoom(user, roomNo);
	}
	
	//회원이 존재하지 않는 채팅방 삭제
	@PostMapping("/deleteDmRoom")
	public void deleteRoom(@RequestBody DmRoomVO dmRoomVO) {
	    int roomNo = dmRoomVO.getRoomNo();
	    dmServiceImpl.deleteRoom(roomNo);
	}
	
	//채팅방 정보 수정
	@PutMapping("/updateRoomInfo")
	public void updateRoomInfo(@RequestBody DmRoomDto dmRoomDto) {
	    dmServiceImpl.changeRoomInfo(dmRoomDto);
	}
	
	//채팅방 이름 변경
	@PutMapping("/changeReName")
	public void changeReName(@RequestBody DmRoomDto dmRoomDto) {
	    dmServiceImpl.updateReName(dmRoomDto);
	}
	
	//특정 채팅방에 참여한 총 회원수
	@GetMapping("/countUsersInDmRoom")
	public int countUsersInDmRoom(@RequestParam int roomNo) {
		return dmServiceImpl.countUsersInRoom(roomNo);
	}
	
	//특정 채팅방 정보 조회
	@GetMapping("/searchDmRoom")
	public DmRoomDto searchDmRoom(@RequestParam int roomNo) {
		return dmServiceImpl.findRoomByRoomNo(roomNo);
	}
	

}
