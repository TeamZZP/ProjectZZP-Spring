package com.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.dto.OrderDTO;
import com.service.MypageService;
import com.service.OrderService;

@Controller
public class OrderController {
	@Autowired
	OrderService service ;
	MypageService myService;
	
	
	//상품상세에서 주문할 때 CartDTO로 캐스팅 후 orders로 전달
		@RequestMapping("/castingCartDTO")
		public @ResponseBody CartDTO castingCartDTO(HashMap<String, String> map) {
			CartDTO cdto = new CartDTO();
			Date date = new Date();
			String now = String.valueOf(date);
			cdto.setCart_created(now);
			cdto.setCart_id(1);
			cdto.setMoney(Integer.parseInt(map.get("p_amount"))*Integer.parseInt(map.get("p_selling_price")));
			cdto.setP_amount(Integer.parseInt(map.get("p_amount")));
			cdto.setP_id(Integer.parseInt(map.get("p_id")));
			cdto.setP_image(map.get("p_image"));
			cdto.setP_name(map.get("p_name"));
			cdto.setP_selling_price(Integer.parseInt(map.get("p_selling_price")));
			cdto.setUserid(map.get("userid"));	
			
			return cdto;
		}
		
		//주문하기페이지
		 @RequestMapping("orders/checkout")
		  public ModelAndView orders(HttpSession session, @PathVariable("cdto") CartDTO cdto) {
			  ModelAndView mav = new ModelAndView();
			  List<CartDTO> list = new ArrayList<CartDTO>();
			  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
			  AddressDTO addrdto = myService.selectDefaultAddress(mdto.getUserid());  //주소가져오기
			  List<MemberCouponDTO> couponList = service.selectAllCoupon(mdto.getUserid()); //쿠폰가져오기
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
