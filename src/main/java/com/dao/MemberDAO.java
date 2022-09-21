package com.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.dto.MemberDTO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate session;
	
	//로그인 ID 확인
	public MemberDTO loginIDCheck(Map<String, String> map) {
		return session.selectOne("loginIDCheck", map);
	}
	
	//로그인
	public MemberDTO login(Map<String, String> map) {
		return session.selectOne("login", map);
	}
	
	//회원가입
	public int joinMember (Map<String, String> map) throws Exception {
		return session.insert("joinMember",map);
	}
	
	
	
}