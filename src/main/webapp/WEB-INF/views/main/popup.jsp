<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
font-family: SF Pro KR, SF Pro Display, SF Pro Icons, AOS Icons, Apple Gothic, HY Gulim, MalgunGothic, HY Dotum, Lexi Gulim, Helvetica Neue, Helvetica, Arial, sans-serif;
.layerPopup img{
	margin-bottom : 20px;
}
.layerPopup:before {
	display:block;  
	content:""; 
	position:fixed; 
	left:0; 
	top:0; 
	width:100%; 
	height:100%; 
	/* background:rgba(0,0,0,.5);  */
	z-index:9000;
}
.layerPopup .layerBox {    
	z-index:10000;   
	position:fixed; 
	left:85%; 
	top:48%; 
	transform:translate(-50%, -50%); 
	padding:30px; 
	background:#fff; 
	border-radius:6px;
	border: 0.1px solid black;
	padding:10px;
	 
}
.layerPopup .layerBox .title {
	margin-bottom:10px; 
	padding-bottom:10px; 
	font-weight:600; 
	border-bottom:1px solid #d9d9d9;
}
.layerPopup .layerBox .btnTodayHide {
	font-size:14px; 
	font-weight:600; 
	color:black; 
	float: left;
	text-decoration:none;
	width: 150px; 
	height : 30px;
	line-height:30px;
	border:black solid 1px; 
	text-align : center;
	text-decoration:none;
}
.layerPopup div{
	display : inline;
}
.layerPopup form{
	margin-top : 5px;
	font-size:16px; font-weight:600;
	weight: 100%;
	height : 30px;
	line-height:30px
}
.layerPopup #close {
	font-size:16px; 
	font-weight:600; 
	width: 40px; 
	height : 30px;
	color:black; 
	float: right; 
	line-height:30px; 
	text-align : center;
	text-decoration:underline;
}
.layerPopup a{
	text-decoration : none;
	color : black;
	width: 50px;
	height : 40px;
}
</style>  
    
<div class="layerPopup" id="layer_popup" style="visibility: visible;">
    <div class="layerBox">
        <h4 class="title">ZZP 공지사항</h4>
        <div class="cont">
            <p>
			 <img src="resources/images/main/main_popup.png" width=350 height=500 usemap="#popup" alt="event page">
            </p>
        </div>
          <form name="pop_form">
	        <div id="check">
		        <input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
		        <label for="chkbox">&nbsp&nbsp오늘 하루동안 보지 않기</label>
	        </div>
			<div id="close">닫기</div>    
		</form>
	</div>
</div>

<script type="text/javascript">
	var myPopup = document.querySelector(".layerPopup");//popup
	var checkbox = document.querySelector("#chkbox");//체크박스
	var popupClose = document.querySelector("#close");//닫기버튼
	
	//쿠키 생성
	function setCookie(name, value, day) {
		var date = new Date(); //현재 날짜 생성
		date.setDate(date.getDate() + day);
		
		var mycookie = '';
		mycookie += name + '=' +value + ';';
		mycookie += 'Expires=' + date.toUTCString();
		
		document.cookie = mycookie; //쿠키 설정, 생성
	}
	//setCookie('ZZP','Main', 1); -> 사용자가 닫기 버튼 누를 때 체크박스 여부 확인 후 쿠키 생성
	
	//쿠키 삭제
	function delCookie(name) {
		var date = new Date();
		date.setDate(date.getDate() - 1);
		
		var setCookie = '';
		setCookie += name +'=Main;';
		setCookie += 'Expires=' + date.toUTCString();
		
		document.cookie = setCookie; //쿠키 설정, 생성
	}
	
	//쿠키 확인
	function checkCookie(name) {
		var cookies = document.cookie.split(';');
		console.log(cookies);
		var visited = false; //방문여부 - 거짓(방문한적없음)
		
		for ( var i in cookies) {
			if (cookies[i].indexOf(name) > -1) { //사용자가 확인하고자 하는 쿠키가 있다면 true
				visited = true;
				console.log(visited);
			}
		}
		console.log(visited);
		
		//재방문이면 안 띄움
		if (visited) {//true:재방문
			myPopup.style.display = 'none';
		} else { //신규방문
			myPopup.style.display = 'block';
		} 
		
	}
	checkCookie('ZZP'); //페이지 열리자마자 'ZZP' 쿠키유무 확인
	
	//닫기버튼
	popupClose.addEventListener('click', function() {
		//대상.checked
		if (checkbox.checked) {//팝업을 다시 안 봄, 팝업 닫고 쿠키 생성->visited 값이 true이므로 팝업 보이지 않음
			setCookie('ZZP','Main', 1);
			myPopup.style.display = 'none';
		} else {//팝업 계속 봄, 팝업 닫고 쿠키 제거->새로 열었을 때 visited 값이 false이므로 팝업 계속 떠 있음
			myPopup.style.display = 'none';
			delCookie('ZZP');
		}
	});
   
</script>