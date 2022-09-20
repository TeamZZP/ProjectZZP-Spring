package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dao.MypageDAO;

@Service
public class MypageService {
	@Autowired
	private MypageDAO dao;
	
}