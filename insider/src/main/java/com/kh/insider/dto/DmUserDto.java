package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data 
public class DmUserDto {

	private long memberNo;
	private int roomNo;
	private Date joinTime;
	private String memberNick;
	
	//안읽은 사람 수 표시를 위한 읽은 시간 입력
	private long readTime;
}
