package com.newdeal.ledger.card.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

public class CardRequest {

	@Data
	public static class Create {
		@NotNull
		public CardType type;
		@NotBlank
		public String name;
		public String nickname;
		@Min(1) @Max(31)
		public Integer statementDay;
		@NotNull
		public Long amount;
		public String memo;
		public String imgUrl;
	}

	@Data
	public static class Update {
		@NotNull
		public CardType type;
		@NotBlank
		public String name;
		public String nickname;
		@Min(1) @Max(31)
		public Integer statementDay;
		@NotNull
		public Long amount;
		public String memo;
		public String imgUrl;
	}
}
