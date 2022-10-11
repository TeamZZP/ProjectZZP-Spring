package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.PageDTO;
import com.dto.ProductImagesDTO;
import com.dto.QuestionDTO;
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
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(questionListCount());
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int questionListCount() {
		return session.selectOne("QuestionMapper.questionListCount");
	}
	
	public PageDTO prodSelect(Map<String, String> map, int prodNum) {
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(prodNum);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<ProductImagesDTO> list = session.selectList("QuestionMapper.prodSelect", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(prodSelectCount(map));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	public int prodSelectCount(Map<String, String> map) {
		return session.selectOne("QuestionMapper.prodSelectCount", map);
	}
	public QuestionProductDTO questionDetail(String q_id) {
		QuestionProductDTO dto = session.selectOne("QuestionMapper.questionDetail", q_id);
		return dto;
	}
	public void questionDelete(String q_id) {
		int num = session.delete("QuestionMapper.questionDelete", q_id);
		System.out.println("삭제된 게시글 갯수 " + num);
	}
	public void questionStatus(String q_id) {
		int num = session.update("QuestionMapper.questionStatus", q_id);
		System.out.println("답변 상태 수정 갯수 " + num);
	}
	public void questionInsert(HashMap<String, String> map) {
		int num = session.insert("QuestionMapper.questionInsert", map);
		System.out.println("게시글 작성 갯수 " + num);
	}
	public void questionUpdate(Map<String, String> map) {
		int num = session.update("QuestionMapper.questionUpdate", map);
		System.out.println("게시글 수정 갯수 " + num);
	}
	public List<QuestionDTO> prodQuestion(String p_id) {
		List<QuestionDTO> list = session.selectList("QuestionMapper.prodQuestion", p_id);
		return list;
	}
	public PageDTO myQuestion(String userid, Map<String, String> map) {
		PageDTO pDTO = new PageDTO();
		int curPage = Integer.parseInt(map.getOrDefault("page", "1"));
		pDTO.setPerPage(10);
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<QuestionProductDTO> list = session.selectList("QuestionMapper.myQuestion", userid, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(myQuestionCount(userid));
		
		pDTO.setStartEndPages();
		
		return pDTO;
	}
	private int myQuestionCount(String userid) {
		return session.selectOne("QuestionMapper.myQuestionCount", userid);
	}

}
