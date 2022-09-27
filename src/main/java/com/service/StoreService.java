package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.StoreDAO;
import com.dto.CategoryDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;

@Service
public class StoreService {
	
	@Autowired
	StoreDAO dao;

	//카테고리List
	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = dao.category();
		return cList;
	}

	 public PageDTO bestProduct() {
		 return dao.bestProduct();
	}

	public PageDTO productByCategory(int c_id) {
		return  dao.productByCategory(c_id);

	}

	public ProductByCategoryDTO productRetrieve(int p_id) {
		ProductByCategoryDTO dto= dao.productRetrieve(p_id);
		return dto;
	}
	
	public List<Integer> zzimAllCheck(String userid) {
		List<Integer> list = dao.zzimAllCheck(userid);
		return list;
	}

	public int zzimCheck(HashMap<String, String> map) {
		int n = dao.zzimCheck(map);
		return n;
	}

	public void addZzim(HashMap<String, String> map) {
		dao.addZzim(map);
		
	}

	public void deleteZzim(HashMap<String, String> map) {
		dao.deleteZzim(map);
		
	}
	
	//관리자페이지 상품관리 : 전체 상품 목록
	public PageDTO selectAllProduct(HashMap<String, String> map) {
		return dao.selectAllProduct(map);
	}

}
