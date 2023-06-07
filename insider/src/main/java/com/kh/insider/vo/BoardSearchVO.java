package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.BoardTagDto;
import com.kh.insider.dto.FollowDto;

import lombok.Data;

@Data
public class BoardSearchVO {
	private List<FollowDto> followDtoList;
	private List<BlockDto> blockDtoList;
	private List<String> tagList; 
	private int page;
	private int boardCount;
	private long loginMemberNo;
	private String tagName;

	private Integer settingDistance;
	private Double memberLat;
	private Double memberLon;
	
	public int getEnd() {
		return page*boardCount;
	}
	public int getBegin() {
		return this.getEnd()-(boardCount-1);
	}
}