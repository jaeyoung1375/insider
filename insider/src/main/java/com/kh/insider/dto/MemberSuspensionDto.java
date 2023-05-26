package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberSuspensionDto {
	private long memberNo;
	private int memberSuspensionDays;
	private Date memberSuspensionLiftDate;
	private int memberSuspensionStatus;
	private int memberSuspensionTimes;
	private String memberSuspensionContent;
}