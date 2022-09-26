package com.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
	private List list;   // 현재 페이지에 들어갈 레코드를 perPage만큼 저장 
	private int page;    //현재 페이지 번호 
	private int perPage;  //한페이지에 보여질 레코드 개수 
	private int totalCount; //전체 레코드 개수
	
	private int startPage; //현재 화면에 보이는 시작번호
	private int endPage; //현재 화면에 보이는 끝번호
	
	boolean prev; //이전 존재
	boolean next; //다음 존재
	
	public PageDTO() {
		super();
	}
	
	public void setStartEndPages() {
		//현재 화면에 보이는 끝번호/시작번호
		endPage = (int) (Math.ceil(page/10.0)) * 10;
		startPage = endPage - 9;
		
		//진짜 끝번호 구하기
		int realEnd = (int) (Math.ceil((totalCount * 1.0) / perPage));
		if (realEnd < endPage) endPage = realEnd;
		
		//이전과 다음 
		prev = startPage > 1;
		next = endPage < realEnd;
	}
	
}
