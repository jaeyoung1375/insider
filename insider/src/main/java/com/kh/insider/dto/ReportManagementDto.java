package com.kh.insider.dto;

import lombok.Data;

@Data
public class ReportManagementDto {
	private long reportMemberNo;
	private int reportTableNo;
	private String reportTable;
	private Integer reportResult;
	private int count;
	private String memberName;
	private String memberNick;
	private Integer attachmentNo;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}