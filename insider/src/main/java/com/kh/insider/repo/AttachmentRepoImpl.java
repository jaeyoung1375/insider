package com.kh.insider.repo;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.insider.dto.AttachmentDto;

@Repository
public class AttachmentRepoImpl implements AttachmentRepo{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void upload(@RequestParam MultipartFile attachment) throws IllegalStateException, IOException {
		sqlSession.insert("attachment.insert", attachment);
	}

	@Override
	public List<AttachmentDto> selectList() {
		return sqlSession.selectList("attachment.selectList");
	}


}
