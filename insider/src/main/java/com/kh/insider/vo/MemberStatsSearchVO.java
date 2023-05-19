package com.kh.insider.vo;

import lombok.Data;

@Data
public class MemberStatsSearchVO {
	private String stat="member_login";
	private String col="days";
	private String order="all_parts.date_part DESC";
	
	private int page=1;
	//시작행 번호 계산
	public int getSize() {
		if(this.col.equals("days")) {
			if(this.order.equals("all_parts.date_part DESC")) {
				return 31;
			}
			else {
				return 10;
			}
		}
		else {
			return 12;
		}
	}
	
	public int getBegin() {
		return page*getSize()-getSize()+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return page*getSize();
	}
}
