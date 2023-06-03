package com.kh.insider.dto;

import lombok.Data;

@Data
public class TagFollowDto {
	private String tagName;
	private	long memberNo;
	
	// 조인 데이터
	private int attachmentNo;
	private int tagCount;
}
