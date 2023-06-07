package com.kh.insider.service;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.dto.DmMessageDeletedDto;
import com.kh.insider.dto.DmMessageDto;
import com.kh.insider.dto.DmPrivacyRoomDto;
import com.kh.insider.dto.DmRoomDto;
import com.kh.insider.dto.DmRoomRenameDto;
import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.DmMessageDeletedRepo;
import com.kh.insider.repo.DmMessageRepo;
import com.kh.insider.repo.DmNoticeRepo;
import com.kh.insider.repo.DmPrivacyRoomRepo;
import com.kh.insider.repo.DmRoomRenameRepo;
import com.kh.insider.repo.DmRoomRepo;
import com.kh.insider.repo.DmUserRepo;
import com.kh.insider.vo.ChannelReceiveVO;
import com.kh.insider.vo.DmRoomVO;
import com.kh.insider.vo.DmUserVO;
import com.kh.insider.vo.MemberMessageVO;
import com.kh.insider.websocket.WebSocketConstant;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DmServiceImpl implements DmService {
	
	@Autowired
	private DmRoomRepo dmRoomRepo;
	
	@Autowired
	private DmUserRepo dmUserRepo;
	
	@Autowired
	private DmMessageRepo dmMessageRepo;
	
	@Autowired
	private DmMessageDeletedRepo dmMessageDeletedRepo;
	
	@Autowired
	private DmPrivacyRoomRepo dmPrivacyRoomRepo;
	
	@Autowired
	private DmRoomRenameRepo dmRoomRenameRepo;
	

	//여러 개의 방을 관리할 저장소
	Map<Integer, DmRoomVO> rooms = Collections.synchronizedMap(new HashMap<>());
	
	//메세지 해석기
	private ObjectMapper mapper = new ObjectMapper();
	
	//- DmRoom 존재 여부
	public boolean containsRoom(int roomNo) {
		return rooms.containsKey(roomNo);
	}

	//- DmRoom 생성
	public void createRoom(int roomNo, String memberNick) {
		if(containsRoom(roomNo)) return;
			rooms.put(roomNo, new DmRoomVO());
				
		//방 생성(등록) 코드(DB)
		boolean isWaitingRoom = roomNo == WebSocketConstant.WAITING_ROOM_NO;
		if(!isWaitingRoom && dmRoomRepo.find(roomNo) == null) {
			DmRoomDto dmRoomDto = new DmRoomDto();
			dmRoomDto.setRoomNo(roomNo);
			dmRoomDto.setRoomName(memberNick);
			dmRoomDto.setRoomType(1);
			dmRoomRepo.create(dmRoomDto);
		}
	}

	//- DmRoom 제거
	public void deleteRoom(int roomNo) {
		if(containsRoom(roomNo) == false) return;

	    // 채팅방에 참여자가 남아있는지 확인
	    boolean isEmpty = dmUserRepo.findMembersByRoom(roomNo).isEmpty();
	    log.debug("isEmpty: " + isEmpty);
	    
	    //채팅방에 회원이 남아있지 않으면 방 제거(DB)
	    if (isEmpty) {
	        DmRoomDto dmRoomDto = new DmRoomDto();
	        dmRoomDto.setRoomNo(roomNo);
	        dmRoomRepo.deleteRoom(dmRoomDto);
	        rooms.remove(roomNo);
	    }
	}
	
	//- 사용자 방에 입장
	public void join(DmUserVO user, int roomNo) {
		createRoom(roomNo, user.getMemberNick());
		//방 선택
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.enter(user);
		
		boolean isWaitingRoom = roomNo == WebSocketConstant.WAITING_ROOM_NO;
		
		if (isWaitingRoom) return;
		//참여자 등록(DB)
		log.debug("{}님이 {}방으로 참여하였습니다.", user.getMemberNo(), roomNo);
  }
	
	//사용자 방에서 퇴장
	public void exit(DmUserVO user, int roomNo) {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.leave(user);
		
		//참여자 제거(DB)
		log.debug("{}님이 {}방에서 퇴장하였습니다.", user.getMemberNo(), roomNo);
	}
	
	//채팅방에 메세지를 전송하는 기능(broadcast)
	public void broadcastRoom(
			DmUserVO user,
			int roomNo,
			TextMessage jsonMessage,
			long messageNo,
			int messageType) throws IOException {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.broadcast(jsonMessage);
		
		//메세지 DB 저장
		//- 사용자 아이디, 방 이름, 메세지 내용
		DmMessageDto dmMessageDto = new DmMessageDto();
		dmMessageDto.setMessageNo(messageNo);
		dmMessageDto.setRoomNo(roomNo);
		dmMessageDto.setMessageSender(user.getMemberNo());
		dmMessageDto.setMessageContent(jsonMessage.getPayload());
		dmMessageDto.setMessageType(messageType);		
		dmMessageRepo.create(dmMessageDto);
	}
	
	//채팅방에 이미지 메세지를 전송하는 기능
	public void broadcastPicture(
			DmUserVO user, int roomNo, TextMessage jsonMessage,
			long messageNo, int attachmentNo) throws IOException {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.broadcast(jsonMessage);
		
		//메세지 DB 저장
		//- 사용자 아이디, 방 이름, 메세지 내용
		DmMessageDto dmMessageDto = new DmMessageDto();
		dmMessageDto.setMessageNo(messageNo);
		dmMessageDto.setRoomNo(roomNo);
		dmMessageDto.setMessageSender(user.getMemberNo());
		dmMessageDto.setMessageContent(jsonMessage.getPayload());
		dmMessageDto.setAttachmentNo(attachmentNo);
		dmMessageRepo.pictureMsg(dmMessageDto);
	}
	
	
	//방 인원에게 데이터 전송하고 읽은 시간 갱신 기능
	public void broadcastRoom (int roomNo) throws IOException {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		Set<DmUserVO> users = dmRoomVO.getUsers();
        for (DmUserVO user : users) {
        	DmUserDto dmUserDto = new DmUserDto();
        	dmUserDto.setReadTime(System.currentTimeMillis());
        	dmUserDto.setReadDmTime(new Date());
        	dmUserDto.setMemberNo(user.getMemberNo());
        	dmUserDto.setRoomNo(roomNo);
        	dmUserRepo.updateReadTime(dmUserDto);
        }
		
        List<Long> timeList = dmUserRepo.selectReadTime(roomNo);
        String timeJson = mapper.writeValueAsString(timeList);
        TextMessage timeJsonMessage = new TextMessage(timeJson);
        
		dmRoomVO.broadcast(timeJsonMessage);
	}
	
	//- 사용자가 존재하는 방의 번호를 찾는 기능
	public int findUser(DmUserVO user) {
		for(int roomNo : rooms.keySet()) {
			//대기실이면 패스
			if(roomNo==-1) {
				continue;
			}
			DmRoomVO dmRoomVO = rooms.get(roomNo);
			if(dmRoomVO.contains(user)) {
				return roomNo;
			}
		}
		return -1;
	}
			
	//- 사용자를 방에서 방으로 이동시키는 기능
	public void moveUser(DmUserVO user, int roomNo) {
		int beforeRoomNo = findUser(user);
		//대기실은 나가지 않음
		if(roomNo!=-1) {
			exit(user, beforeRoomNo);
		}
		join(user, roomNo);
	}
	

	@Override
	public void connertHandler(WebSocketSession session) {
		DmUserVO user = new DmUserVO(session);
		int roomNo = WebSocketConstant.WAITING_ROOM_NO;
		this.join(user, roomNo);
	}

	@Override
	public void disconnectHandler(WebSocketSession session) {
		DmUserVO user = new DmUserVO(session);
		int roomNo = this.findUser(user);
		if(roomNo!=-1) {
			this.exit(user, roomNo);
		}
		this.exit(user,  -1);
	}

	@Override
	public void receiveHandler(WebSocketSession session, TextMessage message) throws IOException {
		//회원 정보 생성
		DmUserVO user = new DmUserVO(session);
		
		//비회원 차단
		if(user.isMember() == false) return;
		
		//메세지 수신
		ChannelReceiveVO receiveVO = mapper.readValue(message.getPayload(), ChannelReceiveVO.class);
		log.debug("receiveVO = {}", receiveVO);
		
		//채팅메세지인 경우
		if(receiveVO.getType() == WebSocketConstant.CHAT) {
			
			int roomNo = this.findUser(user);
			
			//(옵션)대기실인 경우 메세지 전송이 불가
			if(roomNo == WebSocketConstant.WAITING_ROOM_NO) return;
			
			int MessageType = receiveVO.getType();
			
			//보낼 메세지 생성
			MemberMessageVO msg = new MemberMessageVO();
			msg.setContent(receiveVO.getContent());
			msg.setTime(System.currentTimeMillis());
			msg.setMemberNick(user.getMemberNick());
			long messageNo = dmMessageRepo.sequence();
			msg.setMessageNo(messageNo);
			msg.setMemberNo(user.getMemberNo());
			msg.setMessageType(MessageType);
			
			//JSON 변환
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			
			//채팅방으로 메세지 전송
			this.broadcastRoom(user, roomNo, jsonMessage, messageNo, MessageType);			 
			
			//채팅 참가자 시간 데이터 전송
			this.broadcastRoom(roomNo);
			
		}
		//입장메세지인 경우
		else if (receiveVO.getType() == WebSocketConstant.JOIN) {
			int roomNo = receiveVO.getRoom();
			this.moveUser(user, roomNo);
			//this.join(user, roomNo);
			
			//채팅 참가자 시간 데이터 전송
			this.broadcastRoom(roomNo);
		}
		
		// 채팅방으로 이미지 메세지 전송
		else if (receiveVO.getType() == WebSocketConstant.PICTURE) {
		    int roomNo = this.findUser(user);

		    // 대기실인 경우 메세지 전송이 불가
		    if (roomNo == WebSocketConstant.WAITING_ROOM_NO) return;

		    //int messageType = WebSocketConstant.PICTURE;
		    int attachmentNo = receiveVO.getAttachmentNo();
		    
		    // 보낼 메세지 생성
		    MemberMessageVO msg = new MemberMessageVO();
		    msg.setRoomNo(roomNo);
		    msg.setMemberNick(user.getMemberNick());
		    msg.setContent(receiveVO.getContent());
		    msg.setTime(System.currentTimeMillis());
		    long messageNo = dmMessageRepo.sequence();
		    msg.setMessageNo(messageNo);
		    msg.setMemberNo(user.getMemberNo());
		    msg.setMessageType(receiveVO.getType());
		    msg.setAttachmentNo(attachmentNo);

		    // JSON 변환
		    String json = mapper.writeValueAsString(msg);
		    TextMessage jsonMessage = new TextMessage(json);

		    // 채팅방으로 이미지 메세지 전송
		    this.broadcastPicture(user, roomNo, jsonMessage, messageNo, attachmentNo);
		}

		
	    //메시지 삭제
		else if(receiveVO.getType() == WebSocketConstant.DELETE) {
			long messageNo = receiveVO.getMessageNo();
			this.deleteMessage(user, messageNo);
		}
	    //회원 퇴장 메세지
	    else if (receiveVO.getType() == WebSocketConstant.LEAVE) {
	        int roomNo = this.findUser(user);
	        if (roomNo == -1) return;
	        
	        String content = user.getMemberNick() + " 님이 퇴장하셨습니다.";
	        sendWebSocketMessage(roomNo, content);
	        
	        this.exit(user, roomNo);
	    }
		// 읽지 않은 메시지 수
	    else if (receiveVO.getType() == WebSocketConstant.NEW_MESSAGE) {
	    	int roomNo = this.findUser(user);
	    	List<DmUserDto> unreadMessage = dmUserRepo.getUnreadMessageNum(user.getMemberNo(), roomNo);
	    	
	    	String unreadJson = mapper.writeValueAsString(unreadMessage);
	    	TextMessage unreadTextMessage = new TextMessage(unreadJson);
	    	// 대기실에 있는 사용자에게 이벤트 전송
	    	DmRoomVO waitingRoom = rooms.get(WebSocketConstant.WAITING_ROOM_NO);
	        waitingRoom.broadcast(unreadTextMessage, waitingRoom.getUsers());
	    }
		
		//회원 초대 메세지
//	    else if (receiveVO.getType() == WebSocketConstant.INVITATION) {
//	        int roomNo = this.findUser(user);
//	        if (roomNo == -1) return;

//	        List<Long> memberList = new ArrayList<>();
//	        memberList.add(receiveVO.getMemberNo());

//	        DmRoomVO dmRoomVO = new DmRoomVO();
//	        dmRoomVO.setRoomNo(roomNo);
//	        dmRoomVO.setMemberList(memberList);

//	        String content = user.getMemberNick() + "님이 회원을 초대하였습니다.";
//	        sendWebSocketMessage(roomNo, content);

//	        this.inviteUsersToRoom(dmRoomVO);
//	    }

	}
	//메세지 삭제
	private void deleteMessage(DmUserVO user, long messageNo) {
		DmMessageDeletedDto dmMessageDeletedDto = new DmMessageDeletedDto();
        dmMessageDeletedDto.setMemberNo(user.getMemberNo());
        dmMessageDeletedDto.setMessageNo(messageNo);
        dmMessageDeletedRepo.insertDeleteMessage(dmMessageDeletedDto);
	}
	
	// 회원 입장 DB 등록
	public void  enterUsersInRoom(DmRoomVO dmRoomVO) {
		int roomNo = dmRoomVO.getRoomNo();
		List<Long> memberList = dmRoomVO.getMemberList();
		
		//채팅 유저 DB 등록
	    for (Long memberNo : memberList) {
	        DmUserDto dmUserDto = new DmUserDto();
	        dmUserDto.setRoomNo(roomNo);
	        dmUserDto.setMemberNo(memberNo);
	        
	        boolean isJoin = dmUserRepo.check(dmUserDto);
	        if (isJoin) return;
	        
	        DmUserDto userDto = new DmUserDto();
	        userDto.setRoomNo(roomNo);
	        userDto.setMemberNo(memberNo);
	        
	        dmUserRepo.enter(userDto);
	        
	        log.debug("DB등록 {}님이 {}방으로 참여하였습니다.", memberNo, roomNo);
	    }
	        
        // 일대일 채팅방일 경우, dm_privacy_room 테이블에도 저장
        if (memberList.size() == 2) {
            DmPrivacyRoomDto dmPrivacyRoomDto = new DmPrivacyRoomDto();
            dmPrivacyRoomDto.setInviterNo(memberList.get(1));
            dmPrivacyRoomDto.setInviteeNo(memberList.get(0));
            dmPrivacyRoomDto.setRoomNo(roomNo);
            
            dmPrivacyRoomRepo.createPrivacy(dmPrivacyRoomDto);
            log.debug("일대일 채팅방 DB 등록 {}님이 {}방으로 참여되었습니다.", memberList.get(0), roomNo);
        }
        else {
			return;
		}
	} 
	
	//회원 초대
	public void inviteUsersToRoom(DmRoomVO dmRoomVO) {
		int roomNo = dmRoomVO.getRoomNo();
		List<Long> memberList = dmRoomVO.getMemberList();
		//이 시점에서 채팅방 목록 정보를 보내줘야됨
		log.debug("확인용 초대 멤버 {}", memberList.size());
	    for (Long memberNo : memberList) {
	        DmUserDto dmUserDto = new DmUserDto();
	        dmUserDto.setRoomNo(roomNo);
	        dmUserDto.setMemberNo(memberNo);
	        
	        boolean isJoin3 = dmUserRepo.check(dmUserDto);
	        if (isJoin3) return;
	        
	        DmUserDto userDto = new DmUserDto();
	        userDto.setRoomNo(roomNo);
	        userDto.setMemberNo(memberNo);
	        dmUserRepo.enter(dmUserDto);
	        
	        log.debug("회원 초대 DB등록 {}님이 {}방으로 참여하였습니다.", memberNo, roomNo);
	    }
	} 
	
	//채팅방 퇴장 DB
	public void leaveDmRoom(DmUserVO user, int roomNo) {
		if(containsRoom(roomNo) == false) return;
		//이 시점에서 채팅방 목록 정보를 보내줘야됨
		//참여자 제거(DB)
		DmUserDto dmUserDto = new DmUserDto();
	    dmUserDto.setMemberNo(user.getMemberNo());
	    dmUserDto.setRoomNo(roomNo);
	    dmUserRepo.leaveRoom(dmUserDto);
	    
	    //dm_privacy_room 테이블에서 해당 회원 정보 삭제
	    DmPrivacyRoomDto dmPrivacyRoomDto = new DmPrivacyRoomDto();
	    dmPrivacyRoomDto.setInviterNo(user.getMemberNo());
	    dmPrivacyRoomDto.setRoomNo(roomNo);
	    dmPrivacyRoomRepo.leaveRoom(dmPrivacyRoomDto);
	    
		log.debug("DB삭제 {}님이 {}방에서 퇴장하였습니다.", user.getMemberNo(), roomNo);
	}
	
	//알림 메세지 전송
	private void sendWebSocketMessage(int roomNo, String content) throws IOException {
		ChannelReceiveVO message = new ChannelReceiveVO();
	    message.setType(WebSocketConstant.LEAVE);
	    message.setRoom(roomNo);
	    message.setContent(content);

        String json = mapper.writeValueAsString(message);
        TextMessage jsonMessage = new TextMessage(json);

        DmRoomVO dmRoomVO = rooms.get(roomNo);
        dmRoomVO.broadcast(jsonMessage);
	}
	
	//채팅방 정보 변경
	public void changeRoomInfo(DmRoomDto dmRoomDto) {
	    dmRoomRepo.changeRoomInfo(dmRoomDto);
	}

  //특정 채팅방에 참여한 총 회원수
  public int countUsersInRoom(int roomNo) {
      return dmUserRepo.countUsersInRoom(roomNo);
  }

  //특정 채팅방 정보 조회
  public DmRoomDto findRoomByRoomNo(int roomNo) {
      return dmRoomRepo.find(roomNo);
  }

  //채팅방 이름 나에게만 변경
  public void RenameInsert(DmRoomVO dmRoomVO) {
      DmRoomRenameDto dmRoomRenameDto = new DmRoomRenameDto();
      dmRoomRenameDto.setRenameNo(dmRoomRenameRepo.sequence()); 
      dmRoomRenameDto.setRoomNo(dmRoomVO.getRoomNo());
      dmRoomRenameDto.setMemberNo(dmRoomVO.getMemberNo());
      dmRoomRenameDto.setRoomRename(dmRoomVO.getRoomRename());
      dmRoomRenameRepo.RenameInsert(dmRoomRenameDto);
  }

	//변경된 채팅방 이름 수정
	public void updateReName(DmRoomRenameDto dmRoomRenameDto) {
	    dmRoomRenameRepo.updateRoomRename(dmRoomRenameDto);
	}
	
	//변경된 이름의 채팅방 번호 확인
	public boolean existsByRoomNo(int roomNo) {
		return dmRoomRenameRepo.existsByRoomNo(roomNo);
	}
	
	//특정 회원이 특정 채팅방에서 읽지 않은 메세지 수
   public List<DmUserDto> unreadMessageNum(long memberNo, int roomNo) {
        return dmUserRepo.getUnreadMessageNum(memberNo, roomNo);
    }
   
    //읽지 않은 메세지 수 수정
   public void updateUnReadDm(DmUserDto dmUserDto) {
	   dmUserRepo.updateUnReadDm(dmUserDto);
   }
   
	// 읽지 않은 메시지 수 변경 감지 및 웹소켓 이벤트 발송
   public void broadcastRoom (DmUserDto dmUserDto) throws IOException {
	   
	    long memberNo = dmUserDto.getMemberNo();
	    int roomNo = dmUserDto.getRoomNo();
	    List<DmUserDto> unreadMessages = dmUserRepo.getUnreadMessageNum(memberNo, roomNo); // 읽지 않은 메시지 수 조회

	    // 웹소켓 클라이언트에게 이벤트 전송
	    String unreadJson = mapper.writeValueAsString(unreadMessages);
	    TextMessage unreadMessage = new TextMessage(unreadJson);

	    // 대기실에 있는 사용자에게 이벤트 전송
	    if (roomNo == WebSocketConstant.WAITING_ROOM_NO) {
	        DmRoomVO waitingRoom = rooms.get(WebSocketConstant.WAITING_ROOM_NO);
	        waitingRoom.broadcast(unreadMessage, waitingRoom.getUsers());
	    }
	    // 채팅방에 있는 사용자에게 이벤트 전송
	    //DmRoomVO dmRoomVO = rooms.get(roomNo);
	    //dmRoomVO.broadcast(unreadMessage, dmRoomVO.getUsers());
	}

	   
}
