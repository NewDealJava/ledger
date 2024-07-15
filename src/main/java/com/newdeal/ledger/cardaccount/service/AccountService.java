package com.newdeal.ledger.cardaccount.service;

import java.util.List;

import com.newdeal.ledger.cardaccount.dto.AccountDto;
import com.newdeal.ledger.cardaccount.dto.AccountRequest;

public interface AccountService {

	List<AccountDto> selectAllByEmail(String email);

	void createAccount(String tempEmail, AccountRequest.Create request);
}
