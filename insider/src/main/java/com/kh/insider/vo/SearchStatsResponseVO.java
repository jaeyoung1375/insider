package com.kh.insider.vo;

import java.util.List;

import lombok.Data;

@Data
public class SearchStatsResponseVO {
	private List<SearchStatsVO> searchNickList;
	private List<SearchStatsVO> searchTagList;
}
