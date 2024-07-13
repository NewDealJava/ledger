package com.newdeal.ledger.transaction.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransactionDto {
	private int tno;
	private String email;
	private int cno;
	private String type;
	private String stype;
	private int sno;
	private String keyword;
	private long samount;
	private int installment;
	private String imageUrl;
	private String tsmemo;
	private Timestamp time;
	private Integer rtype;
}
