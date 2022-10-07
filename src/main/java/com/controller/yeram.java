package com.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.ChallengeDTO;
import com.dto.ReportDTO;
import com.service.AdminService;
import com.service.ChallengeService;
import com.util.Upload;

@Controller
public class yeram {
	@Autowired
	private AdminService service;
	@Autowired
	private ChallengeService chservice;
	
	
	
	
	
	
}
