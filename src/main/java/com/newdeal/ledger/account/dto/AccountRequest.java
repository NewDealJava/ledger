package com.newdeal.ledger.account.dto;

import lombok.Data;

public class AccountRequest {

	@Data
	public static class Create {
		public AccountType type;
		public String name;
		public String nickname;
		public Long amount;
		public String memo;
		public String imgUrl;
	}

	@Data
	public static class Update {
		public AccountType type;
		public String name;
		public String nickname;
		public Long amount;
		public String memo;
		public String imgUrl;
	}
}
