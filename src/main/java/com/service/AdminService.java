package com.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AdminDAO;
import com.dto.PageDTO;

@Service
public class AdminService {
	
	@Autowired
	AdminDAO dao;
	
	//관리자페이지 상품관리 : 전체 상품 목록
	public PageDTO selectAllProduct(HashMap<String, String> map) {
		return dao.selectAllProduct(map);
	}

}
