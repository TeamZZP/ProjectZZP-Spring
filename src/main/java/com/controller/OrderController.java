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
	
	
		//주문하기페이지
		 @RequestMapping(value = "orders/checkout", method = RequestMethod.POST)
		  public ModelAndView orders(HttpSession session,CartDTO cdto,@RequestParam HashMap<String, String> map) {
			 
			  System.out.println(cdto.toString());
			  ModelAndView mav = new ModelAndView();
			  List<CartDTO> list = new ArrayList<CartDTO>();
			  MemberDTO mdto = (MemberDTO)session.getAttribute("login");
			  cdto.setUserid(mdto.getUserid());
			  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  //주소가져오기
			  System.out.println("address : "+ addrList);
			  List<MemberCouponDTO> couponList = service.selectAllCoupon(mdto.getUserid()); //쿠폰가져오기
			  System.out.println("coupon : "+couponList);
			  int money = cdto.getP_amount()*cdto.getP_selling_price();
			  cdto.setMoney(money);
			  list.add(cdto);  //카트 리스트로 담기(여러개일경우의수를 생각하여)
			  mav.addObject("cartList", list);
			  mav.addObject("mdto", mdto);
			  mav.addObject("addrList", addrList);
			  mav.addObject("couponList", couponList);
			  mav.setViewName("orders");
			  return mav;
		  }
		 
		 //주문추가
		 @RequestMapping("/orders")
		 public void addOrders(OrderDTO odto, HttpSession session) {
			 System.out.println(odto);
			 MemberDTO mdto = (MemberDTO) session.getAttribute("login");
			 ModelAndView mav = new ModelAndView();
			 List<OrderDTO> olist = new ArrayList<OrderDTO>();
			 HashMap<String,String> map =new HashMap<String, String>();
			 olist.add(odto);
			 int order_id = service.getOrderId();
			 System.out.println("order_id: "+order_id);
			 int n=0;
			 int cartdel =0;
			 for (int i = 0; i < olist.size(); i++) {
				olist.get(i).setOrder_id(order_id);
				n += service.addOrder(olist.get(i)) ;
				if(n!=0) { //오더저장 성공시 카트삭제
					map.put("p_id",String.valueOf(olist.get(i).getP_id()) );
					map.put("userid",mdto.getUserid());
					System.out.println(map);
					cartdel += service.cartDelete(map);	 
				 }
			 }
			 System.out.println("주문 상품 개수 : " +n );
			 System.out.println("장바구니에서 삭제된 상품 개수: "+cartdel);
			 
			 
		 }
		 
		 
		 //주문완료
		 @RequestMapping("orders/{review_id}")
		 public void orderSuccess() {
			 
		 }

}
