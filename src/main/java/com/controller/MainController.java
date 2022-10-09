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
    public ModelAndView searchProduct(String searchValue, HttpSession session) {
    	System.out.println("main searchValue : "+searchValue);
    	ModelAndView mav = new ModelAndView();
    	List<Integer> zzimList = new ArrayList<Integer>();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login");  //로그인세션
		PageDTO pDTO = new PageDTO();
    	pDTO = sService.searchProduct(searchValue); //검색 상품 리스트
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
		mav.setViewName("storeMain");
		
		return mav;
    }
    /**
	 * 토스 페이먼츠 테스트 화면
	 */
    @RequestMapping(value = "/toss" , method = RequestMethod.GET) 
    public ModelAndView toss_test(HttpSession session, ModelAndView mav) {
    	MemberDTO mdto = (MemberDTO)session.getAttribute("login");
    	   System.out.println(mdto);
		  //주소가져오기	
		  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  
		  //쿠폰가져오기
		  //List<MemberCouponDTO> couponList = service.selectAllCoupon1(mdto.getUserid()); 
		  //System.out.println(couponList);
		  //주문하기 리스트
		  ArrayList<String> list = new ArrayList<String>();
		  list.add("446");
		  List<CartDTO> cartList = service.orderCart(list); 
		  
		  System.out.println(cartList);
		  mav.addObject("cartList", cartList);
		  mav.addObject("mdto", mdto);
		  mav.addObject("addrList", addrList);
		  //mav.addObject("couponList", couponList);
		  mav.setViewName("orders2");
		  return mav;
    }
    /**
	 * 토스 페이먼츠 테스트 결제
	 */
    @RequestMapping(value = "/toss/success" , method = RequestMethod.GET) 
    public String toss_test_success(String orderId) {
    	System.out.println(orderId);
    	//1665309501015aaa
    	
    	
    	
    	//ordertable 결제완료
		return "Toss_Test_success";
    }
    
    
}