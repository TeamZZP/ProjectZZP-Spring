<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.dto.CartDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:forEach var="like" items="${likeList}">
					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="p-3">
							<div style="text-align: center;"  id="likediv">
								<div class="hover-zoomin">
									<a href="/zzp/product/${like.p_id}"> <img
										src="/zzp/resources/images/product/p_image/${like.p_image}"
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
										<img src="/zzp/resources/images/product/cart.png"
											width="25" height="25">
									</button>
								</div>	
								<div>
									<a href="/zzp/product/${like.p_id}"> <span
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
			
			
			
			
			<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>


	$(document).ready(function () {
		
		console.log(${likeCount});
		$("#likeCount").text(${likeCount});
		
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