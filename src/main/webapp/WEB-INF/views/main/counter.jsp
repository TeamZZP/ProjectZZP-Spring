<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

//쿠키 생성
function setCookie(name, value, day) {
	let date = new Date(); //현재 날짜 생성
	date.setDate(date.getDate() + day);
	
	let mycookie = '';
	mycookie += name + '=' +value + ';';
	mycookie += 'Expires=' + date.toUTCString();
	
	document.cookie = mycookie; //쿠키 설정, 생성
}
//쿠키 확인
function checkCookie(name) {
	let cookies = document.cookie.split(';');
	console.log(cookies);
	
	for ( var i in cookies) {
		if (cookies[i].indexOf(name) > -1) { //사용자가 확인하고자 하는 쿠키가 있다면 true
			return true;
		}
	}
	return false;
}

if (!checkCookie('counted')) { //페이지 열리자마자 'IP' 쿠키유무 확인
	setCookie('counted','true', 1); //쿠키 생성 
	$.ajax({
		type:'post',
		url:'/zzp/counter',
		success: function (data) {
			console.log('방문수 카운트')
		},
		error: function () {
			alert('문제가 발생했습니다. 다시 시도해 주세요.');
		}
	});
}


</script>