<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


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


<p>main.jsp</p>

 	<div style="text-align: center;">
              <img id="banner" alt="" src="images/main/banner_sale.png">    
     </div> 
 ${mdto}<br>
 ${zzimList}<br>
 

<form action="StoreServlet" id="prodForm" >    
    <div id="categoryProductContainer" class="container ">
 
     <div class="row">
      <c:forEach var="pList" items="${Productlist}" varStatus="status">
      
        
      <div class="col-lg-3 col-md-4 col-sm-6">
      
         <div class="hover-zoomin">
            <a href="product/${pList.p_id}"> 
            <img src="${contextPath}/zzp/resources/images/product/p_image/${pList.p_image}">
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
         
         <a id="zzim" href="javascript:zzimFunc(${pList.p_id})"> 
         
         <c:if test="${!empty zzimList}">
	   	 	 <spring:eval var="zzim" expression="zzimList.contains(${pList.p_id})" />
	   	   </c:if>
	   	   <c:choose>
	   	     <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
	   	     <c:when test="${zzim}">
	   	     	<img src="resources/images/product/fullHeart.png" width="30" height="30" class="zzimImage" data-pid="${pList.p_id}" id="zzimImage${pList.p_id}">
	   	     </c:when>
	   	     <%-- 그외의 경우 --%>
	   	     <c:otherwise>
	   	     	<img src="resources/images/product/emptyHeart.png" width="30" height="30" class="zzimImage" data-pid="${pList.p_id}" id="zzimImage${pList.p_id}">
	   	     </c:otherwise>
	   	   </c:choose>
        
         
            </a>
             
            </div> 
            		   
           
          </c:forEach>
          
       </div>
      </div>
</form>
