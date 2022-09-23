package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("QuestionProductDTO")
public class QuestionProductDTO {

	private String p_name;
	private String p_content;
	private int c_id;
	private int p_cost_price;
	private int p_selling_price;
	private int p_discount;
	private String p_created;
	private int p_stock;
	private int q_id; 
	private int q_board_category;
	private  String q_category; 
	private  String q_title;
	private  String q_content; 
	private String q_created; 
	private String q_img; 
	private String q_status;
	private String userid;
	private int p_id; 
	
	public QuestionProductDTO() {
		super();
	}

	public QuestionProductDTO(String p_name, String p_content, int c_id, int p_cost_price, int p_selling_price,
			int p_discount, String p_created, int p_stock, int q_id, int q_board_category, String q_category,
			String q_title, String q_content, String q_created, String q_img, String q_status, String userid,
			int p_id) {
		super();
		this.p_name = p_name;
		this.p_content = p_content;
		this.c_id = c_id;
		this.p_cost_price = p_cost_price;
		this.p_selling_price = p_selling_price;
		this.p_discount = p_discount;
		this.p_created = p_created;
		this.p_stock = p_stock;
		this.q_id = q_id;
		this.q_board_category = q_board_category;
		this.q_category = q_category;
		this.q_title = q_title;
		this.q_content = q_content;
		this.q_created = q_created;
		this.q_img = q_img;
		this.q_status = q_status;
		this.userid = userid;
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_content() {
		return p_content;
	}

	public void setP_content(String p_content) {
		this.p_content = p_content;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public int getP_cost_price() {
		return p_cost_price;
	}

	public void setP_cost_price(int p_cost_price) {
		this.p_cost_price = p_cost_price;
	}

	public int getP_selling_price() {
		return p_selling_price;
	}

	public void setP_selling_price(int p_selling_price) {
		this.p_selling_price = p_selling_price;
	}

	public int getP_discount() {
		return p_discount;
	}

	public void setP_discount(int p_discount) {
		this.p_discount = p_discount;
	}

	public String getP_created() {
		return p_created;
	}

	public void setP_created(String p_created) {
		this.p_created = p_created;
	}

	public int getP_stock() {
		return p_stock;
	}

	public void setP_stock(int p_stock) {
		this.p_stock = p_stock;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public int getQ_board_category() {
		return q_board_category;
	}

	public void setQ_board_category(int q_board_category) {
		this.q_board_category = q_board_category;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_created() {
		return q_created;
	}

	public void setQ_created(String q_created) {
		this.q_created = q_created;
	}

	public String getQ_img() {
		return q_img;
	}

	public void setQ_img(String q_img) {
		this.q_img = q_img;
	}

	public String getQ_status() {
		return q_status;
	}

	public void setQ_status(String q_status) {
		this.q_status = q_status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	@Override
	public String toString() {
		return "QuestionProductDTO [p_name=" + p_name + ", p_content=" + p_content + ", c_id=" + c_id
				+ ", p_cost_price=" + p_cost_price + ", p_selling_price=" + p_selling_price + ", p_discount="
				+ p_discount + ", p_created=" + p_created + ", p_stock=" + p_stock + ", q_id=" + q_id
				+ ", q_board_category=" + q_board_category + ", q_category=" + q_category + ", q_title=" + q_title
				+ ", q_content=" + q_content + ", q_created=" + q_created + ", q_img=" + q_img + ", q_status="
				+ q_status + ", userid=" + userid + ", p_id=" + p_id + "]";
	}

}
