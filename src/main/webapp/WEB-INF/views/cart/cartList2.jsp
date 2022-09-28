<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
				장바구니(${cartList.size})
			</button>
			<button type="button" class="btn btn-outline-success" id="like"
				onclick="location.href='ProductLikeListServlet';">
				<!--   <input type="checkbox" name="allCheck" id="allCheck"> -->
				찜한상품()
			</button>
		</div>
	</div>
	</div> 
	<c:choose>
		<c:when test="${cartList.size)==0}">  
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
				<c:forEach var="cart" items="${cartList}" >	
				<tbody class="cart_content" >
					<input type="hidden" class="individual_sum_money"
						value="">
					<input type="hidden" class="individual_fee" value="">
					<input type="hidden" class="individual_total"
						value=">">
					<input type="hidden" class="individual_userid" name="userid" id="userid" value="${cart.cartuserid}">
					<input type="hidden" class="individual_p_id" id="p_id" name="p_id" value="${cart.p_id}">

					<tr>
						<td>
						<!-- 체크박스  -->
						<input type="checkbox" name="check" id="check${cart.cart_id}>"
							checked="checked" class="individual_cart_checkbox"
							value="${cart.cart_id}" data-p_id="${cart.p_id}"></td>
						<td>
						<!-- 주문번호  -->
						<span name="cart_id" id="cart_id" data-p_id="${cart.p_id}">${cart.cart_id}</span></td>
						<!-- 이미지사진  -->
						<td><a href="ProductRetrieveServlet?p_id=${cart.p_id}"> <img
								src="images/p_image/${cart.p_image}" width="100"
								style="border: 10px;" height="100"></a> <a
							href="ProductRetrieveServlet?p_id=${cart.p_id}"> 
							<!-- 상품명  -->
							<span name="p_name" style="font-weight: bold; margin: 8px; display: line">${cart.p_name}</span></a></td>
						<td style=" border-left: 100px;">
						<!-- 수량  -->
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
						<td><span id="item_price${cart.cart_id}" data-id="${cart.cart_id}"
							name="item_price" style="margin-bottom: 15px; font-weight: bold;"
							class="item_price">${cart.p_selling_price*cart.p_amount}원</span></td>
							<!-- 개인삭제버튼  -->
						<td><span class="cart_item_del"> <img
								src="images/delete.png" width="20" height="20" class="delBtn"
								data-xxx="${cart.cart_id}"></span></td>
					</tr>

				</tbody>
			</c:forEach>
		</c:otherwise>	
</c:choose>
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
				<input type="button" class="btn btn-success" class="orderBtn" value="주문하기">
				<input type="button" class="btn btn-success" id="delAllCart"
					value="상품삭제">
			</div>
		</div>
	</form>
</div>

<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 		  

	$(function() {
		
		//폼 제출시 선택된 체크박스 값만 가져오기
	 	$("#order").on("click", function() {
	 		
            var select_obj = $("input[name=check]:checked");
            var p_id = "";
            var p_amount = 0;
            $.each(select_obj, function (i, e) {
             	p_id += $(this).attr("data-p_id")  + ","; 
             });
            location.href = "OrderServlet?p_id="+p_id;	

	 	});//end order
		
 	//숫자 천단위 ,찍기
 		var sum_money= parseInt($("#sum_money").text());
		var fee = parseInt($("#fee").text());
		var total = parseInt($("#total").text());
		var item_price = parseInt($("span[name=item_price]").text());
		
		$("#sum_money").text(sum_money.toLocaleString('ko-KR')+"원");
		$("#fee").text(fee.toLocaleString('ko-KR')+"원");
		$("#total").text(total.toLocaleString('ko-KR')+"원");
		$("#item_price").text(item_price.toLocaleString('ko-KR')+"원");
		
		//체크박스 미선택시 alert창
		$("#delAllCart").on("click", function() {
			if ($(".individual_cart_checkbox").is(":checked") == false) {
				alert("삭제할 상품을 선택하세요.");
				event.preventDefault();
			}
			$("form").attr("action", "CartDelAllServlet");
		})//체크박스미선택
	
		//전체선택
	 	$("#allCheck").on("click", function() {
			console.log("click====");
			if ($(this).is(":checked")) {
				$("input[name=check]").prop("checked", true);//체크박스 전체 선택
				
				var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
				sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
				sum_money = parseInt(sum_money);//정수로
				console.log("장바구니 금액 : "+sum_money);
				
				//체크박스 전체 가격 데이터 더한 값==text()
				$("input[name=check]").each(function (index, data) {
					var cart_id=$(this).val();
					console.log(cart_id);
					
					var item_price = $("#item_price" + cart_id).text();//상품 가격
					item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
					item_price = parseInt(item_price);//정수로
					console.log("상품 가격 : "+item_price);
					
					sum_money =  parseInt(sum_money) + parseInt(item_price);//장바구니에 상품 가격 추가
					console.log("최종 장바구니 가격 : "+sum_money);

					var fee = sum_money >= 50000 ? 0 : 3000;
					var total = sum_money + fee;
					

				});
				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
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
					console.log("최종 장바구니 가격 : "+sum_money);
					var fee = sum_money >= 50000 ? 0 : 3000;
					var total = sum_money + fee;
					
					var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
					var fee2=fee.toLocaleString('ko-KR')+"원";
					var total2=total.toLocaleString('ko-KR')+"원";

					$("#sum_money").text(sum_money2);
					$("#fee").text(fee2);
					$("#total").text(total2);
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
		
		//개별체크박스 선택시 가격 변동
		$(".individual_cart_checkbox").on("click",function(){
			var n = $(this).val();
			console.log("체크박스의 카트 아이디 : "+n);
			
			var sum_money = $("#sum_money").text();//현재 장바구니 상품 금액
			sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
			sum_money = parseInt(sum_money);//정수로 '원' 삭제됨
			console.log("장바구니 금액 : "+sum_money);
			
			var item_price = $("#item_price" + n).text();//상품 가격
			item_price = item_price.replace(/,/g, "");//콤마 제거 문자열 변환
			item_price = parseInt(item_price);//정수로
			console.log("상품 가격 : "+item_price);

			if($(this).is(":checked")==true){
				console.log("check true");
				console.log("체크 된 상품 가격 : "+item_price);
				
				sum_money = sum_money + item_price;//장바구니에 상품 가격 추가

				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;
				
				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
			} else {
				console.log("check false XXX");
				console.log("체크 해제 된 상품 가격 : "+item_price);
				
				console.log(sum_money);
				console.log(item_price);

				sum_money =  sum_money - item_price;//장바구니에서 상품 가격 빼기
				console.log(sum_money);
				
				var fee = sum_money >= 50000 ? 0 : 3000;
				var total = sum_money + fee;

				var sum_money2=sum_money.toLocaleString('ko-KR')+"원";
				var fee2=fee.toLocaleString('ko-KR')+"원";
				var total2=total.toLocaleString('ko-KR')+"원";
				$("#sum_money").text(sum_money2);
				$("#fee").text(fee2);
				$("#total").text(total2);
			}
		})//end individual_cart_checkbox
		

      
      //전체선택
        $("#a").on("click", function() {//#allCheck
        var result = this.checked;
        var item_price = "";
         $(".individual_cart_checkbox").each(function(idx, data) {
        	 /* var n = $(this).val(); */
        	 console.log(data);
        	
        	 
        	 item_price = $(".item_price");
        	 
        	 console.log(item_price);
        	$.each(item_price,function(idx,data){
        		console.log(data.innerText);
        		
        		var chk =data.innerText+",";
        		console.log(chk);
        		
        	})
            data.checked = result;
         })
         
       })//end allcheck  
      
		//개별 삭제
		$(".delBtn").on("click", function() {
			var cart_id = $(this).attr("data-xxx");
			location.href = "CartDelServlet?cart_id=" + cart_id;
		})//end
		
		//장바구니 수량 수정
		$(".updBtn").on("click", function() {
			var cart_id = $(this).attr("data-xxx"); //cart_id
			var p_selling_price = $(this).attr("data-price");
			var p_amount = $("#cartAmount" + cart_id).val();
			var sum_money = $(this).attr("data-sum_money"); //총금액
			
			console.log(cart_id, p_selling_price, p_amount, sum_money)
			
			var userid = $(this).attr("data-id");

			$.ajax({
				type : "get",
				url : "CartUpdateServlet",
				data : {
					cart_id : cart_id,
					p_amount : p_amount,
					sum_money : sum_money
				},
				dataType : "text",
				success : function(data, status, xhr) {
					var sum = p_amount * p_selling_price;
					$("#item_price" + cart_id).text(sum);

					sum_money = parseInt(data);
					var fee = sum_money >= 50000 ? 0 : 3000;
					var total = sum_money + fee;

					$("#sum_money").text(sum_money);
					$("#fee").text(fee);
					$("#total").text(total);
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			}) // end ajax
		})//end updBtn
   })//end
</script>
