package com.kh.insider.repo;

import java.util.List;

import com.kh.insider.vo.MemberStatsResponseVO;
import com.kh.insider.vo.MemberStatsSearchVO;

public interface MemberStatsRepo {
	List<MemberStatsResponseVO> selectList(MemberStatsSearchVO memberStatsSearchVO);
}
