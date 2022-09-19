package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.StoreDAO;

@Service
public class StoreService {
	
	@Autowired
	StoreDAO dao;

}
