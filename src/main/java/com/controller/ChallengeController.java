package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dto.ChallengeDTO;
import com.service.ChallengeService;

@Controller
public class ChallengeController {
	@Autowired
	private ChallengeService service;
	
	/**
	 * 챌린지 메인 화면
	 */
	@RequestMapping(value = "/challenge")
	public String challengeMain() {
		List<ChallengeDTO> list = service.getList();
		System.out.println(list);
		return "main";
	}

}
