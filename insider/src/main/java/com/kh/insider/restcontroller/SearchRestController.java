package com.kh.insider.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.insider.dto.SearchComplexDto;
import com.kh.insider.dto.SearchDto;
import com.kh.insider.dto.SearchWithProfileDto;
import com.kh.insider.repo.SearchRepo;

@RestController
@RequestMapping("/rest/search")
public class SearchRestController {
	
	@Autowired
	private SearchRepo searchRepo;
	
	//추천 검색 리스트 반환
	@GetMapping("/{searchInput}")
	public List<SearchComplexDto> recommandSearch(@PathVariable String searchInput){
		return searchRepo.selectRecommandList(searchInput);
	}
	//검색했던 기록 리스트
	@GetMapping("/searched")
	public List<SearchWithProfileDto> searchedList(HttpSession httpSession){
		long memberNo = (long)httpSession.getAttribute("memberNo");
		return searchRepo.selectSearchedList(memberNo);
	}
	//검색기록 추가
	@PostMapping("/")
	public void insert(@RequestBody SearchDto searchDto, HttpSession httpSession) {
		
		long memberNo = (long)httpSession.getAttribute("memberNo");
		searchDto.setMemberNo(memberNo);
		
		SearchDto searchedDto = searchRepo.selectOne(searchDto);
		//최초 검색이면 입력
		if(searchedDto==null) {
			searchRepo.insert(searchDto);
		}//기존에 기록이 있으면 삭제 기록 0으로 만들고 시간 수정
		else {
			searchRepo.updateTime(searchDto);
		}
	}
	//검색기록 삭제
	@PutMapping("/")
	public void delete(@RequestBody SearchDto searchDto, HttpSession httpSession) {
		long memberNo = (long)httpSession.getAttribute("memberNo");
		searchDto.setMemberNo(memberNo);
		searchRepo.delete(searchDto);
	}
}