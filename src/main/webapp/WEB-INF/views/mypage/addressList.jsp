<%@page import="com.dto.AddressDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<!-- Required meta tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	th {
		text-align: center;
	}
	a {
		color : black;
		text-decoration: none;
	}
	.currCategory {
		color: green; 
		font-weight: bold;
	}
	.modal {
		overflow: auto;
	}
	.tableTop {
    	border-bottom-color: #24855B;
    	border-bottom-width: 2.5px;
    }
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<div id="addContainer">
<div class="container" id="divCon">
<div class="row">
<div class="col-lg-2">
		<div class="col">
			<a href="">마이페이지 홈</a>
		</div>
	   <div class="col">주문 내역</div>
	   <div class="col">반품/취소/교환 목록</div>
	   <div class="col">
	   		<a href="">내 구매후기</a>
	   </div>
	   <div class="col">
	   		<a href="">내 쿠폰함</a>
	   </div>
	   <div class="col">
	   		<a href="">내 챌린지</a>
	   </div>
	   <div class="col">
	   		<a href="">내 도장</a>
	   </div>
	   <div class="col">
	      <a href="">내 문의 내역</a>
	   </div>
	   <div class="col">
	      <a href="" class="currCategory">배송지 관리</a>
	   </div>
	   <div class="col">
	      <a href="">계정 관리</a>
	   </div>
</div>
<div class="col-lg-10">
<div id="addTableDiv">
<table id="addTable" class="table table-hover" style="table-layout: fixed">
	<tr class="tableTop">
		<th width="20%">배송지</th>
		<th width="55%">주소</th>
		<th width="20%">연락처</th>
		<th width="15%">수정·삭제</th>
	</tr>
<c:set var="size" value="0"/>
<c:forEach var="address" items="${addressList}" varStatus="status">
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
		<td style="text-align: center;">
			<!-- Modal -->
			<div class="modal fade" id="deleteAddress${address.address_id}" name="deleteAddress" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel">배송지 삭제</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        선택한 배송지를 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <button type="button" id="delete" name="delete" data-id="${address.address_id}"
			        		 data-chk="${address.default_chk}" class="btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- end modal -->
			<div class="btns" style="display: inline-block">
			<!-- Button trigger modal -->
			<button type="button" id="change" name="change" data-id="${address.address_id}"
					class="btn btn-light btn-sm">수정</button>
			<button type="button" id="checkDelete" name="checkDelete" class="btn btn-light btn-sm"
					data-bs-toggle="modal" data-bs-target="#deleteAddress${address.address_id}">
				삭제
			</button><!-- open modal -->
			</div>
		</td>
	</tr>
<c:set var="size" value="${size + 1}"/>
</c:forEach>
</table>
</div>
</div>
</div>
	<div style="width : 95px; float : right;">
		<input type="button" id="addAddress" class="btn btn-success btn-sm" value="배송지 추가">
	</div>
</div>
</div>
<form style="display: none" action="${contextPath}/mypage/address" method="POST">
	<input type="hidden" id="data" name="address_id" value="">
</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//console.log("${size}");
		
		//배송지 추가
		$("#addAddress").on("click", function() {
			location.href="${contextPath}/mypage/address";
		});//end fn
		
		//배송지 삭제
		//버튼 구분 userid->address_id로 --> name으로 선택
		$("button[name=delete]").on("click", function() {//모달 창에서 삭제 버튼 클릭
			event.preventDefault();
			var xxx=$(this);
			//console.log(xxx);//#delete 버튼 선택
			var id=$(this).data("id");
			var chk=$(this).data("chk");
			var size=${size};
			//console.log(id, chk, size);
   			if (size <= 1) {
				$("#openModal").trigger("click");
				$("#modalMesg").text("배송지는 한 개 이상 있어야 합니다.");
				$("div[name=deleteAddress]").modal("hide");
			} else if(chk == 1){//기본 배송지
				$("#openModal").trigger("click");
				$("#modalMesg").text("기본 배송지는 삭제할 수 없습니다.");
				$("div[name=deleteAddress]").modal("hide");
			} else {
				//console.log("삭제 가능 : ", size, id);
    	 			$.ajax({
					type : "delete",
					url : "${contextPath}/mypage/${login.userid}/address",
					dataType : "text",
					contentType:"application/json;charset=UTF-8",//매개변수 map으로 받을 수 있도록
					data : JSON.stringify({//서버에 전송할 데이터
						address_id : id
					}),
					success : function(data, status, xhr) {
						$("#openModal").trigger("click");
						$("#modalMesg").text("해당 배송지가 삭제되었습니다.");
						$("div[name=deleteAddress]").modal("hide");//백드롭도 같이 hide
						///////$(".modal-backdrop").hide();//모달창 닫고 백드롭 hide
						//console.log("success");
						xxx.parents().filter("tr").remove();
						///////window.location.reload();//새로고침 자동-스크롤 멈춤 현상 때문에
					},
					error: function(xhr, status, error) {
						console.log(error);
					}
				});//end ajax
			}
		});//end fn
		
		//배송지 수정
		$("button[name=change]").on("click", function() {//배송지 정보 출력 페이지로 이동
			var address_id=$(this).attr("data-id");
			//console.log(address_id);
			$("#data").val(address_id);
			$("form").submit();
		});//end fn
	});//end ready
</script>
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