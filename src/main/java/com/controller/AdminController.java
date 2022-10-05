package com.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AddressDTO;
import com.dto.CouponDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;
import com.service.AdminService;
import com.service.CouponService;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	@Autowired
	CouponService cService;
	
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
	public String addProduct (@RequestParam HashMap<String, String> map, @RequestParam("image_route") CommonsMultipartFile [] uploadFiles) {
		
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//product";
		for (int i = 1; i <= uploadFiles.length; i++) {
			System.out.println(uploadFiles[i-1].getOriginalFilename());
			map.put("image_route_"+i, uploadFiles[i-1].getOriginalFilename());
			map.put("image_rnk"+i, Integer.toString(i));
			
			CommonsMultipartFile uploadFile = uploadFiles[i-1];
			uploadFile(location, uploadFile);
		}
		
		System.out.println("addProduct map : "+map);
		service.insertProduct(map);
		
		return "redirect:../admin/product";
	}
	/**
	 * 상품 등록(upload폴더 이미지 등록)
	 */
	private void uploadFile(String location, CommonsMultipartFile uploadFile) {
		String originalFileName= uploadFile.getOriginalFilename();
		
		File f= new File(location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 상품 상세페이지(수정페이지)
	 */
	@RequestMapping(value = "/admin/product/{p_id}", method = RequestMethod.GET)
	public String productRetrieve (@PathVariable("p_id") int p_id, Model model) {
		 ProductDTO pDTO = service.productRetrieve(p_id);
	     List <ImagesDTO> imageList = service.ImagesRetrieve(p_id);
	     System.out.println(imageList);
		
		 model.addAttribute("pDTO", pDTO);
		 model.addAttribute("imageList", imageList);
	    
		 return "adminProductDetail";
	}
	/**
	 * 상품 수정
	 */
	@RequestMapping(value = "/admin/product/{p_id}", method = RequestMethod.POST)
	public String updateProduct (@RequestParam HashMap<String, String> map, @RequestParam("old_image_route") String [] old_image_routes,
			@RequestParam("image_route") CommonsMultipartFile [] uploadFiles) {
		/*
		 * for (int i = 0; i < uploadFiles.length; i++) {
		 * System.out.println("length "+uploadFiles.length); if
		 * (uploadFiles[0].getOriginalFilename().equals("")) {
		 * System.out.println("비어있음"); for (int j = 0; j < old_image_routes.length; j++)
		 * { System.out.println(old_image_routes[j]); } } }
		 */
		
		if (uploadFiles[0].getOriginalFilename().equals("")) {
			System.out.println("비어있음");
		}
		
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//product";
		
		/*
		 * for (CommonsMultipartFile uploadFile : uploadFiles) { if (uploadFile==null) {
		 * service.updateProduct(map); //product만 수정 } else { //기존 파일 삭제 for (int i = 0;
		 * i < old_image_routes.length; i++) {
		 * System.out.println("old_image_routes : "+old_image_routes[i]);
		 * deleteFile(location, old_image_routes[i]); } //새 파일 업로드 for (int i = 1; i <=
		 * uploadFiles.length; i++) {
		 * System.out.println("uploadFiles : "+uploadFiles[i-1].getOriginalFilename());
		 * map.put("image_route_"+i, uploadFiles[i-1].getOriginalFilename());
		 * map.put("image_rnk"+i, Integer.toString(i));
		 * 
		 * uploadFile = uploadFiles[i-1]; uploadFile(location, uploadFile); }
		 * System.out.println(map); service.deleteImages(map);
		 * service.updateProduct(map); service.insertImages(map); } }
		 */
		
		
		/*
		 * //1.이미지 수정 안 하는 경우 if (uploadFiles[0]==null && old_image_routes.length==4) {
		 * service.updateProduct(map); //product만 수정 } //2.이미지 수정하는 경우 else { String
		 * location =
		 * "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//product";
		 * //2-1.전체 파일 수정 if (uploadFiles.length==4) { //기존 파일 삭제 for (int i = 0; i <
		 * old_image_routes.length; i++) {
		 * System.out.println("old_image_routes : "+old_image_routes[i]);
		 * deleteFile(location, old_image_routes[i]); } //새 파일 업로드 for (int i = 1; i <=
		 * uploadFiles.length; i++) {
		 * System.out.println("uploadFiles : "+uploadFiles[i-1].getOriginalFilename());
		 * map.put("image_route_"+i, uploadFiles[i-1].getOriginalFilename());
		 * map.put("image_rnk"+i, Integer.toString(i));
		 * 
		 * CommonsMultipartFile uploadFile = uploadFiles[i-1]; uploadFile(location,
		 * uploadFile); } System.out.println(map); service.deleteImages(map);
		 * service.updateProduct(map); service.insertImages(map); } //2-2. 일부 파일 수정 else
		 * {
		 * 
		 * } }
		 */
		return "redirect:/admin/product";
	}
	/**
	 * 상품 삭제
	 */
	@RequestMapping(value = "/admin/product", method = RequestMethod.DELETE)
	public String productDelete (@RequestParam("p_id") List<String> ids, RedirectAttributes attr) {
		System.out.println(ids);
		List <ImagesDTO> imageList = service.productImages(ids);
		System.out.println(imageList);
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//product";
		
		int num = service.deleteProduct(ids);
		if (num > 0) {
			for (ImagesDTO imagesDTO : imageList) {
				deleteFile(location, imagesDTO.getImage_route());//폴더에서 파일 삭제
			}
		}
		return "redirect:../admin/product";
	}
	/**
	 * 상품 삭제(upload폴더 이미지 삭제)
	 */
	private void deleteFile(String location, String fileName) {
		Path file = Paths.get(location+"//"+fileName);
		try {
			Files.deleteIfExists(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 관리자 페이지 쿠폰 조회
	 */
	@RequestMapping(value = "/admin/coupon", method = RequestMethod.GET)
	public String couponSelect(@RequestParam Map<String, String> map, Model m, HttpSession session) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		if (mDTO.getRole() == 1) {
			System.out.println(map);
			System.out.println("페이지, 검색어, 유저아이디 " + map);

			PageDTO pDTO = cService.couponSelect(map);
			System.out.println("쿠폰 내역 " + pDTO);

			m.addAttribute("coupon", pDTO);
			m.addAttribute("search", map);
			m.addAttribute("mDTO", session.getAttribute("login"));
		}
		return "adminCoupon";
	}

	/**
	 * 쿠폰 추가 페이지 가기
	 */
	@RequestMapping(value = "/admin/coupon/write", method = RequestMethod.GET)
	public String couponInsertPage(HttpSession session) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		return "adminCouponInsert";
	}

	/**
	 * 쿠폰 등록
	 */
	@RequestMapping(value = "/admin/coupon", method = RequestMethod.POST)
	public String couponInsert(HttpSession session, CouponDTO dto, RedirectAttributes attr) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		if (mDTO.getRole() == 1) {
			System.out.println("등록할 쿠폰 내용 " + dto);
			cService.couponInsert(dto);

			attr.addFlashAttribute("mesg", "쿠폰이 등록 되었습니다.");
		}
		return "redirect:/admin/coupon";
	}

	/**
	 * 쿠폰 수정 페이지 가기
	 */
	@RequestMapping(value = "/admin/coupon/{coupon_id}", method = RequestMethod.GET)
	public String couponUpatePage(@PathVariable String coupon_id, HttpSession session, Model m) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		if (mDTO.getRole() == 1) {
			System.out.println("수정할 쿠폰  " + coupon_id);
			CouponDTO dto = cService.couponOneSelect(coupon_id);
			System.out.println("수정할 쿠폰 내용 " + dto);

			m.addAttribute("coupon", dto);
		}
		return "adminCouponUpdate";
	}

	/**
	 * 쿠폰 수정
	 */
	@RequestMapping(value = "/admin/coupon", method = RequestMethod.PUT)
	public String couponUpdate(CouponDTO dto, HttpSession session, RedirectAttributes attr) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		if (mDTO.getRole() == 1) {
			System.out.println("수정할 쿠폰 번호  " + dto);
			cService.couponUpdate(dto);
		}
		attr.addFlashAttribute("mesg", "쿠폰이 수정 되었습니다.");

		return "redirect:/admin/coupon";
	}

	/**
	 * 쿠폰 개별 삭제
	 */
	@RequestMapping(value = "/admin/coupon/{coupon_id}", method = RequestMethod.DELETE)
	public @ResponseBody void couponDelete(@PathVariable String coupon_id) {
		System.out.println("삭제할 쿠폰 아이디 " + coupon_id);
		cService.couponDelete(coupon_id);
	}

	/**
	 * 쿠폰 전체 삭제
	 */
	@RequestMapping(value = "/admin/coupon", method = RequestMethod.DELETE)
	public String couponDelAll(@RequestParam String coupon_id, RedirectAttributes attr) {
		String[] deleteId = coupon_id.split(",");
		List<String> delCoupon = Arrays.asList(deleteId);
		System.out.println("삭제할 쿠폰 아이디들 " + delCoupon);
		cService.couponAllDel(delCoupon);

		attr.addFlashAttribute("mesg", "선택한 쿠폰이 삭제 되었습니다.");

		return "redirect:/admin/coupon";
	}
	
}