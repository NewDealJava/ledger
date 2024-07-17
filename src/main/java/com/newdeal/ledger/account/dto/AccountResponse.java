package com.newdeal.ledger.account.dto;

import lombok.Data;

public class AccountResponse {

	@Data
	public static class GetOne {
		public Integer accountId;
		public String email;
		public String name;
		public String nickname;
		public AccountType type;
		public String imgUrl;
		public String memo;
		public Long amount;
		public Boolean isExcept;
	}
}
