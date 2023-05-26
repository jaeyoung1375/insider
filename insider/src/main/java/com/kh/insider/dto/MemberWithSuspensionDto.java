package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberWithSuspensionDto {
	private long memberNo;
	private String memberName;
	private String memberPassword;
	private String memberEmail;
	private Date memberLogin;
	private double memberLat;
	private double memberLon;
	private String memberPost;
	private String memberBasicAddr;
	private String memberDetailAddr;
	private int memberLevel;
	private String memberMsg;
	private String memberTel;
	private String memberGender;
	private int memberReport;
	private Date memberBirth;
	private int memberFollow;
	private Integer attachmentNo;
	private String memberNick;
	private Date memberJoin;
	
	private Integer memberSuspensionDays;
	private Date memberSuspensionLiftDate;
	private Integer memberSuspensionStatus;
	private Integer memberSuspensionTimes;
	private String memberSuspensionContent;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}