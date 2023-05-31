package com.kh.insider.dto;

import lombok.Data;

@Data
public class BlockWithProfileDto {
	private long memberNo;
	private long blockNo;
	private String memberName;
	private String memberNick;
	private Integer attachmentNo;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}
