<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dto.ProductOrderImagesDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
   #prodTable:not(:last-child){
      border-bottom-style: solid;
   }
   
   #prodTable th{
      padding-left: 30px;
      padding-right: 10px;
   }
   
   #paymentTable th{
      width: 150px;
   } 
   
   #orderInfo th{
      width: 150px;
   } 
   
   
</style>





<div class="container">
<div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header" style="text-align: center; font-weight: bold; font-size: x-large;">주문이 완료되었습니다.</div>
                            <div class="card-body">
                               <div class="card">
                                  <div class="card-body" >
                                  <div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;  padding-top: 3px;">주문정보</div>
                                  <span style="padding: 3px; 0px;"></span> 
                                  <div class="card" style="padding: 20px; 0px;">
                                     <table id="orderInfo">
                                        <tr>
                                           <th>주문일자</th>
                                           <td>${formatedNow}</td>
                                        </tr>
                                        <tr>
                                           <th>주문번호</th>
                                           <td>${prodList[0].order_id}</td>
                                        </tr>
                                        <tr>
                                           <th>진행상태</th>
                                           <td>${prodList[0].order_state}</td>
                                        </tr>
                                        <tr>
                                           <th>요청사항</th>
                                           <td>${prodList[0].delivery_req}</td>
                                        </tr>
                                        
                                     </table>
                                     
                                  </div>   
                        
                                  <div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;  padding-top: 3px;">결제정보</div>
                                  <span style="padding: 3px; 0px;"></span> 
                                  <div class="card" style="padding: 20px; 0px;">
                                     <table id="paymentTable">
                                        <c:choose>
                                         <c:when test="${payment eq '계좌이체'}">
                                        <tr>
                                           <th>결제방법</th>
                                           <td>${payment}</td>
                                        </tr>
                                        <tr style="color: red;">
                                           <th>입금은행</th>
                                           <td>지구은행</td>
                                        </tr>
                                        <tr style="color: red;">
                                           <th>계좌번호</th>
                                           <td>110-111-300247</td>
                                        </tr>
                                        
                                        </c:when>
                                        <c:otherwise>
                                           <tr>
                                           <th>결제방법</th>
                                           <td>${payment}</td>
                                        </tr>
                                        </c:otherwise>
                                         </c:choose>
                                         <c:choose>
                                            <c:when test="${!empty coupon_id}">    
                                        <tr>
                                           <th>상품금액</th>
                                           <td><fmt:formatNumber>${sum_money}</fmt:formatNumber>원</td>
                                        </tr>
                                        <tr>
                                           <th>할인금액</th>
                                           <td>(-)<fmt:formatNumber>${discount}</fmt:formatNumber>원</td>
                                        </tr>
                                        </c:when>
                                        <c:otherwise>
                                           <tr>
                                           <th>상품금액</th>
                                           <td><fmt:formatNumber>${sum_money}</fmt:formatNumber>원</td>
                                        </tr>
                                        </c:otherwise>
                                        </c:choose>
                                        <tr>
                                           <th>배송비</th>
                                           <td><fmt:formatNumber>${fee}</fmt:formatNumber>원</td>
                                        </tr>
                                        <tr>
                                           <th>최종 결제 금액 </th>
                                           <td><fmt:formatNumber>${total_price}</fmt:formatNumber>원</td>
                                        </tr>
                                     </table>
                                     
                                  </div>   
                                  <div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;  padding-top: 3px;">주문상품정보</div>
                                  <span style="padding: 3px; 0px;"></span> 
                                  <div class="card" style="padding: 20px; 0px;"  >
                                     <c:forEach items="${prodList}" var="pList">
                                        <table id="prodTable" style="display: inline; " >
                                           <tr>
                                              <td rowspan="4">
                                                 <a href="/zzp/product/${pList.p_id}" > 
                                          <img src="/zzp/resources/images/product/p_image/${pList.image_route}" 
                                           style="border: 10px;" width="100" height="100" name="p_image" ></a>
                                        </td>
                                    </tr>
                                           <tr>
                                               <th>상품명</th><td>${pList.p_name}</td> 
                                           </tr>
                                           <tr>
                                              <th id="p_amount" style="border-bottom-color: gray;  border-bottom-style: solid;">수량</th><td>${order_quantity}개</td>
                                           </tr>
                                           <tr>
                                              <th>판매가</th><td><fmt:formatNumber>${pList.p_selling_price*order_quantity}</fmt:formatNumber>원</td>
                                           </tr>
                                           
                                        </table>
                                     </c:forEach>
                                  </div>   
                                  <div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid; padding-top: 3px;">배송정보</div>
                                  <span style="padding: 3px; 0px;"></span> 
                                  <div class="card" style="padding: 20px; 0px;">
                                     <table>
                                        <tr>
                                           <th>구매자명</th>
                                           <td>${addrList[0].receiver_name}</td>
                                        </tr>
                                        <tr>
                                           <th>휴대전화</th>
                                           <td>${addrList[0].receiver_phone}</td>
                                        </tr>
                                        <tr>
                                        
                                           <th>주소</th>
                                           <td>${delivery_address}</td>
                                        </tr>
                                     </table>
                                     
                                  </div>   
                                  </div>
                               </div>
                              </div>
                        </div>
                        <div style="text-align: center; padding-top: 20px;">
                     <input type="button" class="orderBtn btn btn-success" onclick="location.href='/zzp/store'"  value="계속 쇼핑하기" >
                     <input type="button" class="delAllCart btn btn-success" onclick="location.href='/zzp/mypage/${login.userid}/order'"  value="주문내역확인">
                  </div> 
                    </div>
                </div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   $(function() {
      

   });//end function
   
   
</script> 
    
