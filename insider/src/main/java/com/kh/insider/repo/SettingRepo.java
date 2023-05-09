package com.kh.insider.repo;

import com.kh.insider.dto.SettingDto;

public interface SettingRepo {
	//기본설정 생성
	void basicInsert(SettingDto settingDto);
}
