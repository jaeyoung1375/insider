package com.kh.insider.vo;

import lombok.Data;

@Data
public class SearchStatsSearchVO {
	private int tagPage=1;
	private int nickPage=1;
	private String column;
	private Integer memberGender;
	private String memberBeginBirth;
	private String memberEndBirth;
	private String searchBeginDate;
	private String searchEndDate;	
	public int getSize() {
		return 15;
	}
	
	public int getTagBegin() {
		return tagPage*getSize()-getSize()+1;
	}
	//종료행 번호 계산
	public int getTagEnd() {
		return tagPage*getSize();
	}
	public int getNickBegin() {
		return nickPage*getSize()-getSize()+1;
	}
	//종료행 번호 계산
	public int getNickEnd() {
		return nickPage*getSize();
	}
}
