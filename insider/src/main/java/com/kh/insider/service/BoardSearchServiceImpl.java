package com.kh.insider.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.FollowDto;
import com.kh.insider.repo.BlockRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.vo.BoardSearchVO;

@Service
public class BoardSearchServiceImpl implements BoardSearchService{

	@Autowired
	private FollowRepo followRepo;
	@Autowired
	private BlockRepo blockRepo;
	
	@Override
	public BoardSearchVO getBoardSearchVO(long memberNo, int page) {
		List<FollowDto> followList = followRepo.selectList(memberNo);
		List<BlockDto> blockList = blockRepo.selectList(memberNo);
		BoardSearchVO boardSearchVO = new BoardSearchVO();
		boardSearchVO.setPage(page);
		boardSearchVO.setBlockDtoList(blockList);
		boardSearchVO.setFollowDtoList(followList);
		return boardSearchVO;
	}

}
