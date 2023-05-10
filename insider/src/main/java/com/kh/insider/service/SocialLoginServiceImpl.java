package com.kh.insider.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.configuration.KakaoLoginProperties;
import com.kh.insider.vo.KakaoProfile;
import com.kh.insider.vo.OAuthToken;

@Service
public class SocialLoginServiceImpl implements SocialLoginService {
	
	@Autowired
	private KakaoLoginProperties properties;

	@Override
	public OAuthToken tokenCreate(String code) throws URISyntaxException {
		
		URI uri = new URI("https://kauth.kakao.com/oauth/token");
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// HttpBody 생성
		MultiValueMap<String,String> body = new LinkedMultiValueMap<String, String>();
		body.add("grant_type",properties.getGrantType());
		body.add("client_id", properties.getClientId());
		body.add("redirect_uri",properties.getRedirectUri());
		body.add("code", code);
		
		// Header + Body를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body,headers);
		
		// Http 요청 전송하기
		ResponseEntity<String> response = rt.exchange(uri,HttpMethod.POST,request,String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		OAuthToken oAuthToken = null;
		
		try {
			oAuthToken = mapper.readValue(response.getBody(),OAuthToken.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return oAuthToken;
}

	@Override
	public KakaoProfile kakaoLogin(String code, OAuthToken oAuthToken) throws URISyntaxException {

		URI uri2 = new URI("https://kapi.kakao.com/v2/user/me");
		RestTemplate rt2 = new RestTemplate();
		
		// 헤더 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization","Bearer "+oAuthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// Header + Body를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> request2 = new HttpEntity<>(headers2);
		
		ResponseEntity<String> response2 = rt2.exchange(uri2, HttpMethod.POST,request2,String.class);
		
		ObjectMapper mapper2 = new ObjectMapper();
		KakaoProfile profile = null;
		
		try {
			profile = mapper2.readValue(response2.getBody(),KakaoProfile.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		if(profile.getKakao_account().getGender().equals("male")) {
			profile.getKakao_account().setGender("0");
		}else {
			profile.getKakao_account().setGender("1");
		}
		
	
		
		return profile;
	}
	
	

}
