package com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dao.MypageDAO;
import com.dto.AddressDTO;
import com.dto.MemberDTO;
import com.dto.ProfileDTO;

@Service
public class MypageService {
	@Autowired
	private MypageDAO dao;

	public int countReview(String userid) {
		int n=dao.countReview(userid);
		return n;
	}

	public int countCoupon(String userid) {
		int n=dao.countCoupon(userid);
		return n;
	}

	public int countStamp(String userid) {
		int n=dao.countStamp(userid);
		return n;
	}

	public int countChallenge(String userid) {
		int n=dao.countChallenge(userid);
		return n;
	}
	
	public MemberDTO selectMember(String userid) {
		MemberDTO member=dao.selectMember(userid);
		return member;
	}
	
	public AddressDTO selectDefaultAddress(String userid) {
		AddressDTO address=dao.selectDefaultAddress(userid);
		return address;
	}

	public void updateAccount(HashMap<String, Object> map) {
		dao.updateAccount(map);
	}

	public List<AddressDTO> selectAllAddress(String userid) {
		List<AddressDTO> list=dao.selectAllAddress(userid);
		return list;
	}

	public void accountDelete(String userid) {
		dao.accountDelete(userid);
	}

	public void deleteAddress(int address_id) {
		dao.deleteAddress(address_id);
	}

	public void addAddress(AddressDTO address) {
		dao.addAddress(address);
	}

	public void changeNotDefaultAddress(String userid) {
		dao.changeNotDefaultAddress(userid);
	}

	public AddressDTO selectAddress(String address_id) {
		AddressDTO address=dao.selectAddress(address_id);
		return address;
	}

	public void updateAddress(AddressDTO address) {
		dao.updateAddress(address);
	}

	public ProfileDTO selectProfile(String userid) {
		return dao.selectProfile(userid);
	}

	public void updateProfile(HashMap<String, String> map) {
		dao.updateProfile(map);
	}

}