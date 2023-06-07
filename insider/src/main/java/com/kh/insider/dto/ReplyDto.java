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
		
		public String getBoardTime() {
			java.util.Date currentTime = new java.util.Date();
			long timeDif = currentTime.getTime()-replyTime.getTime();
			SimpleDateFormat f = new SimpleDateFormat("yyyy-M-d");
			if(timeDif/1000/60/60/24>=1) {
				return f.format(replyTime); 
			}
			else if(timeDif/1000/60/60>=1) {
				return timeDif/1000/60/60+"시간 전";
			}
			else {
				return timeDif/1000/60+"분 전";
			}
		}
}
