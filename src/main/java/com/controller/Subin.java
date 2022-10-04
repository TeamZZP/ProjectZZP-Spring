package com.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.ProfileDTO;
import com.service.MypageService;

@Controller
public class Subin {
	
	@Autowired
	private MypageService service;
	/**
	 * 마이페이지 프로필 가지고 메인
	 */
	@RequestMapping(value = "/subin/mypage")
	@ResponseBody
	public ModelAndView selectProfile(@PathVariable("userid") String userid) {
		System.out.println(userid+"의 프로필 데이터");
		ProfileDTO profile=service.selectProfile(userid);
		System.out.println("프로필 >>> "+profile);
		
		int myReview=service.countReview(userid);
		int myCoupon=service.countCoupon(userid);
		int myStamp=service.countStamp(userid);
		int myChallenge=service.countChallenge(userid);
		
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("myReview", myReview);
		map.put("myCoupon", myCoupon);
		map.put("myStamp", myStamp);
		map.put("myChallenge", myChallenge);

		ModelAndView mav=new ModelAndView();
		mav.addObject("profile", profile);
		mav.addObject("map", map);
		mav.setViewName("mypage");//mypage.jsp 요청
		return mav;
	}
	/**
	 * 마이페이지 프로필 수정
	 */
	@RequestMapping(value = "/subin/profile")
	public String memberProfile() {
		System.out.println("프로필 수정");
		return "";
	}
}