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
	
	public int getEnd() {
		return page*10;
	}
	public int getBegin() {
		return this.getEnd()-9;
	}
}