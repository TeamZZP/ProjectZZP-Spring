package com.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.PageDTO;
import com.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/admin")
	public String admin() {
		return "adminMain";
	}
	/**
	 * 카테고리
	 */
	@RequestMapping(value = "/admin/{category}")
	public String adminCategory(@PathVariable("category")String category, @RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println("adminCategory category: "+category);
		System.out.println("adminCategory map: "+map);
		
		model.addAttribute("searchName", map.get("searchName"));
		model.addAttribute("searchValue", map.get("searchValue"));
		model.addAttribute("sortBy", map.get("sortBy"));
		
		String url = null;
		PageDTO pDTO = null;
		
		//전체 회원 목록
		if (category.equals("member")) {
			//카테고리 선택하여 회원관리 페이지 이동--처음에는 검색, 정렬 조건 다 null
			pDTO=service.selectAllMember(map);
			System.out.println("member pDTO : "+pDTO);
			
			model.addAttribute("category", "member");
			url = "adminMember";
		} 
		//전체 상품 목록
		else if (category.equals("product")) {
			pDTO = service.selectAllProduct(map);
			System.out.println("product pDTO : "+pDTO);
			
			model.addAttribute("category", "product");
			url = "adminProduct";
		} 
		//관리자 작성 챌린지 목록
		else if (category.equals("challenge")) {
			
		}
		//전체 신고 목록
		else if (category.equals("report")) {
			
		}
		//쿠폰 목록
		else if (category.equals("coupon")) {
			
		}
		//주문 목록
		else if (category.equals("order")) {
			
		}
		
		model.addAttribute("pDTO", pDTO);
		return url;
	}
	
}