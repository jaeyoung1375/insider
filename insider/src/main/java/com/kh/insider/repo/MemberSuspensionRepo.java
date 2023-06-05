package com.kh.insider.repo;

import com.kh.insider.dto.MemberSuspensionDto;
import com.kh.insider.vo.UpdateReportContentVO;

public interface MemberSuspensionRepo {
	void insert(MemberSuspensionDto memberSuspensionDto);
	MemberSuspensionDto selectOne(long memberNo);
	void removeSuspension(long memberNo);
	void addSuspension(MemberSuspensionDto memberSuspensionDto);
	//리포트 컨텐트 수정시 내용 변경
	void updateReportContent(UpdateReportContentVO updateReportContentVo);
}
