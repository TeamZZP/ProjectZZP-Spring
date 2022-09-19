package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	
	
}