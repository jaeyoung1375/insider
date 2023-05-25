package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.MemberSuspensionDto;

@Repository
public class MemberSuspensionRepoImpl implements MemberSuspensionRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(MemberSuspensionDto memberSuspensionDto) {
		sqlSession.insert("memberSuspension.insert",  memberSuspensionDto);
	}

	@Override
	public MemberSuspensionDto selectOne(long memberNo) {
		return sqlSession.selectOne("memberSuspension.selectOne", memberNo);
	}

	@Override
	public void removeSuspension(long memberNo) {
		sqlSession.update("memberSuspension.removeSuspension", memberNo);
	}

	@Override
	public void addSuspension(MemberSuspensionDto memberSuspensionDto) {
		sqlSession.update("memberSuspension.addSuspension",  memberSuspensionDto);
	}
}
