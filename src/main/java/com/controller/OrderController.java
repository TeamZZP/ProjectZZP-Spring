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
import com.dto.OrderDTO;
import com.dto.ProductOrderImagesDTO;
import com.service.CartService;
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
	@Autowired
	CartService cService;
	
	
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
		 public ModelAndView addOrders(@RequestParam("p_id") int[] p_id, HttpSession session, 
			int order_quantity,String delivery_address,String delivery_req, int total_price, String payment, String coupon_id,int sum_money, int fee ) {
			System.out.println();
			 MemberDTO mdto = (MemberDTO) session.getAttribute("login");
			 List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  //주소가져오기
			 OrderDTO odto = new OrderDTO();
			 List<OrderDTO> olist = new ArrayList<OrderDTO>();
			 ModelAndView mav = new ModelAndView();
			 HashMap<String,String> map =new HashMap<String, String>();
			 
			 System.out.println("payment: "+payment);
			 int order_id = service.getOrderId();  //order_id 시퀀스 가져오기 //왜 따로만드는건지 궁금???
			 System.out.println("order_id: "+order_id);
			 
			 int n=0;  //오더저장회수
			 if(delivery_req == null) {
				 delivery_req = "요청사항이 없습니다.";
			 }
			 
			 for (int i = 0; i < p_id.length; i++) {
				 System.out.println("p_id[i]>>>"+p_id[i]);	
				 odto.setOrder_id(order_id);
				 odto.setUserid(mdto.getUserid());
				 odto.setP_id(p_id[i]);
				 odto.setDelivery_address(delivery_address);
				 odto.setDelivery_req(delivery_req);
				 odto.setOrder_quantity(order_quantity);
				 odto.setTotal_price(total_price);
				 n += service.addOrder(odto); //오더저장
				 if(n!=0){//오더 저장 성공시 list add
					 olist.add(odto);
				 }
			 }
			 
			 System.out.println("오더저장 "+n+"번 성공");
			 
			 int cartdel =0; //카트 삭제 회수
			 if(n!=0) { //오더저장 성공시 카트삭제
				 System.out.println("length>>"+p_id.length);	 
				 for(int i = 0; i < p_id.length; i++) {   
					 System.out.println("삭제되는카트 상품 :"+ p_id[i]);
					map.put("p_id",String.valueOf(p_id[i]) );
					map.put("userid",mdto.getUserid());
					System.out.println(map);
					int countCart=service.selectCart(map);
					if(countCart!=0) {						
						cartdel += service.cartDelete(map);	
					} 

				 }//end 주문한 상품 카트 삭제
 

				 //오더저장 성공시 쿠폰 삭제
				 HashMap<String,String> couponMap =new HashMap<String, String>();
				 if(coupon_id==null) {
					System.out.println( "선택한 쿠폰 없음");
				 }else {
					 System.out.println("coupon_id: "+coupon_id);
					 couponMap.put("userid", mdto.getUserid());
					 couponMap.put("coupon_id", coupon_id);
					 
					 //쿠폰 중복체크
					int sameCoupon = service.selectSameCouponCount(couponMap);

					if(sameCoupon!=1) {//중복쿠폰이 있을 경우
						int delOneCoupon = service.deleteOneCoupon(couponMap);
						System.out.println("중복쿠폰 중 "+delOneCoupon+"개 삭제");
					}else if(sameCoupon==1) {//중복쿠폰이 없을 경우
						int delCoupon =  service.deleteCoupon(couponMap);
						System.out.println("쿠폰"+delCoupon+"개 삭제");
					}					
				 }//end 쿠폰삭제

				 //주문성공시 orderDTO저장(jsp보낼거) 
				 List <ProductOrderImagesDTO> prodList = service.selectOrderProd(order_id);  //order_id로 상품정보 불러오기
				 mav.addObject("prodList", prodList);
				 
				 System.out.println("prodList>>>"+prodList);
			 }//end 오더저장 성공시 카트삭제	
			 
			 System.out.println("olist>>>"+olist);			
			 System.out.println("주문 상품 개수 : " +n );
			 System.out.println("장바구니에서 삭제된 상품 개수: "+cartdel);
			 
			 mav.addObject("payment", payment);
			 mav.setViewName("orderSuccess");
			 mav.addObject("addrList", addrList);
			 return mav;
			  
		 }
		 
		 /**
			 * 토스 페이먼츠 테스트 화면
			 */
		    @RequestMapping(value = "/toss2" , method = RequestMethod.GET) 
		    public ModelAndView toss_test2(HttpSession session, ModelAndView mav) {
		    	MemberDTO mdto = (MemberDTO)session.getAttribute("login");
		    	   System.out.println(mdto);
				  //주소가져오기	
				  List<AddressDTO> addrList= myService.selectAllAddress(mdto.getUserid());  
				  //쿠폰가져오기
				  List<MemberCouponDTO> couponList = service.selectAllCoupon(mdto.getUserid()); 
				  //주문하기 리스트
				  ArrayList<String> list = new ArrayList<String>();
				  list.add("412");
				  List<CartDTO> cartList = cService.orderCart(list); 
				  
					
				  mav.addObject("cartList", cartList);
				  mav.addObject("mdto", mdto);
				  mav.addObject("addrList", addrList);
				  mav.addObject("couponList", couponList);
				  mav.setViewName("orders");
				  return mav;
		    }
		    /**
			 * 토스 페이먼츠 테스트 결제
			 */
		    @RequestMapping(value = "/toss/success2" , method = RequestMethod.GET)
		    @ResponseBody
		    public void toss_test_success2(@RequestParam("customerName") String name, Model model, HttpServletResponse response) {
		    	
		    	System.out.println("Toss success=====");
		    	System.out.println("name====="+name);
		    	
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
