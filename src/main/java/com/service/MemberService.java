package com.service;

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
	
}