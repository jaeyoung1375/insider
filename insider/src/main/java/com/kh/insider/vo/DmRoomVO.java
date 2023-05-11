package com.kh.insider.vo;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;

public class DmRoomVO {
	
	private int roomNo;
	
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
    public void broadcast(TextMessage message, DmUserVO sender) throws IOException {
        for (DmUserVO user : users) {
            if (!user.equals(sender)) {
                user.send(message);
            }
        }
    }

}
