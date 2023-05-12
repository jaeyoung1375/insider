package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDto {

	public int boardNo;
	public int memberNo;
	public String boardContent;
	public int boardLike;
	public int boardLat;
	public int boardLon;
	public Date boardTime;
	public int boardReply;
	public int boardReplyValid;
	public int boardLikeValid;
	public int boardReport;
	public int boardHide;
	public int boardKid;
	public int boardSize;
	public String boardMemberNick;
}
