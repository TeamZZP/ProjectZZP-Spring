package com.dto;

import lombok.Data;

@Data
public class TossPayApprovalVO {
	private String mId;
	private String verion;
	private String paymentKey;
	private String orderId;
	private String orderName;
	private String currency;
	private String method;
	private int totalAmount;
	private int balanceAmount;
	private int suppliedAmount;
	private int vat;
	private String status;
	private String requestedAt;
	private String approvedAt;
	private boolean useEscrow;
	private String transactionKey;
	private String lastTransactionKey;

}
