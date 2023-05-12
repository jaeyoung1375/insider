//package com.kh.insider.configuration;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import com.kh.insider.interceptor.MemberNonLoginInterceptor;
//
//@Configuration
//public class InterceptorConfiguration implements WebMvcConfigurer {
//	@Autowired
//	private MemberNonLoginInterceptor memberNonLoginInterceptor;
//	
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		
//		// 1. MemberNonLoginInterceptor
//		registry.addInterceptor(memberNonLoginInterceptor)
//				.addPathPatterns(
//						"/**"
//						)
//				.excludePathPatterns(
//						"/member/login",
//						"/member/join",
//						"/member/addInfo",
//						"/static/**"
//						);
//	
//	}
//}
