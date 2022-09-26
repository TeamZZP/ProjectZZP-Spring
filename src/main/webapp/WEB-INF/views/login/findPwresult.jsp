<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/member/findPwresult.js"></script>   

<%-- <%
	MemberDTO dto = (MemberDTO)session.getAttribute("findPw");
	String userid = dto.getUserid();
	String username = dto.getUsername();
	String passwd = dto.getPasswd();
%> --%>
	
<div id="container" cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">
	<div class="card align-middle" id="div1">
		<div class="card-title" id="div2">
			<h2 class="card-title" id="h2tag"><img alt="로고" src="resources/images/header/main.png" width="50" height="50">
			<span id="main">ZZP</span> </h2>
		</div>
	      <form action="pwcheck" class="find" method="POST">
	        <div class="card-body" style="font-weight: bold;">비밀번호 재설정</div>
			  <div class="card-body">
			  	 <input type="text" name="userid" id="userid" class="form-control" placeholder="아이디" autofocus ><BR>
		       	 <input type="password" name="passwd" id="passwd" class="form-control" placeholder="영문자,숫자,특수문자를 포함 8~25자리" autofocus ><BR>
		       	 <div id="phonediv">
		       	 <input type="password" name="changedPasswd" id="changedPasswd" class="form-control" placeholder="비밀번호 확인"><br>
		       	 </div>
		       	 <p id="check" class="check"></p><br/>
		       <button type="button" id="btn" class="btn btn-lg  btn btn-success" style="margin-bottom: 30px;">비밀번호 변경</button>
		       <button type="reset" id="btn2" class="btn btn-lg  btn btn-success" style="margin-bottom: 30px;">취소</button>
		      </div>
	      </form>
	   </div>
        <div class="links">
            <a class="atag" href="login">로그인</a> | <a class="atag" href="join">회원가입</a> | <a class="atag" href="loginid">아이디 찾기</a>
        </div>
</div> 