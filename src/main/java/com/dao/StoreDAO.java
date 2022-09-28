package com.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CategoryDTO;
import com.dto.ImagesDTO;
import com.dto.PageDTO;
import com.dto.ProductByCategoryDTO;
import com.dto.ProductDTO;

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



	public ProductDTO productRetrieve(int p_id) {
		ProductDTO dto=template.selectOne("StoreMapper.productRetrieve",p_id);
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
	
	//관리자페이지 상품관리 : 전체 상품 목록
	public PageDTO selectAllProduct(HashMap<String, String> map) {
		int curPage = Integer.parseInt(
					  Optional.ofNullable(map.get("page")) //현제 페이지 null이면
					  .orElse(("1"))//1로 설정
				);
		PageDTO pDTO = new PageDTO();
		pDTO.setPerPage(10);//한 페이지 당 record 10개 씩
		int perPage = pDTO.getPerPage();
		int offset = (curPage-1)*perPage; //페이지 시작 idx
		
		List<ProductByCategoryDTO> list = template.selectList("selectAllProduct", map, new RowBounds(offset, perPage));
		
		pDTO.setPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(countTotalAdmin(map));
		
		pDTO.setStartEndPages();//startPage, endPage, prev, next 생성 함수 호출
		
		return pDTO;
	}
	//관리자페이지 상품관리 : 전체 상품 목록 페이징 countTotal
	private int countTotalAdmin(HashMap<String, String> map) {
		return template.selectOne("countTotalAdmin", map);
	}

	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		List<ImagesDTO> list = template.selectList("StoreMapper.ImagesRetrieve",p_id);
		return list;
	}


}
