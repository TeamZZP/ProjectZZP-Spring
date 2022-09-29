<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	#search {
		text-decoration: none;
		color: black;
	}
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	.productDetail{
		cursor: pointer;
	}
	.modal-body{
		text-align: center;
	}	
	#mesg{
		margin: 0;
	}
	#modalBtn{
		display: none;
	}
	.paging {
		cursor: pointer;
	}
	a {
		text-decoration: none;
		color: black;
	}
</style>

<!-- 메세지 있는 경우 modal 일단 지움* 메세지 안 뜨면 jstl로 바꿔서 추가하기 -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
	$(document).ready(function () {
		//관리자페이지 카테고리
		$(".category").click(function() {
			let category = $(this).attr("data-category");
			location.href="/zzp/admin/"+category;
		});
		//페이징
 		$('.paging').on('click', function() {
			$('#page').val($(this).attr('data-page'));
			$('form').attr('action', 'admin/product').submit();
		})
		//상품검색
		$("#searchProd").click(function() {
			$("#sortForm").submit();
		});
		//정렬 기준 선택시 form 제출
		$("#sortBy").on("change", function () {
			$("#sortForm").submit();
		});
		//상품등록 버튼
		$("#addProduct").click(function() {
			location.href="../adminProductAdd.jsp";
		});
		//상품 상세페이지
		$(".productDetail").click(function() {
			let p_id = $(this).attr("data-p_id");
			location.href="AdminProdDetailServlet?p_id="+p_id;
		});
		//상품보기 버튼
		$("body").on("click", "#prodDetail", function () {
			let p_id = $(this).attr("data-id");
			location.href="ProductRetrieveServlet?p_id="+p_id;
		});
		//삭제 모달
		$("#deleteModal").on("shown.bs.modal", function (e) { //삭제모달 띄우면 발생하는 이벤트
 		let button = e.relatedTarget //삭제모달 띄우려고 누른 버튼
 		if (button) {
 			let id = button.getAttribute("data-bs-id") //삭제모달띄우는 버튼의 data-bs-id값
 			$("#delp_id").val(id); //삭제 시 넘어가는 p_id 값으로 설정
		}
		});
		//상품삭제 버튼
		$(".delProdBtn").on("click", function (e) { //삭제모달 안의 확인버튼
			$('#prodForm').attr('action', 'ProductDeleteServlet').submit() //form 제출
		});
		//체크박스 전체선택
		$("#checkAll").click(function() {
			$(".delCheck").prop('checked', $(this).prop('checked'));
		});
		//체크박스 선택 삭제
		$(".delCheckBtn").click(function() {
			if ($('.delCheck:checked').length == 0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("삭제할 상품을 선택해 주세요.");
			} else {
				$("#modalBtn").trigger("click");
				$("#mesg").text("선택한 상품을 삭제하시겠습니까?"); //확인 클릭 시 prodForm이 submit됨
			}
		});
		
	});//end ready
	
</script>

<c:set value="${pDTO.list}" var="product_list" />

<!-- 검색 / 정렬 -->
<div class="container mt-2 mb-2">
	<form action="/zzp/admin/${category}" id="sortForm">
	<input type="hidden" name="category" value="${category}">
		<div class="row">
			<!-- 검색 -->
			<div class="col">
				<select class="form-select sortBy" name="searchName" data-style="btn-info" id="inputGroupSelect01">
					<option selected disabled hidden>검색 기준</option>
					<option value="c_id" <c:if test="${searchName=='c_id'}">selected</c:if>>카테고리</option>
					<option value="p_id" <c:if test="${searchName=='p_id'}">selected</c:if>>상품번호</option>
					<option value="p_name" <c:if test="${searchName=='p_name'}">selected</c:if>>상품명</option>
					<option value="p_selling_price" <c:if test="${searchName=='p_selling_price'}">selected</c:if>>판매가</option>
					<option value="p_created" <c:if test="${searchName=='p_created'}">selected</c:if>>등록일</option>
				</select> 
				<input type="text" name="searchValue" class="form-control searchValue" <c:if test="${!empty searchName && searchValue!='null'}">selected</c:if>>
				<button type="button" class="btn btn-success" id="searchProd" style="margin-top: -5px;">검색</button>
			</div>
			<!-- 정렬 -->
			<div class="col">
				<div class="float-end">
				<select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info">
					<option selected disabled hidden>정렬</option>
					<option value="p_id" <c:if test="${sortBy=='p_id'}">selected</c:if>>최신상품순</option>
					<option value="p_selling_price" <c:if test="${sortBy=='p_selling_price'}">selected</c:if>>판매가순</option>
					<option value="p_name" <c:if test="${sortBy=='p_name'}">selected</c:if>>상품명순</option>
					<option value="p_stock" <c:if test="${sortBy=='p_stock'}">selected</c:if>>재고순</option>
				</select>
				<a href="adminProductAdd.jsp" class="btn btn-success" style="margin-top: -5px;">상품등록</a>
				</div>
			</div>
		</div>
	</form> 
</div>

<!-- product_list 출력 -->
<div class="container col-md-auto">
<div class="row justify-content-md-center">
	<form id="prodForm">
	<input type="hidden" name="searchName" value="${searchName}">
	<input type="hidden" name="searchValue" value="${searchValue}">
	<input type="hidden" name="sortBy" value="${sortBy}">
	<input type="hidden" name="category" value="product">
	<input type="hidden" name="p_id" id="delp_id">
	<!-- 상품 List -->	
	<table class="table table-hover table-sm">
		<tr>
			<th><input type="checkbox" id="checkAll"></th>
			<th>상품번호</th>
			<th>카테고리</th>
			<th>상품명</th>
			<th>판매가</th>
			<th>할인</th>
			<th>재고</th>
			<th>등록일</th>
			<th>관리</th>
		</tr>
		
		<c:forEach var="p" items="${product_list}">
			<tr id="list">
					<td><input type="checkbox" class="delCheck" name="p_id" value="${p.p_id}"></td>
					<td class="productDetail" data-p_id="${p.p_id}">${p.p_id}</td>
					<td class="productDetail" data-p_id="${p.p_id}">
						<c:if test="${p.c_id==6}">sale</c:if>
						<c:if test="${p.c_id==8}">bath</c:if>
						<c:if test="${p.c_id==9}">kitchen</c:if>
						<c:if test="${p.c_id==10}">life</c:if>
					</td>
					<td class="productDetail" data-p_id="${p.p_id}">${p.p_name}</td>
					<td class="productDetail" data-p_id="${p.p_id}">${p.p_selling_price}&nbsp;</td>
					<td class="productDetail" data-p_id="${p.p_id}">${p.p_discount}</td>
					<td class="productDetail" data-p_id="${p.p_id}>">${p.p_stock}&nbsp;&nbsp;</td>
					<td class="productDetail" data-p_id="${p.p_id}">${p.p_created}</td>
					<td>
						<!-- 모달버튼 -->
						<button type="button" id="prodDetail" data-id="${p.p_id}" class="btn btn-outline-success btn-sm">상품보기</button>
						<button type="button" id="delPopup${p.p_id}" data-bs-id="${p.p_id}" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal">
								삭제
						</button>
					</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	<!-- 선택삭제 -->
	<div>
		<div class="float-end me-3" style="margin-top: -8px;">
			<button type="button" class="delCheckBtn btn btn-outline-dark btn-sm" style="width: 80px;"
			data-bs-target="#deleteModal" data-bs-id="">선택삭제</button>
		</div>
	</div>
	<!-- 페이징 -->
	<div class="p-2 text-center productPage">
		 <c:if test="${pDTO.prev}">
		  	<a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
		  </c:if>
		  <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			  <c:choose>
		  		<c:when test="${p==pDTO.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
		  		<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
		  	  </c:choose>
		  </c:forEach>
		  <c:if test="${pDTO.next}">
		  	<a class="paging" data-page="${pDTO.endPage+1}">next</a>
		  </c:if>
	</div>
</div>
</div>

<!-- Modal -->
<div id="deleteModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        선택한 상품을 삭제하시겠습니까? 
      </div>
      <div class="modal-footer">
        <button type="button" class="delProdBtn btn btn-success">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div> 
  </div>
</div> 
<!-- Modal2 -->		
<div class="modal fade" id="checkVal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="delProdBtn btn btn-success">확인</button>
		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>