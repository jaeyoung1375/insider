package com.kh.insider.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties
public class ChannelReceiveVO {
	
	private int type;
	private String content;
	private int room;
	
	private long messageNo; 
	private long memberNo;
	
	private int messageType;
	private int attachmentNo;
	private int profileNo;
}