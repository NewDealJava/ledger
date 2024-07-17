package com.newdeal.ledger.account.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@AllArgsConstructor
@Data
public class AccountDto {
	public Integer ano;
	public String email;
	public String name;
	public String cname;
	public AccountType type;
	public String imgUrl;
	public String memo;
	public Long amount;
	public Boolean isExcept;

}
