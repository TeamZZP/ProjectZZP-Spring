package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	@Autowired
	private MemberService service;
	
	/**
	 * 로그인 화면
	 */
	@RequestMapping(value = "/login" , method = RequestMethod.GET)
	public String loginView() {
		return "loginForm";
	}
	/**
	 * 로그인 처리
	 */
	@RequestMapping(value = "/login" , method = RequestMethod.POST)
	public String login(@RequestParam Map<String,String> map, RedirectAttributes m, HttpSession session) {
		//아이디 확인
		MemberDTO idDTO = service.loginIDCheck(map);
		//비밀번호 확인
		if (idDTO!=null) {
			MemberDTO dto = service.login(map);
			//로그인
			if (dto!=null) {
				session.setAttribute("login", dto);
				session.setMaxInactiveInterval(60*60);
				return "redirect:/home";
			} else {
			//비밀번호 틀림
				m.addFlashAttribute("mesg", "비밀번호가 틀렸습니다:(");
				return "redirect:/login";
			}
		} else {
			//회원정보 없음
			m.addFlashAttribute("mesg", "일치하는 회원이 없습니다:(");
			return "redirect:/login";
		}
	}
	/**
	 * 로그아웃
	 */
	@RequestMapping(value = "/logout" , method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes m) {
		session.invalidate();
		m.addFlashAttribute("mesg", "다음에 또 만나요!");
		return "redirect:/";
	}

}
