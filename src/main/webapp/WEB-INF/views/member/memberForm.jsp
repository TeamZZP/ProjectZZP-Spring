<%@page import="java.util.HashMap"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/member/memberForm.js"></script>

<!-- kakaoInfo -->
<c:if test="${not empty kakaoInfo}">
	<c:set var="email" value="${kakaoInfo.email}"></c:set>
	<c:set var="username" value="${kakaoInfo.nickname}"></c:set>

	<c:set var="emailSplit" value="${fn:indexOf(email,'@')}"></c:set>
	<c:set var="email1" value="${fn:substring(email,0,emailSplit)}"></c:set>
	<c:set var="email2" value="${fn:substring(email,emailSplit+1,fn:length(email))}"></c:set>
</c:if>

<div class="container">
<div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header" style="text-align: center; font-weight: bold; font-size: x-large;">ZZP 회원가입</div>
                            <div class="card-body">
                                <form class="form-horizontal" method="post" action="join" id="memberForm">
                                	<!-- 아이디 -->
                                    <div class="form-group">
                                        <label for="userid" class="cols-sm-2 control-label" style="font-weight: bold;">아이디</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="userid" id="userid" placeholder="영문자와 숫자로 이루어진 4~12자리를 입력하세요" />
                                               <!-- <button id="idCheck" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#checkId">중복확인</button> -->
                                                <a id="idCheck" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#checkIdmodal">중복확인</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 비밀번호 -->
                                     <div class="form-group">
                                        <label for="passwd" class="cols-sm-2 control-label" style="font-weight: bold;">비밀번호</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                                <input type="password" class="form-control" name="passwd" id="passwd" placeholder="영문자,숫자,특수문자를 포함하여 8~25자리를 입력하세요" />
                                                <span id="result2" style="color: blue;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="passwd2" class="cols-sm-2 control-label" style="font-weight: bold;">비밀번호 확인</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                                <input type="password" class="form-control" name="passwd2" id="passwd2" placeholder="다시 한번 입력하세요" />
                                                <span id="result3" style="color: red;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 이름 -->
                                    <div class="form-group">
                                        <label for="username" class="cols-sm-2 control-label" style="font-weight: bold;">이름</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="username" id="username" 
                                                <c:if test="${!empty username}">readonly="readonly" value="${username}"</c:if> placeholder="이름을 입력하세요"  />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 이메일 -->
                                   <div class="form-group">
                   					   <label for="type" class="col-sm-3 control-label" style="font-weight: bold;">이메일</label>
                   					  <div class="row g-3">
									  <div class="col-sm-4">
									    <input type="text" name="email1" id="email1" 
									    <c:if test="${!empty email1}">readonly="readonly" value="${email1}"</c:if> class="form-control">
									  </div>
									  <div class="col-sm-4">
									    <div class="input-group">
									      <div class="input-group-text">@</div>
									      <input type="text" name="email2"  placeholder="직접입력" 
									      <c:if test="${!empty email2}">readonly="readonly" value="${email2}"</c:if> id="email2" class="form-control">
									    </div>
									  </div>
									  <div class="col-sm-4">
									   <div class="col-sm">
									    <label class="visually-hidden" for="autoSizingSelect">email</label>
									    <select id="emailSel" class="form-select" aria-label="Default select example" 
									    	<c:if test="${!empty email2}">onfocus="this.initialSelct=this.seletedIndex;" onchange="this.selectedIndex=this.initialSelect;"</c:if>>
                            				<option value="<c:if test="${!empty email2}">${email2}</c:if>" selected disabled hidden>
                            				<c:if test="${empty email2}">이메일선택</c:if><c:if test="${!empty email2}">${email2}</c:if></option>
									        <option value="daum.net">daum.net</option>
									        <option value="naver.com">naver.com</option>
									        <option value="google.com">google.com</option>
					            		</select>
									  </div>
									</div>
									</div>
								  </div> 
                         		    <!-- 전화번호 -->
                                    <div class="form-group">
                                        <label for="number" class="cols-sm-2 control-label" style="font-weight: bold;">전화번호</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                                                <input type="text" class="form-control" name="phone" id="phone" placeholder="- 없이 입력하세요" />
                                                <span id="result5" style="color: red;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 주소 -->
                                    <div class="form-group">
                                        <label for="address" class="cols-sm-2 control-label" style="font-weight: bold;">주소</label>
                                        <div class="cols-sm-10">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
                                            	<input type="text" name="post_num" id="sample4_postcode" placeholder="우편번호" class="form-control">
												<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn btn-outline-success"><br>
                                            </div>
                                            <div class="row g-3" style="margin-top: -10px;">
                                            	<div class="col-md-6">
                      								<input type="text" name="addr1" id="sample4_roadAddress" placeholder="도로명주소" class="form-control">
                      						 	</div>
                      						 	<div class="col-md-6">
													<input type="text" name="addr2" id="sample4_jibunAddress" placeholder="지번주소" class="form-control">
												<span id="guide" style="color:#999"></span>    
												</div>                  
                                            </div>
                                        </div>
                                    </div>
                                    <!--  -->
                                    <div class="form-group" style="margin-top: 10px; text-align: center;">
                                        <input type="submit" value="회원가입" id="addMember" class="btn btn-success">
										<input type="button" onclick="javascript:history.back();" value="취소" class="btn btn-success">
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
</div>
<!-- 아이디 중복 확인 Modal -->
<div class="modal fade modal-first" id="checkIdmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">아이디 중복 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="form-group">
	        <input type="text" class="form-control" id="modalUserid" style="width: 200px; display: inline;" placeholder="아이디 입력" >
     			<button type="submit" class="btn btn-outline-success" style="display: inline;" id="useridBtn">중복확인</button>
      		<span style="display: block;" id="result4"></span>
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" name="useId" id="useId" data-id="" class="btn btn-success">사용하기</button>
        <button type="button" id="closeWin" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>