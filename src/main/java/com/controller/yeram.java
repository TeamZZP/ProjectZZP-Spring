package com.controller;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.dto.ChallengeDTO;
import com.dto.PageDTO;
import com.service.AdminService;
import com.service.ChallengeService;
import com.util.Upload;

@Controller
public class yeram {
	@Autowired
	private AdminService service;
	@Autowired
	private ChallengeService cService;
	
	
}
