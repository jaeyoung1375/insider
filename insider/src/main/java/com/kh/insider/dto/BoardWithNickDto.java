package com.kh.insider.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class BoardWithNickDto {
	public int boardNo;
	public long memberNo;
	public String boardContent;
	public int boardLike;
	public double boardLat;
	public double boardLon;
	public Date boardTime;
	public int boardReply;
	public int boardReplyValid;
	public int boardLikeValid;
	public int boardReport;
	public int boardHide;
	public int boardKid;
	public int boardSize;
	
	private String memberNick;
	private Integer attachmentNo;
	
	//게시글 시간 계산
	public String getBoardTimeAuto() {
	   java.util.Date time = new java.util.Date(boardTime.getTime());
	   SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	   String timeStr = f.format(time).toString();
	   
	   return timeStr;
	}
	
}
