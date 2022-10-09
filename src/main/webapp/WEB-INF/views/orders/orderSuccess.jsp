<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dto.ProductOrderImagesDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
${prodList}

${addrList}
<div class="container">
<div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header" style="text-align: center; font-weight: bold; font-size: x-large;">주문이 완료되었습니다.</div>
                            <div class="card-body">
                            	<div class="card">
                            		<div class="card-body">
                            		<div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;">주문정보</div>
                            		<div class="card">
                            			<div><span>주문일자</span><span>${prodList[0].order_date}</span></div>
                            			<div><span>주문번호</span>${prodList[0].order_id}</div>
                            			<div><span>진행상태</span>${prodList[0].order_state}</div>
                            		</div>	
                            		<div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;">결제정보</div>
                            		<div class="card">
                            			<div><span>결제방법</span>${payment}</div>
                            			<div><span>상품금액</span><fmt:formatNumber>${prodList[0].sum_money}</fmt:formatNumber>원</div>
                            			<div><span>배송비</span><fmt:formatNumber>${prodList[0].fee}</fmt:formatNumber>원</div>
                            			<div><span>최종 결제 금액</span><fmt:formatNumber>${prodList[0].total_price}</fmt:formatNumber>원</div>
                            		</div>	
                            		<div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;">주문상품 정보</div>
                            		<div class="card">
                            			<c:forEach items="${prodList}" var="pList">
                            			<div><span>상품명</span>${pList.p_name}</div>
                            			<div><span>판매가</span>${pList.p_selling_price}</div>
                            			<div><span>수량</span>${pList.p_amount}개</div>
                            			</c:forEach>
                            			
                            		</div>	
                            		<div style="font-weight: bold; font-size: 25px; border-bottom-color: f1f3f5; border-bottom-style: solid;">배송정보</div>
                            		<div class="card">
                            			<div><span>구매자명</span>${addrList[0].receiver_name}</div>
                            			<div><span>휴대전화</span>${addrList[0].receiver_phone}</div>
                            			<div><span>주소</span>${addrList[0].addr1}${addrList[0].addr2}</div>
                            		</div>	
                            		</div>
                            	</div>
                           	</div>
                        </div>
                    </div>
                </div>
</div>
<!-- <div class="container">
  <div class="row">
  	<table class="table" border="3">
  <thead>
    <tr style="font-size: 25px; background-color: #dee2e6;">
      <th colspan="4">주문 완료</th>
    </tr>
  </thead>
  <tbody >
   	<table border="1">
   		<tr>
			<th style="border-bottom-color: gray;" >주문정보</th> 
   		</tr>
   		<tr>
   			<td>배송지</td>
   		</tr>
   	</table>
  </tbody>
</table>
  </div>
</div> -->