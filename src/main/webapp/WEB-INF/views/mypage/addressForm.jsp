<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<meta charset="UTF-8">
<style>
	label {
		padding: 5px 0 5px 0;
		font-weight: bold;
	}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//배송지 수정
		if ("${address}".length != 0) {
			//console.log("배송지 수정 폼 ${address}");
			$("input[name=_method]").val("put");//method put 요청
		}
		
		//기본 배송지 체크
		if ("${address.default_chk}" == 1) {//기본 배송지 체크 상태로 출력되도록
			//console.log("기본 배송지");
 			$("#gridCheck").on("click", function() {
				$("#openModal").trigger("click");
				$("#modalMesg").text("기본 배송지 설정은 해제할 수 없습니다. 수정을 원하는 경우 다른 배송지를 기본으로 설정하세요.");
			});
		}
		
		$("form").on("submit", function() {
			var address_name=$("#inputAddressName").val();
			var receiver_name=$("#inputReceiverName").val();
			var receiver_phone=$("#inputReceiverPhone").val();
			var post_num=$("#sample4_postcode").val();
			var addr1=$("#sample4_roadAddress").val();
			var addr2=$("#sample4_jibunAddress").val();
			var numChk = /^01(0|1[6-9])(\d{3,4})(\d{4})$/;
			
			if (address_name=="" || receiver_name=="" || receiver_phone=="" ||
					post_num=="" || addr1=="" || addr2=="") {//공백 불가
				$("#openModal").trigger("click");
				$("#modalMesg").text("배송지 정보를 입력해주세요.");
				event.preventDefault();
			} else if (receiver_phone != "" && !numChk.test(receiver_phone)) {//연락처는 숫자 11자리만 가능
				$("#openModal").trigger("click");
				$("#modalMesg").text("연락처를 형식에 맞게 입력해주세요.");
				$("#inputReceiverPhone").val("");
				$("#inputReceiverPhone").focus();
				event.preventDefault();
			} else if (receiver_name.length > 3){
				$("#openModal").trigger("click");
				$("#modalMesg").text("수령인은 3글자 이내로 입력해주세요.");
				$("#inputReceiverName").val("");
				$("#inputReceiverName").focus();
				event.preventDefault();
			} else {
				//submit
			}
		});//end submit
		
		//삭제
		$("#delAddress").on("click", function() {
			$("#confirm").removeAttr("data-bs-dismiss");
			$("#openModal").trigger("click");
			$("#modalMesg").text("배송지를 삭제합니다.");
			$("#confirm").on("click", function() {//배송지 삭제
				var id="${address.address_id}";
				$.ajax({
					type : "delete",
					url : "${contextPath}/mypage/${login.userid}/address",
					contentType:"application/json;charset=UTF-8",//매개변수 map으로 받을 수 있도록
					data : JSON.stringify({
						address_id : id
					}),
					success : function(data, status, xhr) {
						//console.log(data);
						$("#confirm").attr("data-bs-dismiss","modal");
						$("#modalMesg").text("배송지가 삭제되었습니다.");
						$("#confirm").on("click", function() {
							location.href="${contextPath}/mypage/${login.userid}/address";
						});//end fn
					},
					error : function(xhr, status, error) {
						console.log(error)
					}
				});//end ajax
			});//end fn
		});
		
		//취소
		$("#cancle").on("click", function() {
			$("#openModal").trigger("click");
			if ("${address}".length != 0) {//배송지 수정 폼
				$("#modalMesg").text("배송지 수정을 취소합니다.");
			} else {
				$("#modalMesg").text("배송지 추가를 취소합니다.");
			}
			$("#confirm").on("click", function() {
				location.href="${contextPath}/mypage/${login.userid}/address";
			});//end fn
		});
	});//end ready
</script>
<form action="${contextPath}/mypage/${login.userid}/address" method="post" class="row g-2">
<input type="hidden" name="_method" value="">
<input type="hidden" name="addressId" value="${address.address_id}">
	<div class="row justify-content-center">
		<div class="col-md-6">
			  <div class="col-md-4">
			    <label for="inputAddressName" class="form-label">배송지명</label><!-- 줄 안 바꾸고 싶음 -->
			    <input type="text" class="form-control" name="address_name" id="inputAddressName"
			    	<c:if test="${not empty address}">value="${address.address_name}"</c:if> placeholder="ex) 집, 회사...">
			  </div>
			  <div class="col-md-4">
			    <label for="inputReceiverName" class="form-label">수령인</label>
			    <input type="text" class="form-control" name="receiver_name" id="inputReceiverName"
			    	<c:if test="${not empty address}">value="${address.receiver_name}"</c:if> placeholder="받는 분 성함">
			  </div>
			  <div class="col-md-4">
			    <label for="inputReceiverPhone" class="form-label">연락처</label>
			    <input type="text" class="form-control" name="receiver_phone" id="inputReceiverPhone"
			    	<c:if test="${not empty address}">value="${address.receiver_phone}"</c:if> placeholder="숫자 11자리 입력">
			  </div>
			  <!-- 주소 -->
				<div class="col-12">
						<div class="form-group">
							<label for="address" class="cols-sm-2 control-label">주소</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
									<input type="text" name="post_num" id="sample4_postcode" class="form-control" readonly="readonly"
										<c:if test="${not empty address}">value="${address.post_num}"</c:if> placeholder="우편번호">
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-outline-success"><br>
								</div>
								<div class="row g-3" style="margin-top: -10px;">
									<div class="col-md-8">
										<input type="text" name="addr1" id="sample4_roadAddress" class="form-control" readonly="readonly"
											<c:if test="${not empty address}">value="${address.addr1}"</c:if> placeholder="도로명주소">
									</div>
									<div class="col-md-4">
										<input type="text" name="addr2" id="sample4_jibunAddress" class="form-control"
											<c:if test="${not empty address}">value="${address.addr2}"</c:if> placeholder="상세 주소를 입력하세요.">
										<span id="guide" style="color:#999"></span>
									</div>                  
								</div>
							</div>
						</div>
				</div>
			  <div class="col-12">
			    <div class="form-check" id="defaultChk">
			      <input class="form-check-input" type="checkbox" id="gridCheck" name="chk"
			      	<c:if test="${not empty address && address.default_chk eq 1}">checked="checked" onclick="return false;"</c:if>>
			      <span>기본 배송지로 설정</span>
			    </div>
			  </div>
			
		</div>
		<div class="col-12" style="margin-top: 40px;">
			<div style="text-align: center;">
				<button type="submit" id="succ" class="btn btn-success">완료</button>
				<button type="reset" id="cancle" class="btn btn-success">취소</button>
			</div>
			<div style="float: right; margin-top: 10px; margin-right: 370px;">
				<c:if test="${not empty address && address.default_chk eq 0}">
					<button class="btn btn-light btn-sm" type="button" id="delAddress">삭제</button>
				</c:if>
			</div>
		</div>
	</div>
</form>
<!-- Button trigger modal -->
<button type="button" id="openModal" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#mypageModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="mypageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="confirm" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
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