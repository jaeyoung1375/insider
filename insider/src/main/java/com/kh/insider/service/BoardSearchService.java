package com.kh.insider.service;

import com.kh.insider.vo.BoardSearchVO;

public interface BoardSearchService {
	BoardSearchVO getBoardSearchVO(long memberNo, int page);
	//gps위치정보 및 거리정보를 받아 게시물 출력
	BoardSearchVO getBoardSearchVOWithDistance(long memberNo, int page);
}
