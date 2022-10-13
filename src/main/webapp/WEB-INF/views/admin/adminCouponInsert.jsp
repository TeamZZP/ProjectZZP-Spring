<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.modal-body{
		text-align: center;
	}	
	#mesg{
		margin: 0;
	}
	#modalBtn{
		display: none;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#coupon_name").focus();
				$("#couponInsert").click(function() {
					var coupon_name = $("#coupon_name").val();
					var coupon_discount = $("#coupon_discount").val();
					var regExp = /^[0-9]*$/;
					if (coupon_name.length == 0) {
						$("#modal").trigger("click");
						$("#mesg").text("쿠폰 이름을 입력하십시오.");
						event.preventDefault();
					} else if (coupon_discount.length == 0) {
						$("#modal").trigger("click");
						$("#mesg").text("쿠폰 할인율을 입력하십시오.");
						event.preventDefault();
					} else if (!regExp.test(coupon_discount)) {
						$("#modal").trigger("click");
						$("#mesg").text("쿠폰 할인율에 숫자만 입력해 주십시오.");
						event.preventDefault();
					} else {
						$("#couponForm").attr("action", "/zzp/admin/coupon");
					}
				});
				$("#couponList").click(function() {
					history.back();
					event.preventDefault();
				});
			});//end ready
</script>

<form id="couponForm" method="post">
<div class="container justify-content-center">
<div class="row">
	<div class="col-md-5"></div>
	<div class="col-md-5">
		<table style="text-align: left; vertical-align: middle;">
			<tr>
				<td colspan="3"> <b>쿠폰 등록</b> <hr> </td>
			</tr>
			<tr>
				<td colspan="3"> 
					<b>쿠폰 이름</b>
					<div class="input-group">
					  <input type="text" class="form-control" name="coupon_name" id="coupon_name">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<b>할인율</b>
					<div class="input-group">
					  <input type="text" class="form-control" name="coupon_discount" id="coupon_discount">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> <button id="couponList" class="btn btn-success">목록</button> </td>
				<td style="text-align: right;">
					<button id="couponInsert" type="submit" class="btn btn-success">등록</button>
					<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#aa">취소</button>
					
					<div class="modal fade" id="aa" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">취소</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="text-align: left;">
					   	     이전 페이지로 돌아가시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-success" onclick="history.back()">확인</button>
					        <button type="button" class="btn btn-success" data-bs-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="col-md-2"></div>
</div>
</div>
</form>

<!-- Button trigger modal -->
<button type="button" id="modal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#couponModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="couponModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <span id="mesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>