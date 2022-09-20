package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.StoreDAO;
import com.dto.CategoryDTO;

@Service
public class StoreService {
	
	@Autowired
	StoreDAO dao;

	//카테고리List
	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = dao.category();
		return cList;
	}

}
