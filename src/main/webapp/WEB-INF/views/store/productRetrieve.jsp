<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ImagesDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<style>
  
	table {
  		 font-family: sans-serif;
   		}
   		
   	.item_info  td {
   		padding-left: 50px;
   	}	
</style>

<script type="text/javascript"src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function zzimFunc(p_id) {

	if("${mdto.userid}".length != 0){
		
			$.ajax({
			type: "post",
			url : "/zzp/zzim",
			data : {
				p_id:p_id
			},
			dataType: "text" ,
			success : function(data,status,xhr) {
				console.log("찜ajax");
				console.log(data);
				if(data==0){
					$("#zzimImage"+p_id).attr("src","/zzp/resources/images/product/emptyHeart.png");
				}else{
					$("#zzimImage"+p_id).attr("src","/zzp/resources/images/product/fullHeart.png");
				}
				
			},
			error : function(xhr, status,error) {
				console.log(error);
			}
		
		
	}) //end ajax
		}else{
			
		        $("#modalBtn").trigger("click");
		        $("#mesg").text("로그인이 필요합니다.");
		        
		        $("#closemodal").click(function() {
		          location.href="/login";
		       });
		          
		     }

}//end func

  $(function () {
	
	  //이미지 변경
	   $(".anotheImage").mouseover(function () {
	      var src2 = $(this).attr("src");
	       $("#firstImage").attr("src", src2);
	       
	   });
	      
	  	$(".anotheImage").mouseout(function () {
	  		var src2 = $("#img").val();
	  		$("#firstImage").attr("src",src2);
	   }); 
	
	  	
		
});//end func


</script>

<!-- 넘어온데이터 -->
<c:set value="${pdto}" var="p" />
<%-- <c:set value="${mdto}" var="m" /> 
<c:set value="${zzimList}" var="zzim" />--%>

   <form  name="goodRetrieveForm" id="goodRetrieveForm" action="${contextPath}/orders/checkout" method="post">
      <div class="row">
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <table>
          
              <c:forEach var="image" items="${imageList}">
              	<c:choose>
              	  <c:when test="${image.image_rnk==1}">
                 <tr>
                  <td >
                    <img id="firstImage" name="p_image"
                     src="/zzp/resources/images/product/p_image/${image.image_route}"
                     class="img-thumbnail" style="height: 500px; width: 600px; "  >
                      <input type="hidden" name="p_image" id="p_image" value="${image.image_route}">
                      <input type="hidden" id="img" value="/zzp/resources/images/product/p_image/${image.image_route}">
                     </td>
                  </tr>
              </c:when>
              
              <c:otherwise>
               <tr>
               
                <table style="display: inline; ">
                      <tr>
                        <td >
                           <img id="anotheImage" value="${image.image_route}"
                              src="/zzp/resources/images/product/p_image/${image.image_route}"
                           	 class="anotheImage" style="width: 100px; height: 100px;"  > 
                        </td>
                    </tr>
                   </table>
                    
   				</tr>
             </c:otherwise>
               </c:choose>
          </c:forEach>
          	
            </table>
         </div>
         <div class="col-md-1"></div>
         <div class="col-md-5" >
            <table class="item_info" style="line-height: 70px;">
             <input type="hidden" name="p_id" id="p_id" value="${p.p_id}">
             <input type="hidden" name="p_name" id="p_name" value="${p.p_name}">
             <input type="hidden" name="p_selling_price" id="p_selling_price" value="${p.p_selling_price}">
               <!-- 상품 설명 -->
            
               <tr>
                  <th>상품명</th>
                
                  <td style="font-size: 20px; font-weight: bold;">${p.p_name}</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>설명</th>
                 
                  <td>${p.p_content}</td>
               </tr>

               <tr>
       
               </tr>

               <tr>
                  <th>상품가격</th>
              
                  <td><span id="price${p.p_id}"><fmt:formatNumber pattern="###,###,###">${p.p_selling_price}</fmt:formatNumber></span>원</td>
                  
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>배송비</th>
               
                  <td>3,000원(50,000원 이상 무료배송)</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>수량</th>
                  <td>
                  <input id="p_amount${p.p_id}" name="p_amount" value="1" class="form-control"
                  style=" text-align; right; margin-top: -4px; height:39px; width:80px; display: inline;  " maxlength="3"
                        size="2" >
                  
                     <button style="display:inline; margin-top: -7px;" type="button" class="btn btn-outline-success" name="up" id="up${p.p_id}" data-p_id="${p.p_id}">+</button>
                     <button style="display:inline; margin-top: -7px;" type="button" class="btn btn-outline-success" name="down" id="down${p.p_id}"  data-p_id="${p.p_id}">-</button>
                  
                  </td>
                  <td></td>

               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>총 상품가격</th>
                  <td style="font-size: 20px; font-weight: bold; color: green;"><span id="total${p.p_id}"><fmt:formatNumber pattern="###,###,###"> ${p.p_selling_price}</fmt:formatNumber></span>원</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr >
               
               <!-- 찜  -->
               <td>
	               <a id="productChoice"  href="javascript:zzimFunc(${p.p_id})">
	               
	                <c:if test="${!empty zzimList}">
	                    <spring:eval var="zzim" expression="zzimList.contains(${p.p_id})" />
	                </c:if>
	            
		            <c:choose>
		              <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
		              <c:when test="${zzim}">
		                 <img src="/zzp/resources/images/product/fullHeart.png" width="30" height="30" class="zzimImage" data-pid="${p.p_id}" id="zzimImage${p.p_id}">
		              </c:when>
		              <%-- 그외의 경우 --%>
		              <c:otherwise>
		                 <img src="/zzp/resources/images/product/emptyHeart.png" width="30" height="30" class="zzimImage" data-pid="${p.p_id}" id="zzimImage${p.p_id}">
		              </c:otherwise>
		            </c:choose>
		               </a>
               </td> 
                 
                  <td>
                  <button type="submit"  class="btn btn-success" data-p_id = "${p.p_id}" data-p_name = "${p.p_name}" data-p_selling_price="${p.p_selling_price}" data-p_image="${imageList}" id="toOrder">주문하기</button>
                  <!-- Button trigger modal -->
                  <button  type="button" class="btn btn-success" name="cart" id="cart${p.p_id}" data-P_id = "${p.p_id}"
                  data-p_name = "${p.p_name}" data-p_selling_price="${p.p_selling_price}" data-p_image="${image.image_rnk}">
                  			장바구니
                  </button>
                 
                  </td>
               </tr>
               
            </table>
         </div>
      </div>
   </form>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	
   $(function() {
      
      var count = "1";
      $("button[name=up]").click(function() {
         
         var p_id =$(this).attr("data-p_id");
         console.log("up클릭 "+p_id);
         
         var p_amount= $("#p_amount"+p_id).val();
         $("#p_amount"+p_id).val(parseInt(p_amount)+1);
         count = $("#p_amount"+p_id).val();
         
         var price = $("#price"+p_id).text();
         	price =parseInt(price.replace(/,/g, ""));//콤마 제거 문자열 변환
        	
         var total = $("#total"+p_id).text((count*price).toLocaleString('ko-KR'));
         
      });//end up

       $("button[name=down]").click(function() {

         var p_id =$(this).attr("data-p_id");
         console.log("down클릭 "+p_id);
         var p_amount= $("#p_amount"+p_id).val();
         
         if(p_amount != 1){
         $("#p_amount"+p_id).val(parseInt(p_amount)-1);
         count = $("#p_amount"+p_id).val();
         console.log(count);
         var price = $("#price"+p_id).text();
        	 price =parseInt(price.replace(/,/g, ""));//콤마 제거 문자열 변환
         var total = $("#total"+p_id).text((count*price).toLocaleString('ko-KR'));
         
         }
         
      });//end down 

     $("button[name=cart]").on("click", function() {
        var p_id = $(this).attr("data-P_id");
        var p_name = $(this).attr("data-p_name");
   
         console.log("p_id",p_id,"p_name :", p_name ,"count:", count);
        
       if ("${mdto.userid}" != "") {
            $.ajax({
               type : "post",
               url : "${contextPath}/cart/${login.userid}",
               data : {
                  p_id : p_id,
                  p_name : p_name, 
                  p_amount : count,
               },
                dataType : "text",
              success : function(data, status, xhr) {
               console.log("add성공");
            },
            error : function(xhr, status, error) {
            console.log(error);
            }
        })//end ajax
        
        $("#modalBtn2").trigger("click");
            
      }else{
            $("#modalBtn").trigger("click");
            $("#mesg").text("로그인이 필요합니다.");
            
            $("#closemodal").click(function() {
              location.href="${contextPath}/login";
           });
              
         }
   
   })//cart 
   

 
      
   });//end ready
   
    
</script>
 <!-- Modal -->
                  <button type="button" id="modalBtn2" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#cartCkeck" style="display: none;">modal</button>
                  <div class="modal fade" id="cartCkeck" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" style="text-align: center;">
                            	장바구니에 저장되었습니다.
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">쇼핑계속하기</button>
                          <button type="button" class="btn btn-success" onclick="location.href='${contextPath}/cart/${login.userid}';" >장바구니보기</button>
                        </div>
                      </div>
                    </div>
                  </div>
