<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>

a {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
}


.cart_total>div {
	display: flex;
	text-align: center;
	justify-content: space-evenly;
}


</style>
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
			${cartList.p_id}
			<button type="button" class="btn btn-outline-success" id="cart">
				장바구니(<span id="cartCount">${map.count}</span>)</button>
			<button type="button" class="btn btn-outline-success" id="like"
				onclick="location.href='${contextPath}/like/${login.userid}';"> 
				찜한상품()
			</button>
		</div>
	</div>
	<c:choose>
		<c:when test="${fn:length(map.cartList)==0}">
			<div>
				<div class="no_item_cart"
					style="text-align: center; padding: 50px; line-height: 70px;">
					<img src="../resources/images/cart/cart.png" width="150" height="150"><br>
					<span>장바구니에 담긴 상품이 없습니다.</span>
					<div>
						<button type="button" onclick="${contextPath}/store';"
							class="btn btn-success">상품보러가기</button>
						<hr>
					</div>
				</div>
			</div>
		</c:when>
			<c:otherwise>
		
			<%-- <form id="cartListForm" action="cart/${login.userid}/" method="post"> --%>
			<form action="" method="post"> 
			 	<input type="hidden" name="_method" value="delete">
			 
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
						<c:forEach var="cart" items="${map.cartList}">
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
									<td><a href="${contextPath}/product/${cart.p_id}"> 
										<img src="../resources/images/product/p_image/${cart.p_image}" width="100"
											style="border: 10px;" height="100"></a> <a
										href="${contextPath}/product/${cart.p_id}"> 
										<!-- 상품명  -->
										<span name="p_name" style="font-weight: bold; margin: 8px; display: line">${cart.p_name}</span></a></td>
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
									<!-- 개별 총 가격 -->
									<td>
									<span id="item_price${cart.cart_id}" data-id="${cart.cart_id}"
										name="item_price" style="margin-bottom: 15px; font-weight: bold;"
										class="item_price">
										${cart.p_selling_price*cart.p_amount}원</span>
									</td>
										<!-- 개인삭제버튼  -->
									<td><span class="cart_item_del"> <img
											src="../resources/images/cart/delete.png" width="20" height="20" class="delBtn"
											data-xxx="${cart.cart_id}"></span></td>	 
								</tr>
							</tbody>
						</c:forEach>
					</table>
				
					 	 <div class="cart_total" style="text-align: center;">
							<div class="cart_info_div"
							style="font-weight: bold; font-size: 30px; padding-top: 30px;">
							<span class="price" id="sum_money">원</span> <span
								style="font-size: 40px; color: gray;">+</span> <span class="price"
								id="fee">원</span> <span
								style="font-size: 40px; color: gray;">=</span> <span class="price"
								id="total" style="color: green;">원</span>
							</div>
							<div class="shipping" style="color: gray;">
								<p>상품 금액</p>
								<span></span>
								<p>배송비</p>
								<span></span>
								<p>총 주문금액</p>
							</div>
						</div>
						<div style="float: right;">
							<input type="submit" class="btn btn-success" class="orderBtn" value="주문하기">
							<input type="submit" class="btn btn-success" id="delAllCart"
								value="상품삭제">
						</div> 
				</div>
			</form>
		</c:otherwise> 
	</c:choose>
</div>


<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

function totalprice(){
	
	var sum_money = 0;
	$(".item_price").each(function(idx,data){
		sum_money += Number.parseInt($(data).text());
	});
	
	//배송비 결정
 	var fee = sum_money >= 50000 ? 0 : 3000;
 	//배송비 + 상품합계
	var total = sum_money+fee;
	console.log(sum_money,fee,total);
	//값 삽입
	$("#sum_money").text(sum_money+"원");
	$("#fee").text(fee+"원");
	$("#total").text(total+"원");

}

function totalprice2(){
	
}//체크박스 선택 시 토탈값 변경
	
$(function() {
	
	//전체선택
 	$("#allCheck").on("click", function() {
		console.log("click====");
		if ($(this).is(":checked")) {
			$("input[name=check]").prop("checked", true);//체크박스 전체 선택
			
			var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
			/* sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환 */
			sum_money = 0;
			sum_money = parseInt(sum_money);//정수로
			console.log("장바구니 금액 : "+sum_money);
			
			//체크박스 전체 가격 데이터 더한 값==text()
			$("input[name=check]").each(function (index, data) {
				var cart_id=$(this).val();
				console.log("전체선택 카트번호>",cart_id);
				
				var item_price = $("#item_price" + cart_id).text();//상품 가격
				item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
				item_price = parseInt(item_price);//정수로
				console.log("상품 가격 : "+item_price);
				
				sum_money =  parseInt(sum_money) + parseInt(item_price);//장바구니에 상품 가격 추가
				console.log("최종 장바구니 가격 : "+sum_money);

				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;  
				$("#sum_money").text(sum_money.toLocaleString('ko-KR'));
				$("#fee").text(fee.toLocaleString('ko-KR'));
				$("#total").text(total.toLocaleString('ko-KR')); 

			});
			
			
		} else {
			$("input[name=check]").prop("checked", false);//체크박스 전체 선택 해제
			
			var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
			sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
			sum_money = parseInt(sum_money);//정수로
			console.log("장바구니 금액 : "+sum_money);
			
			//체크박스 전체 가격 데이터 뺀 값==text()
			$("input[name=check]").each(function (index, data) {
				var cart_id=$(this).val();
				console.log(cart_id);
				
				var item_price = $("#item_price" + cart_id).text();//상품 가격
				item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
				item_price = parseInt(item_price);//정수로
				console.log("상품 가격 : "+item_price);
				
				sum_money =  parseInt(sum_money) - parseInt(item_price);//장바구니에서 상품 가격 빼기
				sum_money =0;
				console.log("최종 장바구니 가격 : "+sum_money);
				
				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;
				
				$("#sum_money").text(sum_money.toLocaleString('ko-KR'));
				$("#fee").text(fee.toLocaleString('ko-KR'));
				$("#total").text(total.toLocaleString('ko-KR'));
			});

		}
	})//end fn
})//end
	
</script>

