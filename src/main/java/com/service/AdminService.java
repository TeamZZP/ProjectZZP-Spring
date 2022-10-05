package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	//관리자 페이지 회원 관리 : 회원 삭제
	public void deleteMember(String userid) {
		dao.deleteMember(userid);
	}
	
	//관리자 페이지 회원 관리 : 회원 정보 조회
	public MemberDTO selectMember(String userid) {
		return dao.selectMember(userid);
	}
	
	//관리자 페이지 회원 관리 : 회원 배송지 목록 조회
	public List<AddressDTO> selectAllAddress(String userid) {
		return dao.selectAllAddress(userid);
	}
	
	//관리자 페이지 회원 관리 : 회원 정보 수정
	public void updateMember(HashMap<String, String> map) {
		dao.updateMember(map);
	}
	
	//상품관리 : 전체 상품 목록
		public PageDTO selectAllProduct(HashMap<String, String> map) {
			return dao.selectAllProduct(map);
	}
		
	//상품관리 : 상품 삭제
	public int deleteProduct(List<String> ids) {
		return dao.deleteProduct(ids);
	}
	
	//상품관리 : 상품 삭제(이미지)
	public List<ImagesDTO> productImages(List<String> ids) {
		return dao.productImages(ids);
	}
	
	//상품관리 : 상품 수정페이지(상품)
	public ProductDTO productRetrieve(int p_id) {
		return dao.productRetrieve(p_id);
	}
	
	//상품관리 : 상품 수정페이지(이미지)
	public List<ImagesDTO> ImagesRetrieve(int p_id) {
		return dao.ImagesRetrieve(p_id);
	}
	
	//상품관리 : 상품 등록
	public void insertProduct(HashMap<String, String> map) {
		dao.insertProduct(map);
	}
	
	//상품관리 : 상품 수정
	public void updateProduct(HashMap<String, String> map) {
		dao.updateProduct(map);
	}
	
	//상품관리 : 상품 수정(기존 이미지 삭제)
	public void deleteImages(HashMap<String, String> map) {
		dao.deleteImages(map);
	}
	
	//상품관리 : 상품 수정(새 이미지 등록)
	public void insertImages(HashMap<String, String> map) {
		dao.insertImages(map);
	}

	//신고관리 : 전체 조회
	public PageDTO selectAllReport(HashMap<String, String> map) {
		return dao.selectAllReport(map);
	}

	//주문관리 : 전체 조회
	public PageDTO selectAllOrders(HashMap<String, String> map) {
		return dao.selectAllOrders(map);
	}
	
	//챌린지관리 : 챌린지 등록
	@Transactional
	public void addAdminChallenge(HashMap<String, String> map) {
		//현재 진행중인 이 달의 챌린지 게시글 1=>0으로 변경
		HashMap<String, Integer> updateMap = new HashMap<String, Integer>();
		updateMap.put("before", 1);
		updateMap.put("after", 0);
		dao.updateChallThisMonth(updateMap);
		
		//챌린지 게시글 추가
		dao.insertAdminChallenge(map);
	}

	

}
