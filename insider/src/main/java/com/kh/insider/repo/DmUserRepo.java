package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.dto.DmUserDto;

public interface DmUserRepo {

	void enter(DmUserDto dmUserDto);
	
	List<DmUserDto> find(long memberNo);
	
	boolean check(DmUserDto dmUserDto);
	
	void invite(DmUserDto dmUserDto);
	
//	void exit(DmUserDto dmUserDto);
	
}
