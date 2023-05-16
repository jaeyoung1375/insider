package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.MemberWithProfileDto;

import lombok.Data;

@Data
public class MemberWithProfileSearchResponseVO {
	private List<MemberWithProfileDto> memberList;
	private PaginationVO paginationVO;
}
