package com.kh.insider.advice;

import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice//프로젝트 전체에 대한 catch블록
public class ErrorController {
	
	//404 에러 익셉션
	@ExceptionHandler(NoHandlerFoundException.class)
	public String notFound(Exception ex) {	//model을 설정해서 쓸 수 있다
		return "error/default";
	}
	
	//403 에러 익셉션
	@ExceptionHandler(RequirePermissionException.class)
	public String forbidden(Exception ex) {
		return "error/default";
	}

	//401
	@ExceptionHandler(RequireLoginException.class)
	public String unAuthorized(RequireLoginException ex) {
		return "error/default";
	}
	
	@ExceptionHandler(MissingServletRequestParameterException.class)
	public String badParameter(Exception ex) {
		return "error/default";
	}
	@ExceptionHandler(Exception.class)
	public String notParameter(Exception ex) {
		return "error/default";
	}
}