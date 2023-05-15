package com.kh.insider.vo;

import java.util.ArrayList;
import java.util.List;

import com.kh.insider.dto.MemberWithProfileDto;

import lombok.Data;

@Data
public class MemberWithProfileSearchVO {
	private Integer memberNo;
	private String memberName;
	private String memberEmail;
	private String memberNick;
	private Integer searchLoginDays;
	private String memberAddress;
	private Integer memberLevel;
	private Integer memberGender;
	private Integer memberMinReport;
	private Integer memberMaxReport;
	private String memberBeginBirth;
	private String memberEndBirth;
	private Integer memberMinFollow;
	private Integer memberMaxFollow;
	
	private String orderListString;
	private List<String> orderList;
	
	public void refreshOrderList() {
		if(this.orderListString==null || this.orderListString.length()==0)return;
		String[] temp = orderListString.split(",");
		List<String> list = new ArrayList<>();
		for(String str:temp) {
			if(str.length()>0) {
				list.add(str);
			}
		}
		this.orderList=list;
	}
	private int page=1;
	private int size=10;
	private int count;
	//시작행 번호 계산
	public int getBegin() {
		return page*size-size+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return Math.min(page*size, count);
	}

}
