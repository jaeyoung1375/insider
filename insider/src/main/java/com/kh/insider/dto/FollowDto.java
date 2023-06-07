package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FollowDto {
	private long memberNo;
	private long followFollower;
	private Date followTime;
	private int followAllow;
	
	private int followCheck;
}
