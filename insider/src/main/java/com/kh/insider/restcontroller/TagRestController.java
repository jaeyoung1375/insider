package com.kh.insider.restcontroller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.TagDto;
import com.kh.insider.dto.TagFollowDto;
import com.kh.insider.repo.BoardRepo;
import com.kh.insider.repo.TagFollowRepo;
import com.kh.insider.repo.TagRepo;
import com.kh.insider.service.BoardSearchService;
import com.kh.insider.service.ForbiddenService;
import com.kh.insider.vo.BoardListVO;
import com.kh.insider.vo.BoardSearchVO;

@RestController
@RequestMapping("/rest/tag")
public class TagRestController {
	@Autowired
	private TagRepo tagRepo;
	@Autowired
	private BoardRepo boardRepo;
	@Autowired
	private BoardSearchService boardSearchService;
	@Autowired
	private TagFollowRepo tagFollowRepo;
	@Autowired
	private ForbiddenService forbiddenService;
	
	//사용가능 태그 설정
	@PutMapping("/")
	public int changeAvailable(@RequestBody TagDto tagDto) {
		TagDto oldTagDto = tagRepo.selectOne(tagDto.getTagName());
		int available = oldTagDto.getTagAvailable();
		int newAvailable=0;
		if(available==0) {
			newAvailable=1;
		}
		tagDto.setTagAvailable(newAvailable);
		return tagRepo.updateAvailable(tagDto);
	}
	
	@GetMapping("/list/{tagName}")
	public List<BoardListVO> selectTagBoardList(@PathVariable String tagName, @RequestParam(required=false, defaultValue="1") int page, HttpSession session){
		long memberNo=(Long)session.getAttribute("memberNo");
		
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, page);
		boardSearchVO.setBoardCount(15);
		boardSearchVO.setTagName(tagName);
		return forbiddenService.changeForbiddenWords(boardRepo.selectListWithTag(boardSearchVO));
	}
	@GetMapping("/{tagName}")
	public Map<String, Integer> getHomeData(HttpSession session, @PathVariable String tagName){
		long memberNo=(Long)session.getAttribute("memberNo");
		BoardSearchVO boardSearchVO = boardSearchService.getBoardSearchVO(memberNo, 1);
		boardSearchVO.setTagName(tagName);
		int count = boardRepo.selectListWithTagCount(boardSearchVO);
		
		TagFollowDto tagFollowDto = new TagFollowDto();
		tagFollowDto.setMemberNo(memberNo);
		tagFollowDto.setTagName(tagName);
		TagFollowDto newDto = tagFollowRepo.selectOne(tagFollowDto);
		//팔로우 한 놈이면 1, 아니면 0 반환
		int follow = newDto==null? 0 : 1;
		Map<String, Integer> map = Map.of("count", count, "follow", follow);
		return map;
	}
	@PostMapping("/follow/{tagName}")
	public int tagFollow(HttpSession session, @PathVariable String tagName) {
		long memberNo=(Long)session.getAttribute("memberNo");
		TagFollowDto tagFollowDto = new TagFollowDto();
		tagFollowDto.setMemberNo(memberNo);
		tagFollowDto.setTagName(tagName);
		
		TagFollowDto newTagDto = tagFollowRepo.selectOne(tagFollowDto);
		//언팔 상태면 팔로우
		if(newTagDto==null) {
			tagFollowRepo.insert(tagFollowDto);
			tagRepo.updateFollow(tagFollowDto.getTagName());
			return 1;
		}
		//팔로우 상태면 언팔
		else {
			tagFollowRepo.delete(tagFollowDto);
			tagRepo.updateFollow(tagFollowDto.getTagName());
			return 0;
		}
		
	}
}
