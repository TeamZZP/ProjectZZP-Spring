package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.ChallengeDTO;
import com.dto.MemberDTO;
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
	public String challengeMain(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		model.addAttribute("searchName", map.get("searchName"));
		model.addAttribute("searchValue", map.get("searchValue"));
		model.addAttribute("sortBy", map.get("sortBy"));
		
		//챌린지 전체 목록 가져오기
		PageDTO pDTO = service.selectAllChallenge(map);
		model.addAttribute("pDTO", pDTO);
		
		//현재 로그인한 회원이 좋아요 누른 게시글 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		List<Integer> likedList = new ArrayList<Integer>();
		if (mDTO != null) {
			likedList = service.selectLikedChall(mDTO.getUserid());
		}
		model.addAttribute("likedList", likedList);
		
		//이달의 챌린지 가져오기
		ChallengeDTO challThisMonth = service.selectChallThisMonth();
		model.addAttribute("challThisMonth", challThisMonth);
		
		return "challengeMain";
	}

}
