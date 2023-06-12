package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.BlockWithProfileDto;

public interface BlockRepo {
	void insert(BlockDto blockDto);
	List<BlockDto> selectList(long memberNo);
	List<BlockDto> selectListBlocked(long memberNo);
	BlockDto selectOne(BlockDto blockDto);
	
	//사용자가 차단한 리스트를 반환
	List<BlockWithProfileDto> getBlockList(long memberNo);
	//사용자가 차단 당한 리스트를 반환
	List<BlockWithProfileDto> getBlockedList(long memberNo);
	
	void delete(BlockDto blockDto);
}
