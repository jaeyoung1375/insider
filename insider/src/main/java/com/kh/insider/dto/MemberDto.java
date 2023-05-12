package com.kh.insider.dto;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class MemberDto {
	private long memberNo;
	private String memberName;
	private String memberNick;
	private String memberPassword;
	private String memberEmail;
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
	private String memberBirth;
	
//	 public String getMemberBirth() {
//	        return memberBirth;
//	    }
//	 
//	 public void setMemberBirth(String memberBirth) {
//	        // String 값을 Date로 변환
//	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//	        try {
//	            Date birthDate = (Date) dateFormat.parse(memberBirth);
//	            this.memberBirth = dateFormat.format(birthDate); // Optional: 날짜 형식을 유지하고 싶을 경우
//	        } catch (ParseException e) {
//	            e.printStackTrace();
//	            // 날짜 변환 실패 시 예외 처리
//	        }
//	    }
}
