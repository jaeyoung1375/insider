package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.ReplyDto;
import com.kh.insider.vo.UpdateReportContentVO;

@Repository
public class ReplyRepoImpl implements ReplyRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ReplyDto replydto) {
		sqlSession.insert("reply.insert",replydto);
	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin) {
		return sqlSession.selectList("reply.selectList", replyOrigin);
	}
	
	@Override
	public boolean delete(int replyNo) {
		return sqlSession.delete("reply.delete",replyNo) > 0;
	}
	

	@Override
	public ReplyDto selectOne(int replyNo) {
		return sqlSession.selectOne("reply.selectOne",replyNo);
	}

	@Override
	public void updateLikeCount(int replyNo,int count) {
		Map<String, Object> param = new HashMap<>();
		param.put("replyNo", replyNo);
		param.put("count", count);
		sqlSession.update("reply.updateLikeCount",param);
	}

	@Override
	public void addReport(int replyNo) {
		sqlSession.update("reply.addReport", replyNo);
	}

	@Override
	public List<ReplyDto> selectListReported(long memberNo) {
		return sqlSession.selectList("reply.selectListReported", memberNo);
	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin, long memberNo) {
		Map<String, Long> map = Map.of("replyOrigin", (long)replyOrigin, "memberNo", memberNo);
		return sqlSession.selectList("reply.selectList", map);
	}

	
}
