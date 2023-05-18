package com.kh.insider.service;

import com.kh.insider.vo.BoardSearchVO;

public interface BoardSearchService {
	BoardSearchVO getBoardSearchVO(long memberNo, int page);
}
