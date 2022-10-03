<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="container" cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">
	<div class="card align-middle" id="div1">
		<div class="card-title" id="div2">
			<h2 class="card-title" id="h2tag"><img alt="로고" src="resources/images/header/main.png" width="50" height="50">
			<span id="main" style="color: green;">ZZP</span> </h2>
		</div>
			  <div class="card-body">
		       	 <p id="result">
		       	 	${idDTO.username}님의 아이디는 <span id="idchk">${idDTO.userid}</span> 입니다.
		       	 </p><br/>
		       <a href="login" id="btn" class="btn btn-lg  btn btn-success">로그인 화면으로 돌아가기</a>
		      </div>
	   </div>
        <div class="links">
            <a class="atag" href="join">회원가입</a> | <a class="atag" href="loginpw">비밀번호 찾기</a>
        </div>
</div>  