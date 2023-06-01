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
	
	private String boardContent;
	private String boardContentProhibit;
	private String tag;
	
	private List<String> tagList;
	private Integer tagListLength;
	public void makeTagList() {
		if(this.tag==null || this.tag.length()==0) return;
		String[] temp = this.tag.split("#");
		List<String> list  = new ArrayList<>();
		for(String str :temp) {
			String tempString = str;
			tempString = tempString.replace("#", "");
			tempString = tempString.trim();
			if(tempString.length()>0) {
				list.add(tempString);
			}
		}
		this.tagList = list;
		this.tagListLength=list.size();
	}
	
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
	private Integer tagMinFollow;
	private Integer tagMaxFollow;
	private Integer tagAvailable;
	private Integer tagMinCount;
	private Integer tagMaxCount;
	private int tagPage=1;
	private int tagSize=20;
	private int tagCount;
	private String tagOrderListString;
	private List<String> tagOrderList;
	//시작행 번호 계산
	public int getTagBegin() {
		return tagPage*tagSize-tagSize+1;
	}
	//종료행 번호 계산
	public int getTagEnd() {
		return Math.min(tagPage*tagSize, tagCount);
	}
	public void refreshTagOrderList() {
		if(this.tagOrderListString==null || this.tagOrderListString.length()==0)return;
		String[] temp = tagOrderListString.split(",");
		List<String> list = new ArrayList<>();
		for(String str:temp) {
			if(str.length()>0) {
				list.add(str);
			}
		}
		this.tagOrderList=list;
		
	}
}
