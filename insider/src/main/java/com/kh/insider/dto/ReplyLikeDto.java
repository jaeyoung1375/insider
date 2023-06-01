package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyLikeDto {
	private Long memberNo;
	private Integer replyNo;
	private Date replyLikeTime;
	
	private int replyLikeCheck;
}
