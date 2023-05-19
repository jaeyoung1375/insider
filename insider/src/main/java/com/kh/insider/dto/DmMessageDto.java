package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmMessageDto {

	private long messageNo;
	private int roomNo;
	private long messageSender;
	private String messageContent;
	private Date messageSendTime;
	
	private String memberNick;

}
