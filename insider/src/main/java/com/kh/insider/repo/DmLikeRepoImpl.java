package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.DmLikeDto;

@Repository
public class DmLikeRepoImpl implements DmLikeRepo{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int like(DmLikeDto dmLikeDto) {
		DmLikeDto checkDto = sqlSession.selectOne("dmLike.selectOne", dmLikeDto);
		if(checkDto==null) {
			sqlSession.insert("dmLike.insert", dmLikeDto);
		}
		else {
			sqlSession.delete("dmLike.delete", dmLikeDto);
		}
		return sqlSession.selectOne("dmLike.selectCount", dmLikeDto);
	}

}
