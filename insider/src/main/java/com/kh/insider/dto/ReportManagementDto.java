package com.kh.insider.dto;

import lombok.Data;

@Data
public class ReportManagementDto {
	private long reportMemberNo;
	private int reportTableNo;
	private String reportTable;
	private int reportCheck;
	private int count;
	private String memberName;
	private String memberNick;
	private int attachmentNo;
}