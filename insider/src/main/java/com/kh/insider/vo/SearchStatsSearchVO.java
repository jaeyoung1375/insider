package com.kh.insider.vo;

import lombok.Data;

@Data
public class SearchStatsSearchVO {
	private int page=1;
	private String column;
	private Integer memberGender;
	private String memberBeginBirth;
	private String memberEndBirth;
	private String searchBeginDate;
	private String searchEndDate;	
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
