package com.kh.insider.vo;

import java.util.List;

import lombok.Data;

@Data
public class AdminBoardResponseVO {
	private List<BoardListVO> boardList;
	private PaginationVO paginationVO;
}
