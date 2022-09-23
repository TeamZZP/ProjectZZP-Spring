<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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
            <a href="productRetrieve?p_id=${pList.p_id}"> 
            <img src="resources/images/product/p_image/${pList.p_image}">
            </a>
         </div>
         
         <div class="p-2 text-center">
            <a href="productRetrieve?p_id=${pList.p_id}"> 
            <span  style="margin-bottom: 0.3em; font-weight: normal; color: #646464; font-size: 25px;">${pList.p_name}</span>
            </a>
         </div>
         
         <div>
            <p style="color: green; font-size: 20px;"><fmt:formatNumber pattern="###,###,###" >${pList.p_selling_price}</fmt:formatNumber>원</p>
         </div> 
         
         <a id="productChoice" href="javascript:productChoice(${p_id})"> 
         
          <c:forEach var="zzim" items="${zzimList}" varStatus="status">
          
          ${zzim}
          <c:choose>
			<c:when test="${zzim}==0">
			<img id="like_img${p_id}" src="resources/images/emptyHeart.png" width="30" height="30" class="liked"> 
			</c:when>
			<c:otherwise>
			<img id="like_img${p_id}" src="resources/images/fullHeart.png" width="30" height="30" class="liked">
			</c:otherwise>
			</c:choose>
          
          </c:forEach>
               
            </a>
             
            </div> 
            		    <!-- 한 줄에4개씩 -->
						<c:if test="${status.count%4==0}">
						<div>
							<span style=" height: 10 "></span>
						</div>	
						</c:if>
            
           
          </c:forEach>
       </div>
      </div>
</form>
