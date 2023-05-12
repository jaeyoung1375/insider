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
		String memberEmail = (String) request.getSession().getAttribute("memberEmail");
		MemberDto dto = (MemberDto) request.getSession().getAttribute("socialUser");
		
		if(memberEmail == null || dto == null) {
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
		else {
			return true;
		}
		
	}
}
