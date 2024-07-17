package com.newdeal.ledger.card.dto;

import lombok.Data;

public class CardResponse {
	@Data
	public static class GetOne {
		public Integer cardId;
		public String email;
		public String name;
		public String nickname;
		public CardType type;
		public Integer statementDay;
		public String imgUrl;
		public String memo;
		public Long amount;
		public Boolean isExcept;
	}
}
