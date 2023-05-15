package com.kh.insider.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.insider.dto.MemberDto;

@Component
public class MemberNonLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Long memberNo = (Long) request.getSession().getAttribute("memberNo");
		MemberDto dto = (MemberDto) request.getSession().getAttribute("socialUser");
		System.out.println("memberNo : "+memberNo);
		System.out.println("dto : " + dto);
		
		if(memberNo == null || dto == null) {
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
		else {
			return true;
		}
		
	}
}
