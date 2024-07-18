package com.newdeal.ledger.account.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

public class AccountRequest {

	@Data
	public static class Create {
		@NotNull
		public AccountType type;
		@NotBlank
		public String name;
		public String nickname;
		@NotNull
		public Long amount;
		public String memo;
		public String imgUrl;
	}

	@Data
	public static class Update {
		@NotNull
		public AccountType type;
		@NotBlank
		public String name;
		public String nickname;
		@NotNull
		public Long amount;
		public String memo;
		public String imgUrl;
	}
}
