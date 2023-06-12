package com.kh.insider.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.BlockWithProfileDto;
import com.kh.insider.dto.DmMemberInfoDto;
import com.kh.insider.dto.DmMemberListDto;
import com.kh.insider.dto.DmRoomDto;
import com.kh.insider.dto.DmRoomRenameDto;
import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.BlockRepo;
import com.kh.insider.repo.DmMemberInfoRepo;
import com.kh.insider.repo.DmMemberListRepo;
import com.kh.insider.repo.DmMessageNickRepo;
import com.kh.insider.repo.DmPrivacyRoomRepo;
import com.kh.insider.repo.DmRoomRepo;
import com.kh.insider.repo.DmRoomUserProfileRepo;
import com.kh.insider.repo.DmUserRepo;
import com.kh.insider.service.DmServiceImpl;
import com.kh.insider.vo.DmMemberInfoVO;
import com.kh.insider.vo.DmMessageNickVO;
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
	
	@Autowired
	private DmMemberInfoRepo dmMemberInfoRepo;
	
	@Autowired
	private DmPrivacyRoomRepo dmPrivacyRoomRepo;
	
	@Autowired
	private BlockRepo blockRepo;
	

	//메세지 리스트
	@GetMapping("/message/{roomNo}")
	public List<DmMessageNickVO> roomMessage (
			@PathVariable int roomNo,
			HttpSession session) {
		long memberNo = (Long) session.getAttribute("memberNo");
		long messageSender = (Long) session.getAttribute("memberNo");
		
		//채팅방 읽은 정보 수정
		DmUserDto dmUserDto = new DmUserDto();
		dmUserDto.setReadTime(System.currentTimeMillis());
		dmUserDto.setReadDmTime(new Date());
		dmUserDto.setMemberNo(memberNo);
		dmUserDto.setRoomNo(roomNo);
		dmUserRepo.updateReadTime(dmUserDto);
		
		//return dmMessageNickRepo.getUndeletedMessages(messageSender, roomNo, memberNo);
		//좋아요까지 출력
		return dmMessageNickRepo.getMessagesWithLike(messageSender, roomNo, memberNo);
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
				@RequestParam int roomNo,
				@RequestParam String keyword){
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmMemberListRepo.dmMemberSearch(memberNo, roomNo, keyword);
	}
	
	//초대 : 팔로워 회원 목록
	@GetMapping("/dmInviteMemberList")
	public List<DmMemberListDto> followInviteMemberList(HttpSession session) {
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmMemberListRepo.InvitechooseDm(memberNo);
	}
	
	//초대 : 차단한 회원을 제외한 전체 회원 목록
	@GetMapping("/dmInviteMemberSearch")
	public List<DmMemberListDto> dmInviteMemberSearch(
			HttpSession session,
			@RequestParam int roomNo,
			@RequestParam String keyword){
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmMemberListRepo.dmInviteMemberSearch(memberNo, roomNo, keyword);
	}
	
	//로그인 회원이 참여중인 채팅방 목록
	@GetMapping("/dmRoomList")
	public List<DmMemberInfoDto> findRoomsById (HttpSession session){
		long memberNo = (Long) session.getAttribute("memberNo");
		return dmMemberInfoRepo.dmMemberList(memberNo);
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
	public void inviteUserToRoom(@RequestBody DmRoomVO dmRoomVO) throws IOException {
		dmServiceImpl.inviteUsersToRoom(dmRoomVO);
	}
	
	//채팅방에서 회원 퇴장
	@PostMapping("/exitDmRoom")
	public void exitInRoom(@RequestBody DmUserVO user, HttpSession session) throws IOException {
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
	
	//채팅방 이름 나에게만 변경
    @PostMapping("/roomRenameInsert")
    public void renameInsert(@RequestBody DmRoomVO dmRoomVO) {
        dmServiceImpl.RenameInsert(dmRoomVO);
    }
	
    //변경된 채팅방 이름 수정
    @PutMapping("/changeRoomRename")
    public void changeRoomRename (@RequestBody DmRoomRenameDto dmRoomRenameDto) {
    	dmServiceImpl.updateReName(dmRoomRenameDto);
    }
    
    //변경된 이름의 채팅방 번호 확인
    @GetMapping("/existsRoomNo")
    public boolean existsDmRoomNo(@RequestParam("roomNo") int roomNo) {
        boolean existsRoomNo = dmServiceImpl.existsByRoomNo(roomNo);
        return existsRoomNo;
    }
    
    //채팅방에 참여한 회원 목록
    @GetMapping("/users/{roomNo}")
    public List<DmMemberInfoDto> getUsersByRoomNo(HttpSession session, @PathVariable int roomNo) {
    	long memberNo = (Long) session.getAttribute("memberNo");
        return dmMemberInfoRepo.findUsersByRoomNo(memberNo, roomNo);
    }
    
    //특정 회원이 특정 채팅방에서 읽지 않은 메세지 수
    @GetMapping("/unreadMessageCount")
    public long unreadDmCount(HttpSession session, @RequestParam int roomNo) {
    	long memberNo = (Long) session.getAttribute("memberNo");
    	return dmServiceImpl.unreadMessageNum(memberNo, roomNo);
    }
    
    //읽지 않은 메세지 수 수정
    @PutMapping("/changeUnreadDm")
    public void changeUnreadDm (@RequestBody DmUserDto dmUserDto) {
    	dmServiceImpl.updateUnReadDm(dmUserDto);
    }
    
    //변경된 채팅방 이름 삭제
    @DeleteMapping("/deleteRoomRename")
    public void deleteRename(HttpSession session, @RequestParam int roomNo) {
    	long memberNo = (Long) session.getAttribute("memberNo");
    	if(memberNo==0) return;
    	dmServiceImpl.deleteRename(roomNo, memberNo);
    }
    
    //동일한 회원의 일대일 채팅방 확인
    @PostMapping("/findPrivacyRoom/{inviterNo}/{inviteeNo}")
    public Integer findRoomByMembers(@PathVariable int inviterNo, @PathVariable int inviteeNo) {
        return dmPrivacyRoomRepo.findRoomByMembers(inviterNo, inviteeNo);
    }
    
//방목록 통합
    @GetMapping("/loadDmRoomList")
    public DmMemberInfoVO loadDmRoomList(HttpSession session){
    	//필요 객체 생성
    	DmMemberInfoVO dmMemberInfoVO = new DmMemberInfoVO();
    	DmUserDto dmUserDto = new DmUserDto();
    	long memberNo = (Long) session.getAttribute("memberNo");
    	dmUserDto.setMemberNo(memberNo);
    	//총 회원수, 읽지 않은 메세지 수 리스트 생성
    	List<Integer> count = new ArrayList<>();
    	List<Long> unreadCount = new ArrayList<>();
    	
    	//dm 방 목록 반환
    	List<DmMemberInfoDto> dmRoomList = dmMemberInfoRepo.dmMemberList(memberNo);
    	
    	//배열 돌면서 채핑방에 참여한 총 회원수, 읽지 않은 메세지 수, 메세지 수 수정 수행
    	for(DmMemberInfoDto dmRoom: dmRoomList) {
    		
    		int roomNo = dmRoom.getRoomNo();
    		dmUserDto.setRoomNo(roomNo);
    		
    		//총 회원수
    		int countNum = dmServiceImpl.countUsersInRoom(roomNo);
    		count.add(countNum);
    		//읽지 않은 메세지 수
    		long unreadCountNum = dmServiceImpl.unreadMessageNum(memberNo, roomNo);
    		unreadCount.add(unreadCountNum);
    		
    		//읽지 않은 메세지 수 업데이트
    		dmUserDto.setUnreadMessage(unreadCountNum);
    		dmServiceImpl.updateUnReadDm(dmUserDto);
    	}
    	dmMemberInfoVO.setDmRoomList(dmRoomList);
    	dmMemberInfoVO.setCount(count);
    	dmMemberInfoVO.setUnreadCount(unreadCount);
    	return dmMemberInfoVO;
    }
    // 로그인한 회원이 차단한 회원 목록 - 채팅방 생성 차단
    @GetMapping("/blockList/{memberNo}")
    public List<BlockWithProfileDto> getBlockList(@PathVariable long memberNo) {
        return blockRepo.getBlockList(memberNo);
    }

    // 로그인한 회원이 차단당한 회원 목록 - 채팅방 생성 차단
    @GetMapping("/blockedList/{memberNo}")
    public List<BlockWithProfileDto> getBlockedList(@PathVariable long memberNo) {
        return blockRepo.getBlockedList(memberNo);
    }
    
}
