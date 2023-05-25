package com.kh.insider.vo;

import java.util.List;

import com.kh.insider.dto.MemberWithSuspensionDto;

import lombok.Data;

@Data
public class MemberWithProfileResponseVO {
	private List<MemberWithSuspensionDto> memberList;
	private PaginationVO paginationVO;
}
