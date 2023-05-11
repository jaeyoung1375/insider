package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyDto {

	private int replyNo;
	private int replyOrigin;
	private int replyMemberNo;
	private String replyContent;
	private int replyParent;
	private int replyLike;
	private Date replyTime;
	private int replyReport;
}
