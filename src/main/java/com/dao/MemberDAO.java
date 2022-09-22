package com.dao;

import java.util.HashMap;
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
	
	//회원가입 아이디 중복 확인
	public MemberDTO checkID(String userid) {
		return session.selectOne("checkID", userid);
	}
	
	//회원가입 전화번호 중복 확인
	public MemberDTO checkPhone(String phone) {
		return session.selectOne("checkPhone", phone);
	}
	
	//아이디 찾기
	public MemberDTO findId(HashMap<String, String> map) {
		return session.selectOne("findId", map);
	}
	
	//비밀번호 찾기
	public MemberDTO findPw(HashMap<String, String> map) {
		return session.selectOne("findPw", map);
	}
	
	//새 비밀번호 중복 확인
	public MemberDTO pwcheck(HashMap<String, String> map) {
		return session.selectOne("pwcheck", map);
	}
	
	//새 비밀번호 변경
	public int changePw(HashMap<String, String> map) {
		return session.update("changePw",map);
	}

	
}