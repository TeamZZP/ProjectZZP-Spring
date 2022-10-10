<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="/zzp/kakaoPay">
    <button>카카오페이로 결제하기</button>
</form>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	/* $('button').on('click', function () {
		$.ajax({
			url:"https://kapi.kakao.com/v1/payment/ready",
			type:"POST",
			headers: {
				"Authorization":"KakaoAK"+"adc850c002bad821890c76596cf517ab",
				"Content-Type":"application/x-www-form-urlencoded;charset=utf-8"
			},
			data: {
				"cid":"TC0ONETIME",
				"partner_order_id":"zzp2022",
				"partner_user_id":"cho123",
				"item_name":"초코파이",
				"quantity":"1",
				"total_amount":"2200",
				"vat_amount":"200",
				"tax_free_amount":"0",
				"approval_url":"https://developers.kakao.com/success",
				"fail_url":"https://developers.kakao.com/fail",
				"cancel_url":"https://developers.kakao.com/cancel"
			}
		})
	}) */
</script>
</body>
</html>