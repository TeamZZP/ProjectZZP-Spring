package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	/**
	 * 메인 화면
	 */
	@RequestMapping(value = "/")
	public String main() {
		return "main";
	}

}
