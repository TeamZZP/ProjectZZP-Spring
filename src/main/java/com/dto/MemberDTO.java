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
public class MemberDTO {
	private String userid;
	private String passwd;
	private String username;
	private String email1; 
	private String email2; 
	private String phone; 
	private String created_at;
	private int role;
}