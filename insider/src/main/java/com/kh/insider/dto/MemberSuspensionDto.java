package com.kh.insider.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberSuspensionDto {
	private long memberNo;
	private Date memberSuspensionStopDate;
	private Date memberSuspensionLiftDate;
	private int memberSuspensionStatus;
	private int memberSuspensionTimes;
}