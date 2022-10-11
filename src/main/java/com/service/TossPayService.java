package com.service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.dto.KakaoPayReadyVO;
import com.dto.TossPayApprovalVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TossPayService {
	private TossPayApprovalVO tossPayApprovalVO;

	public String payApprove(@RequestParam HashMap<String, String> map) {
		System.out.println(map);
		//서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        String testSecretApiKey = "test_sk_O6BYq7GWPVvjLaxWpbwVNE5vbo1d"+":";
        String encodedAuth = new String(Base64.getEncoder().encode(testSecretApiKey.getBytes(StandardCharsets.UTF_8)));
        headers.add("Authorization", "Basic "+encodedAuth);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        //서버로 요청할 Body
        JSONObject params = new JSONObject();
        params.put("orderId", map.get("orderId"));
        params.put("amount", Long.parseLong(map.get("amount")));
        params.put("paymentKey", map.get("paymentKey"));
        
        //외부 url 통신
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://api.tosspayments.com/v1/payments/confirm";
        
        //tossPayApprovalVO = restTemplate.postForObject(url, entity, TossPayApprovalVO.class);
        //log.info("토스 결제 승인: " + tossPayApprovalVO);
            
        //return tossPayApprovalVO;
        
        return restTemplate.postForEntity(url, new HttpEntity<>(params, headers), String.class).getBody();
	}
}
