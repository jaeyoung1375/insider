package com.kh.insider.dto;

import java.util.Date;

import lombok.Data;

@Data
public class DmMessageDto {

	private long messageNo;
	private int roomNo;
	private long messageSender;
	private String messageContent;
	private Date messageSendTime;
	private int messageType;
	
	private int attachmentNo;
	private String memberNick;
	

}
