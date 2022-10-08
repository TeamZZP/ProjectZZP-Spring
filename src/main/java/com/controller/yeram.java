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
	
	/**
	 * 마이페이지 내 챌린지
	 */
	@RequestMapping(value = "/mypage/{userid}/challenge", method = RequestMethod.GET)
	public String myChallenge(
			@PathVariable String userid, 
			@RequestParam HashMap<String, String> map,
			Model model,
			HttpSession session) {
		//회원의 챌린지 목록 가져오기
		map.put("userid", userid);
		PageDTO pDTO = chService.selectChallengeByUserid(map, 6);
		model.addAttribute("pDTO", pDTO);
		
		//회원이 좋아요 누른 게시글 가져오기
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		List<Integer> likedList = new ArrayList<Integer>();
		if (mDTO != null) {
			likedList = chService.selectLikedChall(mDTO.getUserid());
		}
		model.addAttribute("likedList", likedList);
		
		return "myChallenge";
	}
	/**
	 * 마이페이지 내 도장
	 */
	@RequestMapping(value = "/mypage/{userid}/stamp", method = RequestMethod.GET)
	public String myStamp(
			@PathVariable String userid, 
			@RequestParam HashMap<String, String> map,
			Model model) {
		//회원의 도장 목록 가져오기
		map.put("userid", userid);
		PageDTO pDTO = chService.selectMemberStampByUserid(map, 6);
		model.addAttribute("pDTO", pDTO);
		
		//전체 도장 개수
		int stampTotalNum = chService.countTotalStamp(map);
		model.addAttribute("stampTotalNum", stampTotalNum);
		
		return "myStamp";
	}
	
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
