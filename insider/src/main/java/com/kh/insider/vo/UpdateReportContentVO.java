package com.kh.insider.vo;

import lombok.Data;

@Data
public class UpdateReportContentVO {
	private int reportListNo;
	private String reportListContentBefore;
	private String reportListContentAfter;
}
