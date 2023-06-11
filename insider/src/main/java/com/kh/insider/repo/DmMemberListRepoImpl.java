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

	//차단한 회원을 제외한 전체 회원 목록
	@Override
	public List<DmMemberListDto> dmMemberSearch(long memberNo,int roomNo, String keyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("keyword", keyword);
		param.put("memberNo", memberNo);
		param.put("roomNo", roomNo);
		return sqlSession.selectList("dmMemberList.dmMemberSearch", param);
	}

	@Override
	public List<DmMemberListDto> InvitechooseDm(long memberNo) {
		return sqlSession.selectList("dmMemberList.InvitechooseDm", memberNo);
	}

	@Override
	public List<DmMemberListDto> dmInviteMemberSearch(long memberNo, int roomNo, String keyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("keyword", keyword);
		param.put("memberNo", memberNo);
		param.put("roomNo", roomNo);
		return sqlSession.selectList("dmMemberList.dmInviteMemberSearch", param);
	}
	
}
