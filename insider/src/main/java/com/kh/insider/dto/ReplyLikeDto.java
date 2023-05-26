package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyLikeDto {
	private long memberNo;
	private Integer replyNo;
	private Date replyLikeTime;
}
