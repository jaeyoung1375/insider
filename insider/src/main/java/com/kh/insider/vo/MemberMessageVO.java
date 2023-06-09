package com.kh.insider.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberMessageVO {
	
	private String memberNick, content;
	private long time;
	
	private long messageNo;
	private long memberNo;
	
	private int messageType;
	private int attachmentNo;
	private int roomNo;
	private int profileNo;
}
