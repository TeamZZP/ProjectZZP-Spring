package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CartDTO;
import com.dto.MemberDTO;
import com.service.CartService;
import com.service.StoreService;

@Controller
public class CartController {

	@Autowired
	CartService service;
	@Autowired
	StoreService Sservice;

	/**
	 * 장바구니추가
	 */
	
	  @RequestMapping(value = "/cart/{userid}", method = RequestMethod.POST)
	  
	  @ResponseBody
	  public String AddCart(@ModelAttribute CartDTO cart, @PathVariable("userid") String userid, HttpSession session, int p_id) {
	  // 장바구니에 기존 상품이 있는지 검사
	  HashMap<String, Object> cartMap = new HashMap<String, Object>();
	  cartMap.put("p_id", p_id); cartMap.put("userid", userid);
	  
	  int cartCount = service.checkCart(cartMap); 
	  System.out.println("동일한상품 확인 " +cartCount);
	  if (cartCount == 0) { // 없으면 새로 insert 
		  service.cartAdd(cart);
	  }else{ // 있으면 수량 update 
		  service.updateCart(cart); 
		 } 
	  return "redirect:../cart/{userid}"; 
	  }
	 
	/**
	 * 장바구니 리스트화면
	 */
	@RequestMapping(value = "/cart/{userid}", method = RequestMethod.GET)
	public ModelAndView cartList(@PathVariable("userid") String userid, ModelAndView mav) {
		HashMap<String, Object> totalMap = new HashMap<String, Object>();
		// 장바구니 List
		List<CartDTO> cartList = service.cartList(userid);
		// 장바구니 전체금액
		int sum_money = service.sum_money(userid);
		// 장바구니에 담긴 갯수
		int cartCount = service.cartCount(userid);
		// 찜에 담긴 갯수

		// 장바구니 전체 금액에 따라 배송비 구분
		// 배송료 (5000만원 이상 ->무료 , 미만 -> 3000원)
		int fee = sum_money >= 50000 ? 0 : 3000;
		int total = sum_money + fee; // 총금액 + 배송비

		totalMap.put("cartList", cartList); // 장바구니 정보 map에 저장
		totalMap.put("count", cartCount); // 상품유무
		totalMap.put("sum_money", sum_money); // 장바구니 전체금액
		totalMap.put("fee", fee); // 배송비
		totalMap.put("total", total); // 주문상품 금액

		mav.setViewName("cartList");
		mav.addObject("map", totalMap);
		return mav;

	}

	/**
	 * 장바구니 상품 개별 삭제
	 */

	@RequestMapping(value = "/cart/{cart_id}", method = RequestMethod.DELETE)
	@ResponseBody
	public void delete(@PathVariable("cart_id") String cart_id) {
		System.out.println(cart_id);
		 service.cartDel(cart_id); 
	}

	/**
	 * 장바구니 상품 전체 삭제
	 */
	
	 @RequestMapping(value = "/cart", method = RequestMethod.DELETE)
	  public String  cartAllDel(@RequestParam("check") ArrayList<String> list, HttpSession session, RedirectAttributes attr ) {
		 MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
		 String userid = mDTO.getUserid();
		 attr.addAttribute("userid", userid);
		 System.out.println(list);
		 service.cartAllDel(list); 
	  return "redirect:/cart/{userid}"; 
	  } 
	  
		/**
		 * 장바구니 수량 변경
		 */
	 @RequestMapping(value = "/cart/{cart_id}", method = RequestMethod.PUT)
	 @ResponseBody
	 public void update(@RequestBody HashMap<String, Object> map) { 
		 System.out.println(map);
		 service.cartUpdate(map);
		 }
	
	 /**
	  * 찜한 상품 목록
	  */
	 @RequestMapping(value = "/like/{userid}" , method = RequestMethod.GET)
	 
	 public ModelAndView likeList(@PathVariable("userid") String userid, ModelAndView mav,HttpSession session  ) { 
		 
			// 찜 List
		 	
		 	
			// 찜목록에 담긴 갯수
		 	
		 	//장바구니 담긴 갯수
			int cartCount = service.cartCount(userid);
		
		 	
		 	mav.addObject("cartCount", cartCount);
			mav.setViewName("likeList");
			
			return mav;
		 }
	 
}
