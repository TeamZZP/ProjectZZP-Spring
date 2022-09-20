package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("CategoryDTO")
public class CategoryDTO {
	
	int c_id;
	String c_name;
	int c_rnk;
	String userid;
	String c_created_date;
	
	public CategoryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CategoryDTO(int c_id, String c_name, int c_rnk, String userid, String c_created_date) {
		super();
		this.c_id = c_id;
		this.c_name = c_name;
		this.c_rnk = c_rnk;
		this.userid = userid;
		this.c_created_date = c_created_date;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public int getC_rnk() {
		return c_rnk;
	}

	public void setC_rnk(int c_rnk) {
		this.c_rnk = c_rnk;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getC_created_date() {
		return c_created_date;
	}

	public void setC_created_date(String c_created_date) {
		this.c_created_date = c_created_date;
	}
	
	

}
