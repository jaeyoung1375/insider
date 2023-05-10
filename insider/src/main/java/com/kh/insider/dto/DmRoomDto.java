package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmRoomDto {

	private int roomNo;
	private String roomName;
	private Date roomCreated;
	
}
