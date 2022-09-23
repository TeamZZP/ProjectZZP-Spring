<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="resources/images/question/question.png" alt="..." style="width: auto;">
	</div>

<div style="padding-top: 10px;  background-color: #8FBC8F; text-align: center;">
	<!-- <span style="padding-bottom: 2rem; padding-bottom: 2rem; font-size: 1.5rem; display: inline-block;"> <b>F&A</b> </span> -->
	<img alt="F&A" src="resources/images/question/FA.png" width="43px" height="25px">  
	<div style="padding: 15px;"></div>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-2">
			<p>
			<button class="btn btn-success" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample1">
			    전체
			</button>
			</p>
		</div>
		<div class="col-md-2">
			<p>
			<button class="btn btn-success" type="button" data-bs-toggle="collapse" data-bs-target="#accordionFlushExampleSipping" aria-expanded="false" aria-controls="accordionFlushExampleSipping">
			    배송/조회
			</button>
			</p>
		</div>
		<div class="col-md-2">
			<p>
			<button class="btn btn-success" type="button" data-bs-toggle="collapse" data-bs-target="#accordionFlushExampleOrder" aria-expanded="false" aria-controls="accordionFlushExampleOrder">
			    주문/결제
			</button>
			</p>
		</div>
		<div class="col-md-2">
			<p>
			<button class="btn btn-success" type="button" data-bs-toggle="collapse" data-bs-target="#accordionFlushExampleCancel" aria-expanded="false" aria-controls="accordionFlushExampleCancel">
			   	취소/환불
			</button>
			</p>
		</div>
		<div class="col-md-2">
			<p>
			<button class="btn btn-success" type="button" data-bs-toggle="collapse" data-bs-target="#accordionFlushExampleMember" aria-expanded="false" aria-controls="accordionFlushExampleMember">
			   	회원/로그인
			</button>
			</p>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>
		<div class="collapse" id="collapseExample1">
		  <div class="card card-body">
			<div class="accordion accordion-flush" id="accordionAll">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingOne">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseOne" aria-expanded="false" aria-controls="AllcollapseOne">
			        Q. "찜"를 누른 콘텐츠들은 어디서 볼 수 있나요?
			      </button>
			    </h2>
			    <div id="AllcollapseOne" class="accordion-collapse collapse" aria-labelledby=AllHeadingOne data-bs-parent="#accordionAll">
			      <div class="accordion-body">우측 상단 장바구니 클릭 후 찜을 클릭하면 확인 가능합니다.</div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingTwo">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseTwo" aria-expanded="false" aria-controls="AllcollapseTwo">
			        Q. 배송 시작 알림 메세지를 받았는데, 배송추척이 되지 않습니다. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="AllcollapseTwo" class="accordion-collapse collapse" aria-labelledby="AllHeadingTwo" data-bs-parent="#accordionAll">
			      <div class="accordion-body">송장번호 등록 후 1영업일 이내 또는 실제 상품배송이 진행됨과 동시에 배송추적이 가능합니다. ※ 배송처에서 배송이 시작되기 전, 송장을 먼저 출력 후 송장번호를 입력하는 경우가 있습니다.</div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingThree">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseThree" aria-expanded="false" aria-controls="AllcollapseThree">
			        Q. 배송조회를 해보면 배송완료로 확인되는데 택배를 받지 못했습니다. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="AllcollapseThree" class="accordion-collapse collapse" aria-labelledby="AllHeadingThree" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        송장번호 등록 후 1영업일 이내 또는 실제 상품배송이 진행됨과 동시에 배송추적이 가능합니다.
					<br>※ 배송처에서 배송이 시작되기 전, 송장을 먼저 출력 후 송장번호를 입력하는 경우가 있습니다.
				  </div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingFour">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseFour" aria-expanded="false" aria-controls="AllcollapseFour">
			        Q. 배송은 얼마나 걸리나요?
			      </button>
			    </h2>
			    <div id="AllcollapseFour" class="accordion-collapse collapse" aria-labelledby="AllHeadingFour" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
				       상품 배송 기간은 배송 유형에 따라 출고 일자 차이가 있습니다.자세한 사항은 구매하신 상품의 상세 페이지에서 확인 가능하며, 배송 유형 별 기본 출고 기간은 아래와 같습니다. 
				      <br> ∙ 일반 택배 / 화물 택배 : 결제 후 1~3 영업일 이내 출고됩니다. 
				      <br> ∙ 업체 직접 배송 : 배송 지역에 따라 배송 일자가 상이할 수 있으므로 상품 상세 페이지에서 확인 해주세요. 
				      <br>※ 영업일은 주말, 공휴일을 제외한 기간입니다. 
				      <br>※ 제조사의 사정에 따라 출고일은 지연될 수 있는 점 양해 부탁드립니다.
				  </div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingSix">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseSix" aria-expanded="false" aria-controls="AllcollapseSix">
			        Q. 가상계좌 은행을 변경할 수 있나요?
			      </button>
			    </h2>
			    <div id="AllcollapseSix" class="accordion-collapse collapse" aria-labelledby="AllHeadingSix" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        한번 발급 받은 계좌번호는 변경이 불가능합니다. 
			        <br>재주문을 통해 새로운 계좌를 발급 받으신 후 입금 부탁드립니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingSeven">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseSeven" aria-expanded="false" aria-controls="AllcollapseSeven">
			        Q. 배송비는 얼마인가요?
			      </button>
			    </h2>
			    <div id="AllcollapseSeven" class="accordion-collapse collapse" aria-labelledby="AllHeadingSeven" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        상품상세페이지에서 배송비를 확인하실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingEight">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseEight" aria-expanded="false" aria-controls="AllcollapseEight">
			        Q. 주문내역은 어디서 확인할 수 있나요?
			      </button>
			    </h2>
			    <div id="AllcollapseEight" class="accordion-collapse collapse" aria-labelledby="AllHeadingEight" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        우측 상단 마이페이지를 통해 확인 가능합니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingNine">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseNine" aria-expanded="false" aria-controls="AllcollapseNine">
			        Q. 취소 후 환불은 언제되나요?
			      </button>
			    </h2>
			    <div id="AllcollapseNine" class="accordion-collapse collapse" aria-labelledby="AllHeadingNine" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        신용카드 및 체크카드의 경우 카드사에서 확인 절차를 거치는 관계로 평균 3~7일 영업일 이내 환불처리가 완료됩니다.
			        <br>무통장 입금의 경우 평균 3영업일 이내 요청 하신 계좌로 환불됩니다.
			        <br>휴대폰 소액결제의 경우 평균 3영업일 이내 환불 또는 취소 처리가 완료됩니다.
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingTen">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseTen" aria-expanded="false" aria-controls="AllcollapseTen">
			        Q. 제품의 교환 또는 반품 가능할까요?
			      </button>
			    </h2>
			    <div id="AllcollapseTen" class="accordion-collapse collapse" aria-labelledby="AllHeadingTen" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        "상품을 수령하신 후 7일 이내에 교환, 반품이 가능하며, 고객님의 변심에 의한 교환/반품의 경우 배송비용이 부과될 수 있습니다.
					<br>※ 단, 아래의 경우 교환/반품이 불가능합니다. 
					<br>- 고객님의 책임 사유로 인해 상품 등이 멸실 또는 훼손된 경우
					<br>- 개봉 및 포장이 훼손으로 상품가치가 현저히 상실된 경우
					<br>- 시간 경과에 의해 재판매가 어려울정도로 상품 가치가 현저히 저하된 경우
					<br>- 고객주문 확인 후 상품제작에 들어가는 주문 제작 상품
					<br>- 직접 조립하는(DIY) 상폼을 조립 한 경우"
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeadingEleven">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#AllcollapseEleven" aria-expanded="false" aria-controls="AllcollapseEleven">
			        Q. 주문한 상품과 다른 상품이 왔어요. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="AllcollapseEleven" class="accordion-collapse collapse" aria-labelledby="AllHeadingEleven" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        우측 상단 프로필 사진을 클릭 후 [마이페이지 > 고객센터]를 통해 문의 주시면 확인 도움드리겠습니다.
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeading12">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#Allcollapse12" aria-expanded="false" aria-controls="Allcollapse12">
			        Q. 회원탈퇴는 어떻게 하나요?
			      </button>
			    </h2>
			    <div id="Allcollapse12" class="accordion-collapse collapse" aria-labelledby="AllHeading12" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        우측 상단 [마이페이지 -> 탈퇴]가 가능하십니다.
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeading13">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#Allcollapse13" aria-expanded="false" aria-controls="Allcollapse13">
			        Q. 아이다와 비밀번호가 기억나지 않아요.
			      </button>
			    </h2>
			    <div id="Allcollapse13" class="accordion-collapse collapse" aria-labelledby="AllHeading13" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			        우측 상단의 로그인 메뉴에 접속하여 내 계정찾기를 통해 아이디와 비밀번호를 찾으실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeading14">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#Allcollapse14" aria-expanded="false" aria-controls="Allcollapse14">
			        Q. 회원탈퇴 후 재가입이 가능한가요?
			      </button>
			    </h2>
			    <div id="Allcollapse14" class="accordion-collapse collapse" aria-labelledby="AllHeading14" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			       	언제든지 다시 가입이 가능하십니다 :>
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="AllHeading15">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#Allcollapse15" aria-expanded="false" aria-controls="Allcollapse15">
			        Q. 비밀번호를 변경하고 싶어요
			      </button>
			    </h2>
			    <div id="Allcollapse15" class="accordion-collapse collapse" aria-labelledby="AllHeading15" data-bs-parent="#accordionAll">
			      <div class="accordion-body">
			       	우측 상단 마이페이지를 클릭 후 비밀번호를 변경하실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			</div>
		  </div>
		</div>
	<div class="collapse" id="accordionFlushExampleSipping">
		  <div class="card card-body">
			<div class="accordion accordion-flush" id="accordionSipping">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="SippingHeading1">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#SippingCollapse1" aria-expanded="false" aria-controls="SippingCollapse1">
			        Q. 배송 시작 알림 메세지를 받았는데, 배송추척이 되지 않습니다. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="SippingCollapse1" class="accordion-collapse collapse" aria-labelledby="SippingHeading1" data-bs-parent="#accordionSipping">
			      <div class="accordion-body">송장번호 등록 후 1영업일 이내 또는 실제 상품배송이 진행됨과 동시에 배송추적이 가능합니다. ※ 배송처에서 배송이 시작되기 전, 송장을 먼저 출력 후 송장번호를 입력하는 경우가 있습니다.</div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="SippingHeading2">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#SippingCollapse2" aria-expanded="false" aria-controls="SippingCollapse2">
			        Q. 배송조회를 해보면 배송완료로 확인되는데 택배를 받지 못했습니다. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="SippingCollapse2" class="accordion-collapse collapse" aria-labelledby=""SippingHeading2"" data-bs-parent="#accordionSipping">
			      <div class="accordion-body">
			        송장번호 등록 후 1영업일 이내 또는 실제 상품배송이 진행됨과 동시에 배송추적이 가능합니다.
					<br>※ 배송처에서 배송이 시작되기 전, 송장을 먼저 출력 후 송장번호를 입력하는 경우가 있습니다.
				  </div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="SippingHeading3">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#SippingCollapse3" aria-expanded="false" aria-controls="SippingCollapse3">
			        Q. 배송은 얼마나 걸리나요?
			      </button>
			    </h2>
			    <div id="SippingCollapse3" class="accordion-collapse collapse" aria-labelledby=""SippingHeading3"" data-bs-parent="#accordionSipping">
			      <div class="accordion-body">
				       상품 배송 기간은 배송 유형에 따라 출고 일자 차이가 있습니다.자세한 사항은 구매하신 상품의 상세 페이지에서 확인 가능하며, 배송 유형 별 기본 출고 기간은 아래와 같습니다. 
				      <br> ∙ 일반 택배 / 화물 택배 : 결제 후 1~3 영업일 이내 출고됩니다. 
				      <br> ∙ 업체 직접 배송 : 배송 지역에 따라 배송 일자가 상이할 수 있으므로 상품 상세 페이지에서 확인 해주세요. 
				      <br>※ 영업일은 주말, 공휴일을 제외한 기간입니다. 
				      <br>※ 제조사의 사정에 따라 출고일은 지연될 수 있는 점 양해 부탁드립니다.
				  </div>
			    </div>
			  </div>
			</div>
		  </div>
		</div>
	<div class="collapse" id="accordionFlushExampleOrder">
		  <div class="card card-body">
			<div class="accordion accordion-flush" id="accordionOrder">
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="OrderHeading1">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#OrderCollapse1" aria-expanded="false" aria-controls="OrderCollapse1">
			        Q. 가상계좌 은행을 변경할 수 있나요?
			      </button>
			    </h2>
			    <div id="OrderCollapse1" class="accordion-collapse collapse" aria-labelledby="OrderHeading1" data-bs-parent="#accordionOrder">
			      <div class="accordion-body">
			        한번 발급 받은 계좌번호는 변경이 불가능합니다. 
			        <br>재주문을 통해 새로운 계좌를 발급 받으신 후 입금 부탁드립니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="OrderHeading2">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#OrderCollapse2" aria-expanded="false" aria-controls="OrderCollapse2">
			        Q. 배송비는 얼마인가요?
			      </button>
			    </h2>
			    <div id="OrderCollapse2" class="accordion-collapse collapse" aria-labelledby="OrderHeading2" data-bs-parent="#accordionOrder">
			      <div class="accordion-body">
			        상품상세페이지에서 배송비를 확인하실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="OrderHeading3">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#OrderCollapse3" aria-expanded="false" aria-controls="OrderCollapse3">
			        Q. 주문내역은 어디서 확인할 수 있나요?
			      </button>
			    </h2>
			    <div id="OrderCollapse3" class="accordion-collapse collapse" aria-labelledby="OrderHeading3" data-bs-parent="#accordionOrder">
			      <div class="accordion-body">
			        우측 상단 마이페이지를 통해 확인 가능합니다.
				  </div>
			    </div>
			  </div> 
			</div>
		  </div>
		</div>
	<div class="collapse" id="accordionFlushExampleCancel">
		  <div class="card card-body">
			<div class="accordion accordion-flush" id="accordionCancel">
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="CancelHeading1">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#CancelCollapse1" aria-expanded="false" aria-controls="CancelCollapse1">
			        Q. 취소 후 환불은 언제되나요?
			      </button>
			    </h2>
			    <div id="CancelCollapse1" class="accordion-collapse collapse" aria-labelledby="CancelHeading1" data-bs-parent="#accordionCancel">
			      <div class="accordion-body">
			        신용카드 및 체크카드의 경우 카드사에서 확인 절차를 거치는 관계로 평균 3~7일 영업일 이내 환불처리가 완료됩니다.
			        <br>무통장 입금의 경우 평균 3영업일 이내 요청 하신 계좌로 환불됩니다.
			        <br>휴대폰 소액결제의 경우 평균 3영업일 이내 환불 또는 취소 처리가 완료됩니다.
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="CancelHeading2">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#CancelCollapse2" aria-expanded="false" aria-controls="CancelCollapse2">
			        Q. 제품의 교환 또는 반품 가능할까요?
			      </button>
			    </h2>
			    <div id="CancelCollapse2" class="accordion-collapse collapse" aria-labelledby="CancelHeading2" data-bs-parent="#accordionCancel">
			      <div class="accordion-body">
			        "상품을 수령하신 후 7일 이내에 교환, 반품이 가능하며, 고객님의 변심에 의한 교환/반품의 경우 배송비용이 부과될 수 있습니다.
					<br>※ 단, 아래의 경우 교환/반품이 불가능합니다. 
					<br>- 고객님의 책임 사유로 인해 상품 등이 멸실 또는 훼손된 경우
					<br>- 개봉 및 포장이 훼손으로 상품가치가 현저히 상실된 경우
					<br>- 시간 경과에 의해 재판매가 어려울정도로 상품 가치가 현저히 저하된 경우
					<br>- 고객주문 확인 후 상품제작에 들어가는 주문 제작 상품
					<br>- 직접 조립하는(DIY) 상폼을 조립 한 경우"
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="CancelHeading3">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#"CancelCollapse3"" aria-expanded="false" aria-controls=""CancelCollapse3"">
			        Q. 주문한 상품과 다른 상품이 왔어요. 어떻게 해야하나요?
			      </button>
			    </h2>
			    <div id="CancelCollapse3" class="accordion-collapse collapse" aria-labelledby="CancelHeading3" data-bs-parent="#accordionCancel">
			      <div class="accordion-body">
			        우측 상단 프로필 사진을 클릭 후 [마이페이지 > 고객센터]를 통해 문의 주시면 확인 도움드리겠습니다.
				  </div>
			    </div>
			  </div> 
			</div>
		  </div>
	   </div>
	<div class="collapse" id="accordionFlushExampleMember">
		  <div class="card card-body">
			<div class="accordion accordion-flush" id="accordionMember">
				   <div class="accordion-item">
			    <h2 class="accordion-header" id="MemberHeading1">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#MemberCollapse1" aria-expanded="false" aria-controls="MemberCollapse1">
			        Q. 회원탈퇴는 어떻게 하나요?
			      </button>
			    </h2>
			    <div id="MemberCollapse1" class="accordion-collapse collapse" aria-labelledby="MemberHeading1" data-bs-parent="#accordionMember">
			      <div class="accordion-body">
			        우측 상단 [마이페이지 -> 탈퇴]가 가능하십니다.
				  </div>
			    </div>
			  </div> 
			   <div class="accordion-item">
			    <h2 class="accordion-header" id="MemberHeading2">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#MemberCollapse2" aria-expanded="false" aria-controls="MemberCollapse2">
			        Q. 아이다와 비밀번호가 기억나지 않아요.
			      </button>
			    </h2>
			    <div id="MemberCollapse2" class="accordion-collapse collapse" aria-labelledby="MemberHeading2" data-bs-parent="#accordionMember">
			      <div class="accordion-body">
			        우측 상단의 로그인 메뉴에 접속하여 내 계정찾기를 통해 아이디와 비밀번호를 찾으실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="MemberHeading3">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#MemberCollapse3" aria-expanded="false" aria-controls="MemberCollapse3">
			        Q. 회원탈퇴 후 재가입이 가능한가요?
			      </button>
			    </h2>
			    <div id="MemberCollapse3" class="accordion-collapse collapse" aria-labelledby="MemberHeading3" data-bs-parent="#accordionMember">
			      <div class="accordion-body">
			       	언제든지 다시 가입이 가능하십니다 :>
				  </div>
			    </div>
			  </div> 
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="MemberHeading4">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#MemberCollapse4" aria-expanded="false" aria-controls="MemberCollapse4">
			        Q. 비밀번호를 변경하고 싶어요
			      </button>
			    </h2>
			    <div id="MemberCollapse4" class="accordion-collapse collapse" aria-labelledby="MemberHeading4" data-bs-parent="#accordionMember">
			      <div class="accordion-body">
			       	우측 상단 마이페이지를 클릭 후 비밀번호를 변경하실 수 있습니다.
				  </div>
			    </div>
			  </div> 
			</div>
		  </div>
	   </div>
