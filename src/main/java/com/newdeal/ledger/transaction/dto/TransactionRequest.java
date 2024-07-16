package com.newdeal.ledger.transaction.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import com.newdeal.ledger.transaction.dto.type.RepeatType;
import com.newdeal.ledger.transaction.dto.type.SourceType;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

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

	@Data
	public static class Update {
		private String email;
		private Integer categoryId;
		private Integer subCategoryId;
		private List<Integer> tagIdList;
		private TransactionType transactionType;
		private SourceType sourceType;
		private Integer sourceId;
		private String keyword;
		private Long amount;
		private Integer installment;
		private String imageUrl;
		private String memo;
		private LocalDate date;
		private LocalTime time;
		private RepeatType repeatType;

		public LocalDateTime getDateTime() {
			return LocalDateTime.of(date, time);
		}
	}
}
