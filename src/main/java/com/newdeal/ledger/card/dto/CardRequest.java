package com.newdeal.ledger.card.dto;

import lombok.Data;

public class CardRequest {

	@Data
	public static class Create {
		public CardType type;
		public String name;
		public String nickname;
		public Integer statementDay;
		public Long amount;
		public String memo;
		public String imgUrl;
	}

	@Data
	public static class Update {
		public CardType type;
		public String name;
		public String nickname;
		public Integer statementDay;
		public Long amount;
		public String memo;
		public String imgUrl;
	}
}
