package com.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired
	private MemberDAO dao;
	
	//로그인 ID 확인
	public MemberDTO loginIDCheck(Map<String, String> map) {
		return dao.loginIDCheck(map);
	}
	
	//로그인
	public MemberDTO login(Map<String, String> map) {
		return dao.login(map);
	}
	
	//회원가입
	public int joinMember(Map<String, String> map) throws Exception {
		int num = dao.joinMember(map);
		return num;
	}
	
	//회원가입 아이디 중복 확인
	public MemberDTO checkID(String userid) {
		return dao.checkID(userid);
	}
	
	//회원가입 전화번호 중복 확인
	public MemberDTO checkPhone(String phone) {
		return dao.checkPhone(phone);
	}
	
	//아이디 찾기 
	public MemberDTO findId(HashMap<String, String> map) {
		return dao.findId(map);
	}
	
	//비밀번호 찾기
	public MemberDTO findPw(HashMap<String, String> map) {
		return dao.findPw(map);
	}
	
	//새 비밀번호 중복 확인
	public MemberDTO pwcheck(HashMap<String, String> map) {
		return dao.pwcheck(map);
	}
	
	//새 비밀번호 변경
	public int changePw(HashMap<String, String> map) {
		return dao.changePw(map);
	}
	

}