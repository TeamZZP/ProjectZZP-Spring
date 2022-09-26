<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 로그인 callback</title>
</head>
<body>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("_ZZF2h9wjuLwjIB5RUOO","http://localhost:8087/ProjectZZP/naverCallback");
  
  //접근 토큰 값 출력
  //alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	let email = naver_id_login.getProfileData('email');
	let username = naver_id_login.getProfileData('name');
	let phone = naver_id_login.getProfileData('mobile');
    /* alert(userid);
    alert(username);
    alert(phone); */
    $.ajax({
    	type: "post",
    	url: "naverLogin",
    	dataType: "text",
    	data: {
    		email : email,
    		username : username,
    		phone : phone
    	},
    	success: function() {
    		window.opener.location.href = "${contextPath}/home";
	        window.close();
		},
		fail: function() {
			console.log("error");
		}	
    });
  }
  
</script>

</body>
</html>