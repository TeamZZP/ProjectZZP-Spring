package com.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.ProductOrderReviewDTO;
import com.service.reviewService;

@Controller
public class ReviewController {

	@Autowired
	reviewService rService;
	
	/**
	 * 리뷰 작성 페이지 가기
	 */
	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String reviewInsertPage(@RequestParam Map<String, String> map, Model m, HttpSession session) {
		System.out.println("리뷰 작성 주문번호, 상품이름, 상품아이디 " + map);
		m.addAttribute("review", map);
		m.addAttribute("mDTO", session.getAttribute("login"));
		return "reviewInsert";
	}
	/**
	 * 리뷰 작성
	 */
	@RequestMapping(value = "/review", method = RequestMethod.POST)
	public String reviewInsert(@RequestParam HashMap<String, String> map, @RequestParam String userid,
			@RequestParam("review_img") CommonsMultipartFile uploadFile, RedirectAttributes attr) {
		
		long size = uploadFile.getSize();
		String name= uploadFile.getName();
		String originalFileName= uploadFile.getOriginalFilename();
		String contentType= uploadFile.getContentType();
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//review";
		
		File f= new File(location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("review_img", originalFileName);
		
		rService.reviewInsert(map);
		
		attr.addFlashAttribute("mesg", "리뷰가 작성되었습니다.");
		
		return "redirect:/mypage/"+userid+"/review";
	}
	/**
	 * 리뷰 수정 페이지 가기
	 */
	@RequestMapping(value = "/review/{review_id}", method = RequestMethod.GET)
	public String reviewUpdatePage(@PathVariable String review_id, Model m, HttpSession session) {
		System.out.println("수정할 리뷰아이디 " + review_id);
		ProductOrderReviewDTO dto = rService.reviewOneSelect(review_id);
		System.out.println("수정할 리뷰 게시글 " + dto);
		
		m.addAttribute("review", dto);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "reviewUpdate";
	}
	/**
	 * 리뷰 수정
	 */
	@RequestMapping(value = "/review/{review_id}", method = RequestMethod.POST)
	public String reviewUpdate(@RequestParam HashMap<String, String> map, @RequestParam String userid,
			@RequestParam("review_img") CommonsMultipartFile uploadFile, RedirectAttributes attr) {
		
		long size = uploadFile.getSize();
		String name= uploadFile.getName();
		String originalFileName= uploadFile.getOriginalFilename();
		String contentType= uploadFile.getContentType();
		System.out.println("size:  "+ size);
		System.out.println("name:  "+ name);
		System.out.println("originalFileName:  "+ originalFileName);
		System.out.println("contentType:  "+ contentType);
		
		String location = "C://eclipse//spring_zzp//workspace//ProjectZZP-Spring//src//main//webapp//resources//upload//review";
		
		File f= new File(location, originalFileName);
		try {
			uploadFile.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("review_img", originalFileName);
		
		rService.reviewUpate(map);
		
		attr.addFlashAttribute("mesg", "리뷰가 수정되었습니다.");
		
		return "redirect:/mypage/"+userid+"/review";
	}
	/**
	 * 리뷰 삭제
	 */
	@RequestMapping(value = "/review/{review_id}", method = RequestMethod.DELETE)
	public @ResponseBody int reviewDelete(@PathVariable String review_id, RedirectAttributes attr) {
		System.out.println("삭제할 리뷰 아이디 " + review_id);
		int num = rService.reviewDelete(review_id);
		System.out.println("삭제된 리뷰 갯수 " + num);
		
		return num;
	}
	
}
