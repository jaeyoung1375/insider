package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyDto {

	private int replyNo;
	private int boardNo;
	private int memberNo;
	private int replyContent;
	private int replyParent;
	private int replyLike;
	private Date replyTime;
	private int replyReport;
}
