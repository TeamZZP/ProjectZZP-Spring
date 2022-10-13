package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("preHandle ========== "+handler);
		HttpSession session = request.getSession();
		if (session.getAttribute("login") == null) {
			FlashMap flashMap = new FlashMap();
			flashMap.put("mesg", "로그인이 필요합니다.");
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect("/zzp/login"); 
			return false;
		}
		return true;
	}

}