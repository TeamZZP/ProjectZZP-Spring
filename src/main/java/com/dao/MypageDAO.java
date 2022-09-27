package com.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.AddressDTO;
import com.dto.MemberDTO;

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

}
