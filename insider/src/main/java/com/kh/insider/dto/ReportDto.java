package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportDto {
	private int reportNo;
	private long memberNo;
	private String reportContent;
	private long reportMemberNo;
	private int reportTableNo;
	private String reportTable;
	private Date reportTime;
	private int reportCheck;
}
