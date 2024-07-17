package com.newdeal.ledger.transaction.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import com.newdeal.ledger.transaction.dto.type.RepeatType;
import com.newdeal.ledger.transaction.dto.type.SourceType;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

public class TransactionRequest {

	@Data
	public static class Create {
		private Integer transactionId;
		@NotNull
		private TransactionType transactionType;
		@NotNull
		private Integer categoryId;
		@NotNull
		private Integer subCategoryId;
		private List<Integer> tagIdList;

		@NotNull
		private SourceType sourceType;
		@NotNull
		private Integer sourceId;
		@NotNull
		private RepeatType repeatType;

		private String keyword;
		private Long amount;
		@Min(1) @Max(30)
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
		private Integer transactionId;
		@NotBlank
		private String email;
		@NotNull
		private Integer categoryId;
		@NotNull
		private Integer subCategoryId;
		private List<Integer> tagIdList;
		@NotNull
		private TransactionType transactionType;
		@NotNull
		private SourceType sourceType;
		@NotNull
		private Integer sourceId;
		private String keyword;

		private Long amount;
		@Min(1) @Max(30)
		private Integer installment;
		private String imageUrl;
		private String memo;
		private LocalDate date;
		private LocalTime time;
		@NotNull
		private RepeatType repeatType;

		public LocalDateTime getDateTime() {
			return LocalDateTime.of(date, time);
		}
	}

	@Data
	public static class MultiFilter{
		private int year;
		private int month;
		private List<Integer> subCategoryIds;
		private List<Integer> tagIds;
		private List<Integer> installment;
		private List<RepeatType> repeatType;
		private List<SourceType> sourceType;
		private List<Integer> sourceIds;
		private String keyword;
	}
}
