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

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.dto.ProductByCategoryDTO;
import com.service.CartService;
import com.service.MypageService;
import com.service.OrderService;
import com.service.StoreService;

@Controller
public class CartController {

	@Autowired
	CartService service;
	@Autowired
	StoreService storeservice;
	@Autowired
	MypageService myService;
	@Autowired
	OrderService orderservice ;

	/**
	 * 장바구니추가
	 */
	
	  @RequestMapping(value = "/cart/{userid}", method = RequestMethod.POST)
	  @ResponseBody
	  public String AddCart(@ModelAttribute CartDTO cart, @PathVariable("userid") String userid, HttpSession session, int p_id,String p_name,int p_amount) {
		System.out.println(userid+p_id+p_name+p_amount);
		  // 장바구니에 기존 상품이 있는지 검사
	  HashMap<String, Object> cartMap = new HashMap<String, Object>();
	  cartMap.put("p_id", p_id); 
	  cartMap.put("userid", userid);
	  int cartCount = service.checkCart(cartMap); 
	  System.out.println("동일한상품 확인 " +cartCount);
	  if (cartCount == 0) { // 없으면 새로 insert 
		  service.cartAdd(cart);
	  }else{ // 있으면 수량 update 
		  service.updateCart(cart); 
		 } 
	  return "redirect:/cart/{userid}"; 
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
		// 찜목록에 담긴 갯수
		int likeCount = service.likeCount(userid);
		// 장바구니 전체 금액에 따라 배송비 구분
		// 배송료 (5000만원 이상 ->무료 , 미만 -> 3000원)
		int fee = sum_money >= 50000 ? 0 : 3000;
		int total = sum_money + fee; // 총금액 + 배송비

		totalMap.put("cartList", cartList); // 장바구니 정보 map에 저장
		totalMap.put("cartCount", cartCount); // 장바구니 갯수
		totalMap.put("likeCount", likeCount); // 찜상품 갯수
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
	public int delete(@PathVariable("cart_id") String cart_id,HttpSession session) {
		System.out.println(cart_id);
		 service.cartDel(cart_id); 
		 
		 MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
		 int n = service.cartCount(mDTO.getUserid());
		 return n; //ajax의 data로 받는 부분
	}

	 /**
	 * 장바구니 상품 선택 삭제
	 */
	
	 @RequestMapping(value = "/cart", method = RequestMethod.DELETE)
	  public String  chkdel(@RequestParam("check") ArrayList<String> list, HttpSession session ) {
		 MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
		 String userid = mDTO.getUserid();
		 System.out.println(list);
		 service.chkdel(list); 
	  return "redirect:/cart/"+userid; 
	  
	  } 
	  
		/**
		 * 장바구니 수량 변경
		 */
	 @RequestMapping(value = "/cart/{cart_id}", method = RequestMethod.PUT)
	 @ResponseBody
	 public void update(@RequestBody HashMap<String, Object> map, HttpSession session ) { 
		 System.out.println("map>>"+map.values());
		 service.cartUpdate(map);	
		 
		 MemberDTO mDTO = (MemberDTO)session.getAttribute("login");
		 String userid = mDTO.getUserid();
		 
		 }
	
	 /**
	  * 찜한 상품 목록
	  */
	 @RequestMapping(value = "/like/{userid}" , method = RequestMethod.GET)
	 @ResponseBody
	 public ModelAndView likeList(@PathVariable("userid") String userid, ModelAndView mav,HttpSession session  ) { 
		// 찜 List
		 List<ProductByCategoryDTO> likeList = service.likeList(userid);
		// 찜목록에 담긴 갯수
		int likeCount = service.likeCount(userid);	
		 //장바구니 담긴 갯수
		int cartCount = service.cartCount(userid);
		
		mav.addObject("likeCount", likeCount); 	
		mav.addObject("cartCount", cartCount);
		mav.addObject("likeList", likeList);
		mav.setViewName("likeList");
			
		return mav;
		 }
	 
	 /** 
	  *  주문하기
	  */
	 @RequestMapping(value = "orders/cart", method = RequestMethod.POST)
	 @ResponseBody
	  public ModelAndView orders(@RequestParam("check") ArrayList<String> list, HttpSession session, ModelAndView mav) {
		  System.out.println("주문!"+list);
		  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
		  //주소가져오기	
		  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  
		  //쿠폰가져오기
		  List<MemberCouponDTO> couponList = orderservice.selectAllCoupon(mdto.getUserid()); 
		  //주문하기 리스트
		  List<CartDTO> cartList = service.orderCart(list); 
		  
			
		  mav.addObject("cartList", cartList);
		  mav.addObject("mdto", mdto);
		  mav.addObject("addrList", addrList);
		  mav.addObject("couponList", couponList);
		  mav.setViewName("orders");
		  return mav;
	  }
}
