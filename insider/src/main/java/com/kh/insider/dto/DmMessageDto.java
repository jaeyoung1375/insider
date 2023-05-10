package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmMessageDto {

	private int messageNo;
	private int roomNo;
	private int messageSender;
	private String messageContent;
	private Date messageSendTime;
	private Date messageReadTime;
	
}
