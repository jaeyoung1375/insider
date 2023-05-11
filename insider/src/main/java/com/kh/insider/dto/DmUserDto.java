package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class DmUserDto {

	private int memberNo;
	private int roomNo;
	private Date joinTime;
	private Integer inviterNo;
	
}
