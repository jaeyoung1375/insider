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
	public void baseInsert(SettingDto settingDto) {
		sqlSession.insert("setting.baseInsert", settingDto);
	}
	
}
