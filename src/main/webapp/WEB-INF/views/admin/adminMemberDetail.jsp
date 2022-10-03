<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- Required meta tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	label {
		padding: 5px 0 5px 0;
	}
	th {
		text-align: center;
	}
	a {
		color : black;
		text-decoration: none;
	}
	.modal {
		overflow: auto;
	}
</style>
<div class="container">
	<div class="row">
		<div class="col-lg-4">
			<div class="container">
			<div class="row justify-content-center">
				<div class="col-12">
					<div class="card">
						<div class="card-header" style="text-align: center; font-weight: bold; font-size: x-large;">${member.userid}님 회원 정보</div>
						<div class="card-body">
							<form class="form-horizontal" method="post" action="/zzp/admin/member/${member.userid}">
							<input type="hidden" name="_method" value="put">
								<!-- username -->
								<div class="form-group">
									<label for="username" class="cols-sm-2 control-label" style="font-weight: bold;">이름</label>
									<div class="cols-sm-10">
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
											<input type="text" class="form-control" name="username" id="username" value="${member.username}"/>
										</div>
									</div>
								</div>
								<!-- 비밀번호 -->
								
								<!-- 이메일 -->
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label" style="font-weight: bold;">이메일</label>
										<div class="row g-3">
										<div class="col-sm-6">
											<input type="text" name="email1" id="email1" class="form-control" value="${member.email1}" readonly="readonly">
										</div>
										<div class="col-sm-6">
											<div class="input-group">
												<div class="input-group-text">@</div>
												<input type="text" name="email2"  placeholder="직접입력" id="email2" class="form-control" value="${member.email2}" readonly="readonly">
											</div>
										</div>
										</div>
								</div>
								<!-- 전화번호 -->
								<div class="form-group">
									<label for="phone" class="cols-sm-2 control-label" style="font-weight: bold;">전화번호</label>
									<div class="cols-sm-10">
										<div class="input-group">
											<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
											<input type="text" class="form-control" name="phone" id="phone" value="${member.phone}"/>
										</div>
									</div>
								</div>
								<!-- 주소 -->
								
								<!--  -->
								<!-- Modal -->
								<div class="modal fade" id="deleteMember" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="staticBackdropLabel">회원 삭제</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        선택한 회원을 삭제하시겠습니까?
								      </div>
								      <div class="modal-footer">
								        <button type="button" id="delete" data-id="${member.userid}" name="delete" class="btn btn-success">삭제</button>
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								      </div>
								    </div>
								  </div>
								</div>
								<div class="form-group" style="margin-top: 10px; text-align: center;">
									<input type="submit" value="변경" class="btn btn-success">
									<input type="reset" value="변경 취소" class="btn btn-success" id="cancle">
								</div>
								<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 15px;">
									<button class="btn btn-light btn-sm" type="button" id="chkDelete" data-bs-toggle="modal" data-bs-target="#deleteMember">회원 삭제</button>
								</div>
								<!--  <div class="login-register">
								</div> -->
							</form>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<div id="addContainer">
			<div class="container" id="divCon">
			<div class="row">
			<div class="col-12">
			<div id="addTableDiv">
			<table id="addTable" class="table table-hover" style="table-layout: fixed">
				<tr class="table-success">
					<th width="20%">배송지</th>
					<th width="60%">주소</th>
					<th width="20%">연락처</th>
				</tr>
			<c:forEach var="address" items="${list}" varStatus="status">
				<tr>
					<td style="padding:5 0 0 10px;">
						<span>${address.address_name}</span><br>
						<span>${address.receiver_name}</span><br>
						<span style="font-size: 12px; background-color: Gainsboro; font-weight: bold">
							<c:if test="${not empty address && address.default_chk eq 1}">기본 배송지</c:if>
						</span><!-- default_chk가 1일 때 text() 입력되도록 -->
					</td>
					<td>
						<span style="font-size: 14px">${address.post_num}</span><br>
						${address.addr1}<br>
						${address.addr2}
					</td>
					<td style="text-align: center;">
						<span>${address.receiver_phone.substring(0, 3)}-${address.receiver_phone.substring(3, 7)}-${address.receiver_phone.substring(7, 11)}</span>
					</td>
				</tr>
			</c:forEach>
			</table>
			</div>
			</div>
			</div>
			</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
	$(document).ready(function() {
		//폼 제출, db 업데이트
		$("form").on("submit", function() {
			var username=$("#username").val();
			var phone=$("#phone").val();
			console.log(username+"의 연락처 : "+phone);
			
			var numChk = /^01(0|1[6-9])(\d{3,4})(\d{4})$/; 
			if (username.length == 0 || phone.length == 0) {
				event.preventDefault();
				$("#openModal").trigger("click");
				$("#modalMesg").text("변경할 회원 정보를 입력하세요.");
				$("#username").focus();
			} else if (username.length > 3) {
				event.preventDefault();
				$("#openModal").trigger("click");
				$("#modalMesg").text("이름은 한글 3글자 이내로 입력하세요.");
				$("#username").val("");
				$("#username").focus();
			} else if (!numChk.test(phone)) {
				event.preventDefault();
				$("#openModal").trigger("click");
				$("#modalMesg").text("전화번호를 형식에 맞게 입력하세요.");
				$("#phone").val("");
				$("#phone").focus();
			} else {
				console.log("공백 확인, 이름 3글자 이내, 전화번호 유효성 검사 완료--update");
			}
		});//end fn
		
		//취소
		$("#cancle").on("click", function() {
			location.href="/zzp/admin/member";
		});//end fn
		
		//회원 삭제
		$("#delete").on("click", function() {
			event.preventDefault();
			var id=$(this).attr("data-id");
			console.log("삭제할 회원 아이디 : "+id);
			//*****ajax
 			$.ajax({
				type : "delete",
				url : "/zzp/admin/member/"+id,
				dataType : "text",
				contentType : "application/json;charset=UTF-8",//매개변수 map으로 받을 수 있도록
				data : JSON.stringify({//서버에 전송할 데이터
					userid : id
				}),
				success : function(data, status, xhr) {
					$("#openModal").trigger("click");
					$("#modalMesg").text("해당 회원이 삭제되었습니다.");
					$("#deleteMember").modal("hide");
					//console.log("success");
					$("#confirm").click(function() {
						location.href="/zzp/admin/member";
					})
				},
				error: function(xhr, status, error) {
					console.log(error);
				}						
			});//end ajax
		});//end fn
	});//end ready
</script>