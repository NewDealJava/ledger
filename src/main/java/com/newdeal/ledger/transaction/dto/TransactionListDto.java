package com.newdeal.ledger.transaction.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransactionListDto {
	public Integer tno;
	public LocalDate date;
	public LocalTime time;
	public String category;
	public String subCategory;
	public String keyword;
	public String amount;
	public String memo;
	public String installment;
	public String tags;
}
