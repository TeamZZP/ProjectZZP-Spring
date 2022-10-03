package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dto.ProfileDTO;
import com.service.MemberService;
import com.service.MypageService;

@Controller
public class ProfileController {
	@Autowired
	private MypageService mService;
	
	@RequestMapping(value = "/profile/{userid}", method = RequestMethod.GET)
	public String profile(@PathVariable String userid) {
		//회원의 프로필 가져오기
		ProfileDTO profile = mService.selectProfile(userid);
		System.out.println(profile);
		return "";
	}
}
