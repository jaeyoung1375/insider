package com.kh.insider.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.insider.repo.ForbiddenRepo;
import com.kh.insider.vo.BoardListVO;

@Service
public class ForbiddenServiceImpl implements ForbiddenService{

	@Autowired
	private ForbiddenRepo forbiddenRepo;

	@Override
	public String getForbiddenRegex() {
		List<String> forbiddenWords = forbiddenRepo.selectList("");
		StringBuffer sb = new StringBuffer();
		sb.append("(.?)(");
		for(int i=0; i<forbiddenWords.size(); i++) {
			sb.append(forbiddenWords.get(i));
			if(i<forbiddenWords.size()-1) {
				sb.append("|");
			}
		}
		sb.append(")(.?)");
		return sb.toString();
	}

	@Override
	public List<BoardListVO> changeForbiddenWords(List<BoardListVO> boardList) {
		String regex = this.getForbiddenRegex();
		for(BoardListVO board : boardList) {
			String oldString = board.getBoardWithNickDto().getBoardContent();
			String newString = oldString.replaceAll(regex, "###");
			board.getBoardWithNickDto().setBoardContent(newString);
		}
		return boardList;
	}
}
