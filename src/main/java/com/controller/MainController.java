package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.CategoryDTO;
import com.dto.ChallengeDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;
import com.service.CartService;
import com.service.ChallengeService;
import com.service.MypageService;
import com.service.OrderService;
import com.service.StoreService;

@Controller
public class MainController {
	
	@Autowired
	private ChallengeService cService;
	@Autowired
	private StoreService sService;
	@Autowired
	CartService service;
	@Autowired
	StoreService storeservice;
	@Autowired
	MypageService myService;
	@Autowired
	OrderService orderservice ;
	
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
	/**
	 * 메인 상품 검색
	 */
    @RequestMapping(value = "/home/search" , method = RequestMethod.GET) 
    public ModelAndView searchProduct(String mainSearch, HttpSession session) {
    	System.out.println("main mainSearch : "+mainSearch);
    	ModelAndView mav = new ModelAndView();
    	List<Integer> zzimList = new ArrayList<Integer>();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		PageDTO pDTO = new PageDTO();
    	pDTO = sService.searchProduct(mainSearch); //검색 상품 리스트
    	System.out.println(pDTO.getList());
    	if(mdto !=null) {//로그인이 되었을 경우 찜 가져오기
			zzimList=sService.zzimAllCheck(mdto.getUserid());
		}
		List<CategoryDTO> categoryList = sService.category(); //카테고리 리스트
		mav.addObject("c_id","");  
		mav.addObject("categoryList", categoryList);
		mav.addObject("pDTO", pDTO);
		mav.addObject("mdto", mdto);
		mav.addObject("zzimList", zzimList);
		mav.addObject("mainSearch", mainSearch);
		mav.setViewName("storeMain");
		
		return mav;
    }
}