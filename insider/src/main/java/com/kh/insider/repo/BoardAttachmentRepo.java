package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.vo.SearchVO;

public interface BoardAttachmentRepo {

	List<BoardAttachmentDto>selectList(SearchVO searchVO);
	BoardAttachmentDto  selectOne(int boardNo);
}
