package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.ChallengeDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;
import com.service.ChallengeService;
import com.service.StoreService;

@Controller
public class MainController {
	
	@Autowired
	private ChallengeService cService;
	@Autowired
	private StoreService sService;
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/")
	public String main(Model model) {
		//배너 : 이달의 챌린지
		ChallengeDTO challThisMonth = cService.selectChallThisMonth();
		model.addAttribute("challThisMonth", challThisMonth.getChall_id());
		//베스트 상품 리스트
		PageDTO pDTO = new PageDTO();
		pDTO = sService.bestProduct();
		List<ProductByCategoryDTO> bestProdudctlist = pDTO.getList();
		//List<ProductByCategoryDTO> bestProdudctlist = sService.bestProduct();
		model.addAttribute("bestProdudctlist", bestProdudctlist);
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