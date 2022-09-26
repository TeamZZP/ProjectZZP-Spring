package com.dao;

import java.util.HashMap;
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

	public ProductByCategoryDTO productRetrieve(int p_id) {
		ProductByCategoryDTO dto=template.selectOne("StoreMapper.productRetrieve",p_id);
		return dto;
	}
	
	public List<Integer> zzimAllCheck(String userid) {
		List<Integer> list = template.selectList("StoreMapper.zzimAllCheck", userid);
		return list;
	}

	public int zzimCheck(HashMap<String, String> map) {
		int n = template.selectOne("StoreMapper.zzimCheck", map);
		return n;
	}

	public void addZzim(HashMap<String, String> map) {
	int n =	template.insert("StoreMapper.addZzim", map);
		System.out.println(map+"찜성공");
	}

	public void deleteZzim(HashMap<String, String> map) {
		int n = template.delete("StoreMapper.deleteZzim", map);
		System.out.println(map+"찜삭제");
		
	}


}
