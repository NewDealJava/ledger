package com.newdeal.ledger.account.service;

import java.util.List;

import com.newdeal.ledger.account.dto.AccountDto;
import com.newdeal.ledger.account.dto.AccountRequest;

public interface AccountService {
	void createAccount(String tempEmail, AccountRequest.Create request);

	void updateAccount(Integer accountId, AccountRequest.Update request);

	void removeAccount(Integer accountId);

	List<AccountDto> getAccountsByEmail(String email);

}
