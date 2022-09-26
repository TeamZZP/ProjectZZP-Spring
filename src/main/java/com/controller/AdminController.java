package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.ChallengeService;
import com.service.MemberService;
import com.service.StoreService;

@Controller
public class AdminController {
	
	@Autowired
	private ChallengeService cService;
	@Autowired
	private StoreService sService;
	@Autowired
	private MemberService mService;
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/admin")
	public String admin() {
		return "adminMain";
	}
	
	
}