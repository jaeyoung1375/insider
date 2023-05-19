package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmMessageNickDto {
	
	private String memberNick;
    private long messageNo;
    private int roomNo;
    private int messageSender;
    private String messageContent;
    private Date messageSendTime;

}
