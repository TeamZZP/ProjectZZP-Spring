package com.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
//@ControllerAdvice
public class CommonExceptionAdvice {
	
	@ExceptionHandler(value = NoHandlerFoundException.class)
	@ResponseStatus(value = HttpStatus.NOT_FOUND)
	public String handle404Exception(NoHandlerFoundException e, Model model) {
		log.error("handle404Exception : {}", e.getMessage());
		model.addAttribute("mesg1", "페이지를 찾을 수 없습니다.");
		model.addAttribute("mesg2", "입력하신 주소가 정확한지 다시 한번 확인해 주시길 바랍니다.");
		return "error/error";
	}

	@ExceptionHandler(value = Exception.class)
	public String handleAllException(Exception e, Model model) {
		log.error("handleAllException : {}", e.getMessage());
		model.addAttribute("mesg1", "문제가 발생해 페이지를 로딩할 수 없습니다.");
		model.addAttribute("mesg2", "잠시 후 다시 시도해 주시길 바랍니다.");
		return "error/error";
	}
}
