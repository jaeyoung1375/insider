package com.kh.insider.service;

import java.net.URISyntaxException;

import com.kh.insider.vo.FacebookProfileVO;
import com.kh.insider.vo.FacebookResponseVO;
import com.kh.insider.vo.GoogleProfileVO;
import com.kh.insider.vo.GoogleResponseVO;
import com.kh.insider.vo.KakaoProfileVO;
import com.kh.insider.vo.KakaoResponseVO;

public interface SocialLoginService {
	
	// 카카오 토큰 발급
	public KakaoResponseVO kakaoTokenCreate(String code) throws URISyntaxException;
	
	// 카카오 로그인
	public KakaoProfileVO kakaoLogin(String code, KakaoResponseVO oAuthToken) throws URISyntaxException;
	
	// 카카오 서비스 탈퇴
	public void kakaoDelete(long memberNo) throws URISyntaxException;
	
	// 구글 토큰 발급
	public GoogleResponseVO googleTokenCreate(String code) throws URISyntaxException;
	
	// 구글 로그인
	public GoogleProfileVO googleLogin(String code, GoogleResponseVO response) throws URISyntaxException;
	
	// 페이스북 토큰 발급
	public FacebookResponseVO facebookTokenCreate(String code) throws URISyntaxException;
	
	// 페이스북 로그인
	public FacebookProfileVO facebookLogin(String code, FacebookResponseVO response) throws URISyntaxException;
	
	// cosKey 암호화
	public String EncryptCoskey(String coskey);
}
