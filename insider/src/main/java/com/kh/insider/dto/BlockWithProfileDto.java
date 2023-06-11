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
		if(attachmentNo == null) return "/static/image/user.jpg";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}
