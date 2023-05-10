package com.kh.insider.service;

import java.net.URISyntaxException;

import com.kh.insider.vo.GoogleInfoResponse;
import com.kh.insider.vo.GoogleResponse;
import com.kh.insider.vo.KakaoProfile;
import com.kh.insider.vo.OAuthToken;

public interface SocialLoginService {
	
	// 카카오 토큰 발급
	public OAuthToken kakaoTokenCreate(String code) throws URISyntaxException;
	
	// 카카오 로그인
	public KakaoProfile kakaoLogin(String code, OAuthToken oAuthToken) throws URISyntaxException;
	
	// 구글 토큰 발급
	public GoogleResponse googleTokenCreate(String code) throws URISyntaxException;
	
	// 구글 로그인
	public GoogleInfoResponse googleLogin(String code, GoogleResponse response) throws URISyntaxException;
}
