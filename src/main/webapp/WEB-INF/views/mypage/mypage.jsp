<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
@charset "UTF-8";
@import url(https://fonts.googleapis.com/css?family=Roboto:300);
	.img a{
	  display: block; /* 영역적용위해 사용 */
	  width: 100%; height: 100%;
	
	  overflow: hidden;/* 이미지가 커질때 다른 이미지를 침범하기 때문에 반드시 부모요소보다 이미지가 커질때 넘어가는 것을 막아주세요. */
	
	  position: relative; /* absolute의 기본기준은 body로 처리 - 현재 요소로 기준변경 - 이 코드 추가하니까 바깥 영역으로 침범 안 하고 잘림 */
	}
 	.img figure{
	  width: 100%; height: 100%; /* a태그의 영역을 상속받도록 처리 */
	}
	.img figcaption{
	  width: 100%; height: 100%;/* 역시 부모 전체 영역을 상속 받도록  width: 100%; height: 100%; 를 줬고, */
	  background-color: rgba(0,0,0,0.5);/* 검정색 배경색에 투명도를 주기 위해  background-color: rgba(0,0,0,0.7); 로  rgba( ) 함수를 사용 */
	
	  position: absolute; /* 이미지와 겹치게 처리 */
	  top: 0; left: 0;/* 이미지 위에 올라가야 하므로  position: absolute; top: 0; left: 0; 를 줘서 겹치도록 */
	
	  color: #fff; text-align: center;
	  line-height: 200px;
	
	  opacity: 0; /* 위에 올라가는 bg기 때문에 처음엔 안 보이게 처리 */
	
	  transition: 0.3s; /* 자연스럽게 나타나야하기 때문에 CSS변화에 시간차를 주기 위해 */
	  border-radius: 9px;/* 모서리 둥글게 */
	}
	.img a:hover figcaption, .img a:focus figcaption{
	  opacity: 1;/* 마우스를 올렸을 때와 초점받았을 때 보이게 하도록 */
	  cursor: pointer;/* 커서 모양 손가락으로 */
	}
	body {/* 무슨 효과 */
		padding: 0;
		margin: 0;
	}
	div {/* 무슨 효과 */
		box-sizing: border-box;
	}
/*	.circle { alert badge
		display: inline-block;
		width: 5px;
		height: 5px;
		border-radius: 2.5px;
		background-color: #ff0000;
		position: absolute;
		top: -5px;
		left: 110%;
	} */
	.green {/* 녹색 텍스트 */
		color: #24855b;
	}
	.wrap {
		background-color: #F8F8F8;
	}
	.greenContainer {/* 녹색 배경 */
		height: 120px;
		background-color: #24855b;
		
		display: flex;
		align-items: flex-end;
		padding: 16px;
	}
	.greenContainer .grade {
		margin-left: 12px;
	}
	.greenContainer .name {
		font-size: 20px;
		font-weight: bold;
		color: #ffffff;
		margin-left: 12px;
	}
	.greenContainer .modify {
		margin-left: auto;
	}
	.summaryContainer {/* 단골상점, 상품후기, 적립금 박스 */
		background-color: white;
		display: flex;
		height: 90px;
		text-align: center;/* div 태그 안의 a 태그 수평 중앙 정렬 */
		align-items: center;/* div 태그 안의 a 태그 수직 중앙 정렬 */
	}
	.summaryContainer a {
		text-decoration: none;
	}
	.summaryContainer .item {/* 단골상점, 상품후기, 적립금 */
		flex-grow: 1
	}
	.summaryContainer .number {/* 녹색 숫자 */
		font-size: 19px;
		font-weight: bold;
		color: #24855b;
	}
	.summaryContainer .item > div:nth-child(2){
		font-size: 13px;
		color: black;
	}
	/* ==================== 주문/배송조회 박스 시작 ==================== */
	.shippingStatusContainer {
		padding: 21px 16px;
		background-color: white;
		margin-bottom: 10px;
/* 		text-align: center; div 태그 안의 a 태그 수평 중앙 정렬
		align-items: center; div 태그 안의 a 태그 수직 중앙 정렬 */
	}
	/* ==================== 주문/배송조회 타이틀 ==================== */
	.shippingStatusContainer .title {
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 15px;
		margin-left: 12px;
	}
	/* ==================== 장바구니 결제완료 배송중 구매확정 [로우] ==================== */
	.shippingStatusContainer .status {
		display: flex;
		justify-content: space-between;/* div 안 item 사이에 간격 추가 */
		margin-bottom: 21px;
		margin-left: 12px;
		margin-right: 12px;
	}
	/* ==================== 장바구니 결제완료 배송중 구매확정 [아이템] ==================== */
	.shippingStatusContainer .item {
		display: flex;
	}
	.shippingStatusContainer .number {
		font-size: 31px;
		font-weight: 500;
		text-align: center;
	}
	.shippingStatusContainer .text {
		font-size: 12px;
		font-weight: normal;
		color: #c2c2c2;
		text-align: center;
	}
	.shippingStatusContainer .icon {
		display: flex;
		align-items: center;
		padding: 20px;
		width: 16px;
		height: 16px;
	}
	/* ==================== 주문목록 ~ 찜한상품 리스트 ==================== */
	.listContainer {
		padding: 0;
		background-color: #ffffff;
		margin-bottom: 10px;
	}
	.listContainer .item {
		display: flex;
		align-items: center;
		padding: 16px;
		color: black;
		text-decoration: none;
		height: 56px;
		box-sizing: border-box;
		margin-left: 12px;
		margin-right: 17px;
	}
	.listContainer .icon {
		margin-right: 14px;
	}
	.listContainer .text {
		font-size: 16px;
		position: relative;
	}
	.listContainer .right {
		margin-left: auto;
	}
	#changeTxt {
		cursor: pointer;/* 커서 모양 손가락으로 */
	}
	.profileTxt {
		border: 1px solid #E0E0E0;
		border-radius: 0.4em;
		padding: 7px;
	}
	.card-body {
		/* 텍스트를 드래그 하지 못하도록 설정 */
		-ms-user-select: none;
		-moz-user-select: -moz-none;
		-khtml-user-select: none;
		-webkit-user-select: none;
		user-select: none;
	}
	div.img, img.card-img-top {
		padding: 10px 10px 5px 10px;
		border-radius: 19px;
	}

</style>
<div class="container col-md-10">
<form action="/zzp/mypage/${login.userid}/profile" method="post" enctype="multipart/form-data">
<input type="hidden" name="old_file" id="old_file" value="${profile.profile_img}">

<div class="justify-content-center">
<div class="row">
<div class="col-md-3">
	<div class="card">
	  <div class="img">
	  	<a>
	  		<figure>
	  			<img src="/zzp/resources/upload/profile/${profile.profile_img}" class="card-img-top">
	  			<figcaption id="changeImg"><b>프로필 이미지 변경</b></figcaption>
	  		</figure>
	  	</a>
	  </div>
	  <div class="card-body">
	    <div class="card-title" style="padding-top: 10px;"><b>${login.username}님</b></div>
	    <div class="profileTxt">${profile.profile_txt}</div>
	    <img id="changeTxt" src="/zzp/resources/images/mypage/edit.png" width="20;" style="margin-top: 10px; padding-bottom: 5px; float: right;">
	  </div>
	</div>
	<div class="col-md-6">
		<!-- Modal -->
			<div class="modal fade" id="selectImg" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">프로필 이미지 변경</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- 이미지 -->
							<div class="form-group">
							    <div class="cols-sm-10">
							        <div class="input-group">
							            <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
										<input class="form-control" type="file" accept="image/*" name="imgFile" id="imgFile" multiple>
							        </div>
							    </div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" id="submitImg" class="btn btn-success">수정</button>
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		<!-- end modal -->
		<button type="button" id="openImgModal" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#selectImg" style="display: none;">
			사진 수정
		</button><br><br>
		<!-- open modal -->
		<!-- Modal -->
			<div class="modal fade" id="writeTxt" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="staticBackdropLabel">프로필 메세지 변경</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body" style="text-align: center;">
							<textarea class="profileTxt" id="profile_txt" name="profile_txt" style="resize: none" cols="55" rows="4">${profile.profile_txt}</textarea>
						</div>
						<div class="modal-footer">
							<button id="submitTxt" class="btn btn-success">수정</button>
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="cancleChangTxt">취소</button>
						</div>
					</div>
				</div>
			</div>
		<!-- end modal -->
		<button type="button" id="openTxtModal" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#writeTxt" style="display: none;">
			프로필 메세지 수정
		</button>
		<!-- open modal -->
	</div>
</div>
</form>

<div class="wrap col-md-9">
	<div class="greenContainer">
		<div>
			<div class="grade">ID : ${login.userid}</div>
			<div class="name">${login.username}님</div>
		</div>
		<div class="modify">i</div>
	</div>
	<div class="summaryContainer">
		<a href="/zzp/mypage/${login.userid}/review" class="item">
			<div class="number">${map.myReview}</div>
			<div>구매 후기</div>
		</a>
		<a href="/zzp/mypage/${login.userid}/coupon" class="item">
			<div class="number">${map.myCoupon}</div>
			<div>내 쿠폰함</div>
		</a>
		<a href="" class="item">
			<div class="number">${map.myChallenge}</div>
			<div>내 챌린지</div>
		</a>
		<a href="" class="item">
			<div class="number">${map.myStamp}</div>
			<div>내 도장</div>
		</a>			
	</div>
	<div class="shippingStatusContainer">
		<div class="title">
			주문/배송조회
		</div>
		<div class="status">
			<div class="item">
				<div>
					<div class="green number">77</div>
					<div class="text">주문 완료</div>
				</div>
				<div class="icon">></div>
			</div>
			<div class="item">
				<div>
					<div class="green number">6</div>
					<div class="text">결제 완료</div>
				</div>
				<div class="icon">></div>
			</div>
			<div class="item">
				<div>
					<div class="number">0</div>
					<div class="text">배송 중</div>
				</div>
				<div class="icon">></div>
			</div>
			<div class="item">
				<div>
					<div class="green number">109</div>
					<div class="text">배송 완료</div>
				</div>
				<div class="icon">></div>
			</div>
			<div class="item">
				<div>
					<div class="green number">3</div>
					<div class="text">구매 확정</div>
				</div>
			</div>
		</div>
	</div>
	<div class="listContainer">
		<a href="/zzp/mypage/${login.userid}/orde" class="item">
			<div class="icon">1.</div>
			<div class="text">주문 내역<span class="circle"></span></div>
			<div class="right">></div>
		</a>
		<a href="#" class="item">
			<div class="icon">2.</div>
			<div class="text">반품/취소/교환 목록</div>
			<div class="right">></div>
		</a>
		<a href="/zzp/mypage/${login.userid}/question" class="item">
			<div class="icon">3.</div>
			<div class="text">내 문의 내역</div>
			<div class="right">></div>
		</a>
		<a href="${contextPath}/mypage/${login.userid}/address" class="item">
			<div class="icon">4.</div>
			<div class="text">배송지 관리</div>
			<div class="right">></div>
		</a>
		<a href="${contextPath}/mypage/${login.userid}/check" class="item">
			<div class="icon">5.</div>
			<div class="text">계정 관리</div>
			<div class="right">></div>
		</a>
	</div>
</div>

</div>
</div>
</div>
<!-- Button trigger modal -->
<button type="button" id="openModal" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#mypageModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="mypageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="confirm" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	
		$("#changeImg").on("click", function() {
			$("#openImgModal").trigger("click");
		});//end fn
		$("#changeTxt").on("click", function() {
			$("#openTxtModal").trigger("click");
		});//end fn
		$("#profile_txt").on("click", function() {
			$(this).val("");
		});//end fn
		$("#cancleChangTxt").on("click", function() {
			$("#profile_txt").val("${profile.profile_txt}");
		});//end fn
		
		//프로필 텍스트 수정 클릭
		$("#submitTxt").on("click", function() {
			var profile_txt=$("#profile_txt").val();//왜 text()는 안 넘어올까
				if (profile_txt.length == 0) {
				event.preventDefault();
				$("#openModal").trigger("click");
				$("#modalMesg").text("변경할 프로필 메세지를 입력하세요.");
			}
		});//end txt
		
		//프로필 이미지 수정 클릭
		$("#submitImg").on("click", function() {
			if ($("#imgFile").val() == "null" || $("#imgFile").val().length == 0) {//이미지 파일이 없을 때
				event.preventDefault();
				$("#openModal").trigger("click");
				$("#modalMesg").text("사진을 업로드해 주세요.");
			} else if ($("#imgFile").val() != 0 && !checkFileExtension()) {
				console.log("이미지 확장자 검사");
			} else {
				console.log($("#imgFile").val());
				$("form").submit();
			}
		});//end img
		
	});//end ready
	
	//이미지 확장자 검사
	function checkFileExtension(){ 
		let imgFile = $("#imgFile").val(); 
		let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
		if (imgFile.match(reg)) {
			return true;
		} else {
			$("#openModal").trigger("click");
			$("#modalMesg").text("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			$("#imgFile").val("");//입력 내용 삭제
			return false;
		}
	}
</script>