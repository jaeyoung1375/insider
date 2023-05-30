package com.kh.insider.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class ReplyDto {

	private int replyNo;
	private int replyOrigin;
	private long replyMemberNo;
	private String replyContent;
	private int replyParent;
	private int replyLike;
	private Date replyTime;
	private int replyReport;
	
	private String memberNick;
	private int attachmentNo;
	
	//댓글 시간 계산
		public String getReplyTimeAuto() {
		   java.util.Date time = new java.util.Date(replyTime.getTime());
		   SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		   String timeStr = f.format(time).toString();
		   
		   return timeStr;
		}
		
}
