package com.kh.insider.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class DmMemberInfoDto {
	
    private int roomNo;
    private String roomName;
    private Date roomCreated;
    private int roomType;
    private long memberNo;
    private Date joinTime;
    private long readTime;
    private int attachmentNo;
    
    private long inviteeNo;
    private String roomRename;
    private String memberNick;
    private String memberName;
    private long messageNo;
    private String messageContent;
    private long messageSender;
    private Date messageSendTime;
    private int messageType;
    
    
    //시간 계산
    public String getMessageSendTimeAuto() {
        if (messageSendTime != null) {
            java.util.Date time = new java.util.Date(messageSendTime.getTime());
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return f.format(time);
        } else {
            return null;
        }
    }

}
