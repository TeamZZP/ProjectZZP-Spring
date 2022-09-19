package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	/**
	 * 로그인
	 */
	@RequestMapping(value = "/login")
	public void login() {
		
	}

}
