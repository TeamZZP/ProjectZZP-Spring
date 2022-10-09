package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AddressDTO;
import com.dto.CartDTO;
import com.dto.MemberCouponDTO;
import com.dto.MemberDTO;
import com.service.CartService;
import com.service.CouponService;
import com.service.MemberService;
import com.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	CouponService cService;
	
	//주문하기 테스트용
	@Autowired
	MypageService myService;
	@Autowired
	CartService cartService;
	
	/**
	 * 회원가입 화면
	 */
	@RequestMapping(value = "/join")
	public String memberForm() {
		return "memberForm";
	}
	/**
	 * 회원가입
	 */
	@RequestMapping(value = "/join" , method = RequestMethod.POST)
	public String join(@RequestParam Map<String, String> map, RedirectAttributes m) {
		int num = 0;
		String nextPage ="";
		try {
			num = service.joinMember(map);
			cService.memberAddCoupon(map.get("userid")); //회원가입 축하 쿠폰 지급
		} catch (Exception e) {
			log.info(e.getMessage());
		} finally {
			System.out.println("회원가입 insert : "+num);
			if (num>0) {
				m.addFlashAttribute("mesg", map.get("userid")+"님 회원가입을 축하합니다 :)");
				nextPage = "redirect:/login";
			} else if (num==0) {
				m.addFlashAttribute("mesg", "다시 시도해 주시기 바랍니다.");
				nextPage = "redirect:/join";
			}
		}
		return nextPage;
	}
	/**
	 * 아이디 중복 확인
	 */
	@RequestMapping(value = "/join/id" , method = RequestMethod.GET , produces = "text/plain;charset=UTF-8")
	public @ResponseBody String join(String userid) {
		String mesg = "사용 가능한 아이디입니다 :)";
		MemberDTO dto = service.checkID(userid);
		if (dto!=null) {
			mesg = "중복된 아이디입니다 :(";
		} else if (userid=="") {
			mesg = "아이디를 확인해주세요 :(";
		}
		return mesg;
	}
	/**
	 * 전화번호 중복 확인
	 */
	@RequestMapping(value = "/join/phone", method = RequestMethod.GET , produces = "text/plain;charset=UTF-8")
	public @ResponseBody String join2(String phone) {
		String mesg = "가입 가능한 번호 :)";
		MemberDTO dto = service.checkPhone(phone);
		if (dto!=null) {
			mesg = "이미 가입된 번호 :(";
		} else if (phone=="") {
			mesg = "번호 미입력 :(";
		}
		return mesg;
	}
	/**
	 * 장바구니 리스트화면 테스트
	 */
	@RequestMapping(value = "/subinx/cartx/{userid}")
	public ModelAndView cartList(@PathVariable("userid") String userid, ModelAndView mav) {
		HashMap<String, Object> totalMap = new HashMap<String, Object>();
		// 장바구니 List
		List<CartDTO> cartList = cartService.cartList(userid);
		// 장바구니 전체금액
		int sum_money = cartService.sum_money(userid);
		// 장바구니에 담긴 갯수
		int cartCount = cartService.cartCount(userid);
		// 찜목록에 담긴 갯수
		int likeCount = cartService.likeCount(userid);
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

		mav.setViewName("cartList_subin");
		mav.addObject("map", totalMap);
		return mav;

	}
	 /** 
	  *  주문하기 테스트
	  */
	 @RequestMapping(value = "/subinx/ordersx/cart", method = RequestMethod.POST)
	 @ResponseBody
	  public ModelAndView orders(@RequestParam("check") ArrayList<String> list, HttpSession session, ModelAndView mav) {
		  System.out.println("주문!"+list);
		  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
		  //주소가져오기//마이페이지 서비스
		  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  
		  //쿠폰가져오기//카트 서비스
		  //List<MemberCouponDTO> couponList = orderservice.selectAllCoupon(mdto.getUserid()); 
		  List<MemberCouponDTO> couponList = cartService.selectAllCoupon1(mdto.getUserid()); 
		  //주문하기 리스트//카트 서비스
		  List<CartDTO> cartList = cartService.orderCart(list); 
		  
			
		  mav.addObject("cartList", cartList);
		  mav.addObject("mdto", mdto);
		  mav.addObject("addrList", addrList);
		  mav.addObject("couponList", couponList);
		  mav.setViewName("orders_subin");
		  return mav;
	  }
	 /** 
	  *  주문 완료 테스트
	  */
		@RequestMapping(value = "/subinx/orders/{userid}")
		@ResponseBody
		public void orderDone(@PathVariable("userid") String userid,
				String amount, String orderId, String orderName, String customerName) {
			System.out.println("결제 성공, 주문 완료 >>>"+userid);
			System.out.println("amount >>> "+amount);
			System.out.println("orderId >>> "+orderId);
			System.out.println("orderName >>> "+orderName);//null
			System.out.println("customerName >>> "+customerName);//null
			//return mav;
		}
}
