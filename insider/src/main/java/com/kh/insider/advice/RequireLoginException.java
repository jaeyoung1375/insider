package com.kh.insider.advice;

import javax.servlet.http.HttpServletRequest;

//401번 상황을 대체하기 위한 예외 클래스
public class RequireLoginException extends RuntimeException{
	private StringBuffer referer;
	//메세지 전달을 위해 생성자 생성
	public RequireLoginException(String message, StringBuffer referer) {
		super(message);
		this.referer = referer;
	}

	public StringBuffer getReferer() {
		return referer;
	}
}
