package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.service.AdminService;
import com.service.ChallengeService;

@Controller
public class yeram {
	@Autowired
	private ChallengeService chService;
	@Autowired
	AdminService service;
	
	
	
	@RequestMapping(value = "/counter", method = RequestMethod.POST)
	@ResponseBody
	public void counter() {
		int n = service.countVisitToday(); //오늘 방문자수 구하기
		
		if (n == 0) { //해당 날짜의 첫 방문인 경우 counter 테이블에 insert
			service.addVisit();
		} else { //해당 날짜의 방문이 이미 있는 경우 counter 테이블에 update
			service.updateVisit();
		}
	}
	
}
