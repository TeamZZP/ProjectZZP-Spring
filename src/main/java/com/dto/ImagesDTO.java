package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("ImagesDTO")
public class ImagesDTO {

	private int p_id;
	private int image_rnk;
	private String image_route;
	private String userid;
	private String update_date;
	
	public ImagesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ImagesDTO(int p_id, int image_rnk, String image_route, String userid, String update_date) {
		super();
		this.p_id = p_id;
		this.image_rnk = image_rnk;
		this.image_route = image_route;
		this.userid = userid;
		this.update_date = update_date;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	public int getImage_rnk() {
		return image_rnk;
	}

	public void setImage_rnk(int image_rnk) {
		this.image_rnk = image_rnk;
	}

	public String getImage_route() {
		return image_route;
	}

	public void setImage_route(String image_route) {
		this.image_route = image_route;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	
	public String toString() {
		return "ImagesDTO [p_id=" + p_id + ", image_rnk=" + image_rnk + ", image_route=" + image_route + ", userid="
				+ userid + ", update_date=" + update_date + "]";
	}
	
	
	
}
