package com.kh.insider.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.insider.configuration.FacebookLoginProperties;
import com.kh.insider.configuration.KakaoLoginProperties;
import com.kh.insider.vo.FacebookProfileVO;
import com.kh.insider.vo.FacebookResponseVO;
import com.kh.insider.vo.GoogleProfileVO;
import com.kh.insider.vo.GoogleRequestVO;
import com.kh.insider.vo.GoogleResponseVO;
import com.kh.insider.vo.KakaoProfileVO;
import com.kh.insider.vo.KakaoResponseVO;

@Service
public class SocialLoginServiceImpl implements SocialLoginService {
	
	@Autowired
	private KakaoLoginProperties properties;
	
	@Autowired
	private FacebookLoginProperties facebookProperties;

	@Override
	public KakaoResponseVO kakaoTokenCreate(String code) throws URISyntaxException {
		
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
		KakaoResponseVO oAuthToken = null;
		
		try {
			oAuthToken = mapper.readValue(response.getBody(),KakaoResponseVO.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return oAuthToken;
}

	@Override
	public KakaoProfileVO kakaoLogin(String code, KakaoResponseVO oAuthToken) throws URISyntaxException {

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
		KakaoProfileVO profile = null;
		
		try {
			profile = mapper2.readValue(response2.getBody(),KakaoProfileVO.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		if(profile.kakao_account.getGender().equals("male")) {
			profile.getKakao_account().setGender("0");
		}else {
			profile.getKakao_account().setGender("1");
		}
		
	
		
		return profile;
	}

	@Override
	public GoogleResponseVO googleTokenCreate(String code) throws URISyntaxException {
		
		RestTemplate rt = new RestTemplate();
		
		// HttpBody 오브젝트 생성
		GoogleRequestVO googleOAuthRequestParam = GoogleRequestVO
			                .builder()
			                .clientId("197694978566-bljc0eo7lnf071parv36ntrenp3g69eb.apps.googleusercontent.com")
			                .clientSecret("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")
			                .code(code)
			                .redirectUri("http://localhost:8080/member/login/oauth_google_check")
			                .grantType("authorization_code").build();
				 
				
				 
				
	ResponseEntity<GoogleResponseVO> resultEntity = 
			rt.postForEntity("https://oauth2.googleapis.com/token",
			     googleOAuthRequestParam, GoogleResponseVO.class);
		
	
	
	return resultEntity.getBody();
	}

	@Override
	public GoogleProfileVO googleLogin(String code, GoogleResponseVO response) throws URISyntaxException {
		
		RestTemplate rt = new RestTemplate();
		 String jwtToken=response.getId_token();
	        Map<String, String> map=new HashMap<>();
	        map.put("id_token",jwtToken);
	        ResponseEntity<GoogleProfileVO> resultEntity = rt.postForEntity("https://oauth2.googleapis.com/tokeninfo",
	                map, GoogleProfileVO.class);
		
		
		return resultEntity.getBody();
	}

	@Override
	public FacebookResponseVO facebookTokenCreate(String code) throws URISyntaxException {
		String url = "https://graph.facebook.com/v13.0/oauth/access_token";
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type","application/x-www-form-urlencoded");
		
		MultiValueMap<String,String> body = new LinkedMultiValueMap<String, String>();
		body.add("client_id",facebookProperties.getClient_id());
		body.add("client_secret",facebookProperties.getClient_secret());
		body.add("redirect_uri",facebookProperties.getRedirect_uri());
		body.add("code",code);
		
		HttpEntity<MultiValueMap<String,String>> request = new HttpEntity<>(body,headers);
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("client_id",facebookProperties.getClient_id())
				.queryParam("client_secret",facebookProperties.getClient_secret())
				.queryParam("redirect_uri",facebookProperties.getRedirect_uri())
				.queryParam("code",code);
		
		ResponseEntity<FacebookResponseVO> response = rt.exchange(builder.toUriString(),HttpMethod.POST,request,FacebookResponseVO.class);
		
		return response.getBody();
	}

	@Override
	public FacebookProfileVO facebookLogin(String code, FacebookResponseVO response) throws URISyntaxException {
		
		String url = "https://graph.facebook.com/v13.0/me";
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization","Bearer "+response.getAccess_token());
		headers.add("Content-type","application/x-www-form-urlencoded");
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("fields","id,email,gender,name,birthday")
				.queryParam("access_token",response.getAccess_token());
		
		ResponseEntity<String> response2 = rt.exchange(builder.toUriString(),HttpMethod.POST,request,String.class);

		ObjectMapper mapper = new ObjectMapper();
		FacebookProfileVO profile = null;
		
		try {
			profile = mapper.readValue(response2.getBody(),FacebookProfileVO.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		
		return profile;
		
	}
	
	

}
