package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.service.AdminService;
import com.service.ChallengeService;
import com.service.KakaoPay;
import com.service.MypageService;
import com.service.OrderService;

import lombok.Setter;

@Controller
public class yeram {
	@Autowired
	private ChallengeService chService;
	@Autowired
	AdminService service;
	
	
	
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
	
	@Setter(onMethod_ = @Autowired)
    private KakaoPay kakaopay;
	
	@Autowired
	MypageService myService;
	@Autowired
	OrderService oService ;
	@RequestMapping(value = "/kakaoPay", method = RequestMethod.GET)
	public ModelAndView kakaoPay(HttpSession session,CartDTO cdto,@RequestParam HashMap<String, String> map) {
		System.out.println(cdto.toString());
		  ModelAndView mav = new ModelAndView();
		  List<CartDTO> list = new ArrayList<CartDTO>();
		  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
		  
		  cdto.setCart_id(398);
		  cdto.setP_name("초코파이");
		  cdto.setP_id(18);
		  cdto.setP_amount(1);
		  cdto.setP_selling_price(300);
		  cdto.setUserid(mdto.getUserid());
		  
		  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  //주소가져오기
		  System.out.println("address : "+ addrList);
		  List<MemberCouponDTO> couponList = oService.selectAllCoupon(mdto.getUserid()); //쿠폰가져오기
		  System.out.println("coupon : "+couponList);
		  int money = cdto.getP_amount()*cdto.getP_selling_price();
		  cdto.setMoney(money);
		  list.add(cdto);  //카트 리스트로 담기(여러개일경우의수를 생각하여)
		  mav.addObject("cartList", list);
		  mav.addObject("mdto", mdto);
		  mav.addObject("addrList", addrList);
		  mav.addObject("couponList", couponList);
		  mav.setViewName("orders/orders_yeram");
		  return mav;
	}
	@RequestMapping(value = "/kakaoPay", method = RequestMethod.POST)
	@ResponseBody
	public String kakaoPaytest(@RequestParam HashMap<String, String> map) {
		System.out.println(map);
		return kakaopay.kakaoPayReady(map);
	}
	@RequestMapping(value = "/kakaoPaySuccess", method = RequestMethod.GET)
	@ResponseBody
	public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model, HttpServletResponse response) {
	    System.out.println("kakaoPaySuccess get............................................");
	    System.out.println("kakaoPaySuccess pg_token : " + pg_token);
	    
	    model.addAttribute("info", kakaopay.kakaoPayInfo(pg_token));
	    
	    try {
			PrintWriter out = response.getWriter();
			out.println("<script>window.opener.document.getElementById('myForm').action = '/zzp/orders';</script>");
			out.println("<script>window.opener.document.getElementById('myForm').submit();</script>");
			out.println("<script>window.close();</script>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
