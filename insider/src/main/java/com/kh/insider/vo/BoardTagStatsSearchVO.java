package com.kh.insider.vo;

import lombok.Data;

@Data
public class BoardTagStatsSearchVO {
	private int page=1;
	private String startDate;
	private String endDate;
	
	public int getSize() {
		return 15;
	}
	
	public int getBegin() {
		return page*getSize()-getSize()+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return page*getSize();
	}
}
