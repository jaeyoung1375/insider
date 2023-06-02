package com.kh.insider.dto;

import java.sql.Date;

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
	private Date reportTime;
	private int managedCount;
	
	private Integer memberSuspensionDays;
	private Date memberSuspensionLiftDate;
	private Integer memberSuspensionStatus;
	private Integer memberSuspensionTimes;
	private String memberSuspensionContent;
	
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/rest/attachment/download/"+attachmentNo;
	}
}