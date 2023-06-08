package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDto {


	public int boardNo;
	public long memberNo;
	public String boardContent;
	public int boardLike;
	public double boardLat;
	public double boardLon;
	public Date boardTime;
	public int boardReply;
	public Integer boardReplyValid;
	public Integer boardLikeValid;
	public int boardReport;
	public int boardHide;
	public int boardKid;
	public int boardSize;
	
	// 조인 할 컬럼
	public int attachmentNo;
}
