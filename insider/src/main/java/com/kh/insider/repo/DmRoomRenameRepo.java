package com.kh.insider.repo;

import com.kh.insider.dto.DmRoomRenameDto;

public interface DmRoomRenameRepo {
	
	int sequence();
	
	//채팅방 이름 변경 등록
	void RenameInsert(DmRoomRenameDto dmRoomRenameDto);
	
	void updateRoomRename(DmRoomRenameDto dmRoomRenameDto);
	
	//변경된 이름의 채팅방 번호 확인
	boolean existsByRoomNo(int roomNo);

}
