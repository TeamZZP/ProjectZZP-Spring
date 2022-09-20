package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CategoryDTO;

@Repository
public class StoreDAO {
	@Autowired
	SqlSessionTemplate template;

	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = template.selectList("StoreMapper.category");
		return cList;
	}
	
	


}
