<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.dto.MemberDTO"%>
<%@ page import="com.dto.CartDTO"%>
<%@ page import="com.dto.AddressDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
   .imagediv{
      width: 100%;
   }
   .image{
      width: 100%;
      height: auto;
   }
   
   .lastorder  td {
      padding-left: 25px;
      padding-top: 10px; 
   }
      #modalBtn{
      display: none;
   }
   .modal-body{
      text-align: center;
   }
   #mesg{
      margin: 0;
   }
</style>
<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://js.tosspayments.com/v1"></script>
<script type="text/javascript">
   $(function() {
      
      
      $("#delivery_req").on("change", function() {
         console.log($("#delivery_req").val());
      });
      
      //폼 제출 유효성 검사
      function checkValidity() {
    	
         var receiver_name = $("#receiver_name").val();
         var receiver_phone = $("#receiver_phone").val();
   	
         var numChk = /^01(0|1[6-9])(\d{3,4})(\d{4})$/; 
        
		 var post_num= $("#sample4_postcode").val(); 
         var addr1= $("#sample4_roadAddress").val();
         var addr2= $("#sample4_jibunAddress").val();
         
         event.preventDefault();
         
         if (receiver_name.length==0) {//공백 불가  
            $("#modalBtn").trigger("click");
            $("#mesg").text("이름을 입력해주세요.");
            return false;
            
         }else if(post_num.length==0 || addr1.length==0 ||addr2.length==0){
        	 $("#modalBtn").trigger("click");
             $("#mesg").text("주소를 입력해주세요.");
             return false;
          
      	}else if(receiver_phone.length==0){
      		 $("#modalBtn").trigger("click");
             $("#mesg").text("전화번호를 입력해주세요.");
             return false;
             
      	} else if (!numChk.test(receiver_phone)){//연락처는 숫자 11자리만 가능
            $("#modalBtn").trigger("click");
            $("#mesg").text("전화번호를 형식에 맞게 입력해주세요");
            $("#receiver_phone").val("");
            $("#receiver_phone").focus();
            return false;
            
         }else if (receiver_name.length > 5) {
            $("#modalBtn").trigger("click");
            $("#mesg").text("수령인은 5글자 이내로 입력해주세요.");
            $("#receiver_name").val("");
            $("#receiver_name").focus();
            return false;
         }
         
         return true;
       
      }


	//주문하기 - 결제방식에 따라
	$("#addOrder").on("click", function () {
		
        
		 if(checkValidity()) {
			let payment = $(".payment:checked").val();
          

			if (payment=="계좌이체") {
				$("#orderForm").submit();
			}
	          
			else if (payment=="카카오페이") {
				let total_amount = $("#total").text().replace(/,/g, ""); //상품금액
				total_amount = parseInt(total_amount);
	
				let quantity='${fn:length(cartList)}';
				let item_name = $(".pName:first").text(); //상품명
				item_name += (quantity > 1)? ' 외 '+(quantity-1)+'건' : '';
	         
				$.ajax({
					url:"/zzp/pay/kakao",
					type:"POST",
					data: {
							"total_amount":total_amount,
							"quantity":quantity,
							"item_name":item_name
					},
					success: function(data) {
						let new_window_width = 400;
						let new_window_height = 650;
						let positionX = (window.screen.width/2) - (new_window_width/2);  
						let positionY = (window.screen.height/2) - (new_window_height/2);
						window.open(data, "kakao", "width=" + new_window_width + ", height=" + new_window_height + ", top=" + positionY + ", left=" + positionX);
	  				},
					error: function() {
						 $("#modalBtn").trigger("click");
				         $("#mesg").text("이용에 불편을 드려 죄송합니다. 다시 시도해 주세요.");
	  				}
				})
			}//end kakaopay
		}//end if  
	})//end addOrder

      
   });
</script>
<div class="container ">

   <div class="row">
      <div class="imagediv" style="text-align: center;">
         <img class="image" src="/zzp/resources/images/product/ordering.jpg">
      </div>

      <form id="orderForm" action="/zzp/orders" method="post">
    <input type="hidden" id="userid" name="userid" value="${mdto.userid}">

      
         <table style="border-collapse: collapse;" class="table">
            <h4 style="font-weight: bold; display: inline-block;">주문상품 정보</h4>

            <span style="float: right; font-weight: bold;"><span
               id=total2 style="font-size: 20px; color: green;"></span>원</span>
            <span
               style="float: right; padding-right: 10px; padding-top: 5px; font-weight: bold;"
               id="orderCount">${fn:length(cartList)}개</span>
            <tr style="border-top-width: 5px; border-color: green;">
               <th scope="col">상품정보</th>
               <th scope="col"></th>
               <th scope="col">수량</th>
               <th scope="col">상품가격</th>
            </tr>

            <c:set var="sum" value="0" />
            <c:forEach var="cList" items="${cartList}">
               <input type="hidden" id="p_id" name="p_id" value="${cList.p_id}">
               <tr class="order_content">
                  <!-- 이미지사진  -->
                  <td><img
                     src="/zzp/resources/images/product/p_image/${cList.p_image}"
                     width="100" style="border: 10px;" height="100"></td>
                  <!-- 상품명  -->
                  <td style="line-height: 100px;"><span class="pName"
                     style="font-weight: bold; margin: 8px; display: line">${cList.p_name}</span></td>
                  <!-- 수량  -->
                  <td style="line-height: 100px;"><span id="order_amount" name="order_amount"
                     style="font-weight: bold; font-size: 20px; vertical-align: middele;" value="${cList.p_amount}">${cList.p_amount}개</span></td>
                  <input type="hidden" id="order_quantity" name="order_quantity" value="${cList.p_amount}">
                  <!-- 개별 총 가격 -->
                  <td style="line-height: 100px;"><div
                        style="font-weight: bold; font-size: 20px;">
                        <span id="item_price" class="item_price">${cList.money}</span>원
                        <input type="hidden" id="item_price" name="item_price" value="${cList.money}">
                     </div></td>

               </tr>
               <c:set var="sum" value="${sum+cList.money}" />
            </c:forEach>

         </table>

         <c:set value="${mdto}" var="m" />

         <c:forEach items="${addrList}" var="addr">
            <c:if test="${addr.default_chk==1}">
               <table style="border-collapse: collapse; border-bottom: #ffffff"
                  class="table">
                  <tr class="delivery"
                     style="border-bottom-width: 5px; border-color: green;">
                     <th colspan="4" style="font-size: 20px; font-weight: bold;">배송
                        정보</th>
                  </tr>

                  <tr>
                     <th style="padding-left: 50px;">받는 분</th>
                     <td style="width: 300px;"><input type="text"
                        class="form-control" name="receiver_name" id="receiver_name"
                        value="${addr.receiver_name}" placeholder="이름을 입력하세요" /></td>
                     <td style="width: 300px;"></td>
                     <td style="width: 300px;"></td>
                  </tr>
                  <tr>
                     <th style="padding-left: 50px;">이메일</th>
                     <td><input type="text" name="email1" id="email1"
                        value="${m.email1}" class="form-control"></td>
                     <td><div class="input-group">
                           <div class="input-group-text">@</div>
                           <input type="text" name="email2" placeholder="직접입력" id="email2"
                              class="form-control" value="${m.email2}">
                        </div></td>
                     <td><label class="visually-hidden" for="autoSizingSelect">Preference</label>
                        <select id="emailSel" class="form-select"
                        aria-label="Default select example">
                           <option value="" selected disabled hidden>이메일 선택</option>
                           <option value="daum.net">daum.net</option>
                           <option value="naver.com">naver.com</option>
                           <option value="gmail.com">gmail.com</option>
                     </select></td>
                  </tr>
                  <tr>
                     <th style="padding-left: 50px;">휴대전화</th>
                     <td><input type="text" class="form-control"
                        value="${addr.receiver_phone}" name="receiver_phone"
                        id="receiver_phone" placeholder="- 없이 입력하세요" /></td>
                     <td></td>
                  </tr>
                  <tr>
                     <th rowspan="2" style="padding-left: 50px;">주소</th>
                     <td>
                        <div class="input-group">
                           <span class="input-group-addon"><i
                              class="fa fa-users fa" aria-hidden="true"></i>
                              </span> <input type="text" name="post_num" id="sample4_postcode"
                              value="${addr.post_num}" placeholder="우편번호"
                              class="form-control"> <input type="button"  id="findPost"
                              onclick="sample4_execDaumPostcode()" value="우편번호 찾기" 
                              class=" btn btn-outline-success"><br>
                                 
                        </div>
                     </td>
                     <td></td>
                  </tr>
                  <tr>
                     <td><input type="text" name="addr1" id="sample4_roadAddress"
                        placeholder="도로명주소" class="form-control" value="${addr.addr1}">
                     </td>
                     <td><input type="text" name="addr2"
                        id="sample4_jibunAddress" placeholder="상세주소를 입력해주세요"
                        class="form-control" value="${addr.addr2}"></td>
                        <span id="guide" style="color:#999"></span> 
                  <input type="hidden" id="delivery_address" name="delivery_address" value="${addr.post_num}${addr.addr1}${addr.addr2}">
             
                 
                        
                     <td><button type="button" class=" btn btn-outline-success" id="other"
                           data-bs-toggle="modal" data-bs-target="#otherAddr">다른배송지</button></td>
                  </tr>
                  


                  <!-- 다른배송지 modal -->
                  <!-- Modal -->
                  <div class="modal fade" id="otherAddr" data-bs-backdrop="static"
                     data-bs-keyboard="false" tabindex="-1"
                     aria-labelledby="staticBackdropLabel" aria-hidden="true">
                     <div class="modal-dialog">
                        <div class="modal-content">

                           <div class="modal-header">
                              <h5 class="modal-title" id="otherAddr">${mdto.userid}님의
                                       다른 배송지</h5>
                              <button type="button" class="btn-close"
                                 data-bs-dismiss="modal" aria-label="Close"></button>
                           </div>

                           <div class="modal-body">
                           <c:forEach items="${addrList}" var="addr">
                              <div class="card" >
                                  <div class="card-header">
                                  <span style="font-weight: bold;">주소명 :</span> ${addr.address_name}
                                  </div> <br>
                           <div><span id="otherPost${addr.address_id}">(${addr.post_num})</span><br>
                           <span id="otherAddr1${addr.address_id}">${addr.addr1}</span><span id="otherAddr2${addr.address_id}">${addr.addr2}</span> </div> <br>
                            <button type="button" id="selbtn${addr.address_id}" name="selbtn"
                             class="selbtn btn btn-outline-success" data-addr_id="${addr.address_id}"  data-bs-dismiss="modal" >선택</button>
                              </div>
                              <span style="padding: 10px;"></span>
                              </c:forEach>
                              </div>
                  </div>
                     </div>
                  </div>
                  <!-- 배송지modal끝 -->

                  <tr>
                     <th style="padding-left: 50px;">배송시요청사항</th>
                     <td><select id="delivery_req" name="delivery_req"
                        class="form-select" aria-label="Default select example">
                           <option value="" selected disabled hidden>요청사항을 선택하세요</option>
                           <option value="문앞">문앞</option>
                           <option value="직접 받고 부재 시 문앞">직접 받고 부재 시 문앞</option>
                           <option value="경비실">경비실</option>
                           <option value="택배함">택배함</option>
                     </select></td>
                     <td></td>
                  </tr>


                      <!--  결제정보 -->
                  <tr style="border-bottom-width: 5px; border-color: green;">
                     <th style="font-size: 20px; font-weight: bold;">결제 정보</th>
                  </tr>
                  <tr style="border-bottom-width: 1px; border-color: green; ">
					<td><label><input type="radio" name="payment"  class="payment" style="accent-color:green;" 
                           value="카카오페이" checked>카카오페이</label></td>
                     <td><label><input type="radio" name="payment"  class="payment" style="accent-color:green;" 
                           value="계좌이체">계좌이체</label></td>
                    </tr>




               </table>
            </c:if>
         </c:forEach>

         
         <!-- 총 주문금액 -->
         <table style="float: right;" class="lastorder">
            
            <tr style="border-bottom-width: 3px; border-color: green; font-size: 20px;">
               <th>총 주문금액</th>
            <tr>
            <tr>
               <th>주문금액</th>
               <td></td>
               <td><span class="price" id="sum_money">${sum}</span>원</td>
               <input type="hidden" id="sum_money2" name="sum_money" value=" " >
            </tr>
            <tr>
               <!-- 쿠폰  -->
                  <c:set value="${couponList}" var="cou" />
               <th>쿠폰</th>
               <td></td>
               <td>
               <select id="sel_coupon" name="sel_coupon"
                  class="form-select" aria-label="Default select example">
                     <option value="" selected disabled hidden>쿠폰을 선택하세요</option>

                     <c:choose>
                        <c:when test="${fn:length(cou)==0}">
                           <option disabled="disabled">적용할 쿠폰이  없습니다.</option>
                        </c:when>
                        <c:otherwise>
                           <c:forEach items="${couponList}" var="coupon" varStatus="status">
                              <option hidden id="xxx${status.index}"
                                 data-id="${coupon.coupon_id}"
                                 data-rate="${coupon.coupon_discount}"></option>
                              <option value="${status.index}">${coupon.coupon_name}</option>
                           </c:forEach>
                        </c:otherwise>
                     </c:choose>

                     <input type="hidden" id="coupon_id" name="coupon_id" value="" >   

               </select>
               </td>
            </tr>
            <tr class="dis" style="visibility: hidden;">
               <th>할인 금액</th>
               <td></td>
               <td><span class="price" id="discount"></span></td>
               
            </tr>
            <tr class="dis" style="visibility: hidden;">
               <th>할인 후 금액</th>
               <td></td>
               <td style="font-weight: bold;"><span class="price"
                  id="discounted"></span></td>
                  <input type="hidden" id="discounted" name="discounted" value="">
            </tr>
            <tr>
               <th>배송비</th>
               <td></td>
               <td><span class="price" id="fee"></span>원</td>
            </tr>

            <tr style="border-top-width: 1px; border-color: green; font-size: 20px;">
               <th>총 결제금액</th>
               <td></td>
               <td style="color: green; font-weight: bolder;"><span
                  class="price" id="total"></span>원</td>
                  
                  <input type="hidden" id="fee2" name="fee" value=" " >
                  <input type="hidden" id="total_price" name="total_price" value=" " >
                  <input type="hidden" id="discount2" name="discount" value=""/>
                  
            </tr>

            </tbody>
         </table>

         <div class="form-group"
            style="margin-top: 300px; text-align: center;">
            <input type="submit" value="결제하기" id="addOrder"
               class="btn btn-success"> <input type="button"
               onclick="javascript:history.back();" value="취소"
               class="btn btn-success">
         </div>
      </form>
   </div>
</div>




<!-- 모달 -->
<!-- <div class="modal" id="modal" data-bs-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>
 -->

<script type="text/javascript"
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

   function totalprice() {
      var sum_money = parseInt($("#sum_money").text());
      var fee = sum_money >= 50000 ? 0 : 3000;
      var total = sum_money + fee; // 총금액 + 배송비
      var item = 0;

      $(".item_price").each(function() {
         item = parseInt($(this).text());
         $(this).text(item.toLocaleString('ko-KR')); //개별 상품금액
      });

      $("#sum_money").text(sum_money.toLocaleString('ko-KR')); //총 상품금액
      $("#fee").text(fee.toLocaleString('ko-KR')); //배송비
      $("#total").text(total.toLocaleString('ko-KR')); //총 주문금액
      $("#total2").text(total.toLocaleString('ko-KR')); //상단바 총 주문금액
      
      
      $("#sum_money2").val(sum_money);
      $("#fee2").val(fee);
      $("#total_price").val(total); 
      console.log($("#sum_money2").val(),$("#fee2").val(),$("#total_price").val());
   }
   $(function() {
      totalprice();

      //쿠폰
      $("#sel_coupon").on("change", function() {

         //상품금액
         var sum_money = $("#sum_money").text();
         sum_money = sum_money.replace(/,/g, "");//콤마 제거 문자열 변환
         sum_money = parseInt(sum_money);//정수로

         //
         $(".dis").css("visibility", "visible");
         //할인율
         var idx = $(this).val();
         var cou_id = $("#xxx" + idx).attr("data-id");
         $("#coupon_id").val(cou_id);
         var rate = $("#xxx" + idx).attr("data-rate");
         var discount = sum_money / 100 * rate;
         $("#discount").text("-" + discount.toLocaleString('ko-KR') + "원");
         var discounted = sum_money / 100 * (100 - rate);
         $("#discounted").text(discounted.toLocaleString('ko-KR') + "원");
       
         //배송 정보
         var sum = sum_money - discount; //할인이된 총 금액
         var fee = sum >= 50000 ? 0 : 3000;
         var total = sum + fee; // 총금액 + 배송비

         $("#sum_money").text(sum_money.toLocaleString('ko-KR')); //총 상품금액
         $("#fee").text(fee.toLocaleString('ko-KR')); //배송비
         $("#total").text(total.toLocaleString('ko-KR')); //총 주문금액
         $("#total2").text(total.toLocaleString('ko-KR')); //상단바 총 주문금액 
         
         $("#sum_money2").val(sum_money);
         $("#discount2").val(discount);
          $("#discounted").val(discounted);
         $("#fee2").val(fee);
         $("#total_price").val(total); 
       
      });

      //이메일 select
      $("#emailSel").on("change", function() {
         $("#email2").val($(this).val());
      });//end fn

      //우편번호 찾기 클릭시 기존 입력 데이터 초기화
      $("#findPost").on("click", function() {
         $("#sample4_jibunAddress").val("");
        
         
      });//end fn


      //다른배송지 선택
      $("button[name=selbtn]").on("click", function() {
            var addr_id=$(this).attr("data-addr_id");
            console.log(addr_id,"선택");
         
         
         var otherPost = $("#otherPost"+addr_id).text();
         var otherAddr1 = $("#otherAddr1"+addr_id).text();
         var otherAddr2 = $("#otherAddr2"+addr_id).text()
         
         console.log(otherPost,otherAddr1,otherAddr2);
          $("#sample4_postcode").val(otherPost); 
          $("#sample4_roadAddress").val(otherAddr1);
          $("#sample4_jibunAddress").val(otherAddr2);
         
          $("#delivery_address").val(otherPost+otherAddr1+otherAddr2);
      
      }); //end

   })//end
   </script>
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   <script>

      //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
      function sample4_execDaumPostcode() {
         new daum.Postcode({
            oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
               var extraRoadAddr = ''; // 도로명 조합형 주소 변수

               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                  extraRoadAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                  extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraRoadAddr !== ''){
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
               }
               // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
               if(fullRoadAddr !== ''){
                  fullRoadAddr += extraRoadAddr;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('sample4_roadAddress').value = fullRoadAddr;
               //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

               // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
               if(data.autoRoadAddress) {
                  //예상되는 도로명 주소에 조합형 주소를 추가한다.
                  var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                  document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
               } /* else if(data.autoJibunAddress) {
                  var expJibunAddr = data.autoJibunAddress;
                  document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
               } */ else {
                  document.getElementById('guide').innerHTML = '';
               }
            }
         }).open();
      }
   </script>