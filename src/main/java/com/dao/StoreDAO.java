package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CategoryDTO;
import com.dto.ProductByCategoryDTO;

@Repository
public class StoreDAO {
	@Autowired
	SqlSessionTemplate template;

	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = template.selectList("StoreMapper.category");
		return cList;
	}

	public List<ProductByCategoryDTO> bestProduct() {
		 List<ProductByCategoryDTO> list= template.selectList("StoreMapper.bestProduct");
		return list;
	}

	public List<ProductByCategoryDTO> productByCategory(int c_id) {
		List<ProductByCategoryDTO> productByCategory = template.selectList("StoreMapper.productByCategory", c_id);
		return productByCategory;
	}
	
	


}
