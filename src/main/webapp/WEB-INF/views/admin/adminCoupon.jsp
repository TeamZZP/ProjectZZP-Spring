<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.CouponDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<c:if test="${!empty mesg}">
	<script>
		alert("${mesg}");
	</script>
</c:if>  

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
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#searchCoupon").click(function() {
			$("#couponForm").attr("method","get").attr("action", "/zzp/admin/coupon").submit();
		});
		$("#sortBy").change(function() {
			$("#couponForm").attr("method","get").attr("action", "/zzp/admin/coupon").submit();
		});
		$("#checkAll").click(function() {
			$(".delCheck").prop('checked', $(this).prop('checked'));
		});
		$("#couponInsert").click(function () {
			$("#couponForm").attr("method","get").attr("action", "/zzp/admin/coupon/write").submit();
			$("#couponForm").attr("action", "/zzp/admin/coupon/write").submit();
		});
		$(".delCheckBtn").click(function() {
			if ($(".delCheck:checked").length == 0) {
				$("#modalBtn").trigger("click");
				$("#mesg").text("삭제할 쿠폰을 선택해 주세요.");
				$("#okBtn").html("<button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>취소</button>");
			} else {
				$("#modalBtn").trigger("click");
				$("#mesg").html("선택한 쿠폰을 삭제하시겠습니까?");
				$("#okBtn").html("<button type='button' id='allDelBtn' class='btn btn-success'>확인</button>"
						+"<button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>취소</button>");
				$("#allDelBtn").click(function () {
					var allDel = $(".delCheck:checked");
					console.log(allDel)
					var delId = "";
					$.each(allDel, function (i, e) {
						delId += e.value + ",";
					});
					$("#couponForm").attr("action", "/zzp/admin/coupon?coupon_id="+delId).submit();
				});
			}
		});
		$(".delCoupon").click(function () {
			var coupon_id = $(this).attr("data-couponId");
			var del = $(this);
			console.log(coupon_id);
			$.ajax({
				type:"delete",
				url:"/zzp/admin/coupon/"+coupon_id,
				datatype:"text",
				success: function (data, status, xhr) { 
					del.parents().filter("tr").remove();
					alert("쿠폰 삭제 완료");
				},
				error: function (xhr, status, error) {
					
				}
			});
		});
		$(".couponUpdate").click(function () {
			var couponId = $(this).attr("data-couponId");
			$("#couponForm").attr("method","get").attr("action", "/zzp/admin/coupon/"+couponId).submit();
		});
	});//end ready
</script>

<div class="container col-md-auto">
<div class="row justify-content-md-center">
	<form action="" id="couponForm" method="post">
	<input type="hidden" name="_method" value="delete">
		<input type="hidden" name="category" value="coupon">
		<div class="container mt-2 mb-2">
			<div class="row">
			  	<div class="col">
					<select class="form-select sortBy" name="searchName" data-style="btn-info" id="inputGroupSelect01">
						<option selected disabled hidden>검색 기준</option> 
						<option value="coupon_name" 
							<c:if test="${search != null && search.searchName eq 'coupon_name'}"> selected</c:if>>
							쿠폰이름
						</option>
						<option value="coupon_discount"
							<c:if test="${search != null && search.searchName eq 'coupon_discount'}"> selected</c:if>>
							 할인율
						</option>
					</select> 
					<input type="text" name="searchValue" class="form-control searchValue" 
						<c:if test="${search != null && search.searchValue != null}"> ${search.searchValue}</c:if>>
		  			<button type="button" class="btn btn-success" id="searchCoupon" style="margin-top: -5px;">검색</button>
		  			<a href="/zzp/admin/coupon" class="btn btn-success" style="margin-top: -5px;">쿠폰전체보기</a>
		  	  	</div>
	      	  	<div class="col">
	      	  		<div class="float-end">
					  <select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info">
						    <option selected disabled hidden>정렬</option>
						    <option value="coupon_discount_up" 
						  	  <c:if test="${search != null && search.sortBy eq 'coupon_discount_up'}"> selected</c:if>>
						    	할인율 높은순
						    </option>
						    <option value="coupon_discount_down" 
						    	<c:if test="${search != null && search.sortBy eq 'coupon_discount_down'}"> selected</c:if>>
						    	할인율 낮은순
						    </option>
					  </select>
					  <button id="couponInsert" class="btn btn-success" style="margin-top: -5px;">쿠폰등록</button>
				  </div>
		    	</div>
			</div>
		</div>
		<div class="container col-md-auto">
		<div class="row justify-content-md-center">
		<table class="table table-hover table-sm" style="text-align: center; vertical-align: middle;">
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>쿠폰번호</th>
				<th>쿠폰이미지</th>
				<th>쿠폰명</th>
				<th>할인율</th>
				<th></th>
			</tr>
			<c:forEach var="list" items="${coupon.list}">
			<tr id="list">
				<td><input type="checkbox" class="delCheck" name="COUPON_ID" value="${list.coupon_id}"></td>
				<td> ${list.coupon_id} </td>
				<td> <img alt="쿠폰" src="/zzp/resources/images/coupon/${list.coupon_img}" width="50px" height="50px"> </td>
				<td> ${list.coupon_name} </td>
				<td> ${list.coupon_discount} </td>
				<td>
					<button type="button" data-couponId="${list.coupon_id}" class="couponUpdate btn btn-outline-success btn-sm">
						수정
					</button>
					<button type="button" data-couponId="${list.coupon_id}" class="delCoupon btn btn-outline-dark btn-sm"><!--  data-bs-toggle="modal" data-bs-target="#delCoupon" -->
						삭제
					</button>
				</td>
		</c:forEach>
			</tr>
		</table>
		<div>
		  <div class="float-end me-3" style="margin-top: -8px;">
			<button type="button" class="delCheckBtn btn btn-outline-dark btn-sm" style="width: 80px;" data-bs-target="#deleteModal">
				선택삭제
			</button>
		  </div>
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
			      <div class="modal-footer" id="okBtn">
			      </div>
			    </div>
			  </div>
			</div>
			<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>
		</div>
		<div class="p-2 text-center">
			<c:if test="${myOrder.prev}">
				<a class="paging" data-page="${coupon.startPage-1}">prev&nbsp;&nbsp;</a>
			</c:if>
				<c:forEach var="p" begin="${coupon.startPage}" end="${coupon.endPage}">
				<c:choose>
					<c:when test="${p==coupon.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
					<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
				</c:choose>
				</c:forEach>
				<c:if test="${coupon.next}">
				<a class="paging" data-page="${coupon.endPage+1}">next</a>
			</c:if>
		</div>
		</div>
		</div>
	</form> 
</div>
</div>