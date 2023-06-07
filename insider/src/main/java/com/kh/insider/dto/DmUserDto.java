package com.kh.insider.dto;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
public class DmUserDto {

	private long memberNo;
	private int roomNo;
	private Date joinTime;
	private String memberNick;
	
	//안읽은 사람 수 표시를 위한 읽은 시간 입력
	private long readTime;
	private Date readDmTime;
	
	//읽지 않은 메세지 수
	private long unreadMessage;
	private Date messageSendTime;
	
	
}
