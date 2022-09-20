package com.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MypageController {
	
	/**
	 * 마이페이지 메인
	 */
	@RequestMapping(value = "/mypage/{userid}", method = RequestMethod.GET)
	public String mypage(@PathVariable("userid") String userid) {
		//interceptor 인증 후
		System.out.println("마이페이지 메인 userid : "+userid);
		return "mypage";
	}
	/**
	 * 마이페이지 계정관리
	 */
	
}
