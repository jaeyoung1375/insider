package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FollowWithProfileDto {
	private long memberNo;
	private long followFollower;
	private Date followTime;
	private int followAllow;
	private String memberName;
	private String memberNick;
	private int attachmentNo;
}
