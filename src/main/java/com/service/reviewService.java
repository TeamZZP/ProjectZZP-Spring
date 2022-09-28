package com.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.reviewDAO;
import com.dto.PageDTO;
import com.dto.ReviewProfileDTO;

@Service
public class reviewService {

	@Autowired
	reviewDAO dao;

	public List<ReviewProfileDTO> pordReview(String p_id) {
		List<ReviewProfileDTO> list = dao.pordReview(p_id);
		return list;
	}

	public PageDTO myReview(String userid, Map<String, String> map) {
		PageDTO dto = dao.myReview(userid, map);
		return dto;
	}
	
}
