package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CategoryDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;

@Repository
public class StoreDAO {
	@Autowired
	SqlSessionTemplate template;

	public List<CategoryDTO> category() {
		List<CategoryDTO> cList = template.selectList("StoreMapper.category");
		return cList;
	}
	
	public int countAllProduct() {
		int count = template.selectOne("StoreMapper.countAllProduct");
	return count;
	}

	public PageDTO bestProduct() {
		    int curPage = 1;
		    PageDTO pDTO = new PageDTO();
			pDTO.setPerPage(12);
			int perPage = pDTO.getPerPage();
			int offset = (curPage-1)*perPage;
			List<ProductByCategoryDTO> list= template.selectList("StoreMapper.bestProduct","",new RowBounds(offset, perPage));
			pDTO.setPage(curPage);
			pDTO.setList(list);
			pDTO.setTotalCount(countAllProduct());
			pDTO.setStartEndPages();
			System.out.println("bestDAO list개수"+list.size());
		 return pDTO;
	}

	public PageDTO productByCategory(int c_id) {
			int curPage = 1;
		    PageDTO pDTO = new PageDTO();
			pDTO.setPerPage(12);
			int perPage = pDTO.getPerPage();
			int offset = (curPage-1)*perPage;
			List<ProductByCategoryDTO> list = template.selectList("StoreMapper.productByCategory", c_id,new RowBounds(offset, perPage));
			pDTO.setPage(curPage);
			pDTO.setList(list);
			pDTO.setTotalCount(countAllProduct());
			pDTO.setStartEndPages();
			System.out.println("DAO list개수"+list.size());
			return pDTO;
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
