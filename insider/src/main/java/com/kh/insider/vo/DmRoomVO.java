package com.kh.insider.vo;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.kh.insider.dto.DmMessageDto;

import lombok.Data;

@Data
@JsonIgnoreProperties
public class DmRoomVO {
	
	private int roomNo;
	private String roomName;
	private List<DmMessageDto> messages;
	
	private long memberNo;
	private String memberNick;
	private List<Long> memberList;
	private int roomType;
	
	private String roomRename;
	private int unreadMessage; // 읽지 않은 메세지 수
	
	
    //채팅방의 사용자를 저장할 저장소
    private Set<DmUserVO> users = new CopyOnWriteArraySet<>();

    //입장 기능
    public void enter(DmUserVO user) {
        users.add(user);
    }

    //퇴장 기능
    public void leave(DmUserVO user) {
        users.remove(user);
    }

    //인원수 반환 기능
    public int size() {
        return users.size();
    }

    //사용자 유무 확인 기능(equals / hashCode 반드시 정의)
    public boolean contains(DmUserVO user) {
        return users.contains(user);
    }

    //해당 방에 속한 사용자들에게 메세지를 전송하는 기능
    public void broadcast(TextMessage jsonMessage) throws IOException {
        for (DmUserVO user : users) {
        	user.send(jsonMessage);
        }
    }
    
    //퍼블릭(대기실)에서만 사용될 메서드, 매개변수로 DB저장 전체인원 - 채팅룸에 참가하고 있는 인원 = (대기실 인원)Set<DmUserVO>를 받아야됨
    public void broadcast(TextMessage jsonMessage, Set<DmUserVO> unjoinedUsers) throws IOException{
        for (DmUserVO user : unjoinedUsers) {
        	user.send(jsonMessage);
        }
    }

    
}
