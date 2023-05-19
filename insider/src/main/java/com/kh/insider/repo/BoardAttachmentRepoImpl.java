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

//	@Override
//	public void insert(BoardAttachmentDto boardAttachmentDto) {
//		int sequence = sqlSession.selectOne("board_attachment.sequence");
//		boardAttachmentDto.setBoardAttachmentNo(sequence);
//		
//		sqlSession.insert("board_attachment.insert", boardAttachmentDto);
//	}
	
//	@Override
//	public int boardAttachSeq() {
//		return sqlSession.selectOne("boardAttachment.boardAttachSeq");
//	}
	
	@Override
	public void insert(BoardAttachmentDto boardAttachmentDto) {
		int sequence = sqlSession.selectOne("board_attachment.sequence");
		boardAttachmentDto.setBoardAttachmentNo(sequence);
		sqlSession.insert("boardAttachment.insert", boardAttachmentDto);
	}

	@Override
	public List<BoardAttachmentDto> selectList(int boardNo) {
		return sqlSession.selectList("boardAttachment.list", boardNo);
	}

	@Override
	public void delete(int boardNo) {
		sqlSession.delete("board_attachment.delete", boardNo);
	}

}
