package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.BoardAttachmentDto;

@Repository
public class BoardAttachmentRepoImpl implements BoardAttachmentRepo{

	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public void insert(BoardAttachmentDto boardAttachmentDto) {
		int sequence = sqlSession.selectOne("boardAttachment.sequence");
		boardAttachmentDto.setBoardAttachmentNo(sequence);
		sqlSession.insert("boardAttachment.insert", boardAttachmentDto);
	}

	@Override
	public void delete(int boardNo) {
		sqlSession.delete("board_attachment.delete", boardNo);
	}


	@Override
	public List<BoardAttachmentDto> selectList(int boardNo) {
		return sqlSession.selectList("boardAttach.list", boardNo);
	}

}
