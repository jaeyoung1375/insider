package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.BlockWithProfileDto;

public interface BlockRepo {
	void insert(BlockDto blockDto);
	List<BlockDto> selectList(long memberNo);
	List<BlockDto> selectListBlocked(long memberNo);
	BlockDto selectOne(BlockDto blockDto);
	
	List<BlockWithProfileDto> getBlockList(long memberNo);
	void delete(BlockDto blockDto);
}
