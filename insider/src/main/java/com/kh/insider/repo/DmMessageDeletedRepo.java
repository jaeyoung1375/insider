package com.kh.insider.repo;

import com.kh.insider.dto.DmMessageDeletedDto;

public interface DmMessageDeletedRepo {
	
	//삭제된 메세지 등록
	void insertDeleteMessage(DmMessageDeletedDto dmMessageDeletedDto);
	
}
