package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.OrderDAO;
import com.dto.PageDTO;

@Service
public class OrderService {

	@Autowired
	OrderDAO dao;

	public PageDTO myOrder(Map<String, String> map) {
		PageDTO dto = dao.myOrder(map);
		return dto;
	}
	
}
