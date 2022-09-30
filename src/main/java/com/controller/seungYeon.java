package com.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.AnswerDTO;
import com.dto.CouponDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.QuestionDTO;
import com.dto.QuestionProductDTO;
import com.dto.ReviewProfileDTO;
import com.service.AnswerService;
import com.service.CouponService;
import com.service.OrderService;
import com.service.QuestionService;
import com.service.ReviewService;

@Controller
public class seungYeon {

	@Autowired
	QuestionService qService;
	@Autowired
	ReviewService rService;
	@Autowired
	AnswerService aService;
	@Autowired
	OrderService oService;
	@Autowired
	CouponService cService;

	/**
	 * 상품 상세보기 qna, review
	 */
	@RequestMapping(value = "/product/{p_id}/qna")
	public String prodDetailQna(Model m) {
		String p_id = "9";
		////////////////////
		List<QuestionDTO> prodQuestion = qService.prodQuestion(p_id);
		System.out.println("상품 문의 " + prodQuestion); // Question

		List<ReviewProfileDTO> prodReview = rService.prodReview(p_id);
		System.out.println("상품 리뷰 " + prodReview); // 리뷰

		m.addAttribute("prodQuestion", prodQuestion);
		m.addAttribute("prodReview", prodReview);
		/////////////////////
		return "store/prodReview"; // prodQA.jsp,prodReview.jsp -- include 필요
	}

	/**
	 * 상품 상세보기 qna 답변보기
	 */
	@RequestMapping(value = "/product/qna", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String prodQnaAnswer(@RequestParam String q_id, HttpSession session) throws IOException {
		System.out.println("답변 볼 게시글 번호 " + q_id);
		// MemberDTO mDTO = (MemberDTO) session.getAttribute("login");

		// String userid = mDTO.getUserid();

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
		 * } else { aContent = "다른 사용자의 글 입니다"; }
		 */

		return aContent;
	}
	/**
	 * 마이페이지 내 문의 글
	 */
	/*
	 * @RequestMapping(value = "/mypage/{userid}/question", method =
	 * RequestMethod.GET) public String myQuestion(@PathVariable String
	 * userid, @RequestParam Map<String, String> map, Model m, HttpSession session)
	 * { PageDTO pDTO = qService.myQuestion(userid, map);
	 * System.out.println("내 문의 게시글 " + pDTO);
	 * 
	 * m.addAttribute("orderList", pDTO); m.addAttribute("mDTO",
	 * session.getAttribute("login"));
	 * 
	 * return "myQuestion"; }
	 *//**
		 * 마이페이지 내 리뷰 내역
		 */
	/*
	 * @RequestMapping(value = "/mypage/{userid}/review", method =
	 * RequestMethod.GET) public String myReview(@PathVariable String userid,
	 * 
	 * @RequestParam Map<String, String> map, Model m, HttpSession session) {
	 * PageDTO pDTO = rService.myReview(userid, map); System.out.println("내 리뷰 내역 "
	 * + pDTO);
	 * 
	 * m.addAttribute("myReview", pDTO); m.addAttribute("mDTO",
	 * session.getAttribute("login"));
	 * 
	 * return "myReview"; }
	 *//**
		 * 마이페이지 내 구매내역
		 */
	/*
	 * @RequestMapping(value = "/mypage/{userid}/order", method = RequestMethod.GET)
	 * public String myOrder(@PathVariable String userid,
	 * 
	 * @RequestParam Map<String, String> map, Model m, HttpSession session) {
	 * map.put("userid", userid); System.out.println(map);
	 * 
	 * PageDTO pDTO = oService.myOrder(map); System.out.println("내 주문 내역 " + pDTO);
	 * 
	 * m.addAttribute("myOrder", pDTO); m.addAttribute("search", map);
	 * m.addAttribute("mDTO", session.getAttribute("login")); return "myOrder"; }
	 *//**
		 * 마이페이지 리뷰 작성 여부 확인 ajax
		 */
	/*
	 * @RequestMapping(value = "/orders/review", method = RequestMethod.POST)
	 * public @ResponseBody int reviewCheck(@RequestParam Map<String,String> map) {
	 * System.out.println(map); ReviewDTO dto = rService.reviewCheck(map);
	 * System.out.println("리뷰 작성 여부 " + dto);
	 * 
	 * int review_id = 0; if (dto != null) { review_id = dto.getReview_id(); } else
	 * { review_id = 0; } return review_id; }
	 *//**
		 * 마이페이지 내 쿠폰함
		 *//*
			 * @RequestMapping(value = "/mypage/{userid}/coupon", method =
			 * RequestMethod.GET) public String myCoupon(@PathVariable String userid,
			 * 
			 * @RequestParam Map<String, String> map, Model m, HttpSession session) {
			 * map.put("userid", userid); System.out.println(map);
			 * System.out.println("페이지, 검색어, 유저아이디 " + map);
			 * 
			 * PageDTO pDTO = cService.myCoupon(map); System.out.println("내 쿠폰 내역 " + pDTO);
			 * 
			 * m.addAttribute("myCoupon", pDTO); m.addAttribute("search", map);
			 * m.addAttribute("mDTO", session.getAttribute("login")); return "myCoupon"; }
			 */

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
	@RequestMapping(value = "/admin/coupon", method = RequestMethod.DELETE)
	public @ResponseBody void couponDelete(String coupon_id) {
		System.out.println("삭제할 쿠폰 아이디 " + coupon_id);
		cService.couponDelete(coupon_id);
	}

	/**
	 * 쿠폰 전체 삭제
	 */
	@RequestMapping(value = "/admin/coupon/{coupon_id}", method = RequestMethod.DELETE)
	public String couponDelAll(String coupon_id, RedirectAttributes attr) {
		String[] deleteId = coupon_id.split(",");
		List<String> delCoupon = Arrays.asList(deleteId);
		System.out.println("삭제할 쿠폰 아이디들 " + delCoupon);
		cService.couponAllDel(delCoupon);

		attr.addFlashAttribute("mesg", "선택한 쿠폰이 삭제 되었습니다.");

		return "redirect:/admin/coupon";
	}

}
