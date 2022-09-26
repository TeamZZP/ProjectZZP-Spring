<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/member/loginForm.js"></script>

<div class="login-page">
  <div class="form">
    <form id="loginForm" class="login-form" action="login" method="post">
      <input type="text" name="userid" id="userid" placeholder="아이디" autofocus />
      <input type="password" name="passwd" id="passwd" placeholder="비밀번호"/>
      <button type="submit">로그인</button><br>
      <br>
      <button type="reset" id="resetBtn">취소</button>
      <p class="message">Not registered? <a href="join">Create an account</a></p>
      <p class="message" id="link">
     	<a href="loginid">아이디찾기</a>
      	<a href="loginpw">비밀번호찾기</a>
      </p>
    </form>
      <div id="kko">
	    <a id="custom-login-btn" href="javascript:kakaoLogin();">
			<img src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
				width="222" alt="카카오 로그인 버튼" />
		</a>
		<form id="form-kakao-login" method="post" action="kakaoLogin">
		    			<input type="hidden" name="email" id="kakaoEmail"/>
		    			<input type="hidden" name="nickname" id="kakaoNickname"/>
		    			<input type="hidden" name="accessToken" id="accessToken"/>
		</form>
	  </div>
	  <div id="naver_id_login">
		<a id="naver-login-btn" href="member/naverCallback.jsp">
			<img src="resources/images/login/naverlogin.png"
				width="222" alt="네이버 로그인 버튼" />
		</a>
	  </div>
  </div>
</div>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("_ZZF2h9wjuLwjIB5RUOO","http://localhost:8087/ProjectZZP/naverCallback");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("green",3,47);
	naver_id_login.setDomain("http://localhost:8102/zzp/login");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
	
</script>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	//window.Kakao.init("6967e0449063c04f2ba9d396e18a25a6"); //js key세팅
	
	function kakaoLogin() {
		window.Kakao.init("6967e0449063c04f2ba9d396e18a25a6");
		
		window.Kakao.Auth.login({
			scope: 'profile_nickname, profile_image, account_email',
			success: function(authObj) {
				console.log(authObj);
				window.Kakao.API.request({
					url: '/v2/user/me',/* 로그인한 사용자의 정보 가져오기 */
					success: res => {
						
						var accessToken = Kakao.Auth.getAccessToken();
						Kakao.Auth.setAccessToken(accessToken);
						console.log("accessToken===="+accessToken);
						
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						console.log(kakao_account.email);
						console.log(kakao_account.profile.nickname);
						
						document.getElementById("kakaoEmail").value = kakao_account.email;
						document.getElementById("kakaoNickname").value = kakao_account.profile.nickname;
						document.getElementById("accessToken").value = accessToken;
						
						document.querySelector("#form-kakao-login").submit();
					},
					fail: function(error) {
						console.log('카카오톡과 연결되지 않습니다. 다시 시도해주시기 바랍니다.');
					}
				});
			}
		});
	};

</script>