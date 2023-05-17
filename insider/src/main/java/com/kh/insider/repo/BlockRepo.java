package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BlockDto;

public interface BlockRepo {
	void insert(BlockDto blockDto);
	List<BlockDto> selectList(long memberNo);
	List<BlockDto> selectListBlocked(long memberNo);
	void delete(BlockDto blockDto);
}
