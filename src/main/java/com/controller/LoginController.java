package com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	/**
	 * 아이디 찾기 화면
	 */
	@RequestMapping(value = "/loginid" , method = RequestMethod.GET)
	public String findIdView() {
		return "findIdForm";
	}
	/**
	 * 아이디 찾기 
	 */
	@RequestMapping(value = "/loginid" , method = RequestMethod.POST)
	public String findId(@RequestParam HashMap<String, String> map, RedirectAttributes m) {
		System.out.println("findId map : "+map);
		MemberDTO dto = service.findId(map);
		System.out.println("findId dto : "+dto);
		if (dto!=null) {
			m.addFlashAttribute("idDTO", dto);
			return "redirect:/findIdresult";
		} else {
			m.addFlashAttribute("mesg", "해당 회원 정보가 없습니다:(");
			return "redirect:/loginid";
		}
	}
	/**
	 * 아이디 찾기 결과 화면
	 */
	@RequestMapping(value = "/findIdresult" , method = RequestMethod.GET)
	public String findIdResultView() {
		return "findIdresult";
	}
	/**
	 * 비밀번호 찾기 화면
	 */
	@RequestMapping(value = "/loginpw" , method = RequestMethod.GET)
	public String findPwView() {
		return "findpwForm";
	}
	/**
	 * 비밀번호 찾기
	 */
	@RequestMapping(value = "/loginpw" , method = RequestMethod.POST)
	public String findPw(@RequestParam HashMap<String, String> map, RedirectAttributes m) {
		System.out.println("findPw map : "+map);
		MemberDTO dto = service.findPw(map);
		if (dto!=null) {
			m.addFlashAttribute("pwDTO", dto);
			return "redirect:/findPwresult";
		} else {
			m.addFlashAttribute("mesg", "해당 회원 정보가 없습니다:(");
			return "redirect:/loginpw";
		}
	}
	/**
	 * 비밀번호 찾기 결화 화면
	 */
	@RequestMapping(value = "/findPwresult" , method = RequestMethod.GET)
	public String findPwResult() {
		return "findPwResult";
	}
	/**
	 * 새 비밀번호 중복 확인
	 */
	@RequestMapping(value = "/pwcheck" , method = RequestMethod.POST)
	public String pwcheck(@RequestParam HashMap<String, String> map, RedirectAttributes m) {
		System.out.println("pwcheck map : "+map);
		MemberDTO dto = service.pwcheck(map);
		System.out.println("pwcheck dto : "+dto);
		String passwd = dto.getPasswd(); //기존 비밀번호
		//기존과 동일한 비밀번호 입력할 경우
		if (passwd.equals(map.get("changedPasswd"))) {
			m.addFlashAttribute("mesg", "기존 비밀번호와 동일합니다. 다시 입력해주세요.");
			return "redirect:/findPwresult";
		} 
		//새 비밀번호 변경
		else {
			int num = service.changePw(map);
			System.out.println("changePw num : "+num);
			m.addFlashAttribute("mesg", "비밀번호가 변경되었습니다:)");
			return "redirect:/login";
		}
	}
	/**
	 * 비밀번호 변경
	 */
//	@RequestMapping(value = "/pwchange" , method = RequestMethod.GET)
//	public void changePw(@RequestParam String userid, @RequestParam String changedPasswd, RedirectAttributes m) {
//		System.out.println("changePw : "+userid+" "+changedPasswd);
//		
//		
//	}
}