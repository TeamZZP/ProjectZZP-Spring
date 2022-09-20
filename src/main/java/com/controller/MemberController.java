package com.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	 * 회원가입 화면
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
				nextPage = "redirect:/";
			} else if (num==0) {
				m.addFlashAttribute("mesg", "다시 시도해 주시기 바랍니다.");
				nextPage = "redirect:/join";
			}
		}
		return nextPage;
	}

}
