package com.newdeal.ledger.transaction.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import lombok.Data;

public class TransactionRequest {

	@Data
	public static class Create {
		private Integer tno;
		private TransactionType type;
		private Integer category;
		private Integer subcategory;
		private List<Integer> tags;

		private SourceType sourceType;
		private Integer sno;
		private RepeatType rtype;

		private String keyword;
		private Long amount;
		private Integer installment;

		private LocalDate date;
		private LocalTime time;

		private String memo;
		private String imageUrl;

		public LocalDateTime getDateTime() {
			return LocalDateTime.of(date, time);
		}
	}
}
