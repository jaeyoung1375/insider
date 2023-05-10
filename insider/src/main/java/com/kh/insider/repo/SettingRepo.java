package com.kh.insider.repo;

import com.kh.insider.dto.SettingDto;

public interface SettingRepo {
	//기본설정 생성
	void basicInsert(long memberNo);
	//수정
	void update(SettingDto settingDto);
	//정보 읽기
	SettingDto selectOne(int memberNo);
}
