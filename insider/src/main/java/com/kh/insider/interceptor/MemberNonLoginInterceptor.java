//package com.kh.insider.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//@Component
//public class MemberNonLoginInterceptor implements HandlerInterceptor {
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		String memberEmail = (String) request.getSession().getAttribute("memberEmail");
//		
//		if(memberEmail == null) {
//			response.sendRedirect(request.getContextPath()+"/member/login");
//			return false;
//		}
//		else {
//			return true;
//		}
//		
//	}
//}
