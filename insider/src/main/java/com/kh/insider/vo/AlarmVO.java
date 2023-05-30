package com.kh.insider.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AlarmVO {
	
	//게시물 번호
	private int boardNo;
	//게시물 시간
	private Date boardTime;
	//게시물 좋아요 시간
	private Date boardLikeTime;
	//유저번호
	private Long memberNo;
	//유저닉네임
	private String memberNick;
	//댓글번호
	private int replyNo;
	//댓글 시간
	private Date replyTime;
	//팔로워
	private long followFollower;
	//팔로우 시간
	private Date followTime;
	
//	private int boardNo;
//	private int memberNo;
//	private String memberNick;
//	private int attachmentNo;
//	private int check;
//	private Date alarmTime;
//	private int type;
//	private int etc;
}
