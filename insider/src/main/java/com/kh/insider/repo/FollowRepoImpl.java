package com.kh.insider.repo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.FollowDto;
import com.kh.insider.dto.FollowWithProfileDto;
import com.kh.insider.dto.FollowerWithProfileDto;

@Repository
public class FollowRepoImpl implements FollowRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FollowDto followDto) {
		sqlSession.insert("follow.insert", followDto);
	}
	
	@Override
	public List<FollowWithProfileDto> getFollowList(long memberNo) {
		return sqlSession.selectList("follow.getFollowList", memberNo);
	}
	
	// 팔로우 목록 무한스크롤
	@Override
	public List<FollowWithProfileDto> getFollowListPaging(int page, long memberNo) {
		int end = page * 6;
		int begin = end-9;
		Map param = Map.of("begin",begin, "end",end, "memberNo",memberNo);
			
		return sqlSession.selectList("follow.getFollowListPaging",param);
	}
	
	// 팔로우 목록 무한스크롤
		@Override
		public List<FollowWithProfileDto> getFollowerListPaging(int page, long memberNo) {
			int end = page * 6;
			int begin = end-9;
			Map param = Map.of("begin",begin, "end",end, "memberNo",memberNo);
				
			return sqlSession.selectList("follow.getFollowerListPaging",param);
		}
		
	
	@Override
	public List<FollowerWithProfileDto> getFollowerList(long memberNo) {
		return sqlSession.selectList("follow.getFollowerList", memberNo);
	}

	@Override
	public void changeAllow(FollowDto followDto) {
		sqlSession.update("follow.changeAllow", followDto);
	}

	@Override
	public void delete(FollowDto followDto) {
		sqlSession.delete("follow.delete", followDto);
	}

	@Override
	public int getFollowerNumber(long memberNo) {
		return sqlSession.selectOne("follow.followerNumber", memberNo);
	}

	@Override
	public int getFollowNumber(long memberNo) {
		return sqlSession.selectOne("follow.followNumber", memberNo);
	}

	@Override
	public List<FollowDto> selectList(long memberNo) {
		return sqlSession.selectList("follow.selectList", memberNo);
	}

	@Override
	public FollowDto selectOne(FollowDto followDto) {
		return sqlSession.selectOne("follow.selectOne", followDto);
	}

	@Override
	public List<Long> checkFollow(long memberNo) {
		return sqlSession.selectList("follow.getFollowNo",memberNo);
	}

	@Override
	public List<Long> checkFollower(long memberNo) {
		return sqlSession.selectList("follow.getFollowerNo",memberNo);
	}






}
