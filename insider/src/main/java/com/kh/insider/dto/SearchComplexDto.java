package com.kh.insider.dto;

import lombok.Data;

@Data
public class SearchComplexDto {
	private String name;
	private String nick;
	private int follow;
	private Long memberNo;
	private Integer attachmentNo;
	
	public String getImageURL() {
		if(attachmentNo == null) return "/static/image/user.jpg";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}
