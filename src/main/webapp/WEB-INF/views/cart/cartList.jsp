<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="outer">
	<header>
		<div
			style="text-align: center; display: flex; justify-content: center; height: 100px; margin-bottom: 10px;">
			<img alt="장바구니로고" src="../resources/images/cart/cart2.png">
		</div>
	</header>
</div>

<div class="container">
	<div class="row">
		<div class="btn-group" role="group" aria-label="Basic example">

			<button type="button" class="btn btn-outline-success" id="cart">
				장바구니(${cartCount})</button>
			<button type="button" class="btn btn-outline-success" id="like"
				onclick="location.href='ProductLikeListServlet';">
				<!--   <input type="checkbox" name="allCheck" id="allCheck"> -->
				찜한상품()
			</button>
		</div>
	</div>

	<c:choose>
		<c:when test="${fn:length(cartList)==0}">
			<div>
				<div class="no_item_cart"
					style="text-align: center; padding: 50px; line-height: 70px;">
					<img src="images/cart.png" width="150" height="150"><br>
					<span>장바구니에 담긴 상품이 없습니다.</span>
					<div>
						<button type="button" onclick="location.href='StoreServlet';"
							class="btn btn-success">상품보러가기</button>
						<hr>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<form action="#">
				<div style="padding-top: 30px;">
					<table class="table table-hover">
						<thead>
							<tr class="table-success">
								<th><input type="checkbox" name="allCheck" id="allCheck"
									checked="checked"></th>
								<th scope="col">주문번호</th>
								<th scope="col">상품정보</th>
								<th scope="col">수량</th>
								<th scope="col">상품가격</th>
								<th></th>
							</tr>
						</thead>
						<c:forEach var="cart" items="${cartList}">
							<tbody class="cart_content">
								<tr>
									<td>
										<!-- 체크박스  --> 
										<input type="checkbox" name="check"
										id="check${cart.cart_id}>" checked="checked"
										class="individual_cart_checkbox" value="${cart.cart_id}"
										data-p_id="${cart.p_id}">
									</td>
									<!-- 주문번호  -->
									<td><span name="cart_id" id="cart_id" data-p_id="${cart.p_id}">${cart.cart_id}</span></td>
									<!-- 이미지사진  -->
									<td><a href="ProductRetrieveServlet?p_id=${cart.p_id}"> 
										<img src="../images/product/p_image/${cart.p_image}.png" width="100"
											style="border: 10px;" height="100"></a> <a
										href="ProductRetrieveServlet?p_id=${cart.p_id}"> 
										<!-- 상품명  -->
										<span name="p_name" style="font-weight: bold; margin: 8px; display: line">${cart.p_name}</span></a></td>
									<td style=" border-left: 100px;">
									<!-- 수량  -->
									<td style=" border-left: 100px;">
									<input type="text" id="cartAmount${cart.cart_id}"
										class="p_amount form-control" name="p_amount"
										style="text-align: right; width: 80px; display: inline; "
										maxlength="3" value="${cart.p_amount}">
										<!-- 수량변경버튼  -->
										 <input type="button"
										value="변경" id="updBtn" class="updBtn btn btn-outline-success"
										style="display: inline; margin-top: -3px;"
										data-xxx="${cart.cart_id}" data-price="${cart.p_selling_price}"
										data-id="${cart.userid}" data-sum_money="" /> <br></td>
								</tr>
							</tbody>
						</c:forEach>
					</table>
				</div>
			</form>

		</c:otherwise>
	</c:choose>
</div>
