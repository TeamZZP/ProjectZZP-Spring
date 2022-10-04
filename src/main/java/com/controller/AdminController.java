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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AddressDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;
import com.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/admin")
	public String admin() {
		return "adminMain";
	}
	/**
	 * 카테고리
	 */
	@RequestMapping(value = "/admin/{category}", method = RequestMethod.GET)
	public String adminCategory(@PathVariable("category") String category, @RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println("adminCategory category: "+category);
		System.out.println("adminCategory map: "+map);
		
		model.addAttribute("searchName", map.get("searchName"));
		model.addAttribute("searchValue", map.get("searchValue"));
		model.addAttribute("sortBy", map.get("sortBy"));
		
		String url = null;
		PageDTO pDTO = null;
		
		//전체 회원 목록
		if (category.equals("member")) {
			//카테고리 선택하여 회원관리 페이지 이동--처음에는 검색, 정렬 조건 다 null
			pDTO=service.selectAllMember(map);
			System.out.println("member pDTO : "+pDTO);
			
			model.addAttribute("category", "member");//카테고리를 member로 저장
			url = "adminMember";
		} 
		//전체 상품 목록
		else if (category.equals("product")) {
			pDTO = service.selectAllProduct(map);
			System.out.println("product pDTO : "+pDTO);
			
			model.addAttribute("category", "product");
			url = "adminProduct";
		} 
		//관리자 작성 챌린지 목록
		else if (category.equals("challenge")) {
			
		}
		//전체 신고 목록
		else if (category.equals("report")) {
			
		}
		//쿠폰 목록
		else if (category.equals("coupon")) {
			
		}
		//주문 목록
		else if (category.equals("order")) {
			
		}
		
		model.addAttribute("pDTO", pDTO);
		return url;
	}
	/**
	 * 관리자 회원 삭제
	 */
	@RequestMapping(value = "/admin/member/{userid}", method = RequestMethod.DELETE)
	@ResponseBody
	public void deleteMember(@RequestBody HashMap<String, String> map,
			@PathVariable("userid") String userid) {
		System.out.println("관리자 회원 삭제 : "+userid);
		String id=map.get("userid");
		System.out.println("data : "+id);
		service.deleteMember(id);
	}
	/**
	 * 관리자 회원 조회
	 */
	@RequestMapping(value = "/admin/member/{userid}", method = RequestMethod.GET)
	public String detailMember(@PathVariable("userid") String userid, Model m) {
		System.out.println("관리자 회원 조회 : "+userid);
		MemberDTO member=service.selectMember(userid);
		System.out.println("회원 >>> "+member);
		List<AddressDTO> list=service.selectAllAddress(userid);
		System.out.println("회원 배송지 목록 >>> "+list);
		m.addAttribute("member", member);
		m.addAttribute("list", list);
		return "adminMemberDetail";
	}
	/**
	 * 관리자 회원 정보 수정
	 */
	@RequestMapping(value = "/admin/member/{userid}", method = RequestMethod.PUT)
	public String updateMember(@PathVariable("userid") String userid, MemberDTO member,
			RedirectAttributes m) {
		System.out.println("관리자 회원 정보 수정 : "+userid);
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("userid", member.getUserid());
		map.put("username", member.getUsername());
		map.put("phone", member.getPhone());
		System.out.println("회원 정보 >>> "+map);
		service.updateMember(map);
		System.out.println("회원 : "+member);
		
		//업데이트 회원 정보
		MemberDTO dto=service.selectMember(userid);
		System.out.println(dto);
		m.addFlashAttribute("member", dto);
		m.addFlashAttribute("mesg", "회원 정보가 수정되었습니다.");
		return "redirect:/admin/member/"+userid;
	}
	/**
	 * 상품 등록화면
	 */
	@RequestMapping(value = "/admin/product/add", method = RequestMethod.GET)
	public String addProductView () {
		return "adminProductAdd";
	}
	/**
	 * 상품 등록
	 */
	@RequestMapping(value = "/admin/product", method = RequestMethod.POST)
	public String addProduct () {
		
		
		
		
		
		return "";
	}
	/**
	 * 상품 상세페이지(수정페이지)
	 */
	@RequestMapping(value = "/admin/product/{p_id}", method = RequestMethod.GET)
	public String productRetrieve (@PathVariable("p_id") int p_id, Model model) {
		 System.out.println("AdminProdDetailServlet에서 파싱한 p_id=="+p_id);
		 ProductDTO pDTO = service.productRetrieve(p_id);
	     List <ImagesDTO> imageList = service.ImagesRetrieve(p_id);
		
		 model.addAttribute("pDTO", pDTO);
		 model.addAttribute("imageList", imageList);
	    
		 return "adminProductDetail";
	}
	/**
	 * 상품 삭제
	 */
	@RequestMapping(value = "/admin/product", method = RequestMethod.DELETE)
	public String productDelete (@RequestParam("p_id") List<String> ids, RedirectAttributes attr) {
		service.deleteProduct(ids);
		return "redirect:../admin/product";
	}
	
}