package com.kh.insider.advice;

//403번 대신 사용할 예외 클래스
//-response.sendError(403) 대신 throw new RequiredPermissionException() 사용
//- 이렇게 해야 @ControllerAdvice에서 처리가 가능하기 때문
//- 예외 클래스가 되려면 Exception을 상속받아야 함
//- RuntimeException을 상속받으면 따로 예외 전가를 하지 않아도 됨
//- interceptor 클래스에서 throw new RequirePermissionException("관리자만 이용 가능합니다");
//에러 발생 이유 : 객체 관리를 위해 버전 관리가 요구됨
public class RequirePermissionException extends RuntimeException{
	//메세지 전달을 위해 생성자 생성
	public RequirePermissionException(String message) {
		super(message);
	}
	
}