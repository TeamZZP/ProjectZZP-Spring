<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ImagesDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.AnswerDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
			if (p_cost_price - p_discount!=0) {
				$("#p_selling_price").val(p_cost_price - p_discount);
			} else {
				$("#p_selling_price").val("금액을 확인하세요");
			}
		});
		//할인가 수정 시 판매가 자동계산
		$("#p_discount").keyup(function() {
			let p_cost_price = $("#p_cost_price").val();
			let p_discount = $(this).val();
			if (p_cost_price - p_discount!=0) {
				$("#p_selling_price").val(p_cost_price - p_discount);
			} else {
				$("#p_selling_price").val("금액을 확인하세요");
			}
		});
 
	})//end ready
</script>

<c:set var="pDTO" value="${pDTO}"></c:set>

<div class="container prodContainer">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card">
			<div class="card-header" style="text-align: left; font-weight: bold; font-size: large;">상품상세보기</div>
				<div class="card-body">
					<!-- Update form 시작 -->
					<form action="/zzp/admin/product/${pDTO.p_id}" class="form-horizontal" method="post" enctype="multipart/form-data">
					<!-- 상품카테고리 -->
					<div class="form-group">
						<label for="c_id" class="cols-sm-2 control-label" style="font-weight: bold;">상품 카테고리</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<label class="visually-hidden" for="autoSizingSelect">category</label>
						    	 <select name="c_id" id="c_id" class="form-select" aria-label="Default select example">
							        <option value="none" selected disabled hidden>카테고리 선택</option>
							        <option <c:if test="${pDTO.c_id==6}">selected</c:if> value="6">세일</option>
							        <option <c:if test="${pDTO.c_id==8}">selected</c:if> value="8">욕실용품</option>
							        <option <c:if test="${pDTO.c_id==9}">selected</c:if> value="9">주방용품</option>
							        <option <c:if test="${pDTO.c_id==10}">selected</c:if> value="10">생활용품</option>
						         </select>
							</div>
						</div>
					</div>
					<!-- 상품번호 -->
					<div class="form-group">
						<label for="p_id" class="cols-sm-2 control-label" style="font-weight: bold;">상품번호</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<input type="text" class="form-control" name="p_id" id="p_id" value="${pDTO.p_id}" readonly />
							</div>
						</div>
					</div>
					<!-- 상품명 -->
					<div class="form-group">
						<label for="p_name" class="cols-sm-2 control-label" style="font-weight: bold;">상품명</label>
						<div class="cols-sm-10">
							<div class="input-group">
							    <input type="text" class="form-control" name="p_name" id="p_name" value="${pDTO.p_name}" />
							</div>
						</div>
					</div>
					<!-- 정상가 -->
					<div class="form-group">
					    <label for="p_cost_price" class="cols-sm-2 control-label" style="font-weight: bold;">정상가</label>
					    <div class="cols-sm-10">
					        <div class="input-group">
					            <input type="text" class="form-control" name="p_cost_price" id="p_cost_price" value="${pDTO.p_cost_price}" />
					        </div>
					    </div>
					</div>
					<!-- 할인 -->
					<div class="form-group">
						<label for="type" class="col-sm-3 control-label" style="font-weight: bold;">할인</label>
						<div class="cols-sm-10">
						    <div class="input-group">
						      <input type="text" name="p_discount" id="p_discount" class="form-control" value="${pDTO.p_discount}">
						    </div>
						</div>
					</div>
					<!-- 최종판매가 -->
					<div class="form-group">
					    <label for="number" class="cols-sm-2 control-label" style="font-weight: bold;">판매가</label>
					    <div class="cols-sm-10">
					        <div class="input-group">
					            <input type="text" class="form-control" name="p_selling_price" id="p_selling_price" value="${pDTO.p_cost_price - pDTO.p_discount}" />
					        </div>
					    </div>
					</div>
					<!-- 재고 -->
					<div class="form-group">
					    <label for="number" class="cols-sm-2 control-label" style="font-weight: bold;">재고</label>
					    <div class="cols-sm-10">
					        <div class="input-group">
					            <input type="text" class="form-control" name="p_stock" id="p_stock" value="${pDTO.p_stock}" />
					        </div>
					    </div>
					</div>
					<!-- 상품설명 -->
					<div class="form-group">
					    <label for="p_content" class="cols-sm-2 control-label" style="font-weight: bold;">상품설명</label>
					    <div class="cols-sm-10">
					        <div class="input-group">
					            <input type="text" class="form-control" name="p_content" id="p_content" value="${pDTO.p_content}" />
					        </div>
					    </div>
					</div>
					<!-- 상품 이미지 -->
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
						<!-- 기존 상품 이미지명 -->
						<c:forEach var="i" items="${imageList}">
							<input type="hidden" name="old_image_route" value="${i.image_route}">
						</c:forEach>
						
					<!-- 상품수정or취소 버튼 -->
					<div class="form-group" style="margin-top: 20px; text-align: center;">
						<input type="submit" value="수정" id="updateProd" class="btn btn-success">
						<a class="btn btn-success" onclick="location.href='/zzp/admin/product';">취소</a>
					</div>
				    </form>
				</div>
			</div>
		</div>
	</div>
</div>