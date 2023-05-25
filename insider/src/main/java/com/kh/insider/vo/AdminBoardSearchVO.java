package com.kh.insider.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class AdminBoardSearchVO {
	private String memberNick;
	
	private String boardTimeBegin;
	private String boardTimeEnd;
	private Integer boardMinReport;
	private Integer boardMaxReport;
	private Integer boardMinLike;
	private Integer boardMaxLike;
	private Integer boardHide;
	
	private int page=1;
	private int size=18;
	private int count;
	
	private String orderListString;
	private List<String> orderList;
	
	//시작행 번호 계산
	public int getBegin() {
		return page*size-size+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return Math.min(page*size, count);
	}
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
}
