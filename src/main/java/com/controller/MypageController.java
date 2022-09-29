package com.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AddressDTO;
import com.dto.MemberDTO;
import com.service.MypageService;


@Controller
public class MypageController {
	@Autowired
	MypageService service;
	/**
	 * 마이페이지 메인
	 */
	@RequestMapping(value = "/mypage/{userid}", method = RequestMethod.GET)
	public ModelAndView mypage(@PathVariable("userid") String userid) {
		//interceptor 인증 후
		System.out.println("마이페이지 메인 userid : "+userid);
		//review, member_coupon, member_stamp, challenge
		int myReview=service.countReview(userid);
		int myCoupon=service.countCoupon(userid);
		int myStamp=service.countStamp(userid);
		int myChallenge=service.countChallenge(userid);
		//System.out.println("리뷰:"+myReview+" 쿠폰:"+myCoupon+" 스탬프:"+myStamp+" 챌린지:"+myChallenge);
		
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("myReview", myReview);
		map.put("myCoupon", myCoupon);
		map.put("myStamp", myStamp);
		map.put("myChallenge", myChallenge);
		System.out.println("map>>>"+map);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("map", map);
		mav.setViewName("mypage");//mypage.jsp 요청
		return mav;
	}
	/**
	 * 마이페이지 계정 인증
	 */
	@RequestMapping(value = "/mypage/{userid}/check", method = RequestMethod.GET)
	public String accountCheck() {
		//interceptor 인증 후
		System.out.println("계정 인증");
		return "checkAccount";
	}
	/**
	 * 마이페이지 계정 삭제 인증
	 */
	@RequestMapping(value = "/mypage/{userid}/check", method = RequestMethod.POST)
	public String deleteCheck(String accountDelete, Model model) {
		//interceptor 인증 후
		System.out.println("계정 삭제 인증");
		model.addAttribute("accountDelete", accountDelete);
		return "checkAccount";
	}
	/**
	 * 마이페이지 계정관리
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.POST)
	//@ResponseBody
	public String myAccount(@PathVariable("userid") String userid, Model model) {
		//interceptor 인증 후
		System.out.println("계정 관리 userid : "+userid);
		
		//회원 기본 배송지
		AddressDTO address=service.selectDefaultAddress(userid);
		System.out.println(address);
		
		//ModelAndView mav=new ModelAndView();
		//mav.addObject("address", address);
		//mav.setViewName("accountForm");//accountForm.jsp 요청
		model.addAttribute("address", address);
		return "accountForm";
	}
	/**
	 * 마이페이지 회원 정보 수정
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.PUT)
	public String updateAccount(@PathVariable("userid") String userid, MemberDTO member,
			AddressDTO address, String changedPasswd, HttpSession session, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("계정 수정 userid : "+userid);
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		if (changedPasswd.length() != 0) {
			System.out.println("비밀번호 변경");
			map.put("changedPasswd", changedPasswd);
		}
		map.put("userid", userid);
		map.put("email1", member.getEmail1());
		map.put("email2", member.getEmail2());
		map.put("address_id", address.getAddress_id());
		map.put("post_num", address.getPost_num());
		map.put("addr1", address.getAddr1());
		map.put("addr2", address.getAddr2());
		System.out.println(map);
		service.updateAccount(map);
		
		//업데이트 회원 정보
		MemberDTO dto=service.selectMember(userid);
		System.out.println(dto);
		session.setAttribute("login", dto);
		m.addFlashAttribute("mesg", "회원 정보가 수정되었습니다.");
		return "redirect:/mypage/"+userid;
	}
	/**
	 * 마이페이지 회원 계정 삭제
	 */
	@RequestMapping(value = "/mypage/{userid}/user", method = RequestMethod.DELETE)
	public String accountDelete(@PathVariable("userid") String userid, HttpSession session, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("계정 삭제 userid : "+userid);
		service.accountDelete(userid);
		session.invalidate();
		m.addFlashAttribute("mesg", "회원 탙퇴가 완료되었습니다.");
		return "redirect:/";
	}
	/**
	 * 마이페이지 배송지 관리
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.GET)
	public ModelAndView addressList(@PathVariable("userid") String userid) {
		//interceptor 인증 후
		System.out.println("배송지 관리 userid : "+userid);
		
		//회원 배송지 목록
		List<AddressDTO> addressList=service.selectAllAddress(userid);
		ModelAndView mav=new ModelAndView();
		mav.addObject("addressList", addressList);
		mav.setViewName("addressList");
		return mav;
	}
	/**
	 * 마이페이지 배송지 추가 폼
	 */
	@RequestMapping(value = "/mypage/address", method = RequestMethod.GET)
	public String addressForm() {
		//interceptor 인증 후
		System.out.println("배송지 추가 폼");
		return "addressForm";
	}
	/**
	 * 마이페이지 배송지 수정 폼
	 */
	@RequestMapping(value = "/mypage/address", method = RequestMethod.POST)
	public String addressUpdateForm(String address_id, Model model) {
		//interceptor 인증 후
		System.out.println("배송지 수정 폼 : "+address_id);
		//int?
		AddressDTO address=service.selectAddress(address_id);
		System.out.println("address 출력>>>"+address);
		model.addAttribute("address", address);
		return "addressForm";
	}
	/**
	 * 마이페이지 배송지 추가
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.POST)
	public String addAddress(@PathVariable("userid") String userid, AddressDTO address,
			String chk, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("배송지 추가 "+address);
		System.out.println("기본 배송지 : "+chk);//체크하면 on//체크 안 하면 null
		
		if (chk == null) {
			System.out.println("기본 배송지 아님");
			service.addAddress(address);
		} else {
			System.out.println("기본 배송지 체크");
			address.setDefault_chk(1);
			//기존 기본 배송지의 default_chk=0으로 변경
			service.changeNotDefaultAddress(userid);
			
			service.addAddress(address);
		}
		
		m.addFlashAttribute("mesg", "배송지가 추가되었습니다.");
		return "redirect:/mypage/"+userid+"/address";
	}
	/**
	 * 마이페이지 배송지 삭제
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteAddress(@RequestBody HashMap<String, String> map) {//@RequestBody 없으면 null 출력
		//interceptor 인증 후
		System.out.println("배송지 삭제 : "+map);
		String id=map.get("address_id");
		int address_id=Integer.parseInt(id);
		service.deleteAddress(address_id);
	}
	/**
	 * 마이페이지 배송지 수정
	 */
	@RequestMapping(value = "/mypage/{userid}/address", method = RequestMethod.PUT)
	public String updateAddress(String addressId, AddressDTO address,
			String chk, RedirectAttributes m) {
		//interceptor 인증 후
		System.out.println("배송지 수정 address_id : "+addressId);
		System.out.println("기본 배송지 : "+chk);//체크하면 on//체크 안 하면 null
		String userid=address.getUserid();
		
		if (chk != null) {
			System.out.println("기본 배송지 체크");
			address.setDefault_chk(1);
			//기존 기본 배송지의 default_chk=0으로 변경
			service.changeNotDefaultAddress(userid);
		}
		
		int id=Integer.parseInt(addressId);
		address.setAddress_id(id);
		System.out.println(address);
		service.updateAddress(address);
		
		m.addFlashAttribute("mesg", "배송지가 수정되었습니다.");
		return "redirect:/mypage/"+userid+"/address";
	}
}
