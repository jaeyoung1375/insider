package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmMessageDto {

	private long messageNo;
	private int roomNo;
	private long memberNo;
	private String messageContent;
	private Date messageSendTime;
	private Date messageReadTime;
	private String memberName;
	
}
