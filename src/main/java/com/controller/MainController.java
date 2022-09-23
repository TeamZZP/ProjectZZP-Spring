package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dto.ChallengeDTO;
import com.service.ChallengeService;

@Controller
public class MainController {
	
	@Autowired
	ChallengeService cService;
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/")
	public String main(Model model) {
		//배너 : 이달의 챌린지
		ChallengeDTO challThisMonth = cService.selectChallThisMonth();
		model.addAttribute("challThisMonth", challThisMonth.getChall_id());
		//베스트 상품 리스트
		
		//뉴 챌린지 리스트
		List<ChallengeDTO> callenge_list = cService.selectNewChallenge();
		model.addAttribute("callenge_list", callenge_list);
		return "main";
	}
	/**
	 * 메인 화면 redirect
	 */
	@RequestMapping(value = "/home")
	public String mainRedirect() {
		return "redirect:/";
	}
	
}