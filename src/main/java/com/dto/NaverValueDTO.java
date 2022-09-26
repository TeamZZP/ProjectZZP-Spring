package com.dto;

import com.auth.NaverUrls;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NaverValueDTO implements NaverUrls {
	
	private String service;
	private String clientId;
	private String clientSecret;
	private String redirectUrl;
	
}
