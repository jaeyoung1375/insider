package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.vo.SearchVO;

@Repository
public class BoardAttachmentRepoImpl implements BoardAttachmentRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public BoardAttachmentDto selectOne(int boardNo) {
		return sqlSession.selectOne("boardAttachment.selectOne", boardNo);
	}

	@Override
	public List<BoardAttachmentDto> selectList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return null;
	}

}
