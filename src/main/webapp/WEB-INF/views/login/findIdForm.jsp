<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/member/findIdForm.js"></script>

<div id="container" cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">
	<div class="card align-middle" id="div1">
		<div class="card-title" id="div2">
			<h2 class="card-title" id="h2tag"><img alt="로고" src="resources/images/header/main.png" width="50" height="50">
			<span id="main" style="color: green;">ZZP</span> </h2>
		</div>
	      <form action="loginid" class="find" method="POST">
	        <div class="checkbox">
	            <label>
		            <input type="radio" class="type" name="type" value="phone" checked="checked"> 전화번호
					&nbsp;&nbsp;
					<input type="radio" class="type" name="type" value="email"> 이메일
	            </label>
	         </div>
			  <div class="card-body">
		       	 <input type="text" name="username" id="username" class="form-control" placeholder="이름" autofocus ><BR>
		       	 <div id="phonediv" >
		       	 <input type="text" name="phone" id="phone" class="form-control" placeholder="전화번호를 -없이 입력하세요"><br>
		       	 </div>
		       	 <div class="row g-3" id="email" style="display: none; margin-bottom: 40px;">
		       	 <input type="text" name="email1" id="email1" class="col form-control" style="margin-left: 8px;" placeholder="이메일 주소" required>
			       	   <div class="col input-group">
					      <div class="input-group-text">@</div>
					      <input type="text" name="email2" placeholder="직접입력" id="email2" class="form-control" >
				       </div>
		       	 </div>
		       	 <p id="check" class="check"></p><br/>
		       <button type="button" id="btn" class="btn btn-lg  btn btn-success">아이디 찾기</button>
		      </div>
	      </form>
	   </div>
        <div class="links">
            <a class="atag" href="login">로그인</a> | <a class="atag" href="join">회원가입</a> | <a class="atag" href="loginpw">비밀번호 찾기</a>
        </div>
</div>  