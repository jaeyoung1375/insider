package com.kh.insider.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.insider.dto.SettingDto;

@Repository
public class SettingRepoImpl implements SettingRepo{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public void basicInsert(SettingDto settingDto) {
		sqlSession.insert("setting.basicInsert", settingDto);
	}
	
}
