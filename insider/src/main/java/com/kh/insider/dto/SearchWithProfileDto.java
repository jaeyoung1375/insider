package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchWithProfileDto {
	public int searchNo;
	public long memberNo;
	public String searchTagName;
	public Long searchMemberNo;
	public Date searchTime;
	public int searchDelete;
	public String memberNick;
	public String memberName;
	public Integer attachmentNo;
	public int follow;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}
