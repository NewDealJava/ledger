package com.newdeal.ledger.card.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@AllArgsConstructor
@Data
public class CardDto {
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
