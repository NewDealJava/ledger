package com.newdeal.ledger.transaction.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransactionDto {
	private Integer tno;
	private String email;
	private Integer cno;
	private TransactionType type;
	private SourceType stype;
	private Integer sno;
	private String keyword;
	private Long samount;
	private Integer installment;
	private String imageUrl;
	private String tsmemo;
	private LocalDateTime time;
	private RepeatType rtype;

}
