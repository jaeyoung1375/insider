package com.kh.insider.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class NoticeVO {
	
	//유저번호
	private Long memberNo;
	//유저닉네임
	private String memberNick;
	//첨부파일
	private Integer attachmentNo;
	//게시물 번호
	private int boardNo;
	//댓글번호
	private int replyNo;
	//알림 시간
	private Date noticeTime;
    //알림 체크
    private String likeCheck;
    //알림 구분
    private String type;


	//게시글 시간 계산
	public String getBoardTimeAuto() {
	   java.util.Date time = new java.util.Date(noticeTime.getTime());
	   SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	   String timeStr = f.format(time).toString();
	   
	   return timeStr;
	}
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}
