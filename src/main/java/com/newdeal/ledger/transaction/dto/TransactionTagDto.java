package com.newdeal.ledger.transaction.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransactionTagDto {
	public Integer transactionId;
	public Integer tagId;
}
