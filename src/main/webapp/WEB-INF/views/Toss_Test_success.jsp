<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<script src="https://js.tosspayments.com/v1"></script>
</head>
<body>
<section>
      <!-- ... -->
      <span>총 주문금액</span>
      <span>15,000 원</span>
      <span>결제 완료</span>
    </section>
   <!--  <script>
      var clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq'
      var tossPayments = TossPayments(clientKey)
      var button = document.getElementById('payment-button') // 결제하기 버튼
      button.addEventListener('click', function () {
        tossPayments.requestPayment('카드', {
          amount: 15000,
          orderId: 'RPisbZLV__YDoyI_eOLak',
          orderName: '토스 티셔츠 외 2건',
          customerName: '박토스',
          successUrl: 'http://localhost:8080/success',
          failUrl: 'http://localhost:8080/fail',
        })
      })
    </script> -->
</body>
</html>
