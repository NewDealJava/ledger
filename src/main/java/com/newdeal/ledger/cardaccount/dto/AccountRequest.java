package com.newdeal.ledger.cardaccount.dto;

import lombok.Data;

public class AccountRequest {

	@Data
	public static class Create {
		public AccountType type;
		public String name;
		public String cname;
		public Long amount;
		public String memo;
		public String imgUrl;
	}
}
