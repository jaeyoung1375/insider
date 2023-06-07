package com.kh.insider.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.insider.dto.BlockDto;
import com.kh.insider.dto.FollowDto;
import com.kh.insider.dto.MemberDto;
import com.kh.insider.dto.SettingDto;
import com.kh.insider.repo.BlockRepo;
import com.kh.insider.repo.FollowRepo;
import com.kh.insider.repo.MemberRepo;
import com.kh.insider.repo.SettingRepo;
import com.kh.insider.repo.TagFollowRepo;
import com.kh.insider.vo.BoardSearchVO;

@Service
public class BoardSearchServiceImpl implements BoardSearchService{

	@Autowired
	private FollowRepo followRepo;
	@Autowired
	private BlockRepo blockRepo;
	@Autowired
	private TagFollowRepo tagFollowRepo;
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private SettingRepo settingRepo;
	
	@Override
	public BoardSearchVO getBoardSearchVO(long memberNo, int page) {
		List<FollowDto> followList = followRepo.selectList(memberNo);
		List<BlockDto> blockList = blockRepo.selectList(memberNo);
		List<String> tagList = tagFollowRepo.selectFollowTagList(memberNo);
		BoardSearchVO boardSearchVO = new BoardSearchVO();
		boardSearchVO.setPage(page);
		boardSearchVO.setBlockDtoList(blockList);
		boardSearchVO.setFollowDtoList(followList);
		boardSearchVO.setTagList(tagList);
		return boardSearchVO;
	}

	@Override
	public BoardSearchVO getBoardSearchVOWithDistance(long memberNo, int page) {
		List<FollowDto> followList = followRepo.selectList(memberNo);
		List<BlockDto> blockList = blockRepo.selectList(memberNo);
		List<String> tagList = tagFollowRepo.selectFollowTagList(memberNo);
		SettingDto settingDto = settingRepo.selectOne(memberNo);
		MemberDto memberDto = memberRepo.findByNo(memberNo);
		BoardSearchVO boardSearchVO = new BoardSearchVO();
		boardSearchVO.setPage(page);
		boardSearchVO.setBlockDtoList(blockList);
		boardSearchVO.setFollowDtoList(followList);
		boardSearchVO.setTagList(tagList);
		boardSearchVO.setSettingDistance(settingDto.getSettingDistance());
		boardSearchVO.setMemberLat(memberDto.getMemberLat());
		boardSearchVO.setMemberLon(memberDto.getMemberLon());
		return boardSearchVO;
	}

}
