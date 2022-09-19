package com.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.NoticeDTO;

@Repository("NoticeDAO")
public class NoticeDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public List<NoticeDTO> noticeList() {
		List<NoticeDTO> list = session.selectList("NoticeMapper.noticeList");
		return list;
	}

}
