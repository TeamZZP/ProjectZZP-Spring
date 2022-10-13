package com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ReviewDAO;
import com.dto.PageDTO;
import com.dto.ProductOrderReviewDTO;
import com.dto.ReviewDTO;
import com.dto.ReviewProfileDTO;

@Service
public class ReviewService {

	@Autowired
	ReviewDAO dao;  

	public List<ReviewProfileDTO> prodReview(String p_id) {
		List<ReviewProfileDTO> list = dao.prodReview(p_id);
		return list;
	}

	public PageDTO myReview(String userid, Map<String, String> map) {
		PageDTO dto = dao.myReview(userid, map);
		return dto;
	}

	public ReviewDTO reviewCheck(Map<String, String> map) {
		ReviewDTO dto = dao.reviewCheck(map);
		return dto;
	}

	public void reviewInsert(HashMap<String, String> map) {
		dao.reviewInsert(map);
	}

	public ProductOrderReviewDTO reviewOneSelect(String review_id) {
		ProductOrderReviewDTO dto = dao.reviewOneSelect(review_id);
		return dto;
	}

	public void reviewUpate(HashMap<String, String> map) {
		dao.reviewUpate(map);
	}

	public int reviewDelete(String review_id) {
		int num = dao.reviewDelete(review_id);
		return num;
	}

}