package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.BlockWithProfileDto;

@Repository
public class BlockRepoImpl implements BlockRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(BlockDto blockDto) {
		sqlSession.insert("block.insert", blockDto);
	}

	@Override
	public List<BlockDto> selectList(long memberNo) {
		return sqlSession.selectList("block.selectList", memberNo);
	}

	@Override
	public List<BlockDto> selectListBlocked(long memberNo) {
		return sqlSession.selectList("block.selectListBlocked", memberNo);
	}

	@Override
	public void delete(BlockDto blockDto) {
		sqlSession.delete("block.delete", blockDto);
	}

	@Override
	public BlockDto selectOne(BlockDto blockDto) {
		return sqlSession.selectOne("block.selectOne", blockDto);
	}

	@Override
	public List<BlockWithProfileDto> getBlockList(long memberNo) {
		return sqlSession.selectList("block.getBlockList", memberNo);
	}

	@Override
	public List<BlockWithProfileDto> getBlockedList(long memberNo) {
		return sqlSession.selectList("block.getBlockedList", memberNo);
	}

}
