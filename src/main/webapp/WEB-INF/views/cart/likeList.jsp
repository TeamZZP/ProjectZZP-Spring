
<%@ page import="com.dto.CartDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>
.container {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

a {
	color: #646464;
	text-decoration: none;
}

.hover-zoomin a {
	display: block;
	position: relative;
	overflow: hidden;
	border-radius: 15px;
}

.hover-zoomin img {
	width: 250px;
	height: 250px;
	-webkit-transition: all 0.2s ease-in-out;
	-moz-transition: all 0.2s ease-in-out;
	-o-transition: all 0.2s ease-in-out;
	-ms-transition: all 0.2s ease-in-out;
	transition: all 0.2s ease-in-out;
}

.hover-zoomin:hover img {
	-webkit-transform: scale(1.1);
	-moz-transform: scale(1.1);
	-o-transform: scale(1.1);
	-ms-transform: scale(1.1);
	transform: scale(1.1);
}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>


	$(document).ready(function () {
		

		
		//좋아요 추가 삭제
		$(".zzim_area").on("click",".zzimImage",function(){
			var p_id = $(this).attr("data-pid");
			var xxx= $(this);
			console.log(p_id);
			$.ajax({
				type: "post",
				url : "/zzp/cartzzim",
				data : {
					p_id:p_id
				},
				dataType: "text" ,
				success : function(data,status,xhr) {
					
					$("#zzimListChange").empty();
					$("#zzimListChange").append(data);	
					
	
				},
				error : function(xhr, status,error) {
					console.log(error);
				}
				
				
			}) //end ajax 
	
			
		})//end zzim_area
		
	});//end ready
</script>
<div id="outer">
	<div
		style="text-align: center; display: flex; justify-content: center; height: 100px; margin-bottom: 10px;">
		<img alt="찜로고" src="../resources/images/cart/like2.png">
	</div>
</div>

<div class="container">
	<div class="row" align="center">
		<div class="btn-group" role="group" aria-label="Basic example">

			<button type="button" class="btn btn-outline-success" id="cart"
				onclick="location.href='${contextPath}/cart/${login.userid}';">
				장바구니(${cartCount})</button>
			<button type="button" class="btn btn-success" id="like">
				찜한상품(<span id="likeCount">${likeCount}</span>)</button>
		</div>
	</div>
	<c:choose>
		<c:when test="${fn:length(likeList)==0}">
			<div class="no_item_cart"
				style="text-align: center; padding: 50px; line-height: 70px;">
				<img src="../resources/images/cart/liked.png" width="150"
					height="150"><br> <span>찜한 상품이 없습니다.</span>
				<div>
					<button type="button"
						onclick="location.href='${contextPath}/store';"
						class="btn btn-success">상품보러가기</button>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row" id="zzimListChange">
				<c:forEach var="like" items="${likeList}">
					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="p-3">
							<div style="text-align: center;"  id="likediv">
								<div class="hover-zoomin">
									<a href="${contextPath}/product/${like.p_id}"> <img
										src="${contextPath}/resources/images/product/p_image/${like.p_image}"
										width="300" height="300"></a>
								</div>
								
								<div style="">
								<!-- 찜 -->
								<div class="zzim_area" id="zzim_area${ike.p_id}" style="display: inline; text-align: center;">
									<c:if test="${!empty zzimList}">
								   	 	 <spring:eval var="zzim" expression="zzimList.contains(${like.p_id})" />
								   	   </c:if>
								   	   <c:choose>
								   	     <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
								   	     <c:when test="${zzim}">
								   	     	<img src="/zzp/resources/images/product/fullHeart.png" width="30" height="30" class="zzimImage" data-pid="${like.p_id}" id="zzimImage${like.p_id}">
								   	     </c:when>
								   	     <%-- 그외의 경우 --%>
								   	     <c:otherwise>
								   	     	<img src="/zzp/resources/images/product/emptyHeart.png" width="30" height="30" class="zzimImage" data-pid="${like.p_id}" id="zzimImage${like.p_id}">
								   	     </c:otherwise>
								   	   </c:choose>
								</div>
							
								<!-- 장바구니 모달창 -->
									<button type="button" class="btn" data-bs-toggle="modal"
										data-bs-target="#addcart${like.p_id}"
										style="border: 0; outline: 0;">
										<img src="${contextPath}/resources/images/product/cart.png"
											width="25" height="25">
									</button>
								</div>	
								<div>
									<a href="${contextPath}/product/${like.p_id}"> <span
										style="margin-bottom: 0.3em; font-weight: normal; color: #646464; font-size: 25px;">${like.p_name}</span></a>
								</div>
								<div>
									<p style="color: green; font-size: 20px;">
										<fmt:formatNumber pattern="###,###,###">${like.p_selling_price}</fmt:formatNumber>원
									</p>
								</div>
								
							</div>

							<!-- Modal -->
							<form action="/cart/{userid}" method="post">
								<input type="hidden" name="p_id" value="${like.p_id}"> <input
									type="hidden" name="p_image" value="${like.p_image}"> <input
									type="hidden" name="p_name" value="${like.p_name}">

								<div class="modal fade" id="addcart${like.p_id}"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header" id="header">
												<h5 class="modal-title" id="cart_title"
													style="text-align: center;">${like.p_name}</h5>

												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body" style="text-align: center;">
												<div class="opt_block no-border order_quantity_area"
													style="height: auto;">
													<div class="area_tit holder">
														<span class="option_title inline-blocked"
															style="margin-bottom: 7px">수량</span>
													</div>
													<div class="area_count holder">
														<div class="option_btn_wrap" style="top: 0;">
															<div class="option_btn_tools" style="float: none;">
																<input name="p_amount" class="form-control"
																	id="quantity${like.p_id}" value="1"
																	style="text-align: right; width: 80px; display: inline; margin-left: 20px;"
																	maxlength="3">
																<button type="button" name="up"
																	class="btn btn-outline-success" id="up${like.p_id}"
																	data-p_id="${like.p_id}">+</button>
																<button type="button" name="down"
																	class="btn btn-outline-success" id="down${like.p_id}"
																	data-p_id="${like.p_id}">-</button>
																<br> <input type="hidden" id="price${like.p_id}"
																	name="p_selling_price" value="${like.p_selling_price}">
																<a>총 상품금액 : </a><span id="total${like.p_id}" style="font-weight: bold;"><fmt:formatNumber pattern="###,###,###" >${like.p_selling_price}</fmt:formatNumber></span>원
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">찜목록보기</button>
												<button type="button" class="btn btn-success"
													id="saveCart${like.p_id}" data-p_id="${like.p_id}"
													name="saveCart" data-p_name="${like.p_name}"
													data-p_selling_price="${like.p_selling_price}"
													data-p_image="${like.p_image}" data-bs-toggle="modal"
													data-bs-target="#chkmodal${like.p_id}">장바구니저장</button>
											</div>
										</div>
									</div>
								</div>
							</form>
							<!-- 장바구니 모달안에 모달 -->
							<div class="modal fade" id="chkmodal${like.p_id}"
								data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
								aria-labelledby="staticBackdropLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="cart_title"
												style="text-align: center">${like.p_name}</h5>

											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">장바구니에 저장되었습니다.</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" name="back"
												data-bs-dismiss="modal" id="chkmodal${like.p_id}"
												data-p_id="${like.p_id}">찜목록보기</button>
											<button type="button" class="btn btn-success" name="moveCart"
												id="moveCart${like.p_id}" data-P_id="${like.p_id}"
												 onclick="location.href='${contextPath}/cart/${login.userid}';">장바구니로이동</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function() {
		
		var count = "1";
		$("button[name=up]").on("click",function(){
			var p_id = $(this).attr("data-p_id");
			
			//input태그 수량 변화
			var quantity = parseInt($("#quantity"+p_id).val());
			 $("#quantity"+p_id).val(parseInt(quantity)+1);
			 count =  $("#quantity"+p_id).val();
			 
			 var price = parseInt($("#price"+p_id).val());
			 
			$("#total"+p_id).text(((quantity+1)*price).toLocaleString('ko-KR'));
			
		})//end up
		
		$("button[name=down]").on("click",function(){
			var p_id = $(this).attr("data-p_id");
			
			//input태그 수량 변화
			var quantity = parseInt($("#quantity"+p_id).val());
			
			if(quantity != 1){
				 $("#quantity"+p_id).val(parseInt(quantity)-1);
				 count =  $("#quantity"+p_id).val();
				 var price = parseInt($("#price"+p_id).val());
				 
				 $("#total"+p_id).text(((quantity-1)*price).toLocaleString('ko-KR'));

			}
		})	//end down
		
		$("button[name=saveCart]").on("click",function(){
			console.log("saveCart클릭됨");
			
			var p_id = $(this).attr("data-P_id");
			var p_name = $(this).attr("data-p_name");
			var p_selling_price = $(this).attr("data-p_selling_price");
			var p_image = $(this).attr("data-p_image");
			console.log(p_id, p_name, p_selling_price, count, p_image);
			
			if ("${login.userid}" != "") {
				$.ajax({
					type : "post",
					url : "${contextPath}/cart/${login.userid}",
					data : {
						p_id : p_id,
						p_name : p_name, 
						p_amount : count,
					},
					dataType : "text",
					success : function(data,status,xhr) {
						console.log("장바구니에 저장되었습니다.");
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				}); //end ajax
				
				$("#modalBtn2").trigger("click");
			}else{
				$("#modalBtn").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
				
				$("#closemodal").click(function() {
		        location.href="/login";
		     });
		     	
			}

		}) 
		
 		$("button[name=back]").on("click", function() {
			console.log("click======");
			var p_id=$(this).attr("data-p_id");
			console.log(p_id);
			$("#addcart"+p_id).modal("hide");
			$("#chkmodal"+p_id).modal("hide");

		});//end fnn
		
	})//end function
	
	
</script>