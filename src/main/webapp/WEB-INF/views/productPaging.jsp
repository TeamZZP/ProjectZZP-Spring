
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<div class="row">
    
      <c:forEach var="pList" items="${pDTO.list}" varStatus="status">


      <div class="col-lg-3 col-md-4 col-sm-6">
      
         <div class="hover-zoomin">
            <a href="product/${pList.p_id}"> 
            <img src="/zzp/resources/images/product/p_image/${pList.p_image}">
            </a>
         </div>
         
         <div class="p-2 text-center">
            <a href="product/${pList.p_id}"> 
            <span  style="margin-bottom: 0.3em; font-weight: normal; color: #646464; font-size: 25px;">${pList.p_name}</span>
            </a>
         </div>
         
         <div>
            <p style="color: green; font-size: 20px;"><fmt:formatNumber pattern="###,###,###" >${pList.p_selling_price}</fmt:formatNumber>원</p>
         </div> 
         
         <!-- 찜 -->
         <a id="zzim" href="javascript:zzimFunc(${pList.p_id})"> 
         
         <c:if test="${!empty zzimList}">
	   	 	 <spring:eval var="zzim" expression="zzimList.contains(${pList.p_id})" />
	   	   </c:if>
	   	   <c:choose>
	   	     <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
	   	     <c:when test="${zzim}">
	   	     	<img src="/zzp/resources/images/product/fullHeart.png" width="30" height="30" class="zzimImage" data-pid="${pList.p_id}" id="zzimImage${pList.p_id}">
	   	     </c:when>
	   	     <%-- 그외의 경우 --%>
	   	     <c:otherwise>
	   	     	<img src="/zzp/resources/images/product/emptyHeart.png" width="30" height="30" class="zzimImage" data-pid="${pList.p_id}" id="zzimImage${pList.p_id}">
	   	     </c:otherwise>
	   	   </c:choose>
            </a>
             <!-- 장바구니 모달창-->
				<!-- Button trigger modal -->
				 <button type="button" class="carticon btn" data-bs-toggle="modal" 
					data-bs-target="#addcart${pList.p_id}" style="border: 0; outline: 0;">
					<img src="/zzp/resources/images/product/cart.png" width="25" height="25" >
				</button>
				
				<!-- Modal -->
				<form action="/cart/{userid}" method="post">
					<input type="hidden" name="p_id" value="${pList.p_id}"> 
					<input type="hidden" name="p_image" value="${pList.p_image}"> 
					<input type="hidden" name="p_name" value="${pList.p_name}">
				

					<div class="modal fade" id="addcart${pList.p_id}"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header" id="header">
									<h5 class="modal-title" id="cart_title"
										style="text-align: center">
										${pList.p_name}
									</h5>

									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" style=" text-align: center;">
									<div class="opt_block no-border order_quantity_area"
										style="height: auto;">
										<div class="area_tit holder">
											<span class="option_title inline-blocked"
												style="margin-bottom: 7px;">수량</span>
										</div>
										<div class="area_count holder">
												<div class="option_btn_wrap" style="top: 0;">
													<div class="option_btn_tools">
														<input name="p_amount" class="form-control" id="p_amount${pList.p_id}" value="1" style="text-align: right; width: 80px; display: inline;margin-left: 20px; " maxlength="3" >
														<button type="button" class="btn btn-outline-success"
															id="up${pList.p_id}" name="up" data-p_id="${pList.p_id}" >+</button>
														<button type="button" class="btn btn-outline-success"
															id="down${pList.p_id}"  name="down"  data-p_id="${pList.p_id}" >-</button>
															<br> <input type="hidden" id="price${pList.p_id}" name="p_selling_price" value="${pList.p_selling_price}">
														<a>총 상품금액 :<span id="total${pList.p_id}" style="font-weight: bold;"><fmt:formatNumber pattern="###,###,###" >${pList.p_selling_price}</fmt:formatNumber></span>원</a>
													</div>
												</div>
											</div>
									</div>
								</div>
								<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">계속쇼핑하기</button>
										<button type="button" class="btn btn-success doubleModal" id="saveCart${pList.p_id}" data-p_id="${pList.p_id}" name = "saveCart"
										data-p_name = "${pList.p_name}" data-p_selling_price="${pList.p_selling_price}" data-p_image="${pList.p_image}"  data-userid="${login.userid}"
											 >장바구니저장</button>
									</div>
								</div>
							</div>
						</div>

					</form>
				<!-- 장바구니 모달안에 모달 -->
						<button type="button" id="modalBtn2" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chkmodal${pList.p_id}" style="display: none;">modal</button>
						<div class="modal fade doublemodal" id="chkmodal${pList.p_id}"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
										<h5 class="modal-title" id="cart_title"
											style="text-align: center">
											${pList.p_name}
										</h5>

										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
								<div class="modal-body" style="text-align: center;">장바구니에 저장되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" name="back"
										data-bs-dismiss="modal" id="back${pList.p_id}" data-p_id="${pList.p_id}">계속쇼핑하기</button>
									<button type="button" class="btn btn-success" name="moveCart" id="moveCart${pList.p_id}" data-P_id="${pList.p_id}"
										 onclick="location.href='${contextPath}/cart/${login.userid}';">장바구니로이동</button>
								</div>
							</div>
						</div>
					</div> 
             
             	
            </div> 
            		   
   
          </c:forEach>

          
       </div>
       
    

       