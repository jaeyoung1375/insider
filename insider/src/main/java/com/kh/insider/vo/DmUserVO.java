package com.kh.insider.vo;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
//판정기분을 추가(WebSocketSession이 같으면 같은 사용자로 본다.)
@EqualsAndHashCode(of= {"session"})
public class DmUserVO {
	
	private WebSocketSession session;
	private long memberNo;
	private String memberNick;
	
	//생성자 생성
	public DmUserVO(WebSocketSession webSocketSession) {
		this.session = webSocketSession;
		Map<String, Object> attr = session.getAttributes();
		this.memberNo = (long)attr.get("memberNo");
		this.memberNick = (String)attr.get("memberNick");
	}
	
	//회원이 아닐 경우, 차단
	public boolean isMember() {
		return this.memberNick != null;
	}
	
	//user의 sesstion 메세지를 가지고 jsonMessage를 보내라.
	public void send(TextMessage jsonMessage) throws IOException {
		session.sendMessage(jsonMessage);
	}
	
}
