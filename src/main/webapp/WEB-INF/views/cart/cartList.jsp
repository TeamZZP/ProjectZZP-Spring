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

	.tableTop {
	border-bottom-color: #24855B;
	border-bottom-width: 2.5px;
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
			<button type="button" class="btn btn-success" id="cart" >
				장바구니(<span id="cartCount">${map.cartCount}</span>)</button>
			<button type="button" class="btn btn-outline-success" id="like" onclick="location.href='${contextPath}/like/${login.userid}';">
			 찜한상품(${map.likeCount})
			</button>
		</div>
	</div>
	<div style="text-align: center; display: flex; justify-content: center; height: 260px; ">
			<img alt="장바구니로고" src="../resources/images/cart/cart3.jpg" >
		</div>	
	<c:choose>
		<c:when test="${fn:length(map.cartList)==0}">
				<div class="no_item_cart"
					style="text-align: center; padding: 50px; line-height: 70px;">
					<img src="../resources/images/cart/cart.png" width="150" height="150"><br>
					<span>장바구니에 담긴 상품이 없습니다.</span>
					<div>
						<button type="button" onclick="location.href='${contextPath}/store';"  
							class="btn btn-success">상품보러가기</button>
						<hr>
					</div>
				</div>
		</c:when>
			<c:otherwise>
		
			<form method="post" name="form" id="cartform" action="${contextPath}/orders/cart"> 
			 	<input type="hidden" name="_method" value="delete">
			 
			 	
				<div style="padding-top: 30px;">
					<table id="cartTable" class="table table-hover">
						<thead>
							<tr class="tableTop">
								<th><input type="checkbox" name="allCheck" id="allCheck"  style="accent-color:green;" 
									checked="checked"></th>
								<th scope="col">주문번호</th>
								<th scope="col">상품정보</th>
								<th scope="col" >상품금액</th>
								<th scope="col" style="padding-left: 50px;">수량</th>
								<th scope="col">총 상품금액</th>
								<th></th>
							</tr>
						</thead>
						<c:forEach var="cart" items="${map.cartList}">
							<input type="hidden" id="hiddenP_id" name="p_id" value="${cart.p_id}">
			 				<input type="hidden" name="cart_id" value="${cart.cart_id}">
			 				<input type="hidden" name="userid" value="${cart.userid}">
			 				<input type="hidden" name="p_name" value="${cart.p_name}">
			 				<input type="hidden" name="p_selling_price" value="${cart.p_selling_price}">
			 				<input type="hidden" name="money" value="${cart.money}">
							<tbody class="cart_content">
								<tr>
									<td style="padding-top: 35px;">
										<!-- 체크박스  --> 
										<input type="checkbox" name="check"
										id="check${cart.cart_id}" checked="checked"  style="accent-color:green;" 
										 class="individual_cart_checkbox"  data-cart_id="${cart.cart_id}" value="${cart.money}" 
										data-p_id="${cart.p_id}" onclick="itemSum(this.form);">
										
									</td>
									<!-- 주문번호  -->
									<td style="padding-top: 35px; padding-left: 20px;"><span id="cart_id" data-p_id="${cart.p_id}">${cart.cart_id}</span></td>
									<!-- 이미지사진  -->
									<td style="width: 350px;"><a href="${contextPath}/product/${cart.p_id}"> 
										<img src="../resources/images/product/p_image/${cart.p_image}" width="100"
											style="border: 10px;" height="100" name="p_image" ></a> <a
										href="${contextPath}/product/${cart.p_id}"> 
										<!-- 상품명  -->
										<span style="font-weight: bold; margin: 8px; display: line">${cart.p_name}</span></a></td>
										<!-- 개별가격 -->
									<td style="padding-top: 40px; font-size: 18px; font-weight: bold; width: 200px; text-align: right; padding-right: 100px;"><fmt:formatNumber>${cart.p_selling_price}</fmt:formatNumber>원</td>
										
									<!-- 수량  -->
									<td style="padding-top: 35px;">
									<input type="text" id="cartAmount${cart.cart_id}"
										class="p_amount form-control" name="p_amount"
										style="text-align: right; width: 80px; display: inline; "
										maxlength="3" value="${cart.p_amount}">
										<!-- 수량변경버튼  -->
										 <input type="button"
										value="변경" id="updBtn" class="updBtn btn btn-outline-success"
										style="display: inline; margin-top: -3px;" 
										data-cart_id="${cart.cart_id}" data-price="${cart.p_selling_price}"
										data-id="${cart.userid}" /> <br></td>
									<!-- 개별 총 가격 -->
									<td style="padding-top: 40px; font-size: 18px; font-weight: bold; width: 200px; text-align: right; padding-right: 100px;">
									<span id="item_price${cart.cart_id}" data-id="${cart.cart_id}"
										 style="margin-bottom: 15px; "
										class="item_price">${cart.money}</span>원
									</td>
										<!-- 개인삭제버튼  -->
									<td ><span class="cart_item_del"> <img
											src="../resources/images/cart/delete.png" width="15" height="15" class="delBtn"
											data-cart_id="${cart.cart_id}" data-price="${cart.money}"></span></td>	 
									
								</tr>
							</tbody>
						</c:forEach>
					</table>
				
					 	 <div class="cart_total" style="text-align: center;">
							<div class="cart_info_div" style="font-weight: bold; font-size: 30px; padding-top: 30px;">
							<!-- 총 상품가격 -->
							<div><span class="price" id="sum_money" >${map.sum_money}</span>원 </div>
							<span style="font-size: 40px; color: gray;">+</span> 
								<!-- 배송비 -->
								<div><span class="price" id="fee">${map.fee}</span>원 </div>
								<span style="font-size: 40px; color: gray;">=</span>
								<!-- 총합계(배송비+총상품가격)  -->
								<div style="color: green;"><span class="price" id="total" >${map.total}</span>원</div> 
							</div>
							<div class="shipping" style="color: gray;">
								<p>상품 금액</p>
								<span></span>
								<p>배송비</p>
								<span></span>
								<p>총 주문금액</p>
							</div>
						</div>
						<div style="text-align: center;">
							<input type="submit" id="order" class="orderBtn btn btn-success" value="주문하기" >
							<input type="submit" id="chkdelCart" class="delAllCart btn btn-success"  value="상품삭제">
						
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

	var sum_money= parseInt($("#sum_money").text());
	var fee = parseInt($("#fee").text());
	var total = parseInt($("#total").text());
	var item = 0;
	
	$(".item_price").each(function(){
		item =parseInt($(this).text());
		$(this).text(item.toLocaleString('ko-KR')); //개별 상품금액
	});
	
	$("#sum_money").text(sum_money.toLocaleString('ko-KR')); //총 상품금액
	$("#fee").text(fee.toLocaleString('ko-KR')); //배송비
	$("#total").text(total.toLocaleString('ko-KR')); //총 주문금액
	console.log(sum_money,fee,total,item)
} //end totalprice


function itemSum(frm) {
	var sum = 0;
	var count = frm.check.length; //체크박스의 name을 찾아 length를 구함
	for (var i = 0; i < count; i++) {
		if(frm.check[i].checked==true){
			sum += parseInt(frm.check[i].value);
			console.log(sum);
		}
	}
	$("#sum_money").text(sum.toLocaleString('ko-KR'));
	var fee = sum >= 50000 ? 0 : 3000;
	var total = sum + fee;
	$("#fee").text(fee.toLocaleString('ko-KR'));
	$("#total").text(total.toLocaleString('ko-KR'));
}


$(function() {
	
	totalprice();

	
	//장바구니 수량 수정
	$(".updBtn").on("click", function() {
		
		var cart_id = $(this).attr("data-cart_id"); //장바구니 번호
		var p_selling_price = $(this).attr("data-price"); //상품가격
		var p_amount = $("#cartAmount" + cart_id).val(); //카트번호 이용 class 선택하여 수량을 가져옴
	
		console.log(cart_id, p_selling_price, p_amount);
		
		$.ajax({
			type : "put",
			url : "${contextPath}/cart/"+cart_id,
			data :JSON.stringify( {
				cart_id : cart_id,
				p_amount : p_amount
			}),
			dataType : "text",
			contentType:'application/json;charset=UTF-8',
			success : function(data, status, xhr) {
				
				//상품개별가격
				var sum = p_amount * p_selling_price;
			 	$("#item_price" + cart_id).text(sum.toLocaleString('ko-KR')); 
			 	console.log($("#item_price" + cart_id).text());
			 	
			 	$("#check"+cart_id).val(sum);
			 	var sum_money = 0;
			 	var check = $("input[name=check]");
				var count = check.length; //체크박스의 name을 찾아 length를 구함

				 for (var i = 0; i < count; i++) {
					if(check[i].checked==true){
						sum_money += parseInt(check[i].value);
						console.log(sum_money);
					}
				}
				$("#sum_money").text(sum_money.toLocaleString('ko-KR'));
				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;
				$("#fee").text(fee.toLocaleString('ko-KR'));
				$("#total").text(total.toLocaleString('ko-KR'));  
			
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
			
		}) // end ajax
	})//end updBtn
	

 	//체크박스 미선택시 alert창 / 전체 선택시 전체선택 주소로 이동
	$("#chkdelCart").on("click", function() {

		//체크박스 미선택시 모달
		 if ($(".individual_cart_checkbox").is(":checked") == false) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("상품을 선택하세요.");
			event.preventDefault();
		}
		// 체크박스 개별 선택 된  cart_id 뽑기
	
		var cart_id="";
		 $.each($(".individual_cart_checkbox"),function(i,e){
			 var result = $(e);
			 console.log(result);
			 if(e.checked){ //선택된 input태그 가져오기
				 cart_id =result.attr("data-cart_id"); //data-cart_id 가져오기
				 $("#check"+cart_id).val(cart_id); //cart_id를 이용해서 하나씩 선택 가능 / value에 cart_id를 저장
				 console.log($("#check"+cart_id).val());
			 }
		 })
	 	$("form").attr("action", "${contextPath}/cart"); 
		
	}) //체크박스미선택
	
	//폼 제출시 선택된 체크박스 값만 가져오기
  	$("#order").on("click", function() {
  		console.log("order 클릭됨");
		//체크박스 미선택시 모달
		 if ($(".individual_cart_checkbox").is(":checked") == false) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("상품을 선택하세요.");
			event.preventDefault();
		}
		 
		 var cart_id="";
		 $.each($(".individual_cart_checkbox"),function(i,e){
			 var result = $(e);
			 console.log(result);
			 if(e.checked){ //선택된 input태그 가져오기
				 cart_id =result.attr("data-cart_id"); //data-cart_id 가져오기
				 $("#check"+cart_id).val(cart_id); //cart_id를 이용해서 하나씩 선택 가능 / value에 cart_id를 저장
				 console.log($("#check"+cart_id).val());
			 }
		 })
		
		 $("input[name=_method]").val("");
		 $("#cartform").attr("action", "${contextPath}/orders/cart");
		 

 	});//end order

	
	

	//개별 삭제
	$(".delBtn").on("click", function() {
		var cart_id = $(this).attr("data-cart_id");
		var xxx = $(this); //클릭된 버튼 자체
		var item_price = parseInt($(this).attr("data-price"));
		var sum1 =$("#sum_money").text();
		console.log(xxx);
		//체크박스 선택된 값만 상품금액에 출력
		if($(".individual_cart_checkbox").is(":checked")==true){
			var sum = parseInt(sum1.replace(/,/g, ""));//콤마 제거 문자열 변환
			
			$.ajax({
				type : "delete",
				url : "${contextPath}/cart/"+cart_id,
				data :{
					cart_id : cart_id
				},
				dataType : "json",
				success : function(data, status, xhr) {
					
					//삭제 버튼의 부모 요소 중 tr을 remove
					
					$("#cartCount").text(data);
					xxx.parents().filter("tr").remove();  
					var sum = 0;
					var check = $("input[name=check]");
					var count = check.length; //체크박스의 name을 찾아 length를 구함
					for (var i = 0; i < count; i++) {
						if(check[i].checked==true){
							sum += parseInt(check[i].value);
							console.log(sum);
						}
					}
					$("#sum_money").text(sum.toLocaleString('ko-KR'));
					var fee = sum >= 50000 ? 0 : 3000;
					var total = sum + fee;
					$("#fee").text(fee.toLocaleString('ko-KR'));
					$("#total").text(total.toLocaleString('ko-KR'));
					
					
				},
				error : function(xhr, status, error) {
					console.log(error);
				} 
				
			}) // end ajax 
		}else{
			console.log(">>체크박스선택x");
			var sum_money = parseInt(sum1.replace(/,/g, ""));//콤마 제거 문자열 변환
			
			 $.ajax({
					type : "delete",
					url : "${contextPath}/cart/"+cart_id,
					data :{
						cart_id : cart_id
					},
					dataType : "json",
					success : function(data, status, xhr) {
						//삭제 버튼의 부모 요소 중 tr을 remove
						$("#cartCount").text(data);
						xxx.parents().filter("tr").remove();  
						$("#sum_money").text(sum_money.toLocaleString('ko-KR')); 
						var fee = sum_money >= 50000 ? 0 : 3000;	
						var total = sum_money + fee;
						$("#fee").text(fee.toLocaleString('ko-KR'));
						$("#total").text(total.toLocaleString('ko-KR')); 
						
					},
					error : function(xhr, status, error) {
						console.log(error);
					} 
					
				}) // end ajax 
		}
				
	})//end
	

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
				var cart_id=$(this).attr("data-cart_id")
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
				var cart_id=$(this).attr("data-cart_id");
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
	
	//전체선택 안됐을 경우 체크 해제
	$("input[name=check]").click(function() {
		var total = $("input[name=check]").length;
		var checked = $("input[name=check]:checked").length;

		if(total != checked) $("#allCheck").prop("checked", false);
		else $("#allCheck").prop("checked", true); 
	});

	
	
})//end  
</script>

