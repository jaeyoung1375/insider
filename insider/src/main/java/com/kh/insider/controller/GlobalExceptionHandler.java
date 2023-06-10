package com.kh.insider.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	  @ExceptionHandler(Exception.class)
	    public ModelAndView handleException(Exception ex) {
	        ModelAndView modelAndView = new ModelAndView();
	        modelAndView.setViewName("error/socialError"); // socialError.jsp 파일의 경로와 이름
	        // 예외 처리에 필요한 추가적인 로직을 수행할 수 있습니다.
	        return modelAndView;
	    }
}
