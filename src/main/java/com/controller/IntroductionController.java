package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroductionController {

	@RequestMapping("/about")
	public String about() {
		return "introduction";
	}
	
}
