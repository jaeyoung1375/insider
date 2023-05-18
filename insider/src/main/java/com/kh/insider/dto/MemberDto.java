package com.kh.insider.dto;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberDto {
	private Long memberNo;
	private String memberName;
	private String memberNick;
	private String memberPassword;
	private String memberEmail;
	 @DateTimeFormat(pattern = "E MMM dd HH:mm:ss z yyyy")
	private Date memberLogin;
	private int memberLat;
	private int memberLon;
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


	private Date memberJoin;

	public String getMemberLogin() {
		
		Date date = memberLogin;
        SimpleDateFormat outputFormat = new SimpleDateFormat("d일 M월 yyyy년");
        String formattedDate = outputFormat.format(date);
        
        return formattedDate;
	}
}
