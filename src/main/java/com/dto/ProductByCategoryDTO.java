package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("ProductByCategoryDTO")
public class ProductByCategoryDTO extends ProductDTO {
	
	private String p_image;
	private String p_name;
	
	private int p_selling_price;
	private int p_id;
	private String p_created;
	private int c_id;


	@Override
	public String toString() {
		return "CategoryProductDTO [p_image=" + p_image + ", p_name=" + p_name + ", p_selling_price=" + p_selling_price
				+ ", p_id=" + p_id + ", p_created=" + p_created + ", c_id=" + c_id + "]";
	}




	public String getP_image() {
		return p_image;
	}




	public void setP_image(String p_image) {
		this.p_image = p_image;
	}




	public String getP_name() {
		return p_name;
	}




	public void setP_name(String p_name) {
		this.p_name = p_name;
	}




	public int getP_selling_price() {
		return p_selling_price;
	}




	public void setP_selling_price(int p_selling_price) {
		this.p_selling_price = p_selling_price;
	}




	public int getP_id() {
		return p_id;
	}




	public void setP_id(int p_id) {
		this.p_id = p_id;
	}




	public String getP_created() {
		return p_created;
	}




	public void setP_created(String p_created) {
		this.p_created = p_created;
	}




	public int getC_id() {
		return c_id;
	}




	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	

	
}
