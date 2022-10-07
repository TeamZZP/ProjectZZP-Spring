<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<c:forEach var="r" items="${pDTO.list}">
	<tr class="reviewPost">
		<td style="padding:5 0 0 10px;" width="25%" class="text-center">
			<a href="/zzp/product/${r.p_id}"> 
			<img src="/zzp/resources/images/product/p_image/${r.image_route}" border="0" align="middle" class="img pb-1"
					onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"><br>
			${r.p_name}</a>
		</td>
		<td width="35%" class="align-middle">
			  <b>${r.review_title}</b><br><br>
			  ${r.review_content}<br>
			  <span class="badge rounded-pill bg-secondary mt-1">${r.review_rate}</span>
		</td>
		<td width="25%" style="text-align: center; vertical-align: middle;">
			<c:choose>
				<c:when test="${r.review_img == null || r.review_img eq 'null'}">
				
				</c:when>
				<c:otherwise>
					<div class="uploadBtu">
						<img class="upload" alt="" src="/upload/review/${r.review_img}" width="100px" height="100px" style="border: 1px solid gray;">
					</div>
				</c:otherwise>
			</c:choose>
		</td>
		<td width="15%" class="align-middle">
			<div>${r.review_create.substring(0,10)}</div>
		</td>
	</tr>
</c:forEach>