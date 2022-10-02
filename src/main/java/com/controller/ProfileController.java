package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dto.ProfileDTO;
import com.service.MemberService;

@Controller
public class ProfileController {
	
	private MemberService mService;
	//private MemberService mService;
	
//	@RequestMapping(value = "/profile/{userid}", method = RequestMethod.GET)
//	public String profile(@PathVariable String userid) {
//		//회원의 프로필 가져오기
//		//ProfileDTO profile = service.selectProfile(userid);
//		
//		
//	}
}
