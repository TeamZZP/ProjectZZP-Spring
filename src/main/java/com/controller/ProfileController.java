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

import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProfileDTO;
import com.dto.ReviewProductImagesDTO;
import com.service.ChallengeService;
import com.service.MypageService;
import com.service.ReviewService;

@Controller
public class ProfileController {
	@Autowired
	private MypageService mService;
	@Autowired
	private ReviewService rService;
	@Autowired
	private ChallengeService cService;
	
	/**
	 * 프로필 페이지 메인
	 */
	@RequestMapping(value = "/profile/{userid}", method = RequestMethod.GET)
	public String profile(@PathVariable String userid, Model model) {
		//회원의 프로필 가져오기
		ProfileDTO profile = mService.selectProfile(userid);
		model.addAttribute("profile", profile);

		//회원의 리뷰 가져오기
		HashMap<String, String> map = new HashMap<String, String>();
		PageDTO rPDTO = rService.myReview(userid, map);
		if (rPDTO!=null && rPDTO.getList().size()>4) {
			rPDTO.setList(new ArrayList<ReviewProductImagesDTO>(rPDTO.getList().subList(0, 4)));
		}
		model.addAttribute("rPDTO", rPDTO);
		
		//회원의 챌린지 목록 가져오기
		map.put("userid", userid);
		PageDTO cPDTO = cService.selectChallengeByUserid(map, 4);
		model.addAttribute("cPDTO", cPDTO);
		
		//회원의 도장 목록 가져오기
		PageDTO sPDTO = cService.selectMemberStampByUserid(map, 4);
		model.addAttribute("sPDTO", sPDTO);
		//전체 도장 개수
		int stampTotalNum = cService.countTotalStamp(map);
		model.addAttribute("stampTotalNum", stampTotalNum);
		
		return "profileMain";
	}
	/**
	 * 프로필 페이지 카테고리
	 */
	@RequestMapping(value = {"/profile/{userid}/{category}"}, method = RequestMethod.GET)
	public String profile(
			@PathVariable String userid, @PathVariable String category, 
			@RequestParam HashMap<String, String> map,
			Model model, 
			HttpSession session) {
		String url = null;
		map.put("userid", userid);
		model.addAttribute("userid", userid);
		
		if (category.contains("review")) {
			//회원의 리뷰 가져오기
			PageDTO pDTO = rService.myReview(userid, map);
			model.addAttribute("pDTO", pDTO);
			url = "profile/profileReview";
			
			if (category.equals("scrollreview")) {
				url = "profile/scrollreview";
			}
			
		} else if (category.contains("challenge")) {
			//회원의 챌린지 목록 가져오기
			PageDTO pDTO = cService.selectChallengeByUserid(map, 6);
			model.addAttribute("pDTO", pDTO);
			
			//현재 로그인한 회원이 좋아요 누른 게시글 가져오기
			MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
			List<Integer> likedList = new ArrayList<Integer>();
			if (mDTO != null) {
				likedList = cService.selectLikedChall(mDTO.getUserid());
			}
			model.addAttribute("likedList", likedList);
			
			url = "profile/profileChallenge";
			
			if (category.equals("scrollchallenge")) {
				url = "profile/scrollchallenge";
			}
			
		} else if (category.contains("stamp")) {
			//회원의 도장 목록 가져오기
			PageDTO pDTO = cService.selectMemberStampByUserid(map, 6);
			model.addAttribute("pDTO", pDTO);
			
			//전체 도장 개수
			int stampTotalNum = cService.countTotalStamp(map);
			model.addAttribute("stampTotalNum", stampTotalNum);
			
			url = "profile/profileStamp";
			
			if (category.equals("scrollstamp")) {
				url = "profile/scrollstamp";
			}
		}
		
		return url;
	}
}
