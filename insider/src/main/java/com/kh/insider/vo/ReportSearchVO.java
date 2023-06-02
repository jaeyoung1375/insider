package com.kh.insider.vo;

import lombok.Data;

@Data
public class ReportSearchVO {
	private int page=1;
	private int size=15;
	private int count;
	
	//시작행 번호 계산
	public int getBegin() {
		return page*size-size+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return Math.min(page*size, count);
	}
	
	private String reportTable;
	private Integer reportMinCount;
	private Integer reportMaxCount;
	private Integer reportMaxManagedCount;
	private Integer reportMinManagedCount;
	private Integer suspension;

	private String memberNick;
	private String memberName;
	private Integer reportResult;
	private String order;
	
	
	private Long memberNo;
	private Integer data;
}
