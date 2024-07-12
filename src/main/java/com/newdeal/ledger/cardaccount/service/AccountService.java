package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import com.newdeal.ledger.cardaccount.dto.AccountDto;

public interface AccountService {

	List<AccountDto> selectAllByEmail(String email);
}
