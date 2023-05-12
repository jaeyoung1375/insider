package com.kh.insider.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "facebook")
public class FacebookLoginProperties {
	private String client_id;
	private String client_secret;
	private String redirect_uri;

}
