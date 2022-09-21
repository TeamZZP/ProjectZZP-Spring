package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.StoreDAO;
import com.dto.CategoryDTO;
import com.dto.ProductByCategoryDTO;
import com.dto.ProductDTO;

@Service
public class StoreService {
	
	@Autowired
	StoreDAO dao;

	//카테고리List
	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = dao.category();
		return cList;
	}

	 public List<ProductByCategoryDTO> bestProduct() {
		 List<ProductByCategoryDTO> list = dao.bestProduct();
		return list;
	}

	public List<ProductByCategoryDTO> productByCategory(int c_id) {
		List<ProductByCategoryDTO> prodByCateList = dao.productByCategory(c_id);
		return prodByCateList;
	}

}
