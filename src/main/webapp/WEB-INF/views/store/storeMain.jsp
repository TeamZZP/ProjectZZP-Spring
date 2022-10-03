<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.List" %>
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
   width: 300px;
   height: 300px;
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

<script type="text/javascript"src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>

	function zzimFunc(p_id) {
		
		$.ajax({
			type: "get",
			url : "zzim",
			data : {
				p_id:p_id
			},
			dataType: "text" ,
			success : function(data,status,xhr) {
				console.log("찜ajax");
				console.log(data);
				if(data==0){
					$("#zzimImage"+p_id).attr("src","resources/images/product/emptyHeart.png");
				}else{
					$("#zzimImage"+p_id).attr("src","resources/images/product/fullHeart.png");
				}
				
			},
			error : function(xhr, status,error) {
				console.log(error);
			}
			
			
		}) //end ajax

	}
	

</script>




   <!-- 세일배너 -->  
    ${banner}
    

<%--  ${mdto}<br>
 ${zzimList}<br> --%>
 
<c:set value="${pDTO.list}" var="Productlist" />

<form action="#" id="prodForm" >    
    <div id="categoryProductContainer" class="container ">


<div class="row">
        <div class="col">
                 <div class="float-end">
                <!-- 정렬 -->
              <select class="form-select sortBy" name="sortBy" id="sortBy" data-style="btn-info" 
                      style="width: 145px; margin-left: -24px; display: inline;">
                   <option value="p_id" selected>정렬</option>
                   <option value="p_created" <% if("p_created".equals("${sortBy}")){%>selected<%}%>>최신상품순</option>
                   <option value="p_selling_price" <% if("p_selling_price".equals("${sortBy}")){%>selected<%}%>>판매가순</option>
                   <option value="p_name" <% if("p_name".equals("${sortBy}")){%>selected<%}%>>상품명순</option>
              </select>
           </div>
          </div>
      </div>
      <div style="height: 10px;"></div>
      

    <div id="productContainer" class="container ">

 
     <div class="row">
    
      <c:forEach var="pList" items="${Productlist}" varStatus="status">


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
      </div>
          <!-- 페이징 -->
      	  <div class="p-2 text-center">
		  <c:if test="${pDTO.prev}">   <!-- boolean타입 변수 prev가 true일 경우 (prev = startPage > 1;) -->
		  	<a class="paging" data-page="${pDTO.startPage-1}" id="page" >prev&nbsp;&nbsp;</a>
		  </c:if>
		  <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			  <c:choose>
		  		<c:when test="${p==pDTO.page}" ><a class="paging" data-page="${p}"  id="page" >${p}&nbsp;&nbsp;</a></c:when>
		  		<c:otherwise><a class="paging" data-page="${p}"  id="page" >${p}&nbsp;&nbsp;</a></c:otherwise>
		  	  </c:choose>
		  </c:forEach>
		  <c:if test="${pDTO.next}">
		  	<a class="paging" data-page="${pDTO.endPage+1}"  id="page" >next</a> <!-- boolean타입 변수 next가 true일 경우 (next = endPage < realEnd;) -->
		  </c:if>
</div>
      
</form>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script  type="text/javascript">
   $(function() {
      //UP버튼 수량 변화   
      var count="1";
      $("button[name=up]").on("click", function() {
         var p_id = $(this).attr("data-p_id");
         console.log(p_id +" up클릭");
         
         var p_amount = parseInt($("#p_amount"+p_id).val());
         $("#p_amount"+p_id).val(parseInt(p_amount) + 1);
         count=$("#p_amount"+p_id).val();
         var price = parseInt($("#price"+p_id).val());
         
          $("#total"+p_id).text(count*price);
      
         //총합 구하기
      })//end up
      
      $("button[name=down]").on("click", function() {
         var p_id = $(this).attr("data-p_id");
         console.log(p_id +" down클릭");
         
         //input태그 수량변화
         var p_amount = parseInt($("#p_amount"+p_id).val());
         
         if(p_amount !=1){
         $("#p_amount"+p_id).val(parseInt(p_amount) - 1);
         count=$("#p_amount"+p_id).val();
         var price = parseInt($("#price"+p_id).val());
         
         $("#total"+p_id).text(count*price);
         
         }
      })//end down
         $("button[name=saveCart]").on("click",function(){
         console.log("saveCart클릭됨");
         
         var p_id = $(this).attr("data-P_id");
         var p_name = $(this).attr("data-p_name");
         var p_selling_price = $(this).attr("data-p_selling_price");
         var p_image = $(this).attr("data-p_image");
         console.log(p_id, p_name, p_selling_price, count, p_image);
         
         if ("${mdto.userid}" != "") {
            $.ajax({
               type : "post",
               url : "${contextPath}/cart/${mdto.userid}",
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


		});//end fn
		
		//페이지 선택시
		$(".paging").on("click", function() {
			console.log("pageChange()실행");
			var sortBy = $("#sortBy").val();
			var curPage = $(this).attr("data-page");
			var c_id = '${c_id}';
			
		    console.log("정렬 change");
			console.log("sortBy:"+ sortBy);
			console.log("c_id:"+ c_id);
			console.log("curPage:"+ curPage);
			
			$(".paging").css( "color", "black");
			$(this).css( "color", "green");
			$.ajax({
			   type : "get",
			   url : "/zzp/pageChange",
			   data : {
			      sortBy :sortBy,
			      c_id :c_id,
			      curPage : curPage
			   },
			   dataType: "text",
			   success : function(data,status,xhr) {
				console.log("페이지 바꿈");
				
				$("#productContainer").empty();
				$("#productContainer").append(data);
				
				
				
										 
			  },
			   error : function(xhr, status,error) {
				console.log(error);
			  }

			}); //end ajax 
		});
		
	
		 
		
		//정렬 선택시 
			$("#sortBy").on("change", function () {
					
			var sortBy = $("#sortBy").val();
			var curPage = 1;
			var c_id = '${c_id}';
			
			console.log("정렬 change");
			console.log("sortBy:"+ sortBy);
			console.log("c_id:"+ c_id);
			console.log("curPage:"+ curPage);
			
			$(".paging").css( "color", "black");
			
			$.ajax({
			   type : "get",
			   url : "/zzp/pageChange",
			   data : {
			      sortBy :sortBy,
			      c_id :c_id,
			      curPage : curPage
			   },
			   dataType: "text",
			   success : function(data,status,xhr) {
				console.log("페이지 바꿈");
				$("#productContainer").empty();
				 $("#productContainer").append(data);
			  },
			   error : function(xhr, status,error) {
				console.log(error);
			  }

			}); //end ajax

		});
		
		
		
	}); //end function
	
	


      
      
     
    
</script>           