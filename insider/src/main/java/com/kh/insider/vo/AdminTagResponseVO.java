package com.kh.insider.vo;

import java.util.List;

import lombok.Data;

@Data
public class AdminTagResponseVO {
	private List<TagCountVO> tagList;
	private PaginationVO paginationVO;
}