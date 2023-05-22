package com.kh.insider.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMemberListDto;

@Repository
public class DmMemberListRepoImpl implements DmMemberListRepo{
	
	@Autowired
	private SqlSession sqlSession;

	//팔로워 회원 목록
	@Override
	public List<DmMemberListDto> chooseDm(long memberNo) {
		return sqlSession.selectList("dmMemberList.chooseDm", memberNo);
	}
	
}
