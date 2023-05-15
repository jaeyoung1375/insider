package com.kh.insider.service;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.dto.DmMessageDto;
import com.kh.insider.dto.DmRoomDto;
import com.kh.insider.dto.DmUserDto;
import com.kh.insider.repo.DmMessageRepo;
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
			dmRoomRepo.create(dmRoomDto);
		}
	}
	
	//- DmRoom 제거
	public void deleteRoom(int roomNo) {
		rooms.remove(roomNo);
		//방 제거 코드(DB)
	}
	
	//- 사용자 방에 입장
	public void join(DmUserVO user, int roomNo) {
		createRoom(roomNo, user.getMemberNick());
		//방 선택
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.enter(user);
		
		//참여자 등록(DB)
		boolean isWaitingRoom = roomNo == WebSocketConstant.WAITING_ROOM_NO;
		
		if (isWaitingRoom) return;
		
		DmUserDto dmUserDto = new DmUserDto();
		dmUserDto.setRoomNo(roomNo);
		dmUserDto.setMemberNo(user.getMemberNo());
		boolean isJoin = dmUserRepo.check(dmUserDto);
		if(isJoin) return;
		
		DmUserDto userDto = new DmUserDto();
		userDto.setRoomNo(roomNo);
		userDto.setMemberNo(user.getMemberNo());
		dmUserRepo.enter(userDto);
		
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
	
	//- 방에 메세지를 전송하는 기능(broadcast)
	public void broadcastRoom(
			DmUserVO user,
			int roomNo,
			TextMessage jsonMessage) throws IOException {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.broadcast(jsonMessage);
		
		//메세지 DB 저장
		//- 사용자 아이디, 방 이름, 메세지 내용
		DmMessageDto dmMessageDto = new DmMessageDto();
		dmMessageDto.setRoomNo(roomNo);
		dmMessageDto.setMessageSender(user.getMemberNo());
		dmMessageDto.setMessageContent(jsonMessage.getPayload());
		dmMessageRepo.create(dmMessageDto);
	}
	
	//- 사용자가 존재하는 방의 번호를 찾는 기능
	public int findUser(DmUserVO user) {
		for(int roomNo : rooms.keySet()) {
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
		exit(user, beforeRoomNo);
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
		this.exit(user, roomNo);
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
			if(roomNo == -1) return;
			
			//(옵션)대기실인 경우 메세지 전송이 불가
			if(roomNo == WebSocketConstant.WAITING_ROOM_NO) return;
			
			//보낼 메세지 생성
			MemberMessageVO msg = new MemberMessageVO();
			msg.setContent(receiveVO.getContent());
			msg.setTime(System.currentTimeMillis());
			msg.setMemberNo(user.getMemberNo());
			msg.setMemberNick(user.getMemberNick());
			
			//JSON 변환
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			
			this.broadcastRoom(user, roomNo, jsonMessage);
		}
		//입장메세지인 경우
		else if (receiveVO.getType() == WebSocketConstant.JOIN) {
			int roomNo = receiveVO.getRoom();
			this.moveUser(user, roomNo);
			//this.join(user, roomNo);
			
		}
	}
	
}
