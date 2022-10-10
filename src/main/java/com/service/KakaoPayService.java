package com.service;

import java.util.HashMap;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.dto.KakaoPayApprovalVO;
import com.dto.KakaoPayReadyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaoPayService {
private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVO;
    
    public String payReady(HashMap<String, String> map) {
        //서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "adc850c002bad821890c76596cf517ab");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        //서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "zzp2022");
        params.add("partner_user_id", "zzp");
        params.add("item_name", map.get("item_name"));
        params.add("quantity", map.get("quantity"));
        params.add("total_amount", map.get("total_amount"));
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:8102/zzp/pay/kakao/success");
        params.add("cancel_url", "http://localhost:8102/zzp/pay/kakao/cancel");
        params.add("fail_url", "http://localhost:8102/zzp/pay/kakao/fail");
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        //외부 url 통신
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/ready";
        
        kakaoPayReadyVO = restTemplate.postForObject(url, entity, KakaoPayReadyVO.class);
        log.info("카카오 결제 준비: " + kakaoPayReadyVO);
            
        return kakaoPayReadyVO.getNext_redirect_pc_url();
    }
    
    public KakaoPayApprovalVO payApprove(String pg_token) {
        //서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "adc850c002bad821890c76596cf517ab");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        //서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "zzp2022");
        params.add("partner_user_id", "zzp");
        params.add("pg_token", pg_token);
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        //외부 url 통신
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/approve";
        
        kakaoPayApprovalVO = restTemplate.postForObject(url, entity, KakaoPayApprovalVO.class);
        log.info("카카오 결제 승인: " + kakaoPayApprovalVO);
          
        return kakaoPayApprovalVO;
    }
    
}
