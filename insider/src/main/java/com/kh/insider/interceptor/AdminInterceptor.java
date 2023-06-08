package com.kh.insider.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.insider.dto.MemberDto;
import com.kh.insider.repo.MemberRepo;

@Component
public class AdminInterceptor implements HandlerInterceptor {
	@Autowired
	private MemberRepo memberRepo;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Long memberNo = (Long) request.getSession().getAttribute("memberNo");
		MemberDto memberDto = memberRepo.findByNo(memberNo);
		if(memberDto != null && memberDto.getMemberLevel()==1) {
			return true;
		}
		else {
			request.getSession().removeAttribute("memberNo");
			request.getSession().removeAttribute("socialUser");
			request.getSession().removeAttribute("memberLevel");
			request.getSession().removeAttribute("memberNick");
			response.sendRedirect(request.getContextPath()+"/member/login");
			
			return false;
		}
		
	}
}
