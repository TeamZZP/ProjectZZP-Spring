<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.prodContainer{
		margin-top: 10px;
	}
	.card{
		border: none;
	}
	.card-header{
		text-align: left; 
		font-weight: bold; 
		font-size: large;
		background-color: white;
	}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		//정상가 수정 시 판매가 자동계산
		$("#p_cost_price").keyup(function() {
			let p_cost_price = $(this).val();
			let p_discount = $("#p_discount").val();
			if (p_cost_price - p_discount>=0) {
				$("#p_selling_price").val(p_cost_price - p_discount);
			} else {
				$("#p_selling_price").val("금액을 확인하세요");
			}
		});
		//할인가 수정 시 판매가 자동계산
		$("#p_discount").keyup(function() {
			let p_cost_price = $("#p_cost_price").val();
			let p_discount = $(this).val();
			if (p_cost_price - p_discount>=0) {
				$("#p_selling_price").val(p_cost_price - p_discount);
			} else {
				$("#p_selling_price").val("금액을 확인하세요");
			}
		});
		//submit 시 값 확인
		$("#addForm").submit(function() {
			let c_id = $("#c_id option:selected").val();
			let p_name = $("#p_name").val();
			let p_cost_price = $("#p_cost_price").val();
			let p_discount = $("#p_discount").val();
			let p_selling_price = $("#p_selling_price").val();
			let p_stock = $("#p_stock").val();
			let image_rnk_1 = $("#image_route_1").val();
			let image_rnk_2 = $("#image_route_2").val();
			let image_rnk_3 = $("#image_route_3").val();
			let image_rnk_4 = $("#image_route_4").val();
			
			if (c_id=='none') {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (p_name.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (p_cost_price.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (p_discount.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (p_selling_price.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (p_stock.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (image_rnk_1.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (image_rnk_2.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (image_rnk_3.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (image_rnk_4.length==0) {
				$("#modalBtn").click();
				event.preventDefault();
			} else if (!checkFileExtension()) {
				event.preventDefault();
			}
		});
		//이미지 확장자 검사
		function checkFileExtension(){ 
			let image_rnk_1 = $("#image_route_1").val();
			let image_rnk_2 = $("#image_route_2").val();
			let image_rnk_3 = $("#image_route_3").val();
			let image_rnk_4 = $("#image_route_4").val();
			let reg = /(.*?)\.(jpg|jpeg|png|gif|PNG)$/;
			
			if (image_rnk_1.match(reg) && image_rnk_2.match(reg) && image_rnk_3.match(reg) && image_rnk_4.match(reg)) {
				return true;
			} else {
				$("#modalBtn").click();
				return false;
			}
		}
		
	})//end ready
</script>

<div class="container prodContainer">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card">
			<div class="card-header" style="text-align: left; font-weight: bold; font-size: large;">상품등록</div>
				<div class="card-body">
					<!-- add form 시작 -->
					<form action="/zzp/admin/product" id="addForm" class="form-horizontal" enctype="multipart/form-data" method="post">
						<!-- 상품카테고리 -->
						<div class="form-group">
							<label for="c_id" class="cols-sm-2 control-label" style="font-weight: bold;">상품 카테고리</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<label class="visually-hidden" for="autoSizingSelect">category</label>
							    	 <select name="c_id" id="c_id" class="form-select" aria-label="Default select example">
								        <option value="none" selected disabled hidden>카테고리 선택</option>
								        <option value="6">세일</option>
								        <option value="8">욕실용품</option>
								        <option value="9">주방용품</option>
								        <option value="10">생활용품</option>
							         </select>
								</div>
							</div>
						</div>
						<!-- 상품명 -->
						<div class="form-group">
							<label for="p_name" class="cols-sm-2 control-label" style="font-weight: bold;">상품명</label>
							<div class="cols-sm-10">
								<div class="input-group">
								    <input type="text" class="form-control" name="p_name" id="p_name"  />
								</div>
							</div>
						</div>
						<!-- 정상가 -->
						<div class="form-group">
						    <label for="p_cost_price" class="cols-sm-2 control-label" style="font-weight: bold;">정상가</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
						            <input type="text" class="form-control" name="p_cost_price" id="p_cost_price"/>
						        </div>
						    </div>
						</div>
						<!-- 할인 -->
						<div class="form-group">
							<label for="type" class="col-sm-3 control-label" style="font-weight: bold;">할인</label>
							<div class="cols-sm-10">
							    <div class="input-group">
							      <input type="text" name="p_discount" id="p_discount" class="form-control" >
							    </div>
							</div>
						</div>
						<!-- 최종판매가 -->
						<div class="form-group">
						    <label for="number" class="cols-sm-2 control-label" style="font-weight: bold;">판매가</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
						            <input type="text" class="form-control" name="p_selling_price" id="p_selling_price"  />
						        </div>
						    </div>
						</div>
						<!-- 재고 -->
						<div class="form-group">
						    <label for="number" class="cols-sm-2 control-label" style="font-weight: bold;">재고</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
						            <input type="text" class="form-control" name="p_stock" id="p_stock" />
						        </div>
						    </div>
						</div>
						<!-- 상품설명 -->
						<div class="form-group">
						    <label for="p_content" class="cols-sm-2 control-label" style="font-weight: bold;">상품설명</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
						            <input type="text" class="form-control" name="p_content" id="p_content"  />
						        </div>
						    </div>
						</div>
						<!-- 이미지 -->
						<div class="form-group">
						    <label for="image_route" class="cols-sm-2 control-label" style="font-weight: bold;">상품이미지 1</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
									<!-- <input class="form-control" type="file" accept="image/*" name="image_route_1" id="image_route_1" multiple> -->
									<input class="form-control" type="file" accept="image/*" name="image_route" id="image_route_1" multiple>
						        </div>
						    </div>
						</div>
						<div class="form-group">
						    <label for="image_route" class="cols-sm-2 control-label" style="font-weight: bold;">상품이미지 2</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
									<!-- <input class="form-control" type="file" accept="image/*" name="image_route_2" id="image_route_2" multiple> -->
									<input class="form-control" type="file" accept="image/*" name="image_route" id="image_route_2" multiple>
						        </div>
						    </div>
						</div>
						<div class="form-group">
						    <label for="image_route" class="cols-sm-2 control-label" style="font-weight: bold;">상품이미지 3</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
									<!-- <input class="form-control" type="file" accept="image/*" name="image_route_3" id="image_route_3" multiple> -->
									<input class="form-control" type="file" accept="image/*" name="image_route" id="image_route_3" multiple>
						        </div>
						    </div>
						</div>
						<div class="form-group">
						    <label for="image_route" class="cols-sm-2 control-label" style="font-weight: bold;">상품이미지 4</label>
						    <div class="cols-sm-10">
						        <div class="input-group">
									<!-- <input class="form-control" type="file" accept="image/*" name="image_route_4" id="image_route_4" multiple> -->
									<input class="form-control" type="file" accept="image/*" name="image_route" id="image_route_4" multiple>
						        </div>
						    </div>
						</div>
						<!-- 상품등록or취소 버튼 -->
						<div class="form-group" style="margin-top: 20px; text-align: center;">
							<input type="submit" value="등록" id="addProd" class="btn btn-success">
							<a class="btn btn-success" onclick="location.href='/zzp/admin/product';">취소</a>
						</div>
				    </form>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Modal button -->
<button id="modalBtn" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#staticBackdrop2" style="display: none;">modal</button>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <b>모든 항목을 입력하였는지 확인해 주세요.</b><br>
        ( 파일 확장자 확인 : jpg, jpeg, png, gif 파일만 업로드 가능 )
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal" onclick="">확인</button>
      </div>
    </div>
  </div>
</div>