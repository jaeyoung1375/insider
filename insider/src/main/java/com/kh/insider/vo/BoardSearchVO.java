package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.FollowDto;

import lombok.Data;

@Data
public class BoardSearchVO {
	private List<FollowDto> followDtoList;
	private List<BlockDto> blockDtoList;
	private int page;
	private int boardCount;
	
	public int getEnd() {
		return page*boardCount;
	}
	public int getBegin() {
		return this.getEnd()-(boardCount-1);
	}
}