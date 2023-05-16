package com.kh.insider.service;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.BoardAttachmentDto;
import com.kh.insider.dto.BoardDto;
import com.kh.insider.repo.AttachmentRepo;
import com.kh.insider.repo.BoardAttachmentRepo;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.vo.BoardAttachVO;
import com.kh.insider.vo.PaginationVO;

@Service
public class BoardAttachServiceImpl implements BoardAttachService{

//	@Autowired
//	private SqlSession sqlSession;
//	@Autowired
//	private BoardAttachmentRepo boardAttachmentRepo;
//	
//
//	@Override
//	public void insert(BoardAttachVO vo) {
//		boardAttachmentRepo.insert(vo);
//	}
//
//	@Override
//	public List<BoardAttachVO> selectList(PaginationVO paging) {
//		return boardAttachmentRepo.selectList(paging);
//	}
//
//	@Override
//	public BoardAttachVO selectOne(int boardNo) {
//		return boardAttachmentRepo.selectOne(boardNo);
//	}
//
//	@Override
//	public void delete(int boardNo) {
//		boardAttachmentRepo.delete(boardNo);
//	}

}
