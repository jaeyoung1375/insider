package com.kh.insider.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.repo.TagRepo;
import com.kh.insider.vo.AdminBoardSearchVO;
import com.kh.insider.vo.AdminTagResponseVO;
import com.kh.insider.vo.PaginationVO;

@RestController
@RequestMapping("/rest/tag")
public class TagRestController {
	@Autowired
	private TagRepo tagRepo;
	
	@GetMapping("/")
	public AdminTagResponseVO selectTagList(@ModelAttribute AdminBoardSearchVO vo) {
		//정렬 리스트 trim
		vo.refreshTagOrderList();
		//전체 게시물 수 반환
		int count = tagRepo.tagCountListCount(vo);
		vo.setTagCount(count);
		AdminTagResponseVO responseVO = new AdminTagResponseVO();
		responseVO.setTagList(tagRepo.tagCountList(vo));
		
		PaginationVO paginationVO = new PaginationVO();
		paginationVO.setCount(count);
		paginationVO.setPage(vo.getPage());
		
		responseVO.setPaginationVO(paginationVO);
		return responseVO;
	}
}
