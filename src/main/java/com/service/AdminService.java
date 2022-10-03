package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AdminDAO;
import com.dto.AddressDTO;
import com.dto.ImagesDTO;
import com.dto.MemberDTO;
import com.dto.PageDTO;
import com.dto.ProductDTO;

@Service
public class AdminService {
	
	@Autowired
	AdminDAO dao;
	
	//회원 관리 : 전체 회원 목록
	public PageDTO selectAllMember(HashMap<String, String> map) {
		return dao.selectAllMember(map);
	}
	
	//회원 관리 : 회원 삭제
	public void deleteMember(String userid) {
		dao.deleteMember(userid);
	}
	
	//회원 관리 : 회원 정보 조회
	public MemberDTO selectMember(String userid) {
		return dao.selectMember(userid);
	}
	
	//회원 관리 : 회원 배송지 목록 조회
	public List<AddressDTO> selectAllAddress(String userid) {
		return dao.selectAllAddress(userid);
	}
	
	//회원 관리 : 회원 정보 수정
	public void updateMember(HashMap<String, String> map) {
		dao.updateMember(map);
	}
	
	//상품관리 : 전체 상품 목록
		public PageDTO selectAllProduct(HashMap<String, String> map) {
			return dao.selectAllProduct(map);
	}
		
	//상품관리 : 상품 삭제
	public void deleteProduct(List<String> ids) {
		dao.deleteProduct(ids);
	}
	
	//상품관리 : 상품 수정페이지(상품)
	public ProductDTO productRetrieve(int p_id) {
		return dao.productRetrieve(p_id);
	}
	
	//상품관리 : 상품 수정페이지(이미지)
	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		return dao.ImagesRetrieve(p_id);
	}

}
