package com.kh.insider.vo;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.TextMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChannelVO {

	//여러 개의 방을 관리할 저장소
	Map<Integer, DmRoomVO> rooms = Collections.synchronizedMap(new HashMap<>());
	
	//- 방 생성/제거/확인
	public void createRoom(int roomNo) {
		if(containsRoom(roomNo)) return;
		rooms.put(roomNo, new DmRoomVO());
	}
	public void deleteRoom(int roomNo) {
		rooms.remove(roomNo);
	}
	public boolean containsRoom(int roomNo) {
		return rooms.containsKey(roomNo);
	}
	
	//- 사용자를 방에 입장/퇴장
	public void join(DmUserVO user, int roomNo) {
		createRoom(roomNo);
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.enter(user);
		
		log.debug("{}님이 {}방으로 참여하였습니다.", user.getMemberName(), roomNo);
	}
	
	public void exit(DmUserVO user, int roomNo) {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.leave(user);
		
		log.debug("{}님이 {}방으로 퇴장하였습니다.", user.getMemberName(), roomNo);
	}
	
	//- 방에 메세지를 전송하는 기능(broadcast)
	public void broadcastRoom(TextMessage jsonMessage, int roomNo) throws IOException {
		if(containsRoom(roomNo) == false) return;
		
		DmRoomVO dmRoomVO = rooms.get(roomNo);
		dmRoomVO.broadcast(jsonMessage, null);
	}
		

}
