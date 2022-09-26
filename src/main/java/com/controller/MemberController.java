package com.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService service;
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
}
