package com.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AddressDTO {
	private int address_id;
	private String userid;
	private String address_name;	
	private String receiver_name;	
	private String receiver_phone;	
	private String post_num;		
	private String addr1;	
	private String addr2;	
	private int default_chk;
	
	private String username;
	private String phone; 
	private String created_at;
}
