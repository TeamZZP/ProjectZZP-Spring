package com.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.ChallengeDTO;
import com.dto.PageDTO;
import com.service.ChallengeService;

@Controller
public class ChallengeController {
	@Autowired
	private ChallengeService service;
	
	/**
	 * 챌린지 메인 화면
	 */
	@RequestMapping(value = "/challenge")
	public String challengeMain(@RequestParam HashMap<String, String> map, Model model) {
		PageDTO pDTO = service.selectAllChallenge(map);
		model.addAttribute("pDTO", pDTO);
		return "challengeMain";
	}

}
