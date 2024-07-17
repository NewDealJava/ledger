package com.newdeal.ledger.transaction.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import com.newdeal.ledger.transaction.dto.type.RepeatType;
import com.newdeal.ledger.transaction.dto.type.SourceType;
import com.newdeal.ledger.transaction.dto.type.TransactionType;

import lombok.Data;

public class TransactionResponse {

	@Data
	public static class GetOne {
		private Integer transactionId;
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
		private LocalDateTime time;
		private RepeatType repeatType;
	}

	@Data
	public static class GetList {
		public Integer transactionId;
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

}
