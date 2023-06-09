package com.kh.insider.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class DmMessageNickVO {
	private String memberNick;
    private long messageNo;
    private int roomNo;
    private int messageSender;
    private String messageContent;
    private Date messageSendTime;
    private int messageType;

    private int attachmentNo;
    
    private int likeCount;
    private int memberLike;
    private int memberAttachmentNo;
}
