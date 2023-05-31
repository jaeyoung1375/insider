package com.kh.insider.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmMemberInfoDto;

@Repository
public class DmMemberInfoRepoImpl implements DmMemberInfoRepo{
	
    @Autowired
    private SqlSession sqlSession;

    //특정 회원에 정보
	@Override
	public List<DmMemberInfoDto> dmMemberList(long memberNo) {
		return sqlSession.selectList("dmMemberInfo.dmMemberList", memberNo) ;
	}
	
}
