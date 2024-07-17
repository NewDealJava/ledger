package com.newdeal.ledger.transaction.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

import com.newdeal.ledger.transaction.dto.type.RepeatType;
import com.newdeal.ledger.transaction.dto.type.SourceType;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransactionDto {
	private Integer transactionId;
	private String email;
	private Integer subCategoryId;
	private TransactionType transactionType;
	private SourceType sourceType;
	private Integer sourceId;
	private String keyword;
	private Long amount;
	private Integer installment;
	private String imageUrl;
	private String memo;
	private LocalDateTime time;
	private RepeatType repeatType;

}
