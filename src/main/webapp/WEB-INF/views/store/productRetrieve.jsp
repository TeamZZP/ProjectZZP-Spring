<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ImagesDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
   .item_info td{
      padding-left: 10px;
   }

</style>


<script type="text/javascript"src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

function order(p_id) {
	
	$.ajax({
		type: "post",
		utl : "castingCartDTO",
		data: {
			p_id : p_id,
			userid: userid,
			p_amount : p_amount,
			p_image : p_image,
			p_name : p_name,
			p_selling_price : p_selling_price,
			userid : userid
		},
		dataType: "text",
		success : function(data,status,xhr) {
			
		location.href="orders";
		},
		error : function(xhr, status,error) {
			console.log(error);
		}
		
		
	})//end order ajax
	
	
}//end order

</script>



<style>
   table {
   font-family: sans-serif;
   }
</style>

<!-- 넘어온데이터 -->
<c:set value="${pdto}" var="p" />
<c:set value="${mdto}" var="m" />
<c:set value="${zzim}" var="zzim" />
<c:set value="${imageList}" var="images" />

   <form  name="goodRetrieveForm" action="#" method="get">
      <div class="row">
         <div class="col-md-1"></div>
         <div class="col-md-5">
            <table>
          
              <c:forEach var=image items="${imageList}" varStatus="status" >
                 <c:if test="${image.image_rnk==1}">  
              
               <tr>
                  <td colspan="5">
                    <img id="firstImage" name="p_image"
                     src="/zzp/resources/images/product/p_image/${image.image_route}"
                     class="img-thumbnail" style="height: 500; width: 600; " ></td>
                     <input type="hidden" name="p_image" id="p_image" value="${image.image_route}">
               </tr>
              </c:if>  
               <tr>
                  <table style="display: inline;">
                     <tr>
                        <td colspan="5">
                           <img class="imageChange"
                              src="/zzp/resources/images/product/p_image/${image.image_route}"
                              class="img-thumbnail" style="height: 100; width: 100;" > 
                        </td>
                     </tr>
                  </table>
               </tr>
          </c:forEach>
            </table>
         </div>
         <div class="col-md-1"></div>
         <div class="col-md-5" >
            <table class="item_info" style="line-height: 70px;">
               <!-- 상품 설명 -->
            
               <tr>
                  <th>상품명</th>
                  <td></td>
                  <td style="font-size: 20px; font-weight: bold;">${p.p_name}</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>설명</th>
                  <td></td>
                  <td>${p.p_content}</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>상품가격</th>
                  <td></td>
                  <td><span id="price${p.p_price}" name="p_selling_price">${p.p_selling_price}</span>원</td>
                  
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>배송비</th>
                  <td></td>
                  <td>3,000원(50,000원 이상 무료배송)</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr>
                  <th>수량</th>
                  <td></td>
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
                  <td></td>
                  <td style="font-size: 20px; font-weight: bold;"><span id="total${p.p_id}">${p.p_selling_price}</span>원</td>
               </tr>

               <tr>
                  <td></td>
               </tr>

               <tr >
               
               <!-- 찜  -->
               <td><a id="productChoice"  href="javascript:zzimCheck(${p.p_id})">
                <c:if test="${!empty zzim}">
	   	 	 		<spring:eval var="zzim" expression="zzim.contains(${p.p_id})" />
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
               </a></td> 
               
                  <td><button type="submit" class="btn btn-success" id="order">주문하기</button>
                  </td>
                  
                  <td>
                  <!-- Button trigger modal -->
                  
                  </td>
               </tr>
               
            </table>
         </div>
      </div>
   </form>


