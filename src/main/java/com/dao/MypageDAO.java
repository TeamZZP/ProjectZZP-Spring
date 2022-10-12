package com.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AddressDTO;
import com.dto.MemberDTO;
import com.dto.ProfileDTO;

@Repository
public class MypageDAO {
	@Autowired
	private SqlSessionTemplate session;

	public int countReview(String userid) {
		int n=session.selectOne("MypageMapper.countReview", userid);
		return n;
	}

	public int countCoupon(String userid) {
		int n=session.selectOne("MypageMapper.countCoupon", userid);
		return n;
	}

	public int countStamp(String userid) {
		int n=session.selectOne("MypageMapper.countStamp", userid);
		return n;
	}

	public int countChallenge(String userid) {
		int n=session.selectOne("MypageMapper.countChallenge", userid);
		return n;
	}
	
	public MemberDTO selectMember(String userid) {
		MemberDTO member=session.selectOne("MypageMapper.selectMember", userid);
		return member;
	}
	
	public AddressDTO selectDefaultAddress(String userid) {
		AddressDTO address=session.selectOne("MypageMapper.selectDefaultAddress", userid);
		return address;
	}

	public void updateAccount(HashMap<String, Object> map) {
		int m=session.update("MypageMapper.updateMember", map);
		int a=session.update("MypageMapper.updateAddress", map);
		System.out.println("계정 정보 수정 : "+m);
		System.out.println("계정 주소 수정 : "+a);
	}

	public List<AddressDTO> selectAllAddress(String userid) {
		List<AddressDTO> list=session.selectList("MypageMapper.selectAllAddress", userid);
		return list;
	}

	public void accountDelete(String userid) {
		int n=session.delete("MypageMapper.deleteMember", userid);
		System.out.println("계정 삭제 : "+n);
	}

	public void deleteAddress(int address_id) {
		int n=session.delete("MypageMapper.deleteAddress", address_id);
		System.out.println("배송지 삭제 : "+n);
	}

	public void addAddress(AddressDTO address) {
		int n=session.insert("MypageMapper.addAddress", address);
		System.out.println("배송지 추가 : "+n);
	}

	public void changeNotDefaultAddress(String userid) {
		int n=session.update("MypageMapper.changeNotDefaultAddress", userid);
		System.out.println("기본 배송지 취소 : "+n);
	}

	public AddressDTO selectAddress(String address_id) {
		AddressDTO address=session.selectOne("MypageMapper.selectAddress", address_id);
		return address;
	}

	public void updateAddress(AddressDTO address) {
		int n=session.update("MypageMapper.changeAddress", address);
		System.out.println("배송지 업데이트 : "+n);
	}

	public ProfileDTO selectProfile(String userid) {
		return session.selectOne("MypageMapper.selectProfile", userid);
	}

	public void updateProfile(HashMap<String, String> map) {
		int n=session.update("MypageMapper.updateProfile", map);
		System.out.println("프로필 업데이트 : "+n);
	}

	public int countOrder(HashMap<String, String> m) {
		return session.selectOne("MypageMapper.countOrder", m);
	}

}
