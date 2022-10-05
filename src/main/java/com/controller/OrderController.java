package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.dto.OrderDTO;
import com.service.MypageService;
import com.service.OrderService;
import com.service.StoreService;

@Controller
public class OrderController {
	@Autowired
	OrderService service ;
	@Autowired
	MypageService myService;
	@Autowired
	StoreService sService;
	
	
	//상품상세에서 주문할 때 CartDTO로 캐스팅 후 orders로 전달
	/*	@RequestMapping("/castingCartDTO")
		public void castingCartDTO(HashMap<String, String> map, HttpSession session,
				@RequestParam("p_selling_price") int p_selling_price, @RequestParam("p_id")int p_id, @RequestParam("p_amount")int p_amount,
				@RequestParam("p_name") String p_name, @RequestParam("p_image") String p_image) {
			System.out.println("castingCartDTO()컨트롤러 실행");
			ModelAndView mav = new ModelAndView();
			MemberDTO mdto = (MemberDTO) session.getAttribute("login");
			CartDTO cdto = new CartDTO();
			Date date = new Date();
			String now = String.valueOf(date);
			cdto.setCart_created(now);
			cdto.setCart_id(1);
			cdto.setMoney(p_amount*p_selling_price);
			cdto.setP_amount(p_amount);
			cdto.setP_id(p_id);
			cdto.setP_image(p_image);
			cdto.setP_name(p_name);
			cdto.setP_selling_price(p_selling_price);
			cdto.setUserid(mdto.getUserid());	
			
			orders(session, cdto);
			
		}*/
		
		//주문하기페이지
		 @RequestMapping(value = "orders/checkout", method = RequestMethod.POST)
		  public ModelAndView orders(HttpSession session,CartDTO cdto,@RequestParam HashMap<String, String> map) {
			 
			  System.out.println(cdto.toString());
			  ModelAndView mav = new ModelAndView();
			  List<CartDTO> list = new ArrayList<CartDTO>();
			  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
			  cdto.setUserid(mdto.getUserid());
			  AddressDTO addrdto = myService.selectDefaultAddress(mdto.getUserid());  //주소가져오기
			  System.out.println("address : "+ addrdto);
			  List<MemberCouponDTO> couponList = service.selectAllCoupon(mdto.getUserid()); //쿠폰가져오기
			  System.out.println("coupon : "+couponList);
			  list.add(cdto);  //카트 리스트로 담기(여러개일경우의수를 생각하여)
			  mav.addObject("cartList", list);
			  mav.addObject("mdto", mdto);
			  mav.addObject("addrdto", addrdto);
			  mav.addObject("couponList", couponList);
			  mav.setViewName("orders");
			  return mav;
		  }
		 
		 //주문추가
		 @RequestMapping("orders")
		 public void addOrders(@PathVariable("odto") OrderDTO odto) {
			 ModelAndView mav = new ModelAndView();
			 List<OrderDTO> olist = new ArrayList<OrderDTO>();
			 olist.add(odto);
			 
		 }
		 
		 
		 //주문완료
		 @RequestMapping("orders/{review_id}")
		 public void orderSuccess() {
			 
		 }

}
