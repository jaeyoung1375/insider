package com.kh.insider.dto;

import lombok.Data;

@Data
public class BlockWithProfileDto {
	private long memberNo;
	private long blockNo;
	private String memberName;
	private String memberNick;
	private int attachmentNo;
}
