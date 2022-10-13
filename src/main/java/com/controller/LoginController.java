package com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	@RequestMapping(value = "/id" , method = RequestMethod.GET)
	public String findIdView() {
		return "findIdForm";
	}
	/**
	 * 아이디 찾기 
	 */
	@RequestMapping(value = "/id" , method = RequestMethod.POST)
	public String findId(@RequestParam HashMap<String, String> map, RedirectAttributes m) {
		System.out.println("findId map : "+map);
		MemberDTO dto = service.findId(map);
		System.out.println("findId dto : "+dto);
		if (dto!=null) {
			m.addFlashAttribute("idDTO", dto);
			return "redirect:/id/result";
		} else {
			m.addFlashAttribute("mesg", "해당 회원 정보가 없습니다:(");
			return "redirect:/id";
		}
	}
	/**
	 * 아이디 찾기 결과 화면
	 */
	@RequestMapping(value = "/id/result" , method = RequestMethod.GET)
	public String findIdResultView() {
		return "findIdresult";
	}
	/**
	 * 비밀번호 찾기 화면
	 */
	@RequestMapping(value = "/passwd" , method = RequestMethod.GET)
	public String findPwView() {
		return "findpwForm";
	}
	/**
	 * 비밀번호 찾기
	 */
	@RequestMapping(value = "/passwd" , method = RequestMethod.POST)
	public String findPw(@RequestParam HashMap<String, String> map, RedirectAttributes m, HttpSession session) {
		System.out.println("findPw map : "+map);
		MemberDTO dto = service.findPw(map);
		System.out.println("findPw dto : "+dto);
		if (dto!=null) {
			session.setAttribute("pwDTO", dto);
			return "redirect:/passwd/result";
		} else {
			m.addFlashAttribute("mesg", "해당 회원 정보가 없습니다:(");
			return "redirect:/passwd";
		}
	}
	/**
	 * 비밀번호 찾기 결화 화면
	 */
	@RequestMapping(value = "/passwd/result" , method = RequestMethod.GET)
	public String findPwResult() {
		return "findPwResult";
	}
	/**
	 * 새 비밀번호 중복 확인
	 */
	@RequestMapping(value = "/passwd/check" , method = RequestMethod.POST)
	public String pwcheck(@RequestParam HashMap<String, String> map, RedirectAttributes m) {
		System.out.println("pwcheck map : "+map);
		MemberDTO dto = service.pwcheck(map);
		System.out.println("pwcheck dto : "+dto);
		String passwd = dto.getPasswd(); //기존 비밀번호
		//기존과 동일한 비밀번호 입력할 경우
		if (passwd.equals(map.get("changedPasswd"))) {
			m.addFlashAttribute("mesg", "기존 비밀번호와 동일합니다. 다시 입력해주세요.");
			return "redirect:/passwd/result";
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
	 * 카카오 로그인
	 */
	@RequestMapping(value = "/kakaoLogin" , method = RequestMethod.POST)
	public String kakaoLogin(@RequestParam HashMap<String, String> map, HttpSession session) {
		System.out.println("kakaoLogin map : "+map);
		MemberDTO dto = service.selectMemberBySocial(map);
	    System.out.println("kakaoLogin dto : "+dto);
	    //기존 회원인 경우 로그인 처리
		if (dto!=null) {
			session.setAttribute("login", dto);
	        session.setMaxInactiveInterval(60*60);
	        return "redirect:/home";
		} 
		//새로운 회원인 경우 회원가입
		else {
			session.setAttribute("kakaoInfo", map);
			return "redirect:/join";
		}
	}
	
	/**
	 * 네이버 로그인 callback
	 */
	@RequestMapping(value = "/naver" , method = RequestMethod.GET)
	public String naver() {
		return "naverCallback";
	}
	/**
	 * 네이버 로그인
	 */
	@RequestMapping(value = "/naverLogin" , method = RequestMethod.POST)
	@ResponseBody
	public String naverLogin(String email, String username, HttpSession session) {
		System.out.println("naverLogin : "+email+" "+username);
		String mesg = "naver success";
		
		//이메일 나누기
		int emailSplit = email.indexOf("@");
		String email1 = email.substring(0, emailSplit);
		String email2 = email.substring(emailSplit+1,email.length());
		System.out.println("naverLogin email : "+email1+" "+email2);
		
		//네이버 데이터로 기존 회원 여부 확인
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("nickname", username);
		
		MemberDTO dto = service.selectMemberBySocial(map);
	    System.out.println("naverLogin dto : "+dto);
	    //새로운 회원인 경우 회원가입
		if (dto==null) {
			map.put("userid", email);
			map.put("passwd", "1");
			map.put("username", username);
			map.put("email1", email1);
			map.put("email2", email2);
			map.put("phone", "01000000000");
			map.put("post_num", "우편");
			map.put("addr1", "도로명주소");
			map.put("addr2", "지번주소");
			int num = 0;
			try {
				num = service.joinMember(map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				System.out.println(num);
				//로그인
				HashMap<String, String> Loginmap = new HashMap<String, String>();
				Loginmap.put("userid", email);
				Loginmap.put("passwd", "1");
				MemberDTO loginedto = service.loginIDCheck(Loginmap);
				System.out.println(loginedto);
				session.setAttribute("login", loginedto); 
			}
		} 
		//기존 회원인 경우 로그인 처리
		else {
			mesg = "naver fail";
			session.setAttribute("login", dto);
		}
		session.setMaxInactiveInterval(60*60);
		return mesg;
	}
	
}