package com.kh.insider.service;

import java.net.URISyntaxException;

import com.kh.insider.vo.KakaoProfile;
import com.kh.insider.vo.OAuthToken;

public interface SocialLoginService {
	
	// 토큰 발급
	public OAuthToken tokenCreate(String code) throws URISyntaxException;
	
	// 카카오 로그인
	public KakaoProfile kakaoLogin(String code, OAuthToken oAuthToken) throws URISyntaxException;
}
