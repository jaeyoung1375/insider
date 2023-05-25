package com.kh.insider.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AlarmVO {
	private int boardNo;
	private Long memberNo;
	private String memberNick;
	private int attachmentNo;
	private int check;
	private Date alarmTime;
	private int type;
	private int etc;
}
