<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
	.form-select {
		width: 140px; 
		display: inline;
	}
	.searchValue {
		width: 150px; 
		display: inline;
	}
	.paging {
		cursor: pointer;
	}
	a {
		text-decoration: none;
		color: black;
	}
	.oneOrder {
		cursor: pointer;
	}
	.statusChange {
		width: 120px;
	}

	#modalBtn{
		display: none;
	}
	.modal-body{
		text-align: center;
	}	
	#mesg{
		margin: 0;
	}
</style>


<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
	//페이징
	$('.paging').on('click', function() {
		$('#page').val($(this).attr('data-page'));
		$('#sortForm').submit();
	})
	//정렬 기준 선택시 form 제출
	$("#status").on("change", function () {
		$("#sortForm").submit();
	});
	//주문 상태 변경
	$('.statusChange').on('change', function () {
		let id = $(this).attr('data-id')
		$.ajax({
			type:"put",
			url:"/zzp/admin/order/"+id,
			headers: {
				"Content-Type":"application/json"
			},
			data: JSON.stringify( 
					{
						'id':id,
						'status':$("#status"+id).val()
					} 
			),
			dataType:"text",
			success: function () {
				location.reload();
			},
			error: function () {
				alert("문제가 발생했습니다. 다시 시도해 주세요.");
			}
		});
	})
	
	
});
</script>


<div class="container mt-2 mb-2">
	<form id="sortForm" action="/zzp/admin/order">
	<input type="hidden" name="page" value="1" id="page">
	<input type="hidden" name="category" value="order">
		<div class="row">
		  <div class="col">
			  <select name="searchName" class="form-select" data-style="btn-info" id="inputGroupSelect01">
				   <option selected disabled hidden>검색 기준</option>
				   <option value="o.userid" <c:if test="${searchName=='o.userid'}">selected</c:if>>주문자</option>
				   <option value="p_name" <c:if test="${searchName=='p_name'}">selected</c:if>>상품명</option>
				   <option value="order_date" <c:if test="${searchName=='order_date'}">selected</c:if>>주문일</option>
			  </select>
		  	  <input type="text" class="form-control searchValue" name="searchValue" 
		  	  		<c:if test="${!empty searchValue && searchValue!='null'}">value="${searchValue}"</c:if>>
	      	  <input type="submit" class="btn btn-success" style="margin-top: -5px;" value="검색"></input>
	      </div>
	      <div class="col">
	      	<div class="float-end">
				<select name="status" id="status" class="form-select">
					  <option selected disabled hidden>상태</option>
					  <option value="주문완료" <c:if test="${status=='주문완료'}">selected</c:if>>주문완료</option>
					  <option value="결제완료" <c:if test="${status=='결제완료'}">selected</c:if>>결제완료</option>
					  <option value="배송준비중" <c:if test="${status=='배송준비중'}">selected</c:if>>배송준비중</option>
					  <option value="배송중" <c:if test="${status=='배송중'}">selected</c:if>>배송중</option>
					  <option value="배송완료" <c:if test="${status=='배송완료'}">selected</c:if>>배송완료</option>
					  <option value="구매확정" <c:if test="${status=='구매확정'}">selected</c:if>>구매확정</option>
					  <option value="교환/반품" <c:if test="${status=='교환/반품'}">selected</c:if>>교환/반품</option>
					  <option value="주문취소" <c:if test="${status=='주문취소'}">selected</c:if>>주문취소</option>
				</select> 
			</div>
	      </div>
		</div>
	 </form>
</div>


<c:set var="list" value="${pDTO.list}" />
<div class="container col-md-auto">
<div class="row justify-content-md-center">


<table class="table table-hover table-sm">
	<tr>
		<th>주문 번호</th>
		<th>주문자</th>
		<th>상품명</th>
		<th>가격</th>
		<th>주문일</th>
		<th>상태</th>
	</tr>
	
<c:forEach var="o" items="${list}">
	<tr>
		<td class="oneOrder" data-id="${o.order_id}">${o.order_id}</td>
		<td class="oneOrder" data-id="${o.order_id}">${o.userid}</td>
		<td class="oneOrder" data-id="${o.order_id}">${o.p_name}</td>
		<td class="oneOrder" data-id="${o.order_id}">${o.total_price}</td>
		<td class="oneOrder" data-id="${o.order_id}">${o.order_date}</td>
		<td>
			<select id="status${o.order_id}${o.p_id}" class="statusChange form-select form-select-sm" data-id="${o.order_id}${o.p_id}">
			  <option value="주문완료" <c:if test="${o.order_state=='주문완료'}">selected</c:if>>주문완료</option>
			  <option value="결제완료" <c:if test="${o.order_state=='결제완료'}">selected</c:if>>결제완료</option>
			  <option value="배송준비중" <c:if test="${o.order_state=='배송준비중'}">selected</c:if>>배송준비중</option>
			  <option value="배송중" <c:if test="${o.order_state=='배송중'}">selected</c:if>>배송중</option>
			  <option value="배송완료" <c:if test="${o.order_state=='배송완료'}">selected</c:if>>배송완료</option>
			  <option value="구매확정" <c:if test="${o.order_state=='구매확정'}">selected</c:if>>구매확정</option>
			  <option value="교환/반품" <c:if test="${o.order_state=='교환/반품'}">selected</c:if>>교환/반품</option>
			  <option value="주문취소" <c:if test="${o.order_state=='주문취소'}">selected</c:if>>주문취소</option>
			</select>
		</td>
	</tr>
</c:forEach>
	
</table>

</div>
</div>


	<!-- 페이징 -->
	<div class="container">
	  <div class="p-2 text-center orderPage">
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
	 
	 
