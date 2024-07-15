package com.newdeal.ledger.cardaccount.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@AllArgsConstructor
@Data
public class CardDto {
	public Integer cno;
	public String email;
	public String name;
	public String cname;
	public CardType type;
	public Integer bDay;
	public String imgUrl;
	public String memo;
	public Long amount;
	public Boolean isExcept;

}
