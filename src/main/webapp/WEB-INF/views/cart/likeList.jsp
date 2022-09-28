
<%@ page import="com.dto.CartDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	$(function() {

	})//end
</script>
찜리스트
${zzimList}
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
				장바구니(${cartCount})
			</button>
			<button type="button" class="btn btn-outline-success" id="like">
				찜한상품()
			</button>
		</div>
		</div>
		<c:choose>
			<c:when test="${fn:length(zzimList)==0}">
			<div class="no_item_cart"
				style="text-align: center; padding: 50px; line-height: 70px;">
				<img src="../resources/images/cart/liked.png" width="150" height="150"><br>
				<span>찜한 상품이 없습니다.</span>
				<div>
					<button type="button" onclick="location.href='${contextPath}/store';"
						class="btn btn-success">상품보러가기</button>
				</div>
			</div>
		</div>
		</c:when>	
		<c:otherwise>
			<div class="col-lg-3 col-md-4 col-sm-6">
			<div class="p-3">
				<c:forEach var="pList" items="${Productlist}" varStatus="status">
				<div class="hover-zoomin">
					<a href="${contextPath}/product/${p_id}"> <img
						src="images/p_image/" width="200" height="200"
						importance="low"></a>
					
				</div>
				<%--	<!-- 장바구니 모달창 -->
				<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#addcart<%=p_id %>"
				 style="border: 0; outline: 0;">
					<img src="images/cart.png" width="25" height="25">
				</button>
				
			
				<!-- Modal -->
				<form action="addCartServlet">
					<input type="hidden" name="p_id" value="<%=p_id%>"> <input
						type="hidden" name="p_image" value="<%=p_image%>"> <input
						type="hidden" name="p_name" value="<%=p_name%>">
					
					<div class="modal fade" id="addcart<%=p_id %>" data-bs-backdrop="static"
						data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header" id="header">
									<h5 class="modal-title" id="cart_title" style="text-align: center">
										<%=p_name%>
									</h5>
									
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
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
														id="quantity<%=p_id%>" value="1"
														style="text-align: right; width: 80px; display: inline; margin-left: 20px;"
														maxlength="3">
													<button type="button" name="up"
														class="btn btn-outline-success" id="up<%=p_id%>"
														data-p_id="<%=p_id%>">+</button>
													<button type="button" name="down"
														class="btn btn-outline-success" id="down<%=p_id%>"
														data-p_id="<%=p_id%>">-</button>
													<br> <input type="hidden" id="price<%=p_id%>"
														name="p_selling_price" value="<%=p_selling_price%>">
													<a>총 상품금액 : </a><span id="total<%=p_id%>"><%=p_selling_price%></span>원
												</div>
											</div>
										</div>
										</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">찜목록보기</button>
									<button type="button" class="btn btn-success"
										id="saveCart<%=p_id%>" data-p_id="<%=p_id%>" name="saveCart"
										data-p_name="<%=p_name%>"
										data-p_selling_price="<%=p_selling_price%>"
										data-p_image=<%=p_image%> data-bs-toggle="modal"
										data-bs-target="#chkmodal<%=p_id%>">장바구니저장</button>
								</div>
							</div>
						</div>
					</div>
					</form>
					<!-- 장바구니 모달안에 모달 -->
					<div class="modal fade" id="chkmodal<%=p_id%>"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
										<h5 class="modal-title" id="cart_title"
											style="text-align: center">
											<%=p_name%>
										</h5>

										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
								<div class="modal-body">장바구니에 저장되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" name="back"
										data-bs-dismiss="modal" id="chkmodal<%=p_id%>" data-p_id="<%=p_id%>">찜목록보기</button>
									<button type="button" class="btn btn-success" name="moveCart" id="moveCart<%=p_id%>" data-P_id="<%=p_id%>"
										 onclick="location.href='CartListServlet';">장바구니로이동</button>
								</div>
							</div>
						</div>
					</div> 
			</div>
			<div>
				<a href="ProductRetrieveServlet?p_id=<%=p_id%>"> <span
					style="margin-bottom: 0.3em; font-weight: normal; color: #646464; font-size: 25px;"><%=p_name%></span></a>
			</div>
			<div>
				<p style="color: green; font-size: 20px;"><%=p_selling_price%>원
				</p>
			</div>
		</div>--%>
			</c:forEach>
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
			 
			$("#total"+p_id).text((quantity+1)*price);
			
		})//end up
		
		$("button[name=down]").on("click",function(){
			var p_id = $(this).attr("data-p_id");
			
			//input태그 수량 변화
			var quantity = parseInt($("#quantity"+p_id).val());
			
			if(quantity != 1){
				 $("#quantity"+p_id).val(parseInt(quantity)-1);
				 count =  $("#quantity"+p_id).val();
				 var price = parseInt($("#price"+p_id).val());
				 
				 $("#total"+p_id).text((quantity-1)*price);
			}
		})	//end down
		$("button[name=saveCart]").on("click",function(){
			console.log("saveCart클릭됨");
			
			var p_id = $(this).attr("data-P_id");
			var p_name = $(this).attr("data-p_name");
			var p_selling_price = $(this).attr("data-p_selling_price");
			var p_image = $(this).attr("data-p_image");
			console.log(p_id, p_name, p_selling_price, count, p_image);
			
			$.ajax({
				type : "post",
				url : "addCartServlet",
				data : {
					p_id : p_id,
					p_name : p_name,
					p_selling_price : p_selling_price,
					p_amount : count,
					p_image : p_image,
				},
				dataType : "text",
				success : function(data,status,xhr) {
					console.log("장바구니에 저장되었습니다.");
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			}); //end ajax
		
		})
		
 		$("button[name=back]").on("click", function() {
			console.log("click======");
			var p_id=$(this).attr("data-p_id");
			console.log(md);
			$("#addcart"+p_id).modal("hide");
			$("#chkmodal"+p_id).modal("hide");
			$(".modal-backdrop.show").hide();//모달창 닫고 백드롭 hide
		});//end fn
		
	})//end function
	
	
</script> 