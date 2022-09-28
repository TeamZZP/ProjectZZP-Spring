package com.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.PageDTO;
import com.dto.ProductOrderImagesDTO;

@Repository
public class OrderDAO {

	@Autowired
	SqlSessionTemplate session;

	public PageDTO myOrder(Map<String, String> map) {
		int curPage = Integer.parseInt(Optional.ofNullable(map.get("page")).orElse("1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(5);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<ProductOrderImagesDTO> list = session.selectList("OrderMapper.myOrder", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(myOrderCount(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	public int myOrderCount(Map<String, String> map) {
		return session.selectOne("OrderMapper.myOrderCount", map);
	}
	
}
