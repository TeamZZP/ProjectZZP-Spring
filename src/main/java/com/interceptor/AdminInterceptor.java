package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.dto.MemberDTO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preHandle ========== "+handler);
		MemberDTO member = (MemberDTO) request.getSession().getAttribute("login");
		if (member == null || member.getRole() == 0) {
			FlashMap flashMap = new FlashMap();
			flashMap.put("mesg", "잘못된 접근입니다.");
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect("/zzp/login"); 
			return false;
		}
		return true;
	}
}
