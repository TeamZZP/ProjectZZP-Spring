package com.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.AnswerDTO;
import com.dto.PageDTO;
import com.dto.QuestionDTO;
import com.dto.QuestionProductDTO;
import com.dto.ReviewProfileDTO;
import com.service.AnswerService;
import com.service.OrderService;
import com.service.QuestionService;
import com.service.reviewService;

@Controller
public class seungYeon {

	@Autowired
	QuestionService qService;
	@Autowired
	reviewService rService;
	@Autowired
	AnswerService aService;
	@Autowired
	OrderService oService;
	
	/**
	 * 상품 상세보기 qna, review
	 */
	@RequestMapping(value = "/product/{p_id}/qna")
	public String prodDetailQna(Model m) {
		String p_id = "9";
		////////////////////
		List<QuestionDTO> prodQuestion = qService.prodQuestion(p_id);
		System.out.println("상품 문의 " + prodQuestion); // Question

		List<ReviewProfileDTO> pordReview = rService.pordReview(p_id);
		System.out.println("상품 리뷰 " + pordReview); // 리뷰

		m.addAttribute("prodQuestion", prodQuestion);
		m.addAttribute("pordReview", pordReview);
		/////////////////////
		return "store/prodReview"; // prodQA.jsp,prodReview.jsp include 필요 
	}

	/**
	 * 상품 상세보기 qna 답변보기
	 */
	@RequestMapping(value = "/product/qna", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String prodQnaAnswer(@RequestParam String q_id, HttpSession session) throws IOException {
		System.out.println("답변 볼 게시글 번호 " + q_id);
		// MemberDTO mDTO = (MemberDTO) session.getAttribute("login");

		//String userid = mDTO.getUserid();

		QuestionProductDTO qDTO = qService.questionDetail(q_id);
		System.out.println("답변 볼 게시글 " + qDTO);
		String writer = qDTO.getUserid();

		String aContent = "";
		// if (userid.equals(writer)) {
		AnswerDTO aDTO = aService.answerSelect(q_id);
		System.out.println("답변 " + aDTO);
		if (aDTO != null) {
			aContent = aDTO.getAnswer_content();

		} else {
			aContent = "답변대기";

		}
		/*
		 * } else {
		 * 	 aContent = "다른 사용자의 글 입니다";
		 * }
		 */

		return aContent;
	}
	/**
	 * 마이페이지 내 문의 글
	 */
	@RequestMapping(value = "/mypage/{userid}/question", method = RequestMethod.GET)
	public String myQuestion(@PathVariable String userid, @RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO =  qService.myQuestion(userid, map);
		System.out.println("내 문의 게시글 " + pDTO);
		
		m.addAttribute("orderList", pDTO);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "myQuestion";
	}
	/**
	 * 마이페이지 내 리뷰 내역
	 */
	@RequestMapping(value = "/mypage/{userid}/review", method = RequestMethod.GET)
	public String myReview(@PathVariable String userid, 
			@RequestParam Map<String, String> map, Model m, HttpSession session) {
		PageDTO pDTO = rService.myReview(userid, map);
		System.out.println("내 리뷰 내역 " + pDTO);
		
		m.addAttribute("myReview", pDTO);
		m.addAttribute("mDTO", session.getAttribute("login"));
		
		return "myReview";
	}
	/**
	 * 마이페이지 내 구매내역
	 */
	@RequestMapping(value = "/mypage/{userid}/order", method = RequestMethod.GET)
	public String myOrder(@PathVariable String userid, 
			@RequestParam Map<String, String> map, Model m, HttpSession session) {
		map.put("userid", userid);
		System.out.println(map);
		
		PageDTO pDTO = oService.myOrder(map);
		System.out.println("내 주문 내역 " + pDTO);
		
		m.addAttribute("myOrder", pDTO);
		m.addAttribute("search", map);
		m.addAttribute("mDTO", session.getAttribute("login"));
		return "myOrder";
	}
}
