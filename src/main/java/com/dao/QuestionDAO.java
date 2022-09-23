package com.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.PageDTO;
import com.dto.ProductImagesDTO;
import com.dto.QuestionProductDTO;

@Repository
public class QuestionDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public PageDTO questionPage(int curPage) {
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<QuestionProductDTO> list = session.selectList("QuestionMapper.questionList", null, new RowBounds(offset, perPage));
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(questionListCount());
		
		return pDTO;
	}
	private int questionListCount() {
		return session.selectOne("QuestionMapper.questionListCount");
	}
	
	public PageDTO prodSelect(Map<String, String> map, int curPage, int prodNum) {
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(prodNum);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<ProductImagesDTO> list = session.selectList("QuestionMapper.prodSelect", map, new RowBounds(offset, perPage));
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(prodSelectCount(map));
		
		return pDTO;
	}
	public int prodSelectCount(Map<String, String> map) {
		return session.selectOne("QuestionMapper.prodSelectCount", map);
	}

}
